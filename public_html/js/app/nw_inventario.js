let tb;
$(document).ready(function () {
  tabla();
});

$("#btnNuevo").on("click", function () {
  resetForm();
  $("#mdlMateriales").modal("show");
});

$("#btnInventario").on("click", function () {
  $("#mdlInventario").modal("show");
});

$("#limpiar").on("click", function () {
  resetForm();
});

$("#frmMateriales").submit(function (e) {
  e.preventDefault();
  divLoading.css("display", "flex");
  let formData = $("#frmMateriales").serialize();
  // console.table(formData);
  $.post(base_url + "admin/inventario/save", formData, function (response) {})
    .done(function (response) {
      console.log(response);
      if (response.status) {
        Swal.fire("Éxito", response.message, "success");
        tb.api().ajax.reload();
        resetForm();
        $("#mdlMateriales").modal("hide");
      } else {
        Swal.fire("Error", response.message, "error");
      }
    })
    .fail(function (jqXHR, textStatus, errorThrown) {
      Toast.fire({
        icon: "error",
        title: "error: " + errorThrown,
      });
      console.log(jqXHR);
      console.log(textStatus);
      console.log(errorThrown);
    })
    .always(function (response) {
      divLoading.css("display", "none");
    });
});

$("#filtros").submit(function (e) {
  e.preventDefault();
  divLoading.css("display", "flex");
  tabla();
  divLoading.css("display", "none");
});

function initializeSelect2(selector) {
  $(selector).select2({
    width: "100%",
    placeholder: "Seleccione una opción",
    dropdownParent: $(selector).parent(),
  });
}

function tabla(data = null) {
  tb = $("#tbl").dataTable({
    aProcessing: true,
    aServerSide: true,
    language: {
      url: base_url + "js/app/plugins/dataTable.Spanish.json",
    },
    ajax: {
      url: base_url + "admin/inventario",
      method: "POST",
      dataSrc: "",
      data: function (d) {
        var filtros = $("#filtros").serializeArray();
        filtros.forEach(function (filtro) {
          d[filtro.name] = filtro.value;
        });
      },
    },
    columns: [
      {
        data: null,
        width: "5%",
        render: function (data, type, row, meta) {
          return meta.row + 1;
        },
      },
      {
        data: "codigo_ucss",
        width: "5%",
        render: function (data, type, row, meta) {
          return data;
        },
      },
      {
        data: "tipo",
        width: "5%",
        render: function (data, type, row, meta) {
          let badgeTypes = {
            1: '<span class="fw-normal text-primary">Material</span>',
            2: '<span class="fw-normal text-success">Insumo</span>',
            3: '<span class="fw-normal text-warning">Productos</span>',
          };

          let badge =
            badgeTypes[data] || '<span class="badge bg-danger">Sin tipo</span>';
          return badge;
        },
      },
      {
        data: "nombre",
        className: "fw-semibold",
        render: function (data, type, row, meta) {
          return data;
        },
      },
      {
        data: null,
        render: function (data, type, row, meta) {
          return data.stock;
        },
      },
      {
        data: null,
        render: function (data, type, row, meta) {
          return generateDropdownMenu(data);
        },
      },
    ],
    responsieve: true,
    bDestroy: true,
    iDisplayLength: 10,
    // order: [[0, "desc"]],
  });
}

function generateDropdownMenu(row) {
  let options = [];
  if (row.edit) {
    options.push(
      generateDropdownOption(
        "Editar",
        "bx bx-edit-alt",
        `fntEdit('${row.id}','${row.tipo}')`
      )
    );
  }
  if (row.delete) {
    options.push(
      generateDropdownOption(
        "Eliminar",
        "bx bx-trash",
        `fntDel('${row.id}','${row.tipo}')`
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

function fntEdit(id, tipo) {
  let ajaxUrl = base_url + "admin/inventario/search";
  resetForm();
  divLoading.css("display", "flex");
  $.post(ajaxUrl, { id, tipo }, function (response) {})
    .done(function (response) {
      if (response.status) {
        Toast.fire({
          icon: "success",
          title: "Datos cargados correctamente.",
        });
        let data = response.data;
        $("#idmaterial").val(data.id);
        $("#idtipomaterial").val(data.idtipomaterial);
        $("#tipo_material_original").val(data.idtipomaterial);
        $("#nombre").val(data.nombre);
        $("#modelo").val(data.modelo);
        $("#codigo_ucss").val(data.codigo_ucss);
        $("#observaciones").val(data.observaciones);
        $("#mdlMateriales").modal("show");
      }
    })
    .fail(function (jqXHR, textStatus, errorThrown) {
      Toast.fire({
        icon: "error",
        title: "error: " + errorThrown,
      });
      console.log(jqXHR);
      console.log(textStatus);
      console.log(errorThrown);
    })
    .always(function (response) {
      divLoading.css("display", "none");
    });
}

function resetForm() {
  $("#frmMateriales").trigger("reset");
  $("#idmaterial").val("");
  $("#tipo_material_original").val("");
}

function fntDel(id) {
  Swal.fire({
    text: "No se puede eliminar este registro.",
    icon: "info",
    confirmButtonText: "OK",
  });
}
