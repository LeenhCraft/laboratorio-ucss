var tbl;

$(document).ready(function () {
  const idReservaCita = $("#idreservacita").val();
  var idConsulta = $("#idconsulta").val();

  inicializarComponentes();

  if (idReservaCita !== "0") {
    cargarDatosReservaExistente(idReservaCita);
  } else if (idConsulta !== "0") {
    cargarDatosConsultaExistente(idConsulta);
  } else {
    inicializarNuevaConsulta();
  }

  configurarEventListeners();
});

function inicializarComponentes() {
  autosize($("#diagnostico"));
  cargarEstados(1);
  $('button[data-bs-toggle="tab"]').on("shown.bs.tab", function (event) {
    autosize($("#observaciones"));
    inicializarTabla();
    if ($("#idconsulta").val() !== "0") {
      cargarTratamientos($("#idconsulta").val());
    }
  });
}

function inicializarTabla() {
  if (typeof tbl !== "undefined" && $.fn.DataTable.isDataTable(tbl)) {
    console.log("ya existe la tabla");
    return;
  }
  tbl = $("#tbl").DataTable({
    columns: [
      {
        data: "idtratamiento",
        render: function (data, type, row) {
          return (
            `<span>${data}</span>` +
            `<input type="hidden" value="${data}" name="idservicio">`
          );
        },
      },
      { data: "tratamiento" },
      {
        data: "precio",
        render: function (data, type, row) {
          return `<input type="text" class="form-control" value="${data}" name="precio" onchange="updateRowPrice(this)">`;
        },
      },
      {
        data: "cantidad",
        render: function (data, type, row) {
          return `<input type="number" class="form-control" value="${data}" name="cantidad" min="1" onchange="updateRowPrice(this)">`;
        },
      },
      {
        data: "subtotal",
        render: function (data, type, row) {
          return `<input type="text" class="form-control" value="${data}" name="subtotal" readonly>`;
        },
      },
      {
        data: "descripcion",
        render: function (data, type, row) {
          return `<input type="text" class="form-control" value="${data}" name="descripcion">`;
        },
      },
      {
        data: null,
        render: function (data, type, row) {
          return generateDeleteButton(row);
        },
      },
    ],
    responsive: true,
    bDestroy: true,
    iDisplayLength: 5,
    bFilter: false,
    bSort: false,
    bPaginate: true,
    bInfo: false,
    bAutoWidth: false,
    scrollX: false,
  });
  console.log("tabla inicializada");
}

function cargarDatosReservaExistente(idReservaCita) {
  $.get(
    `${base_url}admin/crearconsulta/obtenerreserva/${idReservaCita}`,
    function (response) {
      if (response.status) {
        const data = response.data;
        cargarPropietarios(data.idpropietario)
          .then(() => cargarMascotas(data.idpropietario, data.idmascota))
          .then(() => {
            loadData("tratamientos", "idtratamiento", "nombre", "idservicio");
          })
          .then(() => {
            $("#motivoConsulta").val(data.motivo_consulta);
            autosize.update($("#motivoConsulta"));

            Toast.fire({
              icon: "info",
              title: "Reserva cargada",
            });
          });
      } else {
        console.error("No se pudo cargar la reserva");
        Toast.fire({
          icon: "error",
          title: "Error al cargar la reserva",
        });
      }
    }
  ).fail(function () {
    console.error("Error en la petición AJAX");
    Toast.fire({
      icon: "error",
      title: "Error al cargar la reserva",
    });
  });
}

function cargarDatosConsultaExistente(idConsulta) {
  $.post(
    `${base_url}admin/crearconsulta/search`,
    {
      idconsulta: idConsulta,
    },
    function (response) {
      if (response.status) {
        const data = response.data;
        cargarPropietarios(data.idpropietario)
          .then(() => cargarMascotas(data.idpropietario, data.idmascota))
          .then(() => {
            loadData("tratamientos", "idtratamiento", "nombre", "idservicio");
          })
          // .then(() => cargarTratamientos(idConsulta))
          .then(() => {
            if (data.idreservacita !== "0") {
            }
            $("#codigo").val(data.codigo);
            $(".codigo").html(data.codigo);
            let fecha = formatDate(
              data.fecha_consulta + " " + data.hora_consulta
            );
            $(".fecha_consulta").html(
              fecha.day + " " + fecha.month + " " + fecha.year
            );
            $("#fecha_consulta").val(data.fecha_consulta);
            $(".hora_consulta").html(
              fecha.hours + ":" + fecha.minutes + " " + fecha.ampm
            );
            $("#hora_consulta").val(data.hora_consulta);
            $("#motivoConsulta").val(data.motivo_consulta);
            autosize.update($("#motivoConsulta"));
            $("#diagnostico").val(data.diagnostico);
            $("#idestado").val(data.idestado).trigger("change");
            Toast.fire({
              icon: "info",
              title: "Consulta cargada",
            });
          });
      } else {
        console.error("No se pudo cargar la reserva");
        Toast.fire({
          icon: "error",
          title: "Error al cargar la reserva",
        });
      }
    }
  ).fail(function () {
    console.error("Error en la petición AJAX");
    Toast.fire({
      icon: "error",
      title: "Error al cargar la reserva",
    });
  });
}

function inicializarNuevaConsulta() {
  cargarPropietarios().then(() => {
    loadData("tratamientos", "idtratamiento", "nombre", "idservicio");
  });
}

function configurarEventListeners() {
  $("#idpropietario").on("change", function () {
    cargarDatosPropietario($(this).val());
  });

  $("#add-treatment").click(function () {
    const selectedTreatmentId = $("#idtratamiento").val();
    if (selectedTreatmentId === "0000") {
      Toast.fire({
        icon: "info",
        title: "Seleccione un tratamiento",
        position: "top",
      });
      return;
    }

    const existingTreatment = tbl
      .rows()
      .data()
      .toArray()
      .find((row) => row.idtratamiento === parseInt(selectedTreatmentId));
    if (existingTreatment) {
      Toast.fire({
        icon: "info",
        title: "El tratamiento ya está en la lista",
        position: "top",
      });
      return;
    }

    $.ajax({
      url: `${base_url}admin/crearconsulta/tratamientos/${selectedTreatmentId}`,
      method: "GET",
      dataType: "json",
      success: function (data) {
        const tratamientoData = {
          idtratamiento: data.data.idservicio,
          tratamiento: data.data.nombre,
          precio: data.data.precio,
          cantidad: 1,
          subtotal: data.data.precio * 1,
          descripcion: "",
          delete: true,
        };
        tbl.row.add(tratamientoData).draw();
        updateTotals();
      },
    });
  });

  $("#crearConsulta").on("submit", function (e) {
    e.preventDefault();
    const tableData = [];

    if (!$("#tbl tbody tr td").hasClass("dataTables_empty")) {
      $("#tbl tbody tr").each(function () {
        const row = $(this);
        const rowData = {
          idservicio: row.find('input[name="idservicio"]').val().trim(),
          precio: row.find('input[name="precio"]').val().trim(),
          cantidad: row.find('input[name="cantidad"]').val().trim(),
          subtotal: row.find('input[name="subtotal"]').val().trim(),
          descripcion: row.find('input[name="descripcion"]').val().trim(),
        };
        tableData.push(rowData);
      });
    }

    let form = new FormData(this);
    form.append("tableData", JSON.stringify(tableData));
    $.ajax({
      url: `${base_url}admin/crearconsulta/save`,
      type: "POST",
      data: form,
      processData: false,
      contentType: false,
      success: function (data) {
        if (data.status) {
          Swal.fire({
            icon: "success",
            title: "Consulta registrada",
            text: data.message,
            showConfirmButton: false,
            timer: 1500,
          });
          setTimeout(() => {
            window.location.href = `${base_url}admin/consultas`;
          }, 1500);
        } else {
          Swal.fire({
            icon: "error",
            title: "Error al registrar",
            text: data.message,
          });
        }
      },
      error: function (jqXHR, textStatus, errorThrown) {
        Swal.fire({
          icon: "error",
          title: "Error al registrar",
          text: errorThrown,
        });
      },
    });
  });
}

function loadData(endpoint, selectId, textKey, valueKey) {
  $.get(`${base_url}admin/crearconsulta/${endpoint}`, function (data) {
    populateSelect(selectId, data, textKey, valueKey);
  });
}

function cargarPropietarios(idPropietarioSeleccionado) {
  return new Promise((resolve, reject) => {
    $.get(`${base_url}admin/crearconsulta/propietarios`, function (data) {
      populateSelect(
        "idpropietario",
        data,
        ["nombres", "apellidos"],
        "idpropietario"
      );
      if (idPropietarioSeleccionado) {
        $("#idpropietario").val(idPropietarioSeleccionado).trigger("change");
      }
      resolve();
    }).fail(reject);
  });
}

function cargarEstados(idEstadoSeleccionado) {
  return new Promise((resolve, reject) => {
    $.get(`${base_url}admin/crearconsulta/estados`, function (data) {
      populateSelect("idestado", data, "nombre", "idestado");
      if (idEstadoSeleccionado) {
        $("#idestado").val(idEstadoSeleccionado).trigger("change");
      }
      resolve();
    }).fail(reject);
  });
}

function cargarDatosPropietario(idPropietario) {
  cargarMascotas(idPropietario);
}

function cargarMascotas(idPropietario, idMascotaSeleccionada) {
  return new Promise((resolve, reject) => {
    $.get(
      `${base_url}admin/crearconsulta/mascotas?id=${idPropietario}`,
      function (data) {
        populateSelect("idmascota", data, "nombre", "idmascota");
        if (idMascotaSeleccionada) {
          $("#idmascota").val(idMascotaSeleccionada).trigger("change");
        }
        resolve();
      }
    ).fail(reject);
  });
}

function populateSelect(selectId, data, textKeys, valueKey) {
  const selectElement = document.getElementById(selectId);
  selectElement.innerHTML = "";

  const defaultOption = document.createElement("option");
  defaultOption.text = "Seleccione una opción";
  defaultOption.value = "0000";
  selectElement.appendChild(defaultOption);

  data.forEach((item) => {
    const option = document.createElement("option");

    if (Array.isArray(textKeys)) {
      option.text = textKeys.map((key) => item[key]).join(" ");
    } else {
      option.text = item[textKeys];
    }

    option.value = item[valueKey];
    selectElement.appendChild(option);
  });

  $(`#${selectId}`).select2({
    width: "100%",
    placeholder: "Seleccione una opción",
    dropdownCssClass: "text-capitalize",
    selectionCssClass: "text-capitalize",
    // desactivar opcion seleccionada
    disabled: false,
  });
}

function generateDeleteButton(row) {
  return `
      <button type="button" class="btn btn-outline-danger" onclick="deleteRow(${row.idtratamiento})">
        <i class="bx bx-trash me-2"></i>  Eliminar
      </button>
  `;
}

function deleteRow(idtratamiento) {
  tbl.rows().every(function () {
    if (this.data().idtratamiento === idtratamiento) {
      this.remove();
      tbl.draw();
      updateTotals();
    }
  });
}

function updateRowPrice(element) {
  const row = $(element).closest("tr");
  const precio = parseFloat(row.find('input[name="precio"]').val()) || 0;
  const cantidad = parseFloat(row.find('input[name="cantidad"]').val()) || 0;
  const subtotal = (precio * cantidad).toFixed(2);
  row.find('input[name="subtotal"]').val(subtotal);
  updateTotals();
}

function updateTotals() {
  let subtotal = 0;

  $("#tbl tbody tr").each(function () {
    const row = $(this);
    const precio = parseFloat(row.find('input[name="subtotal"]').val()) || 0;
    subtotal += precio;
  });

  const descuento = parseFloat($(".descuento").val()) || 0;
  const total = subtotal - descuento;

  $(".subtotal").text(`S/ ${subtotal.toFixed(2)}`);
  $(".total").text(`S/ ${total.toFixed(2)}`);
}

function addCeros(num, len) {
  let numberWithZeros = String(num);
  let counter = numberWithZeros.length;
  while (counter < len) {
    numberWithZeros = "0" + numberWithZeros;
    counter++;
  }
  return numberWithZeros;
}

function cargarTratamientos(idConsulta) {
  $.get(
    `${base_url}admin/consultas/tratamientos/${idConsulta}`,
    function (data) {
      // Supongamos que 'data' es un array de objetos como el ejemplo que diste.
      const tratamientos = data.map((tratamiento) => {
        return {
          idtratamiento: tratamiento.idservicio,
          tratamiento: tratamiento.servicio,
          precio: tratamiento.precio,
          cantidad: tratamiento.cantidad,
          subtotal: tratamiento.subtotal,
          descripcion: tratamiento.descripcion,
        };
      });

      // Limpiar y actualizar los datos de la tabla.
      tbl.clear().rows.add(tratamientos).draw();
      updateTotals();
    }
  );
}

function formatDate(dateString) {
  // Crear un objeto Date a partir del string dado
  const date = new Date(dateString);

  // Crear un array con los nombres de los meses en español
  const months = [
    "enero",
    "febrero",
    "marzo",
    "abril",
    "mayo",
    "junio",
    "julio",
    "agosto",
    "septiembre",
    "octubre",
    "noviembre",
    "diciembre",
  ];

  // Crear un array con los nombres de los días de la semana en español
  const daysOfWeek = [
    "domingo",
    "lunes",
    "martes",
    "miércoles",
    "jueves",
    "viernes",
    "sábado",
  ];

  // Obtener el día de la semana, el día del mes, el mes y el año
  const dayOfWeek = daysOfWeek[date.getDay()];
  const day = date.getDate();
  const month = months[date.getMonth()]; // obtener el nombre del mes
  const year = date.getFullYear();

  // Obtener la hora y los minutos con formato de dos dígitos
  let hours = date.getHours();
  const minutes = String(date.getMinutes()).padStart(2, "0");

  // Determinar si es AM o PM
  const ampm = hours >= 12 ? "PM" : "AM";

  // Convertir la hora a formato de 12 horas
  hours = hours % 12;
  hours = hours ? hours : 12; // la hora 0 se convierte en 12

  // Formatear la hora en dos dígitos
  const formattedHours = String(hours).padStart(2, "0");

  // Formatear la fecha en el formato F j, Y H:i con el día de la semana y la hora en formato de 12 horas
  const formattedDate = `${dayOfWeek}, ${month} ${day}, ${year} ${formattedHours}:${minutes} ${ampm}`;

  // Devolver un objeto con los componentes de la fecha
  return {
    dateString: formattedDate,
    dayOfWeek: dayOfWeek,
    day: day,
    month: month,
    year: year,
    hours: formattedHours,
    minutes: minutes,
    ampm: ampm,
  };
}
