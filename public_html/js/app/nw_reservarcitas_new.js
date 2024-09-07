$(document).ready(function () {
  const idReservaCita = $("#idreservacita").val();

  inicializarComponentes();

  if (idReservaCita !== "0") {
    divLoading.css("display", "flex");
    cargarDatosCitaExistente(idReservaCita);
  } else {
    inicializarNuevaCita();
  }

  configurarEventListeners();
});

function inicializarComponentes() {
  autosize($("#motivo"));

  $("#fecha_consulta").flatpickr({
    altInput: true,
    altFormat: "l j F, Y",
    dateFormat: "Y-m-d",
    inline: false,
    locale: "es",
  });

  $("#hora_consulta").flatpickr({
    enableTime: true,
    noCalendar: true,
    dateFormat: "H:i",
    time_24hr: false,
    locale: "es",
  });
}

function configurarEventListeners() {
  $("#idpropietario").on("change", function () {
    cargarDatosPropietario($(this).val());
  });

  $("#idmascota").on("change", function () {
    cargarDatosMascota($(this).val());
  });

  $("#fecha_consulta").on("change", function () {
    $(".fechaFinConsulta").html($(this).val());
  });

  $("body").on("change", function () {
    mostrarFinconsulta();
  });

  $("#formConsulta").on("submit", function (e) {
    e.preventDefault();
    guardarCita($(this));
  });
}

function cargarDatosCitaExistente(idReservaCita) {
  $.get(
    `${base_url}admin/reservarcitas/obtenercita/${idReservaCita}`,
    function (response) {
      if (response.status) {
        const data = response.data;
        cargarPropietarios(data.idpropietario)
          .then(() => cargarMascotas(data.idpropietario, data.idmascota))
          .then(() => {
            // Cargar datos del propietario
            $(".propietarioNombre").html(data.nombres + " " + data.apellidos);
            $(".propietarioDireccion").html(data.correo); // Asumiendo que quieres mostrar el correo como dirección
            $(".propietarioContacto").html(data.celular);
            $(".nombrePropietarioConsulta").html(data.nombres);
            $(".apellidoPropietarioConsulta").html(data.apellidos);

            // Cargar datos de la mascota
            $(".mascotaNombre").html(data.nombre_mascota);
            $(".mascotaEspecie").html(data.especie);
            $(".mascotaRaza").html(data.raza);
            $(".nombreMascotaConsulta").html(data.nombre_mascota);
            $(".razaMascotaConsulta").html(data.raza);

            // Cargar fecha y hora de la consulta
            // $("#fecha_consulta").val(data.fecha_consulta).trigger("change");
            $("#fecha_consulta")
              .flatpickr({
                altInput: true,
                altFormat: "l j F, Y",
                dateFormat: "Y-m-d",
                inline: false,
                locale: "es",
              })
              .setDate(data.fecha_consulta);
            console.log(data.fecha_consulta);
            $("#hora_consulta").val(data.hora_consulta).trigger("change");

            // Cargar motivo de la consulta
            $("#motivo").val(data.motivo_consulta);
            autosize.update($("#motivo"));

            mostrarFinconsulta();

            divLoading.css("display", "none");

            Toast.fire({
              icon: "info",
              title: "Cita cargada",
            });
          });
      } else {
        console.error("No se pudo cargar la cita");
        Toast.fire({
          icon: "error",
          title: "Error al cargar la cita",
        });
      }
    }
  ).fail(function () {
    console.error("Error en la petición AJAX");
    Toast.fire({
      icon: "error",
      title: "Error al cargar la cita",
    });
  });
}

function inicializarNuevaCita() {
  Toast.fire({
    icon: "success",
    title: "Nueva cita",
  });
  cargarPropietarios();
}

function cargarPropietarios(idPropietarioSeleccionado = null) {
  return new Promise((resolve, reject) => {
    $.get(`${base_url}admin/reservarcitas/propietarios`, function (data) {
      populateSelect(
        "idpropietario",
        data,
        ["nombres", "apellidos"],
        "idpropietario"
      );
      if (idPropietarioSeleccionado) {
        $("#idpropietario").val(idPropietarioSeleccionado).trigger("change");
      }
      resolve();
    }).fail(reject);
  });
}

function cargarMascotas(idPropietario, idMascotaSeleccionada = null) {
  return new Promise((resolve, reject) => {
    $.get(
      `${base_url}admin/reservarcitas/mascotas?id=${idPropietario}`,
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

function populateSelect(selectId, data, textKeys, valueKey) {
  const selectElement = document.getElementById(selectId);
  selectElement.innerHTML = "";

  const defaultOption = document.createElement("option");
  defaultOption.text = "Seleccione una opción";
  defaultOption.value = "0000";
  selectElement.appendChild(defaultOption);

  data.forEach((item) => {
    const option = document.createElement("option");
    if (Array.isArray(textKeys)) {
      option.text = textKeys.map((key) => item[key]).join(" ");
    } else {
      option.text = item[textKeys];
    }
    option.value = item[valueKey];
    selectElement.appendChild(option);
  });

  console.log($(`#${selectId}`).parent());
  $(`#${selectId}`).select2({
    width: "100%",
    placeholder: "Seleccione una opción",
    dropdownParent: $(`#${selectId}`).parent(),
    dropdownCssClass: "text-capitalize",
    selectionCssClass: "text-capitalize",
  });
}

function cargarDatosPropietario(idPropietario) {
  $(".mascotaNombre, .mascotaEspecie, .mascotaRaza").html("");
  cargarMascotas(idPropietario);

  $.post(
    `${base_url}admin/reservarcitas/detallepropietario`,
    { idpropietario: idPropietario },
    function (data) {
      if (data.status) {
        $(".propietarioNombre").html(
          data.data.nombres + " " + data.data.apellidos
        );
        $(".propietarioDireccion").html(data.data.direccion);
        $(".propietarioContacto").html(data.data.celular);
        $(".nombrePropietarioConsulta").html(data.data.nombres);
        $(".apellidoPropietarioConsulta").html(data.data.apellidos);
      } else {
        resetPropietarioInfo();
      }
    }
  ).fail(function () {
    resetPropietarioInfo();
  });
}

function cargarDatosMascota(idMascota) {
  $.post(
    `${base_url}admin/reservarcitas/detallemascota`,
    { idmascota: idMascota },
    function (data) {
      if (data.status) {
        $(".mascotaNombre").html(data.data.nombre);
        $(".mascotaEspecie").html(data.data.especie);
        $(".mascotaRaza").html(data.data.raza);
        $(".nombreMascotaConsulta").html(data.data.nombre);
        $(".razaMascotaConsulta").html(data.data.raza);
      } else {
        resetMascotaInfo();
      }
    }
  ).fail(function () {
    resetMascotaInfo();
  });
}

function guardarCita(form) {
  let formData = form.serialize();
  divLoading.css("display", "flex");

  $.post(`${base_url}admin/reservarcitas/save`, formData, function (data) {
    divLoading.css("display", "none");
    if ($("#idreservacita").val() === "0") {
      if (data.status) {
        mostrarMensajeExito("Consulta registrada con éxito");
        resetForm();
      } else {
        mostrarMensajeError(data.message);
      }
    } else {
      if (data.status) {
        mostrarMensajeExito("Consulta actualizada con éxito");
      } else {
        mostrarMensajeError(data.message);
      }
    }
    // if (data.status) {
    //   mostrarMensajeExito("Consulta registrada con éxito");
    //   resetForm();
    // } else {
    //   mostrarMensajeError(data.message);
    // }
  }).fail(function () {
    divLoading.css("display", "none");
    mostrarMensajeError("No se pudo registrar la consulta");
  });
}

function mostrarFinconsulta() {
  $(".finalizarConsulta").show("low");
  $(".finConsultaMensaje").hide("low");
}

function ocultarFinconsulta() {
  $(".finalizarConsulta").hide("fast");
  $(".finConsultaMensaje").show("fast");
}

function resetForm() {
  $("#formConsulta").trigger("reset");
  resetPropietarioInfo();
  resetMascotaInfo();
  $(".fechaFinConsulta").html("");
  $("#idpropietario, #idmascota").val("0000").trigger("change");
  autosize.update($("#motivo"));
}

function resetPropietarioInfo() {
  $(".propietarioNombre, .propietarioDireccion, .propietarioContacto").html("");
  $(".nombrePropietarioConsulta").html("Nombre del propietario");
  $(".apellidoPropietarioConsulta").html("Apellido del propietario");
}

function resetMascotaInfo() {
  $(".mascotaNombre, .mascotaEspecie, .mascotaRaza").html("");
  $(".nombreMascotaConsulta").html("nombre de la mascota");
  $(".razaMascotaConsulta").html("Raza de la mascota");
}

function mostrarMensajeExito(mensaje) {
  $("#success .mensaje").html(mensaje);
  $("#success").show("low");
  $("#alerta").hide("fast");
}

function mostrarMensajeError(mensaje) {
  $("#alerta .mensaje").html(mensaje);
  $("#alerta").show("low");
  $("#success").hide("fast");
}
