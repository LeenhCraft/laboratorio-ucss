let tb, tbl;
$(document).ready(function () {
  tb = $("#tbl").dataTable({
    aProcessing: true,
    aServerSide: true,
    language: {
      url: base_url + "js/app/plugins/dataTable.Spanish.json",
    },
    ajax: {
      url: base_url + "admin/laboratorio",
      method: "POST",
      dataSrc: "",
    },
    rowCallback: function (row, data, index) {
      $(row).addClass("table-default");
      fecha = data.fecha;
      hora_inicio = data.hora_inicio;
      hora_fin = data.hora_fin;

      if (fecha < new Date().toLocaleDateString("en-CA")) {
        $(row).addClass("table-light");
      } else if (fecha == new Date().toLocaleDateString("en-CA")) {
        horaActual = new Date().toLocaleTimeString("it-IT", {
          hour: "2-digit",
          minute: "2-digit",
        });
        if (hora_inicio < horaActual && hora_fin > horaActual) {
          $(row).addClass("table-success");
        } else if (hora_inicio < horaActual && hora_fin < horaActual) {
          $(row).addClass("table-info");
        }
      }
      if (data.cancelado == 1) {
        $(row).addClass("cancelled-row table-light");

        // Agregar un div contenedor para mantener el layout original
        $("td:first", row).prepend(`
          <div class="cancelled-banner">
            <div class="cancelled-content">
              <i class="fa-solid fa-ban me-2"></i>
              <span class="cancelled-text">Ingreso Cancelado</span>
            </div>
          </div>
        `);
      }

      // ------------------------
    },
    columns: [
      {
        data: null,
        width: "10%",
        className: "text-center px-1",
        render: function (data, type, row, meta) {
          let labelCancelado = "";
          if (row.cancelado == 1) {
            labelCancelado = `<span class="badge bg-label-danger">Cancelado</span>`;
          }
          // agregar el boton solo si no se ha pasado la fecha y la hora
          if (
            row.fecha >= new Date().toLocaleDateString("en-CA") &&
            row.cancelado == 0
          ) {
            return `<button 
              class="btn px-1 text-danger" 
              type="button" 
              title="cancelar ingreso" 
              onclick="cancelarIngreso('${data.idingreso}','${data.fecha}','${data.hora_fin}')"
            >
              <i class="fa-solid fa-ban me-1"></i>
              <span class="small fw-semibold">Cancelar</span>
          </button>
          <button class="btn px-1 badge bg-label-success" type="button" title="Agregar Articulos" onclick="modalCargo('${data.idingreso}')">
            <i class="fa-solid fa-boxes-packing bx-sm"></i>
          </button>
          `;
          }
          if (row.fecha <= new Date().toLocaleDateString("en-CA")) {
            return `
            <button class="btn px-1 badge bg-label-dark" type="button" title="Ver Articulos Prestados" onclick="verArticulos('${data.idingreso}')">
            <i class="fa-solid fa-box bx-sm"></i>
          </button>
            `;
          }
          return "";
        },
      },
      {
        data: null,
        width: "5%",
        className: "text-center px-0",
        render: function (data, type, row, meta) {
          return data.fecha;
        },
      },
      {
        data: null,
        className: "text-center px-0 fw-semibold",
        width: "5%",
        render: function (data, type, row, meta) {
          return (
            formatTime(data.hora_inicio) + " - " + formatTime(data.hora_fin)
          );
        },
      },
      {
        data: null,
        render: function (data, type, row, meta) {
          return data.docente;
        },
      },
      {
        data: null,
        className: "text-capitalize",
        render: function (data, type, row, meta) {
          return data.titulo_practica;
        },
      },
      {
        render: function (data, type, row) {
          return generateDropdownMenu(row);
        },
      },
    ],
    iDisplayLength: 25,
    order: [
      [1, "desc"],
      [2, "asc"],
    ],
    scrollX: true,
  });
});

$("#btnNuevo").on("click", function () {
  resetForm();
  $("#mdlLaboratorio").modal("show");
});

$("#limpiar").on("click", function () {
  resetForm();
  $(".nuevo-input").hide("slow");
  $(".anterior-input").show("slow");
  $("#nombreDocente").val("");
});

$("#frmLaboratorio").submit(function (e) {
  e.preventDefault();
  divLoading.css("display", "flex");
  let formData = $("#frmLaboratorio").serialize();
  $.post(base_url + "admin/laboratorio/save", formData, function () {})
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

$("#hora_inicio").on("change", function () {
  let horaInicio = $(this).val();
  let [horas, minutos] = horaInicio.split(":").map(Number);
  let fecha = new Date();
  fecha.setHours(horas);
  fecha.setMinutes(minutos);
  fecha.setMinutes(fecha.getMinutes() + 45);
  let horasFormateadas = fecha.getHours().toString().padStart(2, "0");
  let minutosFormateados = fecha.getMinutes().toString().padStart(2, "0");
  $("#hora_fin").val(`${horasFormateadas}:${minutosFormateados}`);
});

$("#nuevoDocente").on("click", function () {
  $("#mdlLaboratorio").modal("hide");
  Swal.fire({
    title: "<strong>HTML <u>example</u></strong>",
    icon: "info",
    html: `
      <div class="text-start mb-3">
        <label class="fw-bold form-label text-capitalize" for="nuevoCodigo">Código UCSS</label>
        <input id="nuevoCodigo" name="nuevoCodigo" type="text" class="form-control">
      </div>
      <div class="text-start">
        <label class="fw-bold form-label text-capitalize" for="nuevoNombre">Nombre</label>
        <input id="nuevoNombre" name="nuevoNombre" type="text" class="form-control">
      </div>
    `,
    // evitar que al hacer clicl fuera del modal se cierre
    allowOutsideClick: false,
    // evitar que se cierre al presionar la tecla ESC
    allowEscapeKey: false,
    showCloseButton: true,
    showCancelButton: true,
    confirmButtonText: `
      <i class="fa fa-thumbs-up"></i> Great!
    `,
    cancelButtonText: `
      <i class="fa fa-thumbs-down"></i>
    `,
    preConfirm: async (login) => {
      return {
        codigo: $("#nuevoCodigo").val(),
        nombre: $("#nuevoNombre").val(),
      };
    },
  }).then((result) => {
    if (result.isConfirmed) {
      // peticion ajax a /admin/laboratorio/d
      $.post(
        base_url + "admin/laboratorio/d",
        {
          codigo: result.value.codigo,
          nombre: result.value.nombre,
        },
        function () {}
      )
        .done(function (response) {
          if (response.status) {
            // listDocentes().then(() => {
            //   $("#iddocente").select2({
            //     width: "100%",
            //     placeholder: "Seleccione una opción",
            //     dropdownParent: $("#iddocente").parent(),
            //   });
            // });
            listDocentes().then(() => {
              $("#iddocente").select2({
                width: "100%",
                placeholder: "Seleccione una opción",
                dropdownParent: $("#iddocente").parent(),
              });
              $("#iddocente").val(response.data.iddocente).trigger("change");
            });
          }
          $("#mdlLaboratorio").modal("show");
          Toast.fire(
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
        });
    }
    // cuando se presiona el botón de cancelar
    else if (result.dismiss === Swal.DismissReason.cancel) {
      Toast.fire({
        icon: "info",
        title: "info",
      });
    }

    // cuando se preciona la x del modal
    else if (result.dismiss === Swal.DismissReason.close) {
      alert("cerrado");
    }
  });
});

function resetForm() {
  $("#frmLaboratorio").trigger("reset");
  $("#id").val("");
  $("#fecha").flatpickr({
    altInput: true,
    altFormat: "j F, Y",
    dateFormat: "Y-m-d",
    inline: false,
    locale: "es",
    defaultDate: new Date(),
  });

  $("#hora_fin,#hora_inicio").val(
    new Date().toLocaleTimeString("it-IT", {
      hour: "2-digit",
      minute: "2-digit",
    })
  );

  listDocentes().then(() => {
    $("#iddocente").select2({
      width: "100%",
      placeholder: "Seleccione una opción",
      dropdownParent: $("#iddocente").parent(),
    });
  });

  $("#iddocente").prop("disabled", false);
  $("#hora_inicio").prop("disabled", false);
  $("#hora_fin").prop("disabled", false);
  $("#nuevoDocente").prop("disabled", false);
}

function generateDropdownMenu(row) {
  let options = [];
  if (row.edit && row.fecha >= new Date().toLocaleDateString("en-CA")) {
    options.push(
      generateDropdownOption(
        "Editar",
        "bx bx-edit-alt",
        `fntEdit(${row.idingreso})`
      )
    );
  }

  if (row.edit && row.fecha < new Date().toLocaleDateString("en-CA")) {
    options.push(
      generateDropdownOption("Sin acciones", "bx bxs-info-circle", ``)
    );
  }

  if (row.delete) {
    options.push(
      generateDropdownOption(
        "Eliminar",
        "bx bx-trash",
        `fntDel(${row.idingreso})`
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

function listDocentes() {
  return new Promise((resolve, reject) => {
    $.get(base_url + "admin/laboratorio/docentes", function (response) {})
      .done(function (response) {
        $("#iddocente").empty();
        $("#iddocente").append(
          `<option value="" selected>Seleccione una opción</option>`
        );
        response.forEach((element) => {
          $("#iddocente").append(
            `<option value="${element.iddocente}">${element.nombre}</option>`
          );
        });
        resolve(response);
      })
      .fail(function (jqXHR, textStatus, errorThrown) {
        reject(errorThrown);
      });
  });
}

function listMateriales() {
  return new Promise((resolve, reject) => {
    $.get(base_url + "admin/laboratorio/m", function (response) {})
      .done(function (response) {
        resolve(response);
      })
      .fail(function (jqXHR, textStatus, errorThrown) {
        reject(errorThrown);
      });
  });
}

// Función para sumar minutos a una hora en formato "HH:mm"
function addMinutesToTimeForFlatpickr(timeStr, minutesToAdd) {
  // Crear una fecha base para hoy
  const today = new Date();

  // Separar las horas y minutos
  const [hours, minutes] = timeStr.split(":").map(Number);

  // Establecer la hora y minutos en la fecha
  today.setHours(hours);
  today.setMinutes(minutes);

  // Sumar los minutos
  today.setMinutes(today.getMinutes() + minutesToAdd);

  // Formatear para Flatpickr (que acepta objeto Date directamente)
  return today;
}

function fntEdit(id) {
  resetForm();
  divLoading.css("display", "flex");
  let ajaxUrl = base_url + "admin/laboratorio/search";
  $.post(ajaxUrl, { id }, function () {})
    .done(function (response) {
      if (response.status) {
        $("#mdlLaboratorio").modal("show");
        $(".title-laboratorio span").text(
          "Laboratorio - Nuevo Ingreso : " + addCeros(response.data.idingreso)
        );
        $("#titulo_practica").val(response.data.titulo_practica);
        $("#nro_practicas").val(response.data.nro_practicas);
        listDocentes().then(() => {
          $("#iddocente").val(response.data.iddocente).trigger("change");
        });
        $("#carrera").val(response.data.carrera);
        $("#asignatura").val(response.data.asignatura);
        $("#turno").val(response.data.turno);
        $("#ciclo").val(response.data.ciclo);
        $("#hora_inicio").val(response.data.hora_inicio);
        $("#hora_fin").val(response.data.hora_fin);
        $("#nro_estudiantes").val(response.data.nro_estudiantes);
        $("#id").val(response.data.idingreso);
        // disabled
        $("#iddocente").prop("disabled", true);
        $("#hora_inicio").prop("disabled", true);
        $("#hora_fin").prop("disabled", true);
        $("#fecha")
          .flatpickr({
            altInput: true,
            altFormat: "j F, Y",
            dateFormat: "Y-m-d",
            inline: false,
            locale: "es",
            defaultDate: response.data.fecha,
          })
          .set("clickOpens", false);
        $("#nuevoDocente").prop("disabled", true);
      }
      Toast.fire({
        icon: response.status ? "success" : "error",
        title: response.message,
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

function fntDel(id) {
  Swal.fire({
    title: "Atención!",
    text: "No esta permitido eliminar registros",
    icon: "info",
    confirmButtonText: "OK",
  });
}

function formatTime(time) {
  return time.slice(0, 5);
}

function modalCargo(id) {
  $("#idingreso").val(id);
  $("#cantidad").val(1);
  //
  divLoading.css("display", "flex");
  let ajaxUrl = base_url + "admin/laboratorio/search";
  $.post(ajaxUrl, { id }, function () {})
    .done(function (response) {
      if (response.status) {
        $("#ver_titulo").text(response.data.titulo_practica);
        listDocentes().then((docentes) => {
          $("#ver_docente").text(
            docentes.find(
              (docente) => docente.iddocente == response.data.iddocente
            ).nombre
          );
        });
        listMateriales().then((materiales) => {
          $("#idbien").empty();
          $("#idbien").append(
            `<option value="" selected>Seleccione una opción</option>`
          );
          materiales.forEach((element) => {
            $("#idbien").append(
              `<option value="${element.idbalance}">${element.nombre}</option>`
            );
          });
          $("#idbien").select2({
            width: "100%",
            placeholder: "Seleccione una opción",
            dropdownParent: $("#idbien").parent(),
          });
        });
        tbl = $("#tbll").DataTable({
          aProcessing: true,
          aServerSide: true,
          language: {
            url: base_url + "js/app/plugins/dataTable.Spanish.json",
          },
          ajax: {
            url: base_url + "admin/laboratorio/lm",
            method: "POST",
            data: {
              id,
            },
            dataSrc: "",
          },
          columns: [
            {
              data: "nombre",
            },
            {
              className: "text-center",
              data: "cantidad",
            },
            {
              data: "estado",
            },
            {
              data: null,
              className: "text-center",
              render: function (data, type, row, meta) {
                return generateBtnBrush(data);
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
        $("#mdlCargo").modal("show");
      }
      Toast.fire({
        icon: response.status ? "success" : "error",
        title: response.message,
      });
    })
    .fail(function (jqXHR, textStatus, errorThrown) {
      Toast.fire({
        icon: "error",
        title: "error: " + errorThrown,
      });
      console.log(jqXHR, textStatus, errorThrown);
    })
    .always(function () {
      divLoading.css("display", "none");
    });
}

function verArticulos(id) {
  divLoading.css("display", "flex");
  $("#lista-articulos").DataTable({
    aProcessing: true,
    aServerSide: true,
    language: {
      url: base_url + "js/app/plugins/dataTable.Spanish.json",
    },
    ajax: {
      url: base_url + "admin/laboratorio/lm",
      method: "POST",
      data: {
        id,
      },
      dataSrc: "",
    },
    columns: [
      {
        data: "nombre",
      },
      {
        className: "text-center",
        data: "cantidad",
      },
      {
        data: "estado",
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
  $("#mdlListaArticulos").modal("show");
  divLoading.css("display", "none");
}

function generateBtnBrush(data) {
  return `<button class="btn p-1 btn-sm border-0 text-danger" type="button" onclick="delArticuloIngreso('${data.iddetalle}')">
  <img src="/img/bin_empty.png" class="w-px-20 d-none">
  <i class='bx bx-trash-alt bx-sm' ></i>
  </button>`;
}

$("#add-bien").on("click", function () {
  let id = $("#idbien").val();
  let idingreso = $("#idingreso").val();
  let cantidad = $("#cantidad").val();
  divLoading.css("display", "flex");
  $.post(
    base_url + "admin/laboratorio/sm",
    {
      id,
      idingreso,
      cantidad,
    },
    function () {}
  )
    .done(function (response) {
      if (response.status) {
        tbl.ajax.reload();
      }
      Toast.fire({
        icon: response.status ? "success" : "error",
        title: response.message,
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
});

function delArticuloIngreso(id) {
  Swal.fire({
    title: "Eliminar articulo",
    text: "¿Quieres eliminar este articulo?",
    icon: "warning",
    showCancelButton: true,
    confirmButtonText: "Si, eliminar!",
    cancelButtonText: "No, cancelar!",
  }).then((result) => {
    if (result.isConfirmed) {
      $.post(base_url + "admin/laboratorio/dm", { id }, function () {})
        .done(function (response) {
          if (response.status) {
            tbl.ajax.reload();
          }
          Toast.fire({
            icon: response.status ? "success" : "error",
            title: response.message,
          });
        })
        .fail(function (jqXHR, textStatus, errorThrown) {
          Toast.fire({
            icon: "error",
            title: "error: " + errorThrown,
          });
          console.log(jqXHR, textStatus, errorThrown);
        })
        .always(function () {
          divLoading.css("display", "none");
        });
    }
  });
}

// necesito crear una función que me permita cancelar un ingreso
// solo se podran cancelar un ingreso si la fecha es mayor a la actual y las
// horas son mayores a la actual, para cancelar el ingreso debo enviar al backend
// el id del ingreso y el motivo de la cancelación
// el backend debe devolver un mensaje de confirmación
// si el ingreso se cancela, se debe recargar la tabla
// si el ingreso no se cancela, se debe mostrar un mensaje de error
/* function cancelarIngreso(id) {
  Swal.fire({
    title: "Cancelar Ingreso",
    text: "¿Quieres cancelar este ingreso?",
    icon: "warning",
    showCancelButton: true,
    confirmButtonText: "Si, cancelar!",
    cancelButtonText: "No, cancelar!",
  }).then((result) => {
    if (result.isConfirmed) {
      $.post(base_url + "admin/laboratorio/c", { id }, function () {})
        .done(function (response) {
          if (response.status) {
            tb.api().ajax.reload();
          }
          Toast.fire({
            icon: response.status ? "success" : "error",
            title: response.message,
          });
        })
        .fail(function (jqXHR, textStatus, errorThrown) {
          Toast.fire({
            icon: "error",
            title: "error: " + errorThrown,
          });
          console.log(jqXHR, textStatus, errorThrown);
        })
        .always(function () {
          divLoading.css("display", "none");
        });
    }
  });
} */

async function cancelarIngreso(id, fechaIngreso, hora) {
  // Validar que el ingreso sea cancelable
  const ahora = new Date();
  const fechaHoraIngreso = new Date(`${fechaIngreso} ${hora}`);

  if (fechaHoraIngreso <= ahora) {
    Swal.fire({
      icon: "error",
      title: "No se puede cancelar",
      text: "Solo se pueden cancelar ingresos futuros.",
    });
    return;
  }

  // Solicitar motivo de cancelación
  const { value: motivo, isConfirmed: motivoConfirmado } = await Swal.fire({
    title: "Cancelar Ingreso",
    input: "textarea",
    inputLabel: "Motivo de cancelación",
    inputPlaceholder: "Ingrese el motivo de la cancelación...",
    inputAttributes: {
      maxlength: "250",
      required: "true",
    },
    showCancelButton: true,
    confirmButtonText: "Sí, cancelar",
    cancelButtonText: "No, volver",
    inputValidator: (value) => {
      if (!value?.trim()) {
        return "Debe ingresar un motivo de cancelación";
      }
    },
  });

  if (!motivoConfirmado) return;

  // Confirmación final
  const { isConfirmed } = await Swal.fire({
    title: "¿Está seguro?",
    html: `
          <p>Se cancelará el ingreso con el siguiente motivo:</p>
          <p class="text-muted">${motivo}</p>
      `,
    icon: "warning",
    showCancelButton: true,
    confirmButtonText: "Sí, cancelar ingreso",
    cancelButtonText: "No, volver",
    confirmButtonColor: "#d33",
  });

  if (!isConfirmed) return;

  // Mostrar loading
  divLoading.css("display", "flex");

  try {
    const response = await $.ajax({
      url: `${base_url}admin/laboratorio/c`,
      method: "POST",
      data: {
        id,
        motivo,
        fecha_cancelacion: new Date().toISOString(),
      },
    });
    console.log(response);

    if (response.status) {
      await Swal.fire({
        icon: "success",
        title: "Ingreso cancelado",
        text: response.message,
        timer: 2000,
        timerProgressBar: true,
      });

      // Recargar tabla
      if (typeof tb !== "undefined" && tb.api) {
        tb.api().ajax.reload(null, false); // false para mantener la página actual
      }
    } else {
      throw new Error(response.message || "Error al cancelar el ingreso");
    }
  } catch (error) {
    console.error("Error:", error);

    Swal.fire({
      icon: "error",
      title: "Error",
      text: error.message || "Ocurrió un error al procesar la solicitud",
      footer:
        "<p class='m-0'>Si el problema persiste, contacte al administrador</p>",
    });
  } finally {
    divLoading.css("display", "none");
  }
}
