$(document).ready(function () {
  $("#register_form").on("submit", function (event) {
    event.preventDefault();

    // Comprueba si hay errores
    if (toggleError()) {
      divLoading.css("display", "none");
      return; // Si hay errores, no proceder con la llamada AJAX
    }

    toggleError();
    divLoading.css("display", "flex");
    $.ajax({
      url: "/register",
      method: "POST",
      data: $("#register_form").serialize(),
      success: function (data) {
        if (data.status) {
          resetForm();
          Swal.fire("Menu", data.message, "success");
        } else {
          Swal.fire("Error", data.message, "warning");
        }
        divLoading.css("display", "none");
      },
      error: function (xhr, status, error) {
        // Handle error response
      },
    });
  });
});

function toggleError() {
  let hasErrors = false; // Variable para detectar errores

  // Seleccionar todos los inputs del formulario
  const inputs = document.querySelectorAll("#register_form input");

  inputs.forEach((input) => {
    const errorMessage = input.parentElement.querySelector("span"); // Asumimos que el span de error está justo después del input
    if (input.value.trim() === "") {
      // Mostrar mensaje de error y resaltar el input
      input.classList.add("border-red-600");
      errorMessage.classList.remove("hidden");
      hasErrors = true;
    } else {
      // Ocultar mensaje de error y restablecer el estilo del input
      input.classList.remove("border-red-600");
      errorMessage.classList.add("hidden");
    }
  });

  return hasErrors; // Devuelve true si hay errores
}

function resetForm() {
  // Limpiar formulario
  const form = document.getElementById("register_form");
  form.reset();
}
