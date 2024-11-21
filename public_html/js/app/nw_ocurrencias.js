let tb;
$(document).ready(function () {
  const urlParams = new URLSearchParams(window.location.search);
  const idingreso = urlParams.get("idingreso");
  if (idingreso) {
    resetForm().then((msg) => {
      console.log("resetForm", idingreso);
      $("#titulo_practica").val(idingreso).trigger("change");
    });

    $("#mdlOcurrencias").modal("show");
  }
  cargar_ocurrencias(null);
});

$("#btn_filt").on("click", function () {
  let params = $("#filtros").serialize();
  cargar_ocurrencias(params);
});

function resetForm() {
  return new Promise((resolve, reject) => {
    try {
      $("#formOcurrencia").trigger("reset");
      const tbody = $("#lista-materiales tbody");
      materiales = [];
      tbody.empty();
      $("#idocurrencia").val("");
      autosize($("#descripcion"));
      listIngresos().then(() => {
        $("#titulo_practica").select2({
          width: "100%",
          placeholder: "Seleccione una opción",
          dropdownParent: $("#titulo_practica").parent(),
        });
        resolve("Formulario reseteado correctamente");
      });
    } catch (error) {
      reject("Error al resetear el formulario: " + error);
    }
  });
}

function cargar_ocurrencias(params) {
  let url = base_url + "admin/ocurrencias/list";
  if (params) {
    url += "?" + params;
  }

  // solucionar problema de reinicializacion de la tabla
  if ($.fn.DataTable.isDataTable("#tbl")) {
    $("#tbl").DataTable().destroy();
  }

  tb = $("#tbl").dataTable({
    // sProcessing: true,
    // bServerSide: true,
    language: {
      url: base_url + "js/app/plugins/dataTable.Spanish.json",
    },
    ajax: {
      url: url,
      method: "GET",
      dataSrc: "",
    },
    columns: [
      {
        data: "fecha",
        render: function (data, type, row, meta) {
          // Función auxiliar para determinar las clases de estado y severidad
          const getStatusClass = (idestado) => {
            const estados = {
              1: "bg-label-success",
              2: "bg-label-warning",
              3: "bg-label-info",
            };
            return estados[idestado] || "bg-label-secondary";
          };

          const getSeverityClass = (idseveridad) => {
            const severidades = {
              1: "bg-label-success",
              2: "bg-label-warning",
              3: "bg-label-danger",
            };
            return severidades[idseveridad] || "bg-label-secondary";
          };

          // Función para convertir los IDs a texto
          const getStatusText = (idestado) => {
            const estados = {
              1: "Atendido",
              2: "Pendiente",
              3: "Completado",
            };
            return estados[idestado] || "Desconocido";
          };

          const getSeverityText = (idseveridad) => {
            const severidades = {
              1: "Baja",
              2: "Media",
              3: "Alta",
            };
            return severidades[idseveridad] || "Desconocida";
          };

          return `
            <div class="col-12 col-md-8 mx-auto bg-white rounded-2 shadow-sm mb-4">
              <div class="p-4 border-bottom">
                <div class="d-flex align-items-center justify-content-between mb-2">
                  <div>
                    <p class="p-0 m-0 fw-bold fs-5 text-secondary">
                      ${row.titulo_practica}
                    </p>
                    <div class="d-flex align-items-center gap-2 text-black fs-normal">
                      <i class='bx bx-time'></i>
                      ${row.fecha}
                    </div>
                  </div>
                  <div>
                    <div class="d-flex flex-column align-items-end gap-2">
                      <span class="px-2 py-1 rounded-2 fw-semibold badge ${getStatusClass(
                        row.idestado
                      )}">
                        ${getStatusText(row.idestado)}
                      </span>
                      <span class="px-2 py-1 rounded-2 fw-semibold badge ${getSeverityClass(
                        row.idseveridad
                      )}">
                        Severidad ${getSeverityText(row.idseveridad)}
                      </span>
                    </div>
                  </div>
                </div>
              </div>
              <div class="px-4 py-2 my-3 gap-2 d-flex flex-column">
                <div class="d-flex align-items-center gap-2">
                  <i class='bx bx-user'></i>
                  <span>
                    Estudiante: ${row.estudiante || "No asignado"}
                  </span>
                </div>
                <div class="d-flex align-items-center gap-2">
                  <i class='bx bx-user'></i>
                  <span>
                    Docente: ${row.docente}
                  </span>
                </div>
                <div class="d-flex align-items-center gap-2">
                  <i class='bx bx-book-open'></i>
                  <span>
                    Curso: ${row.asignatura}
                  </span>
                </div>
                <div class="d-flex align-items-center gap-2">
                  <i class='bx bxs-bell-ring'></i>
                  <span>
                    ${row.descripcion}
                  </span>
                </div>
              </div>
              <div class="p-2 bg-body rounded-bottom border-top d-flex justify-content-end gap-2">
                <button type="button" class="btn" onclick="verDetalles('${
                  row.idocurrencia
                }')">
                  <i class='bx bx-file text-info'></i>
                </button>
                <button type="button" class="btn" onclick="editarOcurrencia('${
                  row.idocurrencia
                }')">
                  <i class='bx bx-edit-alt text-success'></i>
                </button>
                <button type="button" class="btn" onclick="eliminarOcurrencia('${
                  row.idocurrencia
                }')">
                  <i class='bx bx-trash text-danger'></i>
                </button>
              </div>
            </div>
          `;
        },
      },
    ],
    initComplete: function () {
      Toast.fire({
        icon: "success",
        title: "Tabla cargada correctamente",
      });
      // O específicamente para el contenedor de datos
      $(".dataTables_wrapper").css("padding", "0");
    },
    iDisplayLength: 25,
    lengthMenu: [5, 10, 15, 25, 50, 100],
    scrollX: true,
    searching: false,
    lengthChange: false,
    // order: [[0, "desc"]],
  });
}

function verDetalles(id) {
  divLoading.css("display", "flex");
  let formData = new FormData();
  formData.append("idocurrencia", id);

  $.ajax({
    url: base_url + "admin/ocurrencias/search",
    type: "POST",
    data: formData,
    processData: false,
    contentType: false,
    success: function (response) {
      if (response.status) {
        // Llenar los datos en el modal
        const data = response.data;
        console.log(data);

        // Actualizar el título y fecha
        $("#mdlVerOcurrencias .fs-5.text-secondary").text(data.titulo_practica);
        $("#mdlVerOcurrencias .bx-time")
          .closest("div")
          .find("span")
          .text(data.fecha);

        // Actualizar estado y severidad
        const estados = {
          1: { text: "Resuelto", class: "bg-label-success" },
          2: { text: "Pendiente", class: "bg-label-warning" },
        };

        const severidades = {
          1: { text: "Severidad Baja", class: "bg-label-success" },
          2: { text: "Severidad Media", class: "bg-label-warning" },
          3: { text: "Severidad Alta", class: "bg-label-danger" },
        };

        // Actualizar badges de estado y severidad
        const estadoBadge = estados[data.idestado] || {};
        const severidadBadge = severidades[data.idseveridad] || {};

        $("#mdlVerOcurrencias .badge")
          .first()
          .text(estadoBadge.text)
          .removeClass()
          .addClass(`badge ${estadoBadge.class}`);

        $("#mdlVerOcurrencias .badge")
          .last()
          .text(severidadBadge.text)
          .removeClass()
          .addClass(`badge ${severidadBadge.class}`);

        // Actualizar información de estudiante, docente y curso
        $("#mdlVerOcurrencias .bx-user")
          .first()
          .closest("div")
          .find("span")
          .text(`Estudiante: ${data.estudiante}`);
        $("#mdlVerOcurrencias .bx-user")
          .last()
          .closest("div")
          .find("span")
          .text(`Docente: ${data.docente}`);
        $("#mdlVerOcurrencias .bx-book-open")
          .closest("div")
          .find("span")
          .text(`Curso: ${data.asignatura}`);
        $("#mdlVerOcurrencias .bxs-bell-ring")
          .closest("div")
          .find("span")
          .text(data.descripcion);

        // Limpiar y llenar la tabla de materiales
        const tbody = $("#ver-materiales tbody");
        tbody.empty();

        data.detalle.forEach((item) => {
          tbody.append(`
            <tr>
              <td>${item.nombre}</td>
              <td>${item.cantidad}</td>
              <td>${item.observaciones || "-"}</td>
            </tr>
          `);
        });

        $("#btnGenerarPDF")
          .off("click")
          .on("click", function () {
            generarPDF(data);
          });

        $("#mdlVerOcurrencias").modal("show");
        Toast.fire({
          icon: "success",
          title: response.message,
        });
      } else {
        Swal.fire("Error", response.message, "error");
      }
    },
    error: function (jqXHR, textStatus, errorThrown) {
      Toast.fire({
        icon: "error",
        title: "error: " + errorThrown,
      });
      console.log(jqXHR, textStatus, errorThrown);
    },
    complete: function (response) {
      divLoading.css("display", "none");
    },
  });
}

function generarPDF(data) {
  divLoading.css("display", "flex");

  // Generar URL segura con base_url
  const pdfURL =
    base_url + "admin/ocurrencias/generarpdf?idocurrencia=" + data.idocurrencia;

  // Abrir en nueva pestaña
  const newWindow = window.open(pdfURL, "_blank");

  // Establecer el título de la nueva pestaña
  newWindow.document.title = `Ocurrencia-${data.titulo_practica}`;

  divLoading.css("display", "none");
}

function editarOcurrencia(id) {
  divLoading.css("display", "flex");
  let formData = new FormData();
  formData.append("idocurrencia", id);

  $.ajax({
    url: base_url + "admin/ocurrencias/search",
    type: "POST",
    data: formData,
    processData: false,
    contentType: false,
    success: function (response) {
      if (response.status) {
        const data = response.data;
        resetForm().then((msg) => {
          // Limpiar el array de materiales antes de cargar los nuevos
          materiales = [];

          $("#idocurrencia").val(data.idocurrencia);
          $("#titulo_practica").val(data.idingreso).trigger("change");
          $("#estudiante").val(data.estudiante);
          $("#idestado").val(data.idestado);
          $("#idseveridad").val(data.idseveridad);
          $("#descripcion").val(data.descripcion);

          const tbody = $("#lista-materiales tbody");
          tbody.empty();

          // Procesar cada detalle y agregarlo tanto a la tabla como al array
          data.detalle.forEach((item) => {
            // Crear el objeto de material con la estructura unificada
            const material = {
              ido: item.ido || "",
              materialId: item.iddetalle || "",
              nombre: item.nombre,
              cantidad: item.cantidad,
              unidad: "unidad",
              observaciones: item.observaciones || "",
              // Mantener información adicional necesaria para la edición
              tipo_item: item.idproducto
                ? "producto"
                : item.idinsumo
                ? "insumo"
                : item.idmaterial
                ? "material"
                : "",
              id_item:
                item.idproducto || item.idinsumo || item.idmaterial || "",
            };

            // Agregar al array de materiales
            materiales.push(material);

            // Agregar a la tabla con la nueva estructura
            tbody.append(`
              <tr data-id="${material.materialId}">
                <td>
                  <input type="hidden" nname="iddetalle[]" value="${material.materialId}">
                  <input type="hidden" nname="tipo_item[]" value="${material.tipo_item}">
                  <input type="hidden" nname="id_item[]" value="${material.id_item}">
                  ${material.nombre}
                </td>
                <td>
                  <input type="number" 
                         class="form-control form-control-sm cantidad-material" 
                         value="${material.cantidad}"
                         min="1">
                </td>
                <td>${material.unidad}</td>
                <td>
                  <input type="text" 
                         class="form-control form-control-sm observacion-material" 
                         value="${material.observaciones}"
                         placeholder="Observaciones">
                </td>
                <td>
                  <button type="button" class="btn btn-danger btn-sm remove-material">
                    <i class="fa-solid fa-trash"></i>
                </button>
                </td>
              </tr>
            `);
          });
        });

        $("#mdlOcurrencias").modal("show");
        Toast.fire({
          icon: "success",
          title: response.message,
        });
      } else {
        Swal.fire("Error", response.message, "error");
      }
    },
    error: function (jqXHR, textStatus, errorThrown) {
      Toast.fire({
        icon: "error",
        title: "error: " + errorThrown,
      });
      console.log(jqXHR, textStatus, errorThrown);
    },
    complete: function (response) {
      divLoading.css("display", "none");
    },
  });
}

function eliminarOcurrencia(id) {
  // Implementar lógica para eliminar
  console.log("Eliminar ocurrencia:", id);
}

$("#nuevoRegistro").on("click", function () {
  resetForm()
    .then((msg) => {
      $("#mdlOcurrencias").modal("show");
    })
    .catch((error) => {
      Toast.fire({
        icon: "error",
        title: error,
      });
    });
});

function listIngresos() {
  return new Promise((resolve, reject) => {
    $.get(base_url + "admin/ocurrencias/ingresos", function () {})
      .done(function (response) {
        $("#titulo_practica").empty();
        $("#titulo_practica").append(
          `<option selected value="">Seleccione</option>`
        );
        response.forEach((element) => {
          $("#titulo_practica").append(
            `<option value="${element.idingreso}">${element.titulo_practica} | ${element.asignatura} | ${element.docente} | ${element.ciclo}</option>`
          );
        });
        resolve(response);
      })
      .fail(function (jqXHR, textStatus, errorThrown) {
        reject(errorThrown);
      });
  });
}

$("#titulo_practica").on("change", function () {
  let idocurrencia = $("#titulo_practica").val();

  $.get(base_url + "admin/ocurrencias/ingresos/" + idocurrencia, function () {})
    .then((response) => {
      $("#v_titulo").html(response.data.titulo_practica);
      $(".v_fecha").html(response.data.fecha);
      $(".v_docente").html(response.data.nombre);
      $("#asignatura").val(response.data.asignatura);
      $("#idingreso").val(response.data.idingreso);
      // cargar los articulos del pestamo
      cargarMateriales(response.data.idingreso).then((msg) => {
        $("#material").select2({
          width: "100%",
          placeholder: "Seleccione una opción",
          dropdownParent: $("#material").parent(),
        });
      });
    })
    .catch((error) => {
      console.log(error);
    });
});

function cargarMateriales(idingreso) {
  return new Promise((resolve, reject) => {
    $.get(
      base_url + "admin/ocurrencias/materiales/" + idingreso,
      function () {}
    )
      .done(function (response) {
        $("#material").empty();
        $("#material").append(
          `<option selected value="">Seleccione una opción</option>`
        );
        response.forEach((element) => {
          $("#material").append(
            `<option value="${element.iddetalle}" data-cantidad="${element.cantidad}">${element.nombre}</option>`
          );
        });
        resolve(response);
      })
      .fail(function (jqXHR, textStatus, errorThrown) {
        reject(errorThrown);
      });
  });
}

$("#formOcurrencia").on("submit", function (e) {
  e.preventDefault();
  divLoading.css("display", "flex");
  let formData = new FormData(this);
  formData.append("materiales", JSON.stringify(getMaterialesAfectados()));
  $.ajax({
    url: base_url + "admin/ocurrencias/save",
    type: "POST",
    data: formData,
    processData: false,
    contentType: false,
    success: function (response) {
      if (response.status) {
        tb.api().ajax.reload();
        $("#mdlOcurrencias").modal("hide");
      }
      Swal.fire(
        response.status ? "Éxito" : "Error",
        response.message,
        response.status ? "success" : "error"
      );
    },
    error: function (jqXHR, textStatus, errorThrown) {
      Toast.fire({
        icon: "error",
        title: "error: " + errorThrown,
      });
      console.log(jqXHR, textStatus, errorThrown);
    },
    complete: function (response) {
      console.log(response);
      divLoading.css("display", "none");
    },
  });
});

// Array para almacenar los materiales
let materiales = [];

$("#addMaterial").on("click", function () {
  // Obtener los valores
  const materialSelect = $("#material");
  const cantidadInput = $("#cantidad_afectado");

  const materialId = materialSelect.val();
  const materialText = materialSelect.find("option:selected").text();
  const cantidad = cantidadInput.val();

  // Validaciones
  if (!materialId || !cantidad) {
    Swal.fire({
      icon: "warning",
      title: "Atención",
      text: "Por favor seleccione un material y especifique la cantidad",
    });
    return;
  }

  // Verificar si el material ya existe en la tabla
  if (materiales.some((m) => m.materialId === materialId)) {
    Swal.fire({
      icon: "warning",
      title: "Atención",
      text: "Este material ya ha sido agregado",
    });
    return;
  }

  // Crear objeto del nuevo material
  const nuevoMaterial = {
    ido: "",
    materialId: materialId,
    nombre: materialText,
    cantidad: cantidad,
    unidad: "unidad", // Ajusta según tus necesidades
    observaciones: "",
  };

  // Agregar al array
  materiales.push(nuevoMaterial);

  // Agregar a la tabla
  const newRow = `
        <tr data-id="${materialId}">
            <td>${materialText}</td>
            <td>${cantidad}</td>
            <td>${nuevoMaterial.unidad}</td>
            <td>
                <input type="text" class="form-control form-control-sm observacion-material" 
                       placeholder="Agregar observación">
            </td>
            <td>
                <button type="button" class="btn btn-danger btn-sm remove-material">
                    <i class="fa-solid fa-trash"></i>
                </button>
            </td>
        </tr>
    `;

  $("#lista-materiales tbody").append(newRow);

  // Resetear los inputs
  materialSelect.val("").trigger("change");
  cantidadInput.val(1);
});

// Eliminar material
$(document).on("click", ".remove-material", function () {
  const row = $(this).closest("tr");
  const materialId = row.data("id");

  // Eliminar del array
  materiales = materiales.filter((m) => m.materialId !== materialId);

  // Eliminar de la tabla
  row.remove();
});

// Actualizar observaciones
$(document).on("change", ".observacion-material", function () {
  Toast.fire({
    icon: "success",
    title: "actualiza observaciones",
  });
  const row = $(this).closest("tr");
  console.log(row);

  const materialId = row.data("id");
  console.log(materialId);

  const observacion = $(this).val();
  console.log(observacion);

  // Actualizar en el array
  const material = materiales.find(
    (m) => Number(m.materialId) === Number(materialId)
  );
  console.log(material);

  if (material) {
    material.observaciones = observacion;
  }
});

// Función para obtener los materiales (útil para enviar al backend)
function getMaterialesAfectados() {
  return materiales;
}
