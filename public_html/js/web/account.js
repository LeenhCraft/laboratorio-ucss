let tb, tbHistorial;
let z = 0;
$(document).ready(function () {
  $("#btnSalir").on("click", function (event) {
    event.preventDefault();

    $.ajax({
      url: "/logout",
      method: "GET",
      success: function (data) {
        window.location.reload();
      },
      error: function (xhr, status, error) {
        // Manejar la respuesta de error
        Swal.fire("Error", "Se produjo un error durante la solicitud", "error");
      },
    });
  });

  const $tabButtons = $('button[role="tab"]');
  const $tabPanels = $('[role="tabpanel"]');

  $tabButtons.on("click", function (e) {
    e.preventDefault();

    // Remover clases activas de todos los botones de pestañas
    $tabButtons.removeClass("bg-pink-500 text-white font-bold");
    $tabButtons.addClass("bg-gray-200 text-gray-500 font-medium text-xs");

    // Agregar clases activas al botón de pestaña clickeado
    $(this).removeClass("bg-gray-200 text-gray-500 font-medium");
    $(this).addClass("bg-pink-500 text-white font-bold");

    // Ocultar todos los paneles de pestañas
    $tabPanels.addClass("hidden");

    // Mostrar el panel de pestaña correspondiente
    const target = $(this).attr("data-bs-target");
    $(target).removeClass("hidden");
  });

  // listar mascotas
  tb = $("#tbl").dataTable({
    aProcessing: true,
    aServerSide: true,
    language: {
      url: base_url + "js/app/plugins/dataTable.Spanish.json",
    },
    ajax: {
      url: base_url + "me/mascotas/list",
      method: "POST",
      dataSrc: "",
    },
    columns: [
      {
        width: "25%",
        data: "nombre",
        render: function (data, type, row) {
          return `
          <span class="font-medium">Historia Clinica</span>
          <p class="text-blue-400 font-bold">${row.numero_historia}</p>
          <span class="font-bold text-pink-500 text-base capitalize">${data}</span>
          `;
        },
      },
      {
        width: "25%",
        data: "idespecie",
        render: function (data, type, row) {
          return `<i class="${row.icono} text-pink-500 mr-2"></i><span class="text-base">${row.especie}</span>`;
        },
      },
      {
        width: "25%",
        data: "idespecie",
        render: function (data, type, row) {
          const fechaNacimiento = new Date(row.fecha_nacimiento);
          const edad = calcularEdad(fechaNacimiento);
          return `<span class="font-bold text-pink-500">Edad: ${edad.years} años, ${edad.months} meses, ${edad.days} días</span>`;
        },
      },
      {
        width: "25%",
        render: function (data, type, row) {
          return `<button onclick="fntEdit(${row.idmascota})" class="text-white bg-pink-500 hover:bg-pink-600 focus:ring-4 focus:outline-none focus:ring-pink-300 font-medium rounded-lg text-sm p-2 text-center transition-all duration-150 ease-in-out hover:shadow-lg hover:translate-y-0.5 hover:-translate-x-0.5 hover:scale-105 hover:origin-center transform-gpu">
          Editar
          </button>
          <button onclick="fntDel(${row.idmascota})" class="text-white bg-pink-500 hover:bg-pink-600 focus:ring-4 focus:outline-none focus:ring-pink-300 font-medium rounded-lg text-sm p-2 text-center transition-all duration-150 ease-in-out hover:shadow-lg hover:translate-y-0.5 hover:-translate-x-0.5 hover:scale-105 hover:origin-center transform-gpu">
          Eliminar
          </button>
          `;
        },
        // render: function (data, type, row) {
        //   return generateDropdownMenu(row);
        // },
      },
    ],
    resonsieve: "true",
    bDestroy: true,
    iDisplayLength: 10,
    bFilter: false,
    bSort: false,
    bPaginate: false,
    bInfo: false,
    bAutoWidth: false,
    scrollX: false,
  });

  $("#idespecie").on("change", function () {
    selectRazas();
    setTimeout(() => {
      $("#idraza").val(addCeros(z)).trigger("change");
    }, 200);
  });

  autosize(document.getElementById("motivo"));
  $("#fecha_consulta").flatpickr({
    altInput: true,
    altFormat: "F j, Y",
    dateFormat: "Y-m-d",
    inline: false,
    locale: "es",
  });
  $("#hora_consulta").flatpickr({
    enableTime: true,
    noCalendar: true,
    dateFormat: "H:i",
    time_24hr: false,
    locale: "es",
  });
  loadData("post", "mascotas/list", "idmascota", "nombre", "idmascota");
});
$(document).on("submit", "#newMascota", function (event) {
  event.preventDefault();
  let form = $(this).serialize();
  let ajaxUrl = base_url + "me/mascotas/save";
  divLoading.css("display", "flex");
  try {
    $.post(ajaxUrl, form, function (data) {
      if (data.status) {
        closeModal();
        resetForm();
        Swal.fire("Menu", data.message, "success");
        tb.api().ajax.reload();
      } else {
        Swal.fire("Error", data.message, "warning");
      }
      divLoading.css("display", "none");
    });
  } catch (error) {
    divLoading.css("display", "none");
    Swal.fire({
      title: "Error",
      text: error,
      icon: "error",
      confirmButtonText: "ok",
    });
  }
});
$(document).on("submit", "#agendarCita", function (event) {
  event.preventDefault();
  let form = $(this).serialize();
  let ajaxUrl = base_url + "me/citas/save";
  divLoading.css("display", "flex");
  try {
    $.post(ajaxUrl, form, function (data) {
      divLoading.css("display", "none");
      if (data.status) {
        $("#agendarCita").trigger("reset");
        $("#idmascota").trigger("change");
        $("#fecha_consulta")
          .flatpickr({
            altInput: true,
            altFormat: "F j, Y",
            dateFormat: "Y-m-d",
            inline: false,
            locale: "es",
          })
          .clear();
        $("#hora_consulta")
          .flatpickr({
            enableTime: true,
            noCalendar: true,
            dateFormat: "H:i",
            time_24hr: false,
            locale: "es",
          })
          .clear();
        Swal.fire("Menu", data.message, "success");
      } else {
        Swal.fire("Error", data.message, "warning");
      }
    });
  } catch (error) {
    divLoading.css("display", "none");
    Swal.fire({
      title: "Error",
      text: error,
      icon: "error",
      confirmButtonText: "ok",
    });
  }
});
$(document).on(
  "click",
  'button[data-bs-target="#navs-left-historial"]',
  function (event) {
    // Listar historial de citas
    tbHistorial = $("#tablaHistorialCitas").dataTable({
      aProcessing: true,
      aServerSide: true,
      language: {
        url: base_url + "js/app/plugins/dataTable.Spanish.json",
      },
      ajax: {
        url: base_url + "me/citas/list",
        method: "POST",
        dataSrc: "",
        data: { order: "fecha_consulta", dir: "desc" },
      },
      columns: [
        {
          width: "25%",
          data: "fecha_consulta",
          render: function (data, type, row) {
            const fecha = formatDate(
              row.fecha_consulta + " " + row.hora_consulta
            );
            return `<p class="capitalize font-bold text-pink-500">${fecha.dayOfWeek} ${fecha.day}, ${fecha.month} ${fecha.year}</p>
          <p class="font-bold text-pink-500">${fecha.hours}:${fecha.minutes} ${fecha.ampm}</p>`;
          },
        },
        {
          width: "25%",
          data: "nombre_mascota",
          render: function (data, type, row) {
            return `<span class="text-base capitalize">${data}</span>`;
          },
        },
        {
          width: "25%",
          data: "motivo_consulta",
          render: function (data, type, row) {
            return `<span class="font-bold text-pink-500 capitalize">${data}</span>`;
          },
        },
        {
          width: "10%",
          data: "idestadocita",
          render: function (data, type, row) {
            switch (data) {
              case 1:
                return `<span class="text-green-500 font-bold d-flex justify-center items-center"><i class='text-lg bx bx-check-circle mr-2'></i>Agendado</span>`;
              case 2:
                return `<span class="text-gray-400 font-bold d-flex justify-center items-center"><i class='text-lg bx bx-check-circle mr-2'></i>Atendido</span>`;
              case 3:
                return `<span class="text-yellow-500 font-bold d-flex justify-center items-center"><i class='text-lg bx bx-x-circle mr-2'></i>Cancelado</span>`;
              case 5:
                return `<span class="text-pink-500 font-bold d-flex justify-center items-center"><i class='text-lg bx bx-bell mr-2'></i>Pendiente</span>`;
              default:
                return `<span class="text-gray-400 font-bold d-flex justify-center items-center"><i class='text-lg bx bx-check-circle mr-2'></i>Atendido</span>`;
            }
          },
        },
        {
          width: "25%",
          render: function (data, type, row) {
            if (row.idestadocita === 1) {
              return `<button onclick="funCancelarCita(${row.idreservacita})" class="text-pink-500 border-2 border-pink-500 transition-all duration-150 shadow-md hover:bg-pink-500 hover:text-white hover:shadow-lg hover:translate-y-0.5 hover:-translate-x-0.5 hover:scale-105 hover:origin-center transform-gpu focus:ring-4 focus:outline-none focus:ring-pink-300 font-medium rounded-lg text-sm p-2 text-center ease-in-out">
            Cancelar cita
            </button>
            `;
            }
            return ``;
          },
          // render: function (data, type, row) {
          //   return generateDropdownMenu(row);
          // },
        },
      ],
      resonsieve: "true",
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
$(document).on(
  "click",
  'button[data-bs-target="#navs-left-vacunas"]',
  function (event) {
    // Listar historial de citas
    $("#tablaVacunas").dataTable({
      aProcessing: true,
      aServerSide: true,
      language: {
        url: base_url + "js/app/plugins/dataTable.Spanish.json",
      },
      ajax: {
        url: base_url + "me/vacunas",
        method: "GET",
        dataSrc: "",
        data: { order: "fecha_vacuna", dir: "desc" },
      },
      columns: [
        {
          width: "25%",
          data: "fecha_vacuna",
          render: function (data, type, row) {
            const fecha = formatDate(row.fecha_vacuna + " 00:00:00");
            return `<p class="capitalize text-base font-normal">${fecha.dayOfWeek} ${fecha.day}, ${fecha.month} ${fecha.year}</p>`;
          },
        },
        {
          width: "25%",
          data: "proxima_vacuna",
          render: function (data, type, row) {
            const fecha = formatDate(row.proxima_vacuna + " 00:00:00");
            return `<p class="capitalize text-base font-normal">${fecha.dayOfWeek} ${fecha.day}, ${fecha.month} ${fecha.year}</p>`;
          },
        },
        {
          width: "25%",
          data: "nombre_mascota",
          render: function (data, type, row) {
            return `<span class="text-base capitalize">${data}</span>`;
          },
        },
        {
          width: "25%",
          data: "tipo_vacuna",
          render: function (data, type, row) {
            return `<span class="font-bold text-pink-500 capitalize">${data}</span>`;
          },
        },
      ],
      resonsieve: "true",
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
$(document).on(
  "click",
  'button[data-bs-target="#navs-left-desparacitacion"]',
  function (event) {
    // Listar historial de citas
    $("#tablaDesparacitaciones").dataTable({
      aProcessing: true,
      aServerSide: true,
      language: {
        url: base_url + "js/app/plugins/dataTable.Spanish.json",
      },
      ajax: {
        url: base_url + "me/desparasitaciones",
        method: "GET",
        dataSrc: "",
        data: { order: "fecha_vacuna", dir: "desc" },
      },
      columns: [
        {
          width: "25%",
          data: "fecha_vacuna",
          render: function (data, type, row) {
            const fecha = formatDate(row.fecha_vacuna + " 00:00:00");
            return `<p class="capitalize text-base font-normal">${fecha.dayOfWeek} ${fecha.day}, ${fecha.month} ${fecha.year}</p>`;
          },
        },
        {
          width: "25%",
          data: "proxima_vacuna",
          render: function (data, type, row) {
            const fecha = formatDate(row.proxima_vacuna + " 00:00:00");
            return `<p class="capitalize text-base font-normal">${fecha.dayOfWeek} ${fecha.day}, ${fecha.month} ${fecha.year}</p>`;
          },
        },
        {
          width: "25%",
          data: "nombre_mascota",
          render: function (data, type, row) {
            return `<span class="text-base capitalize">${data}</span>`;
          },
        },
        {
          width: "25%",
          render: function (data, type, row) {
            return `<p class="capitalize">
              <span class="font-bold text-sm">Administración: </span>
              <span class="text-base">${row.producto}</span>
            </p>
            <p class="capitalize">
              <span class="font-bold text-sm">Medicamento: </span>
              <span class="text-base">${row.tipo}</span>
            </p>`;
          },
        },
      ],
      resonsieve: "true",
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
function resetForm() {
  console.log("resetForm");
  $("#newMascota").trigger("reset");
  loadData("get", "mascotas/especies", "idespecie", "nombre", "idespecie");
  loadData("get", "mascotas/generos", "idgenero", "nombre", "idgenero");
  // loadData("mascotas/razas", "idraza", "nombre", "idraza");
}
function generateDropdownMenu(row) {
  let options = [];
  if (row.edit) {
    options.push(
      generateDropdownOption(
        "Editar",
        "bx bx-edit-alt",
        `fntEdit(${row.idmascota})`
      )
    );
  }
  if (row.delete) {
    options.push(
      generateDropdownOption(
        "Eliminar",
        "bx bx-trash",
        `fntDel(${row.idmascota})`
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
function loadData(method = "get", endpoint, selectId, textKey, valueKey) {
  if (method === "get") {
    $.get(`${base_url}me/${endpoint}`, function (data) {
      populateSelect(selectId, data, textKey, valueKey);
    });
  }

  if (method === "post") {
    $.post(`${base_url}me/${endpoint}`, function (data) {
      populateSelect(selectId, data, textKey, valueKey);
    });
  }
}
function populateSelect(selectId, data, textKeys, valueKey) {
  const selectElement = document.getElementById(selectId);
  selectElement.innerHTML = "";

  // Create and append the default "Seleccione una opcion" option
  const defaultOption = document.createElement("option");
  defaultOption.text = "Seleccione una opción";
  defaultOption.value = "0000";
  selectElement.appendChild(defaultOption);

  // Create and append the options from the data
  data.forEach((item) => {
    const option = document.createElement("option");

    if (Array.isArray(textKeys)) {
      option.text = textKeys.map((key) => item[key]).join(" ");
    } else {
      option.text = item[textKeys];
    }

    option.value = addCeros(item[valueKey], 4);
    selectElement.appendChild(option);
  });

  // Initialize select2
  let select2 = `#${selectId}`;
  $(select2).select2({
    width: "100%",
    placeholder: "Seleccione una opción",
    // dropdownParent: $(select2).parent(),
  });
}
function selectRazas() {
  let selectId = "idraza";
  let textKeys = "nombre";
  let valueKey = "idraza";

  let idespecie = $("#idespecie").val();
  let ajaxUrl = `${base_url}me/mascotas/razas?idespecie=${idespecie}`;

  $.get(ajaxUrl, function (data) {
    const selectElement = document.getElementById(selectId);
    selectElement.innerHTML = "";

    // Create and append the default "Seleccione una opcion" option
    const defaultOption = document.createElement("option");
    defaultOption.text = "Seleccione una opción";
    defaultOption.value = "0000";
    selectElement.appendChild(defaultOption);

    // Create and append the options from the data
    data.forEach((item) => {
      const option = document.createElement("option");

      if (Array.isArray(textKeys)) {
        option.text = textKeys.map((key) => item[key]).join(" ");
      } else {
        option.text = item[textKeys];
      }

      option.value = addCeros(item[valueKey], 4);
      selectElement.appendChild(option);
    });

    // Initialize select2
    let select2 = `#${selectId}`;
    $(select2).select2({
      width: "100%",
      placeholder: "Seleccione una opción",
      dropdownParent: $(select2).parent(),
      language: {
        noResults: function () {
          // Agrega el mensaje y el botón al contenedor del resultado
          return (
            '<div class="no-results-container w-100">' +
            "<p>No se encontraron resultados</p>" +
            '<button id="nuevaRaza" type="button" class="btn btn-sm btn-primary">Crear razas</button>' +
            "</div>"
          );
        },
        searching: function () {
          return "Buscando...";
        },
      },
      escapeMarkup: function (markup) {
        return markup;
      },
    });
  });
}
function calcularEdad(fechaNacimiento, fechaReferencia = new Date()) {
  let years = fechaReferencia.getFullYear() - fechaNacimiento.getFullYear();
  let months = fechaReferencia.getMonth() - fechaNacimiento.getMonth();
  let days = fechaReferencia.getDate() - fechaNacimiento.getDate();

  // Ajustar si el número de meses es negativo
  if (months < 0) {
    years--;
    months += 12;
  }

  // Ajustar si el número de días es negativo
  if (days < 0) {
    months--;
    // Calcular el número de días del mes anterior
    const previousMonthDate = new Date(
      fechaReferencia.getFullYear(),
      fechaReferencia.getMonth() - 1,
      0
    );
    days += previousMonthDate.getDate();
    // Ajustar si restar un mes hizo que los meses sean negativos
    if (months < 0) {
      years--;
      months += 12;
    }
  }

  return { years, months, days };
}
function fntEdit(id) {
  divLoading.css("display", "flex");
  let ajaxUrl = base_url + "me/mascotas/search";
  try {
    $.post(ajaxUrl, { idmascota: id }, function (data) {
      if (data.status) {
        console.log(data.data);
        resetForm();
        setTimeout(() => {
          divLoading.css("display", "none");
          $("#idmascota").val(data.data.idmascota);
          $("#idespecie").val(addCeros(data.data.idespecie)).trigger("change");
          // $("#idraza").val(addCeros(data.data.idraza)).trigger("change");
          z = data.data.idraza;
          $("#idgenero").val(addCeros(data.data.idgenero)).trigger("change");
          $("#nombre").val(data.data.nombre);
          $("#color").val(data.data.color);
          $("#fecha_nacimiento").val(data.data.fecha_nacimiento);
          openModal();
        }, 500);
      } else {
        Swal.fire({
          title: "Error",
          text: data.message,
          icon: "error",
          confirmButtonText: "ok",
        });
      }
    });
  } catch (error) {
    divLoading.css("display", "none");
    Swal.fire({
      title: "Error",
      text: error,
      icon: "error",
      confirmButtonText: "ok",
    });
  }
}
function fntDel(idp) {
  Swal.fire({
    title: "Eliminar Mascotas",
    text: "¿Realmente quiere eliminar Mascotas?",
    icon: "warning",
    showCancelButton: true,
    //   confirmButtonColor: "#3085d6",
    //   cancelButtonColor: "#d33",
    confirmButtonText: "Si, eliminar!",
    cancelButtonText: "No, cancelar!",
  }).then((result) => {
    if (result.isConfirmed) {
      divLoading.css("display", "flex");
      let ajaxUrl = base_url + "me/mascotas/delete";
      $.post(ajaxUrl, { idmascota: idp }, function (data) {
        if (data.status) {
          Swal.fire({
            title: "Eliminado!",
            text: data.message,
            icon: "success",
            confirmButtonText: "ok",
          });
          tb.DataTable().ajax.reload();
          divLoading.css("display", "none");
        } else {
          Swal.fire({
            title: "Error",
            text: data.message,
            icon: "error",
            confirmButtonColor: "#007065",
            confirmButtonText: "ok",
          });
          divLoading.css("display", "none");
        }
      });
    }
  });
}
// Obtener elementos del DOM
const openModalBtn = document.getElementById("openModalBtn");
const modal = document.getElementById("modal");
const modalContent = document.getElementById("modal-content");
// Función para abrir el modal
function openModal() {
  document.body.style.overflow = "hidden";
  modal.classList.remove("hidden");
  setTimeout(() => {
    modal.classList.remove("opacity-0");
    modal.classList.add("opacity-100");
    modalContent.classList.remove("scale-0", "opacity-0");
    modalContent.classList.add("scale-100", "opacity-100");
  }, 50);
}
// Función para cerrar el modal
function closeModal() {
  document.body.style.overflow = "auto";
  modal.classList.remove("opacity-100");
  modal.classList.add("opacity-0");
  modalContent.classList.remove("scale-100", "opacity-100");
  modalContent.classList.add("scale-0", "opacity-0");
  setTimeout(() => {
    modal.classList.add("hidden");
  }, 300); // Debe coincidir con la duración de la transición del fondo
}
// Agregar event listener al botón para abrir el modal
// openModalBtn.addEventListener("click", openModal);
openModalBtn.addEventListener("click", function () {
  resetForm();
  openModal();
});
// Agregar event listener al botón de cierre del modal
const closeModalBtn = modal.querySelectorAll(
  'button[data-modal-toggle="modal"]'
);
// Recorrer todos los closeModalBtn y agregarles el evento click
closeModalBtn.forEach(function (btn) {
  btn.addEventListener("click", closeModal);
});
// closeModalBtn.addEventListener("click", closeModal);

// Cerrar el modal al hacer clic fuera de él
// window.addEventListener("click", function (event) {
//   if (event.target == modal) {
//     closeModal();
//   }
// });
function funCancelarCita(id) {
  Swal.fire({
    title: "Cancelar Cita",
    text: "¿Realmente quiere cancelar la cita?",
    icon: "warning",
    showCancelButton: true,
    confirmButtonText: "Si, eliminar!",
    cancelButtonText: "No, cancelar!",
  }).then((result) => {
    if (result.isConfirmed) {
      divLoading.css("display", "flex");
      let ajaxUrl = base_url + "me/citas/cancelar";
      try {
        $.ajax({
          url: ajaxUrl,
          method: "POST",
          data: { idreservacita: id },
          success: function (data) {
            divLoading.css("display", "none");
            console.log(data);
            // tbHistorial.DataTable().ajax.reload();
            tbHistorial.api().ajax.reload();
          },
          error: function (error) {
            divLoading.css("display", "none");
            console.log(error);
          },
        });
      } catch (error) {
        divLoading.css("display", "none");
        console.log(error);
      }
    }
  });
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
