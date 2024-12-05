let tb;
$(document).ready(function () {
  limpiarFecha();

  $("#fecha_ingreso")
    .flatpickr({
      altInput: true,
      altFormat: "l j F, Y",
      dateFormat: "Y-m-d",
      inline: false,
      locale: "es",
    })
    .setDate(new Date());

  autosize($("#observaciones"));

  tb = $("#tbl").dataTable({
    // sProcessing: true,
    // bServerSide: true,
    language: {
      url: base_url + "js/app/plugins/dataTable.Spanish.json",
    },
    ajax: {
      url: base_url + "admin/ingresos",
      method: "POST",
      dataSrc: "",
    },
    columns: [
      {
        data: null,
        className: "px-2",
        render: function (data, type, row, meta) {
          return generateDropdownMenu(data);
        },
      },
      {
        data: null,
        className: "text-center px-2",
        render: function (data, type, row, meta) {
          return `<button type="button" class="btn p-0 m-0 text-secondary" onclick="verArticulosIngreso(${data.idinventario},'${data.codigo}')">
            <i class='bx bx-search-alt bx-sm' ></i>
          </button>
          <button type="button" class="btn p-0 m-0 text-warning" onclick="agregarArticulo(this,${data.idinventario},'${data.codigo}')">
            <i class='bx bxs-folder-plus bx-sm' ></i>
          </button>
          <button type="button" class="btn p-0 m-0 text-info d-none">
            <i class='bx bx-save bx-sm'></i>
          </button>
          `;
          // return meta.row + 1;
        },
      },
      {
        data: null,
        className: "px-1 text-center",
        render: function (data, type, row, meta) {
          return data.codigo;
        },
      },
      {
        data: null,
        className: "px-2 text-center",
        render: function (data, type, row, meta) {
          // reemplazar los "-" por "/" en la fecha
          let fecha = data.fecha_ingreso.split("-");
          fecha = fecha.join("/");
          return fecha;
        },
      },
      {
        data: null,
        className: "px-2 text-center",
        render: function (data, type, row, meta) {
          return data.total_articulos;
        },
      },
      {
        // datos del ingreso
        data: null,
        className: "px-2",
        width: "70%",
        render: function (data, type, row, meta) {
          // motivo_ingreso
          const motivoMap = {
            1: "Compras",
            2: "Devolución",
            3: "Inventario",
            4: "No especificado",
            5: "Transferencia",
          };
          const tipoDocumentoMap = {
            1: "Cargo",
            2: "No especificado",
          };
          const motivo = motivoMap[data.motivo_ingreso] ?? "No especificado";
          const tipo_documento =
            tipoDocumentoMap[data.tipo_documento] ?? "No especificado";
          const observaciones =
            data.observaciones ??
            `<span class="text-warning"><i class='bx bxs-alarm-exclamation'></i> No se encontraron datos.</span>`;
          return `<p class="m-0 p-0 fw-bold text-capitalize">Motivo ingreso: <span class="fw-bold text-primary">${motivo}</span></p>
          <p class="mb-2 p-0 fw-bold text-capitalize">Tipo Documento: <span class="fw-bold text-primary">${tipo_documento}</span></p>
          <p class="fw-normal form-text m-0 p-0">${observaciones}</p>`;
        },
      },
    ],
    responsieve: true,
    bDestroy: true,
    iDisplayLength: 10,
    // order: [[2, "desc"]],
    scrollX: true,
  });
});

$("#btnNuevo").on("click", function () {
  resetForm();
  $("#mdlIngresos").modal("show");
});

$("#limpiar").on("click", function () {
  resetForm();
});

$("#cargar_fecha_hoy").on("click", function () {
  $("#fecha_vencimiento")
    .flatpickr({
      altInput: true,
      altFormat: "l j F, Y",
      dateFormat: "Y-m-d",
      inline: false,
      locale: "es",
    })
    .setDate(new Date());
});

$("#limpiar_fecha_hoy").on("click", function () {
  limpiarFecha();
});

$("#frmIngresos").submit(function (e) {
  e.preventDefault();
  divLoading.css("display", "flex");
  let formData = $("#frmIngresos").serialize();
  $.post(base_url + "admin/ingresos/save", formData, function () {})
    .done(function (response) {
      if (response.status) {
        tb.api().ajax.reload();
        resetForm();
      }
      Swal.fire(
        response.status ? "Éxito" : "Error",
        response.message,
        response.status ? "success" : "error"
      );
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

$("#frmIngresosArticulos").submit(function (e) {
  e.preventDefault();
  divLoading.css("display", "flex");
  let formData = $("#frmIngresosArticulos").serialize();
  $.post(base_url + "admin/ingresos/save/art", formData, function () {})
    .done(function (response) {
      if (response.status) {
        tb.api().ajax.reload();
        resetFormArt();
      }
      Swal.fire(
        response.status ? "Éxito" : "Error",
        response.message,
        response.status ? "success" : "error"
      );
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
    .always(function () {
      divLoading.css("display", "none");
    });
});

function initializeSelect2(selector) {
  $(selector).select2({
    width: "100%",
    placeholder: "Seleccione una opción",
    dropdownParent: $(selector).parent(),
  });
}

function generateDropdownMenu(row) {
  let options = [];
  if (row.edit) {
    options.push(
      generateDropdownOption(
        "Editar",
        "bx bx-edit-alt",
        `fntEdit(${row.idinventario})`
      )
    );
  }
  if (row.delete) {
    options.push(
      generateDropdownOption(
        "Eliminar",
        "bx bx-trash",
        `fntDel(${row.idinventario})`
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
        <div class="dropdown">
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

// funcion para generar un boton de agregar inventario, la funcion recibe el id del material
function generateBtnInventario(idmaterial) {
  return `<button class="btn btn-outline-primary fw-bold btn-sm" type="button" onclick="fntAddInventario(${idmaterial})">Agregar</button>`;
}

function fntAddInventario(idmaterial) {
  $("#idmaterial").val(idmaterial);
  $("#mdlInventario").modal("show");
}

function resetForm() {
  $("#frmIngresos").trigger("reset");
  $("#id").val("");
  $("#fecha_ingreso")
    .flatpickr({
      altInput: true,
      altFormat: "l j F, Y",
      dateFormat: "Y-m-d",
      inline: false,
      locale: "es",
    })
    .setDate(new Date());
}

function resetFormArt() {
  $("#frmIngresosArticulos").trigger("reset");
  $("#id").val("");
  $("#fecha_vencimiento")
    .flatpickr({
      altInput: true,
      altFormat: "l j F, Y",
      dateFormat: "Y-m-d",
      inline: false,
      locale: "es",
    })
    .setDate("");

  $("#lista_articulos").val("").trigger("change");
  $("#estado_articulos").val("").trigger("change");
  $("#und_medida").val("").trigger("change");
}

function initializeSelect2(selector, placeholder) {
  $(selector).select2({
    width: "100%",
    placeholder: placeholder,
    dropdownParent: $(selector).parent(),
  });
}

function agregarArticulo(ths, idinventario, codigo) {
  $("#modal-title .title-text").text("Ingreso N°: " + codigo);
  $("#idingreso").val(idinventario);

  const productosPromise = listProductos();
  const estadosPromise = listEstados();
  const undMedidaPromise = listUndMedida();

  productosPromise.then(() =>
    initializeSelect2("#lista_articulos", "Seleccione una opción")
  );
  estadosPromise.then(() =>
    initializeSelect2("#estado_articulos", "Seleccione una opción")
  );
  undMedidaPromise.then(() =>
    initializeSelect2("#und_medida", "Seleccione una opción")
  );

  // esperar a que todas las promesas se resuelvan
  Promise.all([productosPromise, estadosPromise, undMedidaPromise]).then(() => {
    resetFormArt();
    $("#estado_articulos").val(2).trigger("change");
    $("#und_medida").val(2).trigger("change");
    $("#mdlAgregar").modal("show");
  });
}

function listProductos() {
  return new Promise((resolve, reject) => {
    $.get(base_url + "admin/ingresos/p", function (response) {})
      .done(function (response) {
        $("#lista_articulos").empty();
        response.forEach((element) => {
          $("#lista_articulos").append(
            `<option value="${element.id}-${element.idtipo}">${element.nombre}</option>`
          );
        });
        resolve(response);
      })
      .fail(function (jqXHR, textStatus, errorThrown) {
        reject(errorThrown);
      });
  });
}

function listEstados() {
  return new Promise((resolve, reject) => {
    $.get(base_url + "admin/ingresos/e", function (response) {})
      .done(function (response) {
        $("#estado_articulos").empty();
        response.forEach((element) => {
          $("#estado_articulos").append(
            `<option ${element.idcondicion == 2 ? "selected" : ""} value="${
              element.idcondicion
            }">${element.nombre}</option>`
          );
        });
        resolve(response);
      })
      .fail(function (jqXHR, textStatus, errorThrown) {
        reject(errorThrown);
      });
  });
}

function listUndMedida() {
  return new Promise((resolve, reject) => {
    $.get(base_url + "admin/ingresos/u", function (response) {})
      .done(function (response) {
        $("#und_medida").empty();
        response.forEach((element) => {
          $("#und_medida").append(
            `<option value="${element.idmedida}">${element.nombre}</option>`
          );
        });
        resolve(response);
      })
      .fail(function (jqXHR, textStatus, errorThrown) {
        reject(errorThrown);
      });
  });
}

function limpiarFecha() {
  $("#fecha_vencimiento")
    .flatpickr({
      altInput: true,
      altFormat: "l j F, Y",
      dateFormat: "Y-m-d",
      inline: false,
      locale: "es",
    })
    .setDate("");
}

function verArticulosIngreso(id, codigo) {
  $(".title-articulos-ingreso .ver-articulos-ingreso").text(codigo);
  $.post(base_url + "admin/ingresos/view", { id }, function () {})
    .done(function (response) {
      if (response.status) {
        $("#tbl2").dataTable({
          data: response.data,
          language: {
            url: base_url + "js/app/plugins/dataTable.Spanish.json",
          },
          columns: [
            {
              data: null,
              width: "5%",
              className: "text-center px-1",
              render: function (data, type, row, meta) {
                return meta.row + 1;
              },
            },
            {
              data: null,
              className: "px-0",
              render: function (data, type, row, meta) {
                return data.insumo
                  ? data.insumo
                  : data.material
                  ? data.material
                  : data.producto;
              },
            },
            {
              data: "cantidad",
              className: "text-center px-0",
              render: function (data, type, row, meta) {
                // si es caja agregar la cantidad y el factor, pero si no es caja solo la cantidad
                return row.medida == "Caja"
                  ? `${data} cajas x ${row.factor}`
                  : `${data} Und.`;
              },
            },
            {
              data: "estado",
              className: "text-center px-0",
            },
            {
              data: null,
              className: "text-center",
              render: function (data, type, row, meta) {
                return generateBtnBrush(data, id, codigo);
              },
            },
          ],
          responsieve: true,
          bDestroy: true,
          iDisplayLength: 10,
          searching: false,
          lengthChange: false,
        });
        $("#mdlVer").modal("show");
      }
      Toast.fire({
        icon: response.status ? "success" : "error",
        title:
          response.data.length > 0
            ? "Listo!"
            : "No hay articulos agregados en este ingreso",
      });
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
    .always(function () {
      divLoading.css("display", "none");
    });
}

function generateBtnBrush(data, id, codigo) {
  return `<button class="btn p-1 btn-sm border-0 text-danger" type="button" onclick="delArticuloIngreso(${data.idinventariodetalle},${id},'${codigo}')">
  <img src="/img/bin_empty.png" class="w-px-20 d-none">
  <i class='bx bx-trash-alt bx-sm' ></i>
  </button>`;
}

function delArticuloIngreso(id, l, n) {
  Swal.fire({
    title: "Eliminar permisos",
    text: "¿Realmente quiere eliminar permisos?",
    icon: "warning",
    showCancelButton: true,
    confirmButtonText: "Si, eliminar!",
    cancelButtonText: "No, cancelar!",
  }).then((result) => {
    if (result.isConfirmed) {
      $.post(base_url + "admin/ingresos/delete/art", { id }, function () {})
        .done(function (response) {
          if (response.status) {
            verArticulosIngreso(l, n);
          }
          tb.DataTable().ajax.reload();
          Swal.fire(
            response.status ? "Éxito" : "Error",
            response.message,
            response.status ? "success" : "error"
          );
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
        .always(function () {
          divLoading.css("display", "none");
        });
    }
  });
}

function fntEdit(id) {
  resetForm();
  divLoading.css("display", "flex");
  let ajaxUrl = base_url + "admin/ingresos/search";
  $.post(ajaxUrl, { id }, function () {})
    .done(function (response) {
      $(".title-ingresos span").text(
        " : " +
          response.data.codigo +
          "|" +
          response.data.fecha_ingreso.split("-").join("")
      );
      $("#fecha_ingreso")
        .flatpickr({
          altInput: true,
          altFormat: "l j F, Y",
          dateFormat: "Y-m-d",
          inline: false,
          locale: "es",
        })
        .setDate(response.data.fecha_ingreso);
      $("#motivo_ingreso").val(response.data.motivo_ingreso);
      $("#tipo_documento").val(response.data.tipo_documento);
      $("#observaciones").val(response.data.observaciones);
      $("#id").val(response.data.idinventario);
      $("#mdlIngresos").modal("show");
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
    .always(function () {
      divLoading.css("display", "none");
    });
}

function fntDel(id) {
  Swal.fire({
    title: "Eliminar Ingreso",
    text: "¿Realmente quiere eliminar ingreso?",
    icon: "warning",
    showCancelButton: true,
    confirmButtonText: "Si, eliminar!",
    cancelButtonText: "No, cancelar!",
  }).then((result) => {
    if (result.isConfirmed) {
      let ajaxUrl = base_url + "admin/ingresos/delete";
      $.post(ajaxUrl, { id }, function () {})
        .done(function (response) {
          if (response.status) {
            tb.DataTable().ajax.reload();
          }
          Swal.fire(
            response.status ? "Éxito" : "Error",
            response.message,
            response.status ? "success" : "error"
          );
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
        .always(function () {
          divLoading.css("display", "none");
        });
    }
  });
}
