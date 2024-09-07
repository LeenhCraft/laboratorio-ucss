let tbl;
$(document).ready(function () {
  const idReservaCita = $("#idreservacita").val();

  autosize($("#diagnostico"));
  loadData(
    "propietarios",
    "idpropietario",
    ["nombres", "apellidos"],
    "idpropietario"
  );
  loadData("tratamientos", "idtratamiento", "nombre", "idservicio");
  $('button[data-bs-toggle="tab"]').on("shown.bs.tab", function (event) {
    autosize($("#nota"));
    if (typeof tbl !== "undefined" && $.fn.DataTable.isDataTable(tbl)) {
      return;
    }
    tbl = $("#tbl").DataTable({
      columns: [
        {
          data: "idtratamiento",
          render: function (data, type, row) {
            return (
              `<span>${data}</span>` +
              `<input type="hidden" value="${data}" name="idservicio">`
            );
          },
        },
        { data: "tratamiento" },
        {
          data: "precio",
          render: function (data, type, row) {
            return `<input type="text" class="form-control" value="${data}" name="precio" onchange="updateRowPrice(this)">`;
          },
        },
        {
          data: "cantidad",
          render: function (data, type, row) {
            return `<input type="number" class="form-control" value="${data}" name="cantidad" min="1" onchange="updateRowPrice(this)">`;
          },
        },
        {
          data: "subtotal",
          render: function (data, type, row) {
            return `<input type="text" class="form-control" value="${data}" name="subtotal" readonly>`;
          },
        },
        {
          data: "descripcion",
          render: function (data, type, row) {
            return `<input type="text" class="form-control" value="${data}" name="descripcion">`;
          },
        },
        {
          data: null,
          render: function (data, type, row) {
            return generateDeleteButton(row);
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
  });
  $("#add-treatment").click(function () {
    const selectedTreatmentId = $("#idtratamiento").val();
    if (selectedTreatmentId === "0000") {
      Toast.fire({
        icon: "info",
        title: "Seleccione un tratamiento",
        position: "top",
      });
      return;
    }

    // Verificar si el tratamiento ya está en la tabla
    const existingTreatment = tbl
      .rows()
      .data()
      .toArray()
      .find((row) => row.idtratamiento === parseInt(selectedTreatmentId));
    if (existingTreatment) {
      Toast.fire({
        icon: "info",
        title: "El tratamiento ya está en la lista",
        position: "top",
      });
      return;
    }

    const selectedTreatmentText = $("#idtratamiento option:selected").text();

    $.ajax({
      url: `/admin/consultas/tratamientos/${selectedTreatmentId}`,
      method: "GET",
      dataType: "json",
      success: function (data) {
        const tratamientoData = {
          idtratamiento: data.data.idservicio,
          tratamiento: data.data.nombre,
          precio: data.data.precio,
          cantidad: 1,
          subtotal: data.data.precio * 1, // Supongamos que el precio inicial es el costo
          descripcion: "",
          delete: true,
        };
        tbl.row.add(tratamientoData).draw();
        updateTotals();
      },
    });
  });

  $("#idpropietario").on("change", function () {
    cargarDatosPropietario($(this).val());
  });
  $("#crearConsulta").on("submit", function (e) {
    e.preventDefault();

    const tableData = [];

    // Verificar si la tabla tiene filas antes de iterar sobre ellas
    console.log($("#tbl tbody tr td").hasClass("dataTables_empty"));
    if (
      $("#tbl tbody tr").length === 0 ||
      $("#tbl tbody tr td").hasClass("dataTables_empty")
    ) {
      console.log("La tabla está vacía o muestra mensaje de vacío");
    } else {
      $("#tbl tbody tr").each(function () {
        const row = $(this);
        const rowData = {
          idservicio: row.find('input[name="idservicio"]').val().trim(),
          precio: row.find('input[name="precio"]').val().trim(),
          cantidad: row.find('input[name="cantidad"]').val().trim(),
          subtotal: row.find('input[name="subtotal"]').val().trim(),
          descripcion: row.find('input[name="descripcion"]').val().trim(),
        };
        tableData.push(rowData); // Agregar rowData al array tableData
      });
    }

    let form = new FormData(this);
    form.append("tableData", JSON.stringify(tableData));
    $.ajax({
      url: `${base_url}admin/consultas/save`,
      type: "POST",
      data: form,
      processData: false,
      contentType: false,
      success: function (data) {
        if (data.status) {
          Swal.fire({
            icon: "success",
            title: "Consulta registrada",
            text: data.message,
            showConfirmButton: false,
            timer: 1500,
          });
          // setTimeout(() => {
          //   window.location.href = `${base_url}admin/consultas`;
          // }, 1500);
        } else {
          Swal.fire({
            icon: "error",
            title: "Error al registrar",
            text: data.message,
          });
        }
      },
      error: function (jqXHR, textStatus, errorThrown) {
        Swal.fire({
          icon: "error",
          title: "Error al registrar",
          text: errorThrown,
        });
      },
    });
  });
});
function loadData(endpoint, selectId, textKey, valueKey) {
  $.get(`${base_url}admin/consultas/${endpoint}`, function (data) {
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
  $(`#${selectId}`).select2({
    width: "100%",
    placeholder: "Seleccione una opción",
    // dropdownParent: $(`#${selectId}`).parent(),
    dropdownCssClass: "text-capitalize",
    selectionCssClass: "text-capitalize",
  });
}
function cargarDatosPropietario(idPropietario) {
  cargarMascotas(idPropietario);
}
function cargarMascotas(idPropietario, idMascotaSeleccionada = null) {
  return new Promise((resolve, reject) => {
    $.get(
      `${base_url}admin/consultas/mascotas?id=${idPropietario}`,
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
function generateDeleteButton(row) {
  return `
      <button type="button" class="btn btn-outline-danger" onclick="deleteRow(${row.idtratamiento})">
        <i class="bx bx-trash me-2"></i>  Eliminar
      </button>
  `;
}
function deleteRow(idtratamiento) {
  tbl.rows().every(function () {
    if (this.data().idtratamiento === idtratamiento) {
      this.remove();
      tbl.draw();
    }
  });
}
function updateRowPrice(element) {
  const row = $(element).closest("tr");
  const precio = parseFloat(row.find('input[name="precio"]').val()) || 0;
  const cantidad = parseFloat(row.find('input[name="cantidad"]').val()) || 0;
  const subtotal = (precio * cantidad).toFixed(2);
  row.find('input[name="subtotal"]').val(subtotal);
  updateTotals();
}
function updateTotals() {
  let subtotal = 0;

  $("#tbl tbody tr").each(function () {
    const row = $(this);
    const precio = parseFloat(row.find('input[name="subtotal"]').val()) || 0;
    subtotal += precio;
  });

  const descuento = parseFloat($(".descuento").val()) || 0;
  const total = subtotal - descuento;

  $(".subtotal").text(`S/ ${subtotal.toFixed(2)}`);
  $(".total").text(`S/ ${total.toFixed(2)}`);
}
