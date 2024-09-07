let tb;
let z = 0;
$(document).ready(function () {
  const tabOrder = [
    // "idpropietario",
    "nombre",
    // "idespecie",
    // "idraza",
    // "idgenero",
    "color",
    "fecha_nacimiento",
    "btnActionForm",
  ];

  const elements = tabOrder.map((id) => document.getElementById(id));

  elements.forEach((el, index) => {
    el.addEventListener("keydown", (event) => {
      if (event.key === "Tab") {
        event.preventDefault();
        const nextIndex = (index + 1) % elements.length;
        elements[nextIndex].focus();
      }
    });
  });

  tb = $("#tbl").dataTable({
    aProcessing: true,
    aServerSide: true,
    language: {
      url: base_url + "js/app/plugins/dataTable.Spanish.json",
    },
    ajax: {
      url: base_url + "admin/mascotas",
      method: "POST",
      dataSrc: "",
    },
    columns: [
      {
        width: "5%",
        data: "num",
      },
      {
        render: function (data, type, row) {
          // historia_clinica
          return `<span class="fw-bold text-primary">${row.historia_clinica??""}</span>`;
        },
      },
      {
        width: "30%",
        data: "nombre",
        className: "text-capitalize",
        render: function (data, type, row) {
          return `<span class="fw-bold text-primary">${data}</span>`;
        },
      },
      {
        width: "30%",
        data: "propietario",
        className: "text-capitalize",
      },
      {
        width: "25%",
        data: "raza",
      },
      {
        width: "10%",
        render: function (data, type, row) {
          return generateDropdownMenu(row);
        },
      },
    ],
    resonsieve: "true",
    bDestroy: true,
    iDisplayLength: 10,
    // order: [[0, "desc"]],
    scrollX: true,
  });
  $("#idespecie").on("change", function () {
    selectRazas();
  });

  $("#mdlMascotas").on("shown.bs.modal", function () {
    $("#idraza").val(addCeros(z)).trigger("change");
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
  let ajaxUrl = base_url + "admin/mascotas/save";
  try {
    $.post(ajaxUrl, form, function (data) {
      if (data.status) {
        $("#mdlMascotas").modal("hide");
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
  return false;
}
function fntEdit(id) {
  divLoading.css("display", "flex");
  resetForm();
  setTimeout(() => {
    let ajaxUrl = base_url + "admin/mascotas/search";
    $("#modal-title").html("Actualizar Mascota " + id);
    $("#btnText").html("Actualizar");
    $("#btnActionForm")
      .removeClass("btn-outline-primary")
      .addClass("btn-outline-info");
    $("#frmMascotas").attr("onsubmit", "return update(this,event)");
    //
    try {
      $.post(ajaxUrl, { idmascota: id }, function (data) {
        if (data.status) {
          divLoading.css("display", "none");
          $("#idmascota").val(data.data.idmascota);
          $("#idpropietario")
            .val(addCeros(data.data.idpropietario))
            .trigger("change");
          $("#idespecie").val(addCeros(data.data.idespecie)).trigger("change");
          // $("#idraza").val(addCeros(data.data.idraza)).trigger("change");
          z = data.data.idraza;
          $("#idgenero").val(addCeros(data.data.idgenero)).trigger("change");
          $("#nombre").val(data.data.nombre);
          $("#color").val(data.data.color);
          $("#fecha_nacimiento").val(data.data.fecha_nacimiento);
          $("#mdlMascotas").modal("show");
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
  }, 500);
}
function update(ths, e) {
  // let men_nombre = $("#name").val();
  let form = $(ths).serialize();
  // if (men_nombre == "") {
  //   Swal.fire("Atención", "Es necesario un nombre para continuar.", "warning");
  //   return false;
  // }
  divLoading.css("display", "flex");
  let ajaxUrl = base_url + "admin/mascotas/update";
  $.post(ajaxUrl, form, function (data) {
    if (data.status) {
      $("#mdlMascotas").modal("hide");
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
      let ajaxUrl = base_url + "admin/mascotas/delete";
      $.post(ajaxUrl, { idmascota: idp }, function (data) {
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
  $("#btnActionForm").removeClass("btn-outline-info");
  $("#btnActionForm").addClass("btn-outline-primary");
  $("#btnText").html("Guardar");
  $("#modal-title").html("Crear nueva mascota");
  $("#idmascota").val("");
  $("#frmMascotas").attr("onsubmit", "return save(this,event)");
  $("#frmMascotas").trigger("reset");
  $("#mdlMascotas").modal("show");
}
function resetForm(ths) {
  $("#frmMascotas").trigger("reset");
  loadData(
    "propietarios",
    "idpropietario",
    ["nombres", "apellidos"],
    "idpropietario"
  );
  loadData("especies", "idespecie", "nombre", "idespecie");
  // loadData("razas", "idraza", "nombre", "idraza");
  // selectRazas();
  loadData("generos", "idgenero", "nombre", "idgenero");
  $(ths).attr("onsubmit", "return save(this,event)");
  $("#btnText").html("Guardar");
  $("#btnActionForm").removeClass("btn-info").addClass("btn-outline-primary");
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
function loadData(endpoint, selectId, textKey, valueKey) {
  $.get(`${base_url}admin/mascotas/${endpoint}`, function (data) {
    populateSelect(selectId, data, textKey, valueKey);
  });
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
    dropdownParent: $(select2).parent(),
  });
}
function selectRazas() {
  let selectId = "idraza";
  let textKeys = "nombre";
  let valueKey = "idraza";

  let idespecie = $("#idespecie").val();
  let ajaxUrl = `${base_url}admin/mascotas/razas?idespecie=${idespecie}`;

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
$(document).on("click", "#nuevaRaza", function () {
  $("#nombreRaza").val($(".select2-search__field").val());

  // Save the current modal
  let currentModal = $("#mdlMascotas");

  // Close the current modal
  currentModal.modal("hide");

  // Open the second modal
  $("#mdlRazas").modal("show");

  // When the second modal is closed
  $("#mdlRazas").on("hidden.bs.modal", function () {
    // Reopen the current modal
    currentModal.modal("show");
    selectRazas();
  });
});
$(document).on("submit", "#frmRazas", function (e) {
  e.preventDefault();
  let form = $(this).serialize();
  divLoading.css("display", "flex");
  let ajaxUrl = base_url + "admin/razas/save";
  $.post(ajaxUrl, form, function (data) {
    if (data.status) {
      $("#mdlRazas").modal("hide");
      $("#frmRazas").trigger("reset");
      Swal.fire("Menu", data.message, "success");
    } else {
      Swal.fire("Error", data.message, "warning");
    }
    divLoading.css("display", "none");
  });
});
