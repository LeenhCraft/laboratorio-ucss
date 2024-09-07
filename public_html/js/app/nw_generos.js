let tb;
$(document).ready(function () {
tb = $("#tbl").dataTable({
    aProcessing: true,
    aServerSide: true,
    language: {
    url: base_url + "js/app/plugins/dataTable.Spanish.json",
    },
    ajax: {
    url: base_url + "admin/generos",
    method: "POST",
    dataSrc: "",
    },
    columns: [
        {data: "idgenero"},
		{data: "nombre"},
		{data: "estado"},
		{data: "eliminado"},
		{data: "fecha_registro"},
		{data: "ultima_actualizacion"},
		{
			render: function (data, type, row) {
				return generateDropdownMenu(row);
			}}
    ],
    resonsieve: "true",
    bDestroy: true,
    iDisplayLength: 25,
    // order: [[0, "desc"]],
    scrollX: true,
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
    let ajaxUrl = base_url + "admin/generos/save";
    $.post(ajaxUrl, form, function (data) {
      if (data.status) {
        $("#mdlGeneros").modal("hide");
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
    let ajaxUrl = base_url + "admin/generos/search";
    $("#modal-title").html("Actualizar Generos " + id);
    $("#btnText").html("Actualizar");
    $("#btnActionForm").removeClass("btn-outline-primary").addClass("btn-outline-info");
    $("#frmGeneros").attr("onsubmit", "return update(this,event)");
    $("#mdlGeneros").modal("show");
    //
    $.post(ajaxUrl, { idgenero: id }, function (data) {
      if (data.status) {
        $("#idgenero").val(data.data.idgenero);
$("#nombre").val(data.data.nombre);
$("#estado").val(data.data.estado);
$("#eliminado").val(data.data.eliminado);
$("#fecha_registro").val(data.data.fecha_registro);
$("#ultima_actualizacion").val(data.data.ultima_actualizacion);

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
    let ajaxUrl = base_url + "admin/generos/update";
    $.post(ajaxUrl, form, function (data) {
      if (data.status) {
        $("#mdlGeneros").modal("hide");
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
      title: "Eliminar Generos",
      text: "¿Realmente quiere eliminar Generos?",
      icon: "warning",
      showCancelButton: true,
    //   confirmButtonColor: "#3085d6",
    //   cancelButtonColor: "#d33",
      confirmButtonText: "Si, eliminar!",
      cancelButtonText: "No, cancelar!",
    }).then((result) => {
      if (result.isConfirmed) {
        let ajaxUrl = base_url + "admin/generos/delete";
        $.post(ajaxUrl, { idgenero: idp }, function (data) {
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
    $("#modal-title").html("Crear Nuevo Generos");
    $("#idgenero").val("");
    $("#frmGeneros").attr("onsubmit", "return save(this,event)");
    $("#frmGeneros").trigger("reset");
    $("#mdlGeneros").modal("show");
}
function resetForm(ths) {
    $("#frmGeneros").trigger("reset");
    $("#idgenero").val("");
    $(ths).attr("onsubmit", "return save(this,event)");
    $("#btnText").html("Guardar");
    $("#btnActionForm").removeClass("btn-info").addClass("btn-outline-primary");
    $("#modal-title").html("Crear Nuevo Generos");
}
function generateDropdownMenu(row) {
    let options = [];
    if (row.edit) {
        options.push(
            generateDropdownOption(
              "Editar",
              "bx bx-edit-alt",
              `fntEdit(${row.idgenero})`
            )
        );
    }
    if (row.delete) {
        options.push(
          generateDropdownOption(
            "Eliminar",
            "bx bx-trash",
            `fntEdit(${row.idgenero})`
          )
        );
    }
    if (!row.edit && !row.delete) {
        options.push(
          generateDropdownOption(
            "Sin acciones",
            "bx bxs-info-circle",
            ``
          )
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