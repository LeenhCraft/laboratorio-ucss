$(document).ready(function () {
  // $(".card-success").hide();
  $("#frmlogin").submit(function (event) {
    event.preventDefault();
    divLoading.css("display", "flex");
    const form = $(this).serialize();
    const url = base_url + "admin/login";
    $.post(url, form, function () {})
      .done(function (data) {
        const { status, message } = data;
        const titleMessage = message;
        Toast.fire({
          title: titleMessage,
          icon: status ? "success" : "error",
          position: "top",
        });
        if (status) {
          $(".card-success").show();
          $(".card-content").hide();
          setTimeout(() => window.location.reload(), 1100);
        }
      })
      .fail(function (jqXHR, textStatus, errorThrown) {
        Swal.fire({
          title: "Error",
          text: "An error occurred while processing your request.",
          icon: "error",
          confirmButtonText: "OK",
        });
        console.log(jqXHR, textStatus, errorThrown);
      })
      .always(function () {
        divLoading.css("display", "none");
      });
  });
});
