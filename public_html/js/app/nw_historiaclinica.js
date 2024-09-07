$(document).ready(function () {
  $("#mdlHistoriaclinica").on("show.bs.modal", function (e) {
    let numero = $("#oculto").val();
    let hash = $("#oculto-2").val();
    Toast.fire({
      icon: "success",
      title: "numero de historia creado: " + numero,
    });
    resetForm();
    $("#numero_historia").val(numero);
    $("#hash").val(hash);
    $(".ver-numero").val(numero);
  });
  $("#idpropietario").on("change", function () {
    cargarMascotas($(this).val());
  });
  $("#frmHistoriaclinica").on("submit", function (e) {
    e.preventDefault();
    let formData = $(this).serialize();
    divLoading.css("display", "flex");

    $.post(`${base_url}admin/historiaclinica/save`, formData, function (data) {
      divLoading.css("display", "none");
      if ($("#id").val() === "0" || $("#id").val() === "") {
        if (data.status) {
          mostrarMensajeExito("Consulta registrada con éxito");
          resetForm();
          $("#mdlHistoriaclinica").modal("hide");
          $("#oculto").val(data.data.numero_historia);
          $("#oculto-2").val(data.data.hash);
        } else {
          mostrarMensajeError(data.message);
        }
      } else {
        if (data.status) {
          mostrarMensajeExito("Consulta actualizada con éxito");
          resetForm();
          $("#mdlHistoriaclinica").modal("hide");
          $("#oculto").val(data.data.numero_historia);
          $("#oculto-2").val(data.data.hash);
        } else {
          mostrarMensajeError(data.message);
        }
      }
    }).fail(function () {
      divLoading.css("display", "none");
      mostrarMensajeError("No se pudo registrar la consulta");
    });
  });
  $("#buscarHistoria").on("submit", function (e) {
    e.preventDefault();
    let historia = $("#buscar_numero").val();
    divLoading.css("display", "flex");
    $.get(
      `${base_url}admin/historiaclinica/search/${historia}`,
      function (data) {
        divLoading.css("display", "none");
        if (data.status) {
          limpiarFormulario();
          $("#consultas-idmascota").val(data.data.idmascota);
          $("#consultas-idpropietario").val(data.data.idpropietario);
          $("#numero-historia-clinica").html(data.data.numero_historia);
          $("#propietario-nombres").val(data.data.nombre_propietario);
          $("#propietario-apellidos").val(data.data.apellido_propietario);
          $("#propietario-contacto").val(data.data.contacto_propietario);
          $("#propietario-direccion").val(data.data.direccion_propietario);
          $("#propietario-fecha-registro").val(data.data.fecha_registro);
          $("#propietario-email").val(data.data.email_propietario);
          $("#mascota-nombre").val(data.data.nombre_mascota);
          $("#mascota-color").val(data.data.color_mascota);
          $("#mascota-fecha-nacimiento").val(
            data.data.fecha_nacimiento_mascota
          );
          $("#mascota-especie").val(data.data.especie_mascota);
          $("#mascota-raza").val(data.data.raza_mascota);
          $("#mascota-genero").val(data.data.genero_mascota);
          $('button[data-bs-target="#navs-justified-consultas" ]').trigger(
            "click"
          );
        } else {
          mostrarMensajeError(data.message);
        }
      }
    ).fail(function () {
      divLoading.css("display", "none");
      mostrarMensajeError("No se pudo obtener la consulta");
    });
  });
  $('button[data-bs-target="#navs-justified-consultas"]').on(
    "click",
    function (e) {
      $("#tablaConsultas").dataTable({
        aProcessing: true,
        aServerSide: true,
        language: {
          url: base_url + "js/app/plugins/dataTable.Spanish.json",
        },
        ajax: {
          url: base_url + "admin/historiaclinica/consultas",
          method: "POST",
          dataSrc: "",
          data: {
            idmascota: $("#consultas-idmascota").val(),
            idpropietario: $("#consultas-idpropietario").val(),
          },
        },
        columns: [
          {
            width: "5%",
            data: null,
            render: function (data, type, row, meta) {
              return meta.row + meta.settings._iDisplayStart + 1;
            },
          },
          {
            data: "codigo",
            width: "15%",
            render: function (data, type, row) {
              return `<span class="fw-bold text-primary">${data}</span>`;
            },
          },
          {
            data: "fecha_consulta",
            render: function (data, type, row) {
              const fecha = formatDate(
                row.fecha_consulta + " " + row.hora_consulta
              );
              return `<p class="m-0 p-0 text-capitalize fw-normal">${fecha.dayOfWeek} ${fecha.day}, ${fecha.month} ${fecha.year}</p>
              <p class="m-0 p-0">${fecha.hours}:${fecha.minutes} ${fecha.ampm}</p>`;
            },
          },
          {
            data: "propietario",
            className: "text-capitalize",
          },
          {
            data: "mascota",
            className: "text-capitalize",
          },
          {
            data: "estado",
            render: function (data, type, row) {
              let color = "secondary";
              if (row.idestado == 1) {
                color = "primary";
              } else if (row.idestado == 2) {
                color = "success";
              } else if (row.idestado == 3) {
                color = "danger";
              }
              return `<span class="badge bg-${color}">${data}</span>`;
            },
          },
        ],
        resonsieve: true,
        bDestroy: true,
        iDisplayLength: 10,
        bFilter: false,
        bSort: false,
        bPaginate: false,
        bInfo: false,
        bAutoWidth: false,
        scrollX: false,
      });
    }
  );
  $('button[data-bs-target="#navs-justified-tratamientos"]').on(
    "click",
    function (e) {
      $("#tablaTratamientos").dataTable({
        aProcessing: true,
        aServerSide: true,
        language: {
          url: base_url + "js/app/plugins/dataTable.Spanish.json",
        },
        ajax: {
          url: base_url + "admin/historiaclinica/tratamientos",
          method: "POST",
          dataSrc: "",
          data: {
            idmascota: $("#consultas-idmascota").val(),
            idpropietario: $("#consultas-idpropietario").val(),
          },
        },
        columns: [
          {
            width: "5%",
            data: null,
            render: function (data, type, row, meta) {
              return meta.row + meta.settings._iDisplayStart + 1;
            },
          },
          { data: "tratamiento" },
          {
            data: "precio",
            className: "text-center",
            render: function (data, type, row) {
              return `<label>s/ ${data}</label>`;
            },
          },
          {
            data: "cantidad",
            render: function (data, type, row) {
              return `<label>${data}</label>`;
            },
          },
          {
            data: "subtotal",
            render: function (data, type, row) {
              return `<label>s/ ${data}</label>`;
            },
          },
          {
            data: "descripcion",
            render: function (data, type, row) {
              return `<label>${data}</label>`;
            },
          },
        ],
        resonsieve: true,
        bDestroy: true,
        iDisplayLength: 10,
        bFilter: false,
        bSort: false,
        bPaginate: false,
        bInfo: false,
        bAutoWidth: false,
        scrollX: false,
      });
    }
  );
  $('button[data-bs-target="#navs-justified-vacunas"]').on(
    "click",
    function (e) {
      $("#tablaVacunas").dataTable({
        aProcessing: true,
        aServerSide: true,
        language: {
          url: base_url + "js/app/plugins/dataTable.Spanish.json",
        },
        ajax: {
          url: base_url + "admin/historiaclinica/vacunas",
          method: "POST",
          dataSrc: "",
          data: {
            idmascota: $("#consultas-idmascota").val(),
            idpropietario: $("#consultas-idpropietario").val(),
          },
        },
        columns: [
          {
            width: "5%",
            data: null,
            render: function (data, type, row, meta) {
              return meta.row + meta.settings._iDisplayStart + 1;
            },
          },
          {
            width: "30%",
            render: function (data, type, row) {
              return `<p class="m-0 p-0 fs-5 text-primary fw-bold">${row.mascota}</p>
              <p class="m-0 p-0 fs-6">${row.propietario}</p>`;
            },
          },
          { data: "tipo_vacuna" },
          {
            data: "fecha_vacuna",
            render: function (data) {
              let fecha = formatDate(data + " 00:00");
              return `<span>${fecha.day} de <span class="text-capitalize">${fecha.month}</span> de ${fecha.year}</span>`;
            },
          },
        ],
        resonsieve: true,
        bDestroy: true,
        iDisplayLength: 10,
        bFilter: false,
        bSort: false,
        bPaginate: false,
        bInfo: false,
        bAutoWidth: false,
        scrollX: false,
      });
    }
  );
  $('button[data-bs-target="#navs-justified-desparasitaciones"]').on(
    "click",
    function (e) {
      $("#tablaDesparasitaciones").dataTable({
        aProcessing: true,
        aServerSide: true,
        language: {
          url: base_url + "js/app/plugins/dataTable.Spanish.json",
        },
        ajax: {
          url: base_url + "admin/historiaclinica/desparasitaciones",
          method: "POST",
          dataSrc: "",
          data: {
            idmascota: $("#consultas-idmascota").val(),
            idpropietario: $("#consultas-idpropietario").val(),
          },
        },
        columns: [
          {
            width: "5%",
            data: null,
            render: function (data, type, row, meta) {
              return meta.row + meta.settings._iDisplayStart + 1;
            },
          },
          {
            width: "30%",
            render: function (data, type, row) {
              return `<p class="m-0 p-0 fs-5 text-primary fw-bold">${row.mascota}</p>
              <p class="m-0 p-0 fs-6">${row.propietario}</p>`;
            },
          },
          {
            data: "tipo",
            width: "30%",
          },
          {
            data: "fecha_vacuna",
            width: "30%",
            render: function (data, type, row) {
              let fecha = formatDate(data + " 00:00");
              return `<span>${fecha.day} de <span class="text-capitalize">${fecha.month}</span> de ${fecha.year}</span>`;
            },
          },
        ],
        resonsieve: true,
        bDestroy: true,
        iDisplayLength: 10,
        bFilter: false,
        bSort: false,
        bPaginate: false,
        bInfo: false,
        bAutoWidth: false,
        scrollX: false,
      });
    }
  );
});
function cargarPropietarios(idPropietarioSeleccionado = null) {
  return new Promise((resolve, reject) => {
    $.get(`${base_url}admin/historiaclinica/propietarios`, function (data) {
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
function cargarMascotas(idPropietario, idMascotaSeleccionada = null) {
  return new Promise((resolve, reject) => {
    $.get(
      `${base_url}admin/historiaclinica/mascotas?id=${idPropietario}`,
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
    dropdownParent: $(`#${selectId}`).parent(),
    dropdownCssClass: "text-capitalize",
    selectionCssClass: "text-capitalize",
  });
}
function mostrarMensajeError(message) {
  Swal.fire({
    icon: "error",
    title: "Error",
    text: message,
  });
}
function mostrarMensajeExito(message) {
  Swal.fire({
    icon: "success",
    title: "Éxito",
    text: message,
  });
}
function resetForm() {
  $("#frmHistoriaclinica").trigger("reset");
  if (isSelect2Initialized("#idmascota")) {
    $("#idmascota").select2("destroy");
  }
  $("#idmascota").html("<option>Seleccione una opción</option>");

  if (isSelect2Initialized("#idpropietario")) {
    $("#idpropietario").select2("destroy");
  }
  $("#idpropietario").html("<option>Seleccione una opción</option>");
  cargarPropietarios();
}
function isSelect2Initialized(element) {
  try {
    return $(element).data("select2") !== undefined;
  } catch (e) {
    return false;
  }
}
function limpiarFormulario() {
  $("#consultas-idmascota").val("0");
  $("#consultas-idpropietario").val("0");
  $("#numero-historia-clinica").html("");
  $("#buscar_numero").val("");
  $("#propietario-nombres").val("");
  $("#propietario-apellidos").val("");
  $("#propietario-contacto").val("");
  $("#propietario-direccion").val("");
  $("#propietario-fecha-registro").val("");
  $("#propietario-email").val("");
  $("#mascota-nombre").val("");
  $("#mascota-color").val("");
  $("#mascota-fecha-nacimiento").val("");
  $("#mascota-especie").val("");
  $("#mascota-raza").val("");
  $("#mascota-genero").val("");
}
function generateDropdownMenu(row) {
  let options = [];
  if (row.edit) {
    // options.push(
    //   generateDropdownOption(
    //     "Editar",
    //     "bx bx-edit-alt",
    //     `fntEdit(${row.idconsulta})`
    //   )
    // );
    options.push(
      `<a class="dropdown-item" href="/admin/crearconsulta?idconsulta=${row.idconsulta}"><i class='bx bx-edit-alt me-2'></i>Editar consulta</a>`
    );
  }
  if (row.delete) {
    options.push(
      generateDropdownOption(
        "Eliminar",
        "bx bx-trash",
        `fntDel(${row.idconsulta})`
      )
    );
  }
  if (!row.edit && !row.delete) {
    options.push(
      generateDropdownOption("Sin acciones", "bx bxs-info-circle", ``)
    );
  }
  let optionsString = options.join("");
  return `
        <div class="d-flex flex-row">
        <div class="ms-3 dropdown">
            <button type="button" class="btn p-0 dropdown-toggle hide-arrow" data-bs-toggle="dropdown">
            <i class="bx bx-dots-vertical-rounded"></i>
            </button>
            <div class="dropdown-menu">${optionsString}</div>
        </div>
        </div>
    `;
}
function generateDropdownOption(text, iconClass, onClickFunction) {
  if (onClickFunction) {
    return `
        <a class="dropdown-item" href="#" onclick="${onClickFunction}"><i class="${iconClass} me-2"></i>${text}</a>
      `;
  } else {
    return `
        <a class="dropdown-item disabled" href="#"><i class="${iconClass} me-2"></i>${text}</a>
      `;
  }
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
