let tb;
$(document).ready(function () {
  tb = $("#tbl").dataTable({
    aProcessing: true,
    aServerSide: true,
    language: {
      url: base_url + "js/app/plugins/dataTable.Spanish.json",
    },
    ajax: {
      url: base_url + "admin/servicios",
      method: "POST",
      dataSrc: "",
    },
    columns: [
      {
        data: "num",
        with: "5%",
        className: "text-primary",
      },
      {
        data: "nombre",
        with: "auto",
        className: "fw-semibold",
      },
      {
        data: "precio",
        with: "10%",
        className: "text-success fw-semibold",
        render: function (data, type, row) {
          return `S/ ${data}`;
        },
      },
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
        with: "10%",
        render: function (data, type, row) {
          return generateDropdownMenu(row);
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
  $(".form-control").on("input", limitChars);
});
function save(ths, e) {
  let form = $(ths).serialize();
  if ($("#nombre").val() == "") {
    Swal.fire("Atención", "Es necesario un nombre para continuar.", "warning");
    return false;
  }
  divLoading.css("display", "flex");
  let ajaxUrl = base_url + "admin/servicios/save";
  $.post(ajaxUrl, form, function (data) {
    if (data.status) {
      $("#mdlServicios").modal("hide");
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
  let ajaxUrl = base_url + "admin/servicios/search";
  $("#modal-title span").html("Actualizar Servicio " + id);
  $("#btnText").html("Actualizar");
  $("#btnActionForm")
    .removeClass("btn-outline-primary")
    .addClass("btn-outline-info");
  $("#frmServicios").attr("onsubmit", "return update(this,event)");
  $("#mdlServicios").modal("show");
  //
  $.post(ajaxUrl, { idservicio: id }, function (data) {
    if (data.status) {
      $("#idservicio").val(data.data.idservicio);
      $("#nombre").val(data.data.nombre);
      $("#descripcion").val(data.data.descripcion);
      $("#precio").val(data.data.precio);
      $("#estado").prop("checked", data.data.estado == 1 ? true : false);
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
  let form = $(ths).serialize();
  if ($("#nombre").val() == "") {
    Swal.fire("Atención", "Es necesario un nombre para continuar.", "warning");
    return false;
  }
  divLoading.css("display", "flex");
  let ajaxUrl = base_url + "admin/servicios/update";
  $.post(ajaxUrl, form, function (data) {
    if (data.status) {
      $("#mdlServicios").modal("hide");
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
    title: "Eliminar Servicios",
    text: "¿Realmente quiere eliminar Servicios?",
    icon: "warning",
    showCancelButton: true,
    //   confirmButtonColor: "#3085d6",
    //   cancelButtonColor: "#d33",
    confirmButtonText: "Si, eliminar!",
    cancelButtonText: "No, cancelar!",
  }).then((result) => {
    if (result.isConfirmed) {
      let ajaxUrl = base_url + "admin/servicios/delete";
      $.post(ajaxUrl, { idservicio: idp }, function (data) {
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
  $("#modal-title span").html("Crear servicios");
  $("#idservicio").val("");
  $("#frmServicios").attr("onsubmit", "return save(this,event)");
  $("#frmServicios").trigger("reset");
  $("#mdlServicios").modal("show");
}
function resetForm(ths) {
  $("#frmServicios").trigger("reset");
  $("#idservicio").val("");
  $(ths).attr("onsubmit", "return save(this,event)");
  $("#btnText").html("Guardar");
  $("#btnActionForm").removeClass("btn-info").addClass("btn-outline-primary");
  $("#modal-title span").html("Crear servicios");
}
function generateDropdownMenu(row) {
  let options = [];
  if (row.edit) {
    options.push(
      generateDropdownOption(
        "Editar",
        "bx bx-edit-alt",
        `fntEdit(${row.idservicio})`
      )
    );
  }
  if (row.delete) {
    options.push(
      generateDropdownOption(
        "Eliminar",
        "bx bx-trash",
        `fntDel(${row.idservicio})`
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
