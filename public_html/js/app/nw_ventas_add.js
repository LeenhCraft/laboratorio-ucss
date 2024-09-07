$(document).ready(function () {
  const idConsulta = $("#idconsulta").val();
  console.log(idConsulta);

  inicializarComponentes();

  if (idConsulta !== "0") {
    cargarDatosConsultaExistente(idConsulta);
  } else {
    inicializarNuevaVenta();
  }

  configurarEventListeners();
});
function inicializarComponentes() {
  inicializarTabla();
  autosize($("#nota"));
  $("#fecha_venta, #fecha_vencimiento").flatpickr({
    altInput: true,
    altFormat: "l j F, Y",
    dateFormat: "Y-m-d",
    inline: false,
    locale: "es",
  });
  $("#idtipocomprobante, #idtipopago, #idmoneda, #idestado").select2();
}
function inicializarNuevaVenta() {
  Toast.fire({
    icon: "success",
    title: "Nueva venta",
  });
  cargarPropietarios();
  cargarServicios();
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
function configurarEventListeners() {
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
      url: `${base_url}admin/ventas/servicios/${selectedTreatmentId}`,
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

  $("#crearVenta").on("submit", function (e) {
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
      url: `${base_url}admin/ventas/save`,
      type: "POST",
      data: form,
      processData: false,
      contentType: false,
      success: function (data) {
        if (data.status) {
          Swal.fire({
            icon: "success",
            title: "Venta registrada",
            text: data.message,
            showConfirmButton: false,
            timer: 1500,
          });
          setTimeout(() => {
            window.location.href = `${base_url}admin/ventas`;
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
function cargarDatosConsultaExistente(idConsulta) {
  $.post(
    `${base_url}admin/ventas/consultas`,
    {
      idconsulta: idConsulta,
    },
    function (response) {
      if (response.status) {
        const data = response.data;
        cargarPropietarios(data.idpropietario)
          .then(() => {
            cargarServicios();
          })
          .then(() => {
            if ($("#idconsulta").val() !== "0") {
              cargarTratamientos(idConsulta);
            }
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
function cargarPropietarios(idPropietarioSeleccionado) {
  return new Promise((resolve, reject) => {
    $.get(`${base_url}admin/ventas/propietarios`, function (data) {
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
function cargarServicios(idTratamientoSeleccionado) {
  return new Promise((resolve, reject) => {
    $.get(`${base_url}admin/ventas/servicios`, function (data) {
      populateSelect("idtratamiento", data, "nombre", "idservicio");
      if (idTratamientoSeleccionado) {
        $("#idtratamiento").val(idTratamientoSeleccionado).trigger("change");
      }
      resolve();
    }).fail(reject);
  });
}
function cargarTratamientos(idConsulta) {
  $.get(`${base_url}admin/ventas/tratamientos/${idConsulta}`, function (data) {
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
      <button type="button" class="btn btn-outline-danger border-0 px-3 py-2 m-0" onclick="deleteRow(${row.idtratamiento})">
        <i class="bx bx-trash"></i>
      </button>
  `;
}
function deleteRow(idtratamiento) {
  tbl.rows().every(function () {
    console.log(this.data());
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