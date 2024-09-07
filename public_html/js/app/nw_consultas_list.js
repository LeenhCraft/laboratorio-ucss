let tb;
$(document).ready(function () {
  tb = $("#tbl").dataTable({
    aProcessing: true,
    aServerSide: true,
    language: {
      url: base_url + "js/app/plugins/dataTable.Spanish.json",
    },
    ajax: {
      url: base_url + "admin/consultas",
      method: "POST",
      dataSrc: "",
    },
    columns: [
      {
        data: "num",
        width: "5%",
      },
      {
        data: null,
        width: "5%",
        render: function (data, type, row) {
          // mostrar un icono de un pdf para generar su comprobante
          return `<a title="Generar Comprobante" href="/admin/ventas/nueva?idconsulta=${row.idconsulta}" class="btn btn-outline-primary border-0 btn-sm text-start fs-6"><i class='bx bxs-file-pdf me-2'></i></a>`;
        },
      },
      {
        data: "fecha_consulta",
        render: function (data, type, row) {
          const fecha = formatDate(
            row.fecha_consulta + " " + row.hora_consulta
          );
          return `<p class="m-0 p-0 text-capitalize fw-normal">${fecha.dayOfWeek} ${fecha.day}, ${fecha.month} ${fecha.year}</p>
          <p class="m-0 p-0">${fecha.hours}:${fecha.minutes} ${fecha.ampm}</p>`;
        },
      },
      {
        data: "propietario",
        className: "text-capitalize",
      },
      {
        data: "mascota",
        className: "text-capitalize",
      },
      {
        data: "estado",
        render: function (data, type, row) {
          // 1 generado
          // 2 atendido
          // 3 cancelado
          let color = "secondary";
          if (row.idestado == 1) {
            color = "primary";
          } else if (row.idestado == 2) {
            color = "success";
          } else if (row.idestado == 3) {
            color = "danger";
          }
          return `<span class="badge bg-${color}">${data}</span>`;
        },
      },
      {
        render: function (data, type, row) {
          return generateDropdownMenu(row);
        },
      },
    ],
    resonsieve: true,
    bDestroy: true,
    iDisplayLength: 10,
    bFilter: true,
    bSort: true,
    bPaginate: true,
    bInfo: true,
    bAutoWidth: false,
    scrollX: false,
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
  let ajaxUrl = base_url + "admin/consultas/save";
  $.post(ajaxUrl, form, function (data) {
    if (data.status) {
      $("#mdlConsultas").modal("hide");
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
  let ajaxUrl = base_url + "admin/consultas/search";
  $("#modal-title").html("Actualizar Consultas " + id);
  $("#btnText").html("Actualizar");
  $("#btnActionForm")
    .removeClass("btn-outline-primary")
    .addClass("btn-outline-info");
  $("#frmConsultas").attr("onsubmit", "return update(this,event)");
  $("#mdlConsultas").modal("show");
  //
  $.post(ajaxUrl, { idconsulta: id }, function (data) {
    if (data.status) {
      $("#idconsulta").val(data.data.idconsulta);
      $("#idreservacita").val(data.data.idreservacita);
      $("#idpropietario").val(data.data.idpropietario);
      $("#idmascota").val(data.data.idmascota);
      $("#idestado").val(data.data.idestado);
      $("#idpersonal").val(data.data.idpersonal);
      $("#codigo").val(data.data.codigo);
      $("#fecha_consulta").val(data.data.fecha_consulta);
      $("#hora_consulta").val(data.data.hora_consulta);
      $("#diagnostico").val(data.data.diagnostico);
      $("#observaciones").val(data.data.observaciones);
      $("#fecha_registro").val(data.data.fecha_registro);
      $("#ultima_actualizacion").val(data.data.ultima_actualizacion);
      $("#eliminado").val(data.data.eliminado);
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
  let ajaxUrl = base_url + "admin/consultas/update";
  $.post(ajaxUrl, form, function (data) {
    if (data.status) {
      $("#mdlConsultas").modal("hide");
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
    title: "Eliminar Consultas",
    text: "¿Realmente quiere eliminar Consultas?",
    icon: "warning",
    showCancelButton: true,
    //   confirmButtonColor: "#3085d6",
    //   cancelButtonColor: "#d33",
    confirmButtonText: "Si, eliminar!",
    cancelButtonText: "No, cancelar!",
  }).then((result) => {
    if (result.isConfirmed) {
      let ajaxUrl = base_url + "admin/consultas/delete";
      $.post(ajaxUrl, { idconsulta: idp }, function (data) {
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
  $("#modal-title").html("Crear Nuevo Consultas");
  $("#idconsulta").val("");
  $("#frmConsultas").attr("onsubmit", "return save(this,event)");
  $("#frmConsultas").trigger("reset");
  $("#mdlConsultas").modal("show");
}
function resetForm(ths) {
  $("#frmConsultas").trigger("reset");
  $("#idconsulta").val("");
  $(ths).attr("onsubmit", "return save(this,event)");
  $("#btnText").html("Guardar");
  $("#btnActionForm").removeClass("btn-info").addClass("btn-outline-primary");
  $("#modal-title").html("Crear Nuevo Consultas");
}
function generateDropdownMenu(row) {
  let options = [];
  if (row.edit) {
    // options.push(
    //   generateDropdownOption(
    //     "Editar",
    //     "bx bx-edit-alt",
    //     `fntEdit(${row.idconsulta})`
    //   )
    // );
    options.push(
      `<a class="dropdown-item" href="/admin/crearconsulta?idconsulta=${row.idconsulta}"><i class='bx bx-edit-alt me-2'></i>Editar consulta</a>`
    );
  }
  if (row.delete) {
    options.push(
      generateDropdownOption(
        "Eliminar",
        "bx bx-trash",
        `fntDel(${row.idconsulta})`
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
