let tb;
$(document).ready(function () {
  tb = $("#tbl").dataTable({
    aProcessing: true,
    aServerSide: true,
    language: {
      url: base_url + "js/app/plugins/dataTable.Spanish.json",
    },
    ajax: {
      url: base_url + "admin/ventas",
      method: "POST",
      dataSrc: "",
    },
    columns: [
      {
        width: "5%",
        data: null,
        render: function (data, type, row, meta) {
          return meta.row + meta.settings._iDisplayStart + 1;
        },
      },
      {
        data: "numero_orden",
        width: "auto",
        render: function (data, type, row) {
          // agregar boton pdf
          let retornar = `<p class="p-0 m-0 text-primary fw-bold text-capitalize">${data}</p>`;
          if (row.eliminado === "0") {
            retornar += `<button data-lnh-url="${base_url}admin/ventas/pdf/${row.numero_orden}" class="btn btn-sm btn-outline-danger border-0" onclick="verPDF(this);">
            <i class="bx bxs-file-pdf"></i>
          </button>`;
          }
          return retornar;
        },
      },
      {
        data: "fecha_venta",
        render: function (data, type, row) {
          const date = formatDate(data);
          return `<span class="text-capitalize">${date.dayOfWeek}, ${date.day} de ${date.month}, ${date.year}</span>`;
        },
      },
      {
        data: "idcliente",
        render: function (data, type, row) {
          return `<span class="text-capitalize">${row.nombres} ${row.apellidos}</span>`;
        },
      },
      {
        data: "idestado",
        render: function (data, type, row) {
          const estados = {
            1: `<span class="badge bg-warning">Pendiente de Pago</span>`,
            2: `<span class="badge bg-success">Pagado</span>`,
            default: `<span class="badge bg-secondary">Sin definir</span>`,
          };

          const retornar =
            row.eliminado === "1"
              ? `<span class="badge bg-danger">Anulado</span>`
              : estados[data] || estados["default"];

          return retornar;
        },
      },
      {
        data: "idtipopago",
        render: function (data, type, row) {
          switch (data) {
            case "1":
              return `<span class="badge bg-success">Efectivo</span>`;
              break;
            case "2":
              return `<span class="badge bg-primary">Tarjeta</span>`;
              break;
            case "3":
              return `<span class="badge bg-info">Transferencia</span>`;
              break;
            default:
              return `<span class="badge bg-secondary">Sin definir</span>`;
              break;
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
    iDisplayLength: 25,
    // order: [[0, "desc"]],
    scrollX: true,
  });
});
function verPDF(ths) {
  let url = $(ths).data("lnh-url");
  console.log(url);
  $("#mdlPDF").on("show.bs.modal", function (e) {
    $("#pdf").attr("src", url);
  });
  $("#mdlPDF").modal("show");
}
function fntAddPago(id) {
  Toast.fire({
    icon: "success",
    title: "Agregar pago " + id,
  });
}
function fntDel(id) {
  Swal.fire({
    title: "Anular Venta",
    text: "¿Realmente desea anular la venta?",
    icon: "warning",
    showCancelButton: true,
    confirmButtonText: "Si, Anular!",
    cancelButtonText: "No, cancelar!",
  }).then((result) => {
    if (result.isConfirmed) {
      let ajaxUrl = base_url + "admin/ventas/anular";
      $.post(ajaxUrl, { numero_orden: id }, function (data) {
        if (data.status) {
          Swal.fire({
            title: "Anulado!",
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
function generateDropdownMenu(row) {
  let options = [];
  if (row.edit) {
    options.push(
      generateDropdownOption(
        "Agrega Pago",
        "bx bx-edit-alt",
        `fntAddPago(${row.idventa})`
      )
    );
  }
  if (row.delete) {
    options.push(
      generateDropdownOption(
        "Anular",
        "bx bx-trash",
        `fntDel('${row.numero_orden}')`
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
function formatDate(dateString) {
  // Crear un objeto Date a partir del string dado
  const date = new Date(dateString);

  // Crear un array con los nombres de los meses en español
  const months = [
    "enero",
    "febrero",
    "marzo",
    "abril",
    "mayo",
    "junio",
    "julio",
    "agosto",
    "septiembre",
    "octubre",
    "noviembre",
    "diciembre",
  ];

  // Crear un array con los nombres de los días de la semana en español
  const daysOfWeek = [
    "domingo",
    "lunes",
    "martes",
    "miércoles",
    "jueves",
    "viernes",
    "sábado",
  ];

  // Obtener el día de la semana, el día del mes, el mes y el año
  const dayOfWeek = daysOfWeek[date.getDay()];
  const day = date.getDate();
  const month = months[date.getMonth()]; // obtener el nombre del mes
  const year = date.getFullYear();

  // Obtener la hora y los minutos con formato de dos dígitos
  let hours = date.getHours();
  const minutes = String(date.getMinutes()).padStart(2, "0");

  // Determinar si es AM o PM
  const ampm = hours >= 12 ? "PM" : "AM";

  // Convertir la hora a formato de 12 horas
  hours = hours % 12;
  hours = hours ? hours : 12; // la hora 0 se convierte en 12

  // Formatear la hora en dos dígitos
  const formattedHours = String(hours).padStart(2, "0");

  // Formatear la fecha en el formato F j, Y H:i con el día de la semana y la hora en formato de 12 horas
  const formattedDate = `${dayOfWeek}, ${month} ${day}, ${year} ${formattedHours}:${minutes} ${ampm}`;

  // Devolver un objeto con los componentes de la fecha
  return {
    dateString: formattedDate,
    dayOfWeek: dayOfWeek,
    day: day,
    month: month,
    year: year,
    hours: formattedHours,
    minutes: minutes,
    ampm: ampm,
  };
}
