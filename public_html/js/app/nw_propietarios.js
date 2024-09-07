let tb;
$(document).ready(function () {
  tb = $("#tbl").dataTable({
    aProcessing: true,
    aServerSide: true,
    language: {
      url: base_url + "js/app/plugins/dataTable.Spanish.json",
    },
    ajax: {
      url: base_url + "admin/propietarios",
      method: "POST",
      dataSrc: "",
    },
    columns: [
      { data: "num" },
      { data: "nombres" },
      { data: "celular" },
      {
        data: "estado",
        render: function (data, type, row) {
          if (data == 1) {
            return `<i class='bx bxs-check-circle text-success'></i>`;
          } else {
            return `<i class='bx bxs-x-circle text-danger'></i>`;
          }
        },
      },
      {
        render: function (data, type, row) {
          return generateDropdownMenu(row);
        },
      },
    ],
    resonsieve: "true",
    bDestroy: true,
    iDisplayLength: 10,
    scrollX: true,
  });
});
function save(ths, e) {
  let form = $(ths).serialize();
  if ($("#nombre").val() == "") {
    Swal.fire("Atención", "Es necesario un nombre para continuar.", "warning");
    return false;
  }
  divLoading.css("display", "flex");
  let ajaxUrl = base_url + "admin/propietarios/save";
  try {
    $.post(ajaxUrl, form, function (data) {
      if (data.status) {
        $("#mdlPropietarios").modal("hide");
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
    console.error("Error: ", error);
  }
  return false;
}
function fntEdit(id) {
  resetForm();
  let ajaxUrl = base_url + "admin/propietarios/search";
  $("#modal-title span").html("Actualizar propietario " + id);
  $("#btnText").html("Actualizar");
  $("#btnActionForm")
    .removeClass("btn-outline-primary")
    .addClass("btn-outline-info");
  $("#frmPropietarios").attr("onsubmit", "return update(this,event)");
  $("#mdlPropietarios").modal("show");
  //
  $.post(ajaxUrl, { idpropietario: id }, function (data) {
    if (data.status) {
      $("#idpropietario").val(data.data.idpropietario);
      $("#nombres").val(data.data.nombres);
      $("#apellidos").val(data.data.apellidos);
      $("#celular").val(data.data.celular);
      $("#direccion").val(data.data.direccion);
      $("#estado").prop("checked", data.data.estado == 1 ? true : false);
      $("#fecha_registro").val(data.data.fecha_registro.split(" ")[0]);
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
  let ajaxUrl = base_url + "admin/propietarios/update";
  $.post(ajaxUrl, form, function (data) {
    if (data.status) {
      $("#mdlPropietarios").modal("hide");
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
    title: "Eliminar Propietarios",
    text: "¿Realmente quiere eliminar Propietarios?",
    icon: "warning",
    showCancelButton: true,
    //   confirmButtonColor: "#3085d6",
    //   cancelButtonColor: "#d33",
    confirmButtonText: "Si, eliminar!",
    cancelButtonText: "No, cancelar!",
  }).then((result) => {
    if (result.isConfirmed) {
      let ajaxUrl = base_url + "admin/propietarios/delete";
      $.post(ajaxUrl, { idpropietario: idp }, function (data) {
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
  $("#modal-title span").html("Registrar nuevo propietario");
  $("#idpropietario").val("");
  $("#frmPropietarios").attr("onsubmit", "return save(this,event)");
  $("#mdlPropietarios").modal("show");
}
function resetForm(ths) {
  $("#frmPropietarios").trigger("reset");
  $("#idpropietario").val("");
  $(ths).attr("onsubmit", "return save(this,event)");
  $("#btnText").html("Guardar");
  $("#btnActionForm").removeClass("btn-info").addClass("btn-outline-primary");
  $("#modal-title span").html("Registrar nuevo propietario");
}
function generateDropdownMenu(row) {
  let options = [];
  if (row.edit) {
    options.push(
      generateDropdownOption(
        "Editar",
        "bx bx-edit-alt",
        `fntEdit(${row.idpropietario})`
      )
    );
  }
  if (row.delete) {
    options.push(
      generateDropdownOption(
        "Eliminar",
        "bx bx-trash",
        `fntDel(${row.idpropietario})`
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
