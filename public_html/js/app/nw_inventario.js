let tb;
$(document).ready(function () {
  // Inicializar tipo_material
  initializeSelect2("#tipo_material");

  // Inicializar condicion_material
  initializeSelect2("#condicion_material");

  initializeSelect2("#idtipomaterial");

  tabla();

  
});

$("#btnNuevo").on("click", function () {
  $("#mdlMateriales").modal("show");
});

$("#btnInventario").on("click", function () {
  $("#mdlInventario").modal("show");
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
        data: "nombre",
        render: function (data, type, row, meta) {
          return data;
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