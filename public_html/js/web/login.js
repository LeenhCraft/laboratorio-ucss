$(document).ready(function () {
  $("#formLogin").on("submit", function (event) {
    event.preventDefault();

    // Comprueba si hay errores
    if (toggleError()) {
      divLoading.css("display", "none");
      return; // Si hay errores, no proceder con la llamada AJAX
    }

    divLoading.css("display", "flex");
    $.ajax({
      url: "/login",
      method: "POST",
      data: $("#formLogin").serialize(),
      success: function (data) {
        console.log(data);
        divLoading.css("display", "none");
        if (data.status) {
          Swal.fire({
            title: data.message,
            icon: "success",
            showConfirmButton: false,
            timer: 1100,
            timerProgressBar: true,
          }).then((result) => {
            if (result.dismiss === Swal.DismissReason.timer) {
              window.location.reload();
            }
          });
        } else {
          Swal.fire({
            title: data.message,
            icon: "error",
            confirmButtonText: "ok",
          });
        }
      },
      error: function (xhr, status, error) {
        // Manejar la respuesta de error
        divLoading.css("display", "none");
        Swal.fire("Error", "Se produjo un error durante la solicitud", "error");
      },
    });
  });
});

function toggleError() {
  let hasErrors = false; // Variable para detectar errores

  // Seleccionar todos los inputs del formulario
  const inputs = document.querySelectorAll("#formLogin input");

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

  // Restablecer estilos y mensajes de error
  const inputs = form.querySelectorAll("input");
  inputs.forEach((input) => {
    input.classList.remove("border-red-600");
    const errorMessage = input.nextElementSibling;
    errorMessage.classList.add("hidden");
  });
}
