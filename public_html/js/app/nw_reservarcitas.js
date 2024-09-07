$(document).ready(function () {
  Toast.fire({
    icon: "success",
    title: $("#idreservacita").val(),
  });
  loadData(
    "propietarios",
    "idpropietario",
    ["nombres", "apellidos"],
    "idpropietario"
  );
  $("#idpropietario").on("change", function () {
    $(".mascotaNombre").html("");
    $(".mascotaEspecie").html("");
    $(".mascotaRaza").html("");
    loadData(
      "mascotas?id=" + $(this).val(),
      "idmascota",
      "nombre",
      "idmascota"
    );
    try {
      $.post(
        `${base_url}admin/reservarcitas/detallepropietario`,
        { idpropietario: $(this).val() },
        function (data) {
          if (data.status) {
            $(".propietarioNombre").html(
              data.data.nombres + " " + data.data.apellidos
            );
            $(".propietarioDireccion").html(data.data.direccion);
            $(".propietarioContacto").html(data.data.celular);
            $(".nombrePropietarioConsulta").html(data.data.nombres);
            $(".apellidoPropietarioConsulta").html(data.data.apellidos);
          }
        }
      );
    } catch (error) {
      console.log(error);
      $(".propietarioNombre").html("No se encontraron datos");
      $(".propietarioDireccion").html("No se encontraron datos");
      $(".propietarioContacto").html("No se encontraron datos");
    }
  });
  $("#idmascota").on("change", function () {
    try {
      $.post(
        `${base_url}admin/reservarcitas/detallemascota`,
        { idmascota: $(this).val() },
        function (data) {
          if (data.status) {
            $(".mascotaNombre").html(data.data.nombre);
            $(".mascotaEspecie").html(data.data.especie);
            $(".mascotaRaza").html(data.data.raza);
            $(".nombreMascotaConsulta").html(data.data.nombre);
            $(".razaMascotaConsulta").html(data.data.raza);
          }
        }
      );
    } catch (error) {
      console.log(error);
      $(".mascotaNombre").html("No se encontraron datos");
      $(".mascotaEspecie").html("No se encontraron datos");
      $(".mascotaRaza").html("No se encontraron datos");
    }
  });
  $("#fechaConsulta").on("change", function () {
    console.log($(this).val());
    $(".fechaFinConsulta").html($(this).val());
  });
  autosize($("#motivo"));
  $("#fecha_consulta").flatpickr({
    altInput: true,
    altFormat: "F j, Y",
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
  $("body").on("change", function () {
    mostrarFinconsulta();
  });
  $("#formConsulta").on("submit", function (e) {
    e.preventDefault();
    let form = $(this).serialize();
    divLoading.css("display", "flex");
    try {
      $.post(`${base_url}admin/reservarcitas/save`, form, function (data) {
        divLoading.css("display", "none");
        if (data.status) {
          $("#success .mensaje").html("Consulta registrada con éxito");
          $("#success").show("low");
          $("#alerta").hide("fast");
          // Swal.fire({
          //   icon: "success",
          //   title: "Consulta registrada",
          //   text: "La consulta ha sido registrada con éxito",
          // });
          resetForm();
        } else {
          // Swal.fire({
          //   icon: "error",
          //   title: "Error",
          //   text: data.message,
          // });
          $("#alerta .mensaje").html(data.message);
          $("#alerta").show("low");
          $("#success").hide("fast");
        }
      });
    } catch (error) {
      divLoading.css("display", "none");
      $("#alerta .mensaje").html("No se pudo registrar la consulta");
      $("#alerta").show("low");
      $("#success").hide("fast");
    }
  });
});
function loadData(endpoint, selectId, textKey, valueKey) {
  $.get(`${base_url}admin/reservarcitas/${endpoint}`, function (data) {
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

    // option.value = addCeros(item[valueKey], 4);
    option.value = item[valueKey];
    selectElement.appendChild(option);
  });

  // Initialize select2
  let select2 = `#${selectId}`;
  $(select2).select2({
    width: "100%",
    placeholder: "Seleccione una opción",
    dropdownParent: $(select2).parent(),
    dropdownCssClass: "text-capitalize",
    selectionCssClass: "text-capitalize",
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
  $(".propietarioNombre").html("");
  $(".propietarioDireccion").html("");
  $(".propietarioContacto").html("");
  $(".mascotaNombre").html("");
  $(".mascotaEspecie").html("");
  $(".mascotaRaza").html("");
  $(".nombrePropietarioConsulta").html("Nombre del propietario");
  $(".apellidoPropietarioConsulta").html("Apellido del propietario");
  $(".nombreMascotaConsulta").html("nombre de la mascota");
  $(".razaMascotaConsulta").html("Raza de la mascota");
  $(".fechaFinConsulta").html("");

  $("#idpropietario").val("0000").trigger("change");
  $("#idmascota").val("0000").trigger("change");
  autosize.update($("#motivo"));
}
