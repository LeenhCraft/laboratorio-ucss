let tb;
$(document).ready(function () {
  $("#idpropietario").on("change", function () {
    cargarMascotas($("#idpropietario").val());
  });

  tb = $("#tbl").dataTable({
    aProcessing: true,
    aServerSide: true,
    language: {
      url: base_url + "js/app/plugins/dataTable.Spanish.json",
    },
    ajax: {
      url: base_url + "admin/vacunaciones",
      method: "POST",
      dataSrc: "",
    },
    columns: [
      { data: "num" },
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
      {
        render: function (data, type, row) {
          return generateDropdownMenu(row);
        },
      },
    ],
    resonsieve: true,
    bDestroy: true,
    iDisplayLength: 10,
    bFilter: false,
    bSort: false,
    bPaginate: true,
    bInfo: false,
    bAutoWidth: false,
    scrollX: false,
  });
});
function save(ths, e) {
  // let men_nombre = $("#name").val();
  let form = $(ths).serialize();
  // if (men_nombre == "") {
  //   Swal.fire("Atención", "Es necesario un nombre para continuar.", "warning");
  //   return false;
  // }
  divLoading.css("display", "flex");
  let ajaxUrl = base_url + "admin/vacunaciones/save";
  $.post(ajaxUrl, form, function (data) {
    if (data.status) {
      $("#mdlVacunaciones").modal("hide");
      resetForm();
      Swal.fire("Menu", data.message, "success");
      tb.api().ajax.reload();
    } else {
      Swal.fire("Error", data.message, "warning");
    }
    divLoading.css("display", "none");
  });
  return false;
}
function fntEdit(id) {
  resetForm();
  let ajaxUrl = base_url + "admin/vacunaciones/search";
  $("#modal-title").html("Actualizar Vacunaciones " + id);
  $("#btnText").html("Actualizar");
  $("#btnActionForm")
    .removeClass("btn-outline-primary")
    .addClass("btn-outline-info");
  $("#frmVacunaciones").attr("onsubmit", "return update(this,event)");
  //
  $.post(ajaxUrl, { idvacuna: id }, function (data) {
    if (data.status) {
      $("#idvacuna").val(data.data.idvacuna);
      cargarPropietarios(data.data.idpropietario).then(() => {
        cargarMascotas(data.data.idpropietario, data.data.idmascota);
      });
      // evitar change event de idpropietario
      $("#edad").val(data.data.edad);
      $("#tipo_vacuna").val(data.data.tipo_vacuna);
      $("#fecha_vacuna").flatpickr().clear();
      $("#proxima_vacuna").flatpickr().clear();
      if (data.data.fecha_vacuna != "") {
        $("#fecha_vacuna")
          .flatpickr({
            altInput: true,
            altFormat: "F j, Y",
            dateFormat: "Y-m-d",
            inline: false,
            locale: "es",
          })
          .setDate(data.data.fecha_vacuna);
      }
      if (data.data.proxima_vacuna != "") {
        $("#proxima_vacuna")
          .flatpickr({
            altInput: true,
            altFormat: "F j, Y",
            dateFormat: "Y-m-d",
            inline: false,
            locale: "es",
          })
          .setDate(data.data.proxima_vacuna);
      }
      $("#peso").val(data.data.peso);
      $("#mdlVacunaciones").modal("show");
    } else {
      Swal.fire({
        title: "Error",
        text: data.message,
        icon: "error",
        confirmButtonText: "ok",
      });
    }
  });
}
function update(ths, e) {
  // let men_nombre = $("#name").val();
  let form = $(ths).serialize();
  // if (men_nombre == "") {
  //   Swal.fire("Atención", "Es necesario un nombre para continuar.", "warning");
  //   return false;
  // }
  divLoading.css("display", "flex");
  let ajaxUrl = base_url + "admin/vacunaciones/update";
  $.post(ajaxUrl, form, function (data) {
    if (data.status) {
      $("#mdlVacunaciones").modal("hide");
      resetForm();
      Swal.fire("Menu", data.message, "success");
      tb.api().ajax.reload();
    } else {
      Swal.fire("Error", data.message, "warning");
    }
    divLoading.css("display", "none");
  });
  return false;
}
function fntDel(idp) {
  Swal.fire({
    title: "Eliminar Vacunaciones",
    text: "¿Realmente quiere eliminar Vacunaciones?",
    icon: "warning",
    showCancelButton: true,
    //   confirmButtonColor: "#3085d6",
    //   cancelButtonColor: "#d33",
    confirmButtonText: "Si, eliminar!",
    cancelButtonText: "No, cancelar!",
  }).then((result) => {
    if (result.isConfirmed) {
      let ajaxUrl = base_url + "admin/vacunaciones/delete";
      $.post(ajaxUrl, { idvacuna: idp }, function (data) {
        if (data.status) {
          Swal.fire({
            title: "Eliminado!",
            text: data.message,
            icon: "success",
            confirmButtonText: "ok",
          });
          tb.DataTable().ajax.reload();
        } else {
          Swal.fire({
            title: "Error",
            text: data.message,
            icon: "error",
            confirmButtonColor: "#007065",
            confirmButtonText: "ok",
          });
        }
      });
    }
  });
}
function openModal() {
  resetForm();
  cargarPropietarios().then(() => {
    $("#btnActionForm").removeClass("btn-outline-info");
    $("#btnActionForm").addClass("btn-outline-primary");
    $("#btnActionForm span").html("Guardar");
    $("#modal-title span").html("Crear Nuevo Vacunaciones");
    $("#idvacuna").val("");
    $("#fecha_vacuna").flatpickr({
      altInput: true,
      altFormat: "F j, Y",
      dateFormat: "Y-m-d",
      inline: false,
      locale: "es",
    });

    $("#proxima_vacuna").flatpickr({
      altInput: true,
      altFormat: "F j, Y",
      dateFormat: "Y-m-d",
      inline: false,
      locale: "es",
    });
    $("#fecha_vacuna").flatpickr().clear();
    $("#proxima_vacuna").flatpickr().clear();
    $("#frmVacunaciones").attr("onsubmit", "return save(this,event)");
    $("#mdlVacunaciones").modal("show");
  });
}
function resetForm() {
  $("#frmVacunaciones").trigger("reset");
  $("#idvacuna").val("");
  $("#frmVacunaciones").attr("onsubmit", "return save(this,event)");
  $("#btnActionForm span").html("Guardar");
  $("#btnActionForm").removeClass("btn-info").addClass("btn-outline-primary");
  if ($("#idmascota").data("select2")) {
    $("#idmascota").select2("destroy").empty().select2();
  }
  $("#modal-title span").html("Crear Nuevo Vacunaciones");
}
function generateDropdownMenu(row) {
  let options = [];
  if (row.edit) {
    options.push(
      generateDropdownOption(
        "Editar",
        "bx bx-edit-alt",
        `fntEdit(${row.idvacuna})`
      )
    );
  }
  if (row.delete) {
    options.push(
      generateDropdownOption(
        "Eliminar",
        "bx bx-trash",
        `fntDel(${row.idvacuna})`
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
function cargarPropietarios(idPropietarioSeleccionado = null) {
  return new Promise((resolve, reject) => {
    $.get(`${base_url}admin/vacunaciones/propietarios`, function (data) {
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
      `${base_url}admin/vacunaciones/mascotas?id=${idPropietario}`,
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
