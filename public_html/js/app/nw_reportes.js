$(document).ready(function () {
  let url = "";
  $("#reportePropietario").on("click", function () {
    divLoading.css("display", "flex");
    url = $(this).data("lnh-url");
    $("#pdf").attr("src", url);
    $("#mdlPDF").modal("show");
  });

  $("#reporteMascotas").on("click", function () {
    divLoading.css("display", "flex");
    url = $(this).data("lnh-url");
    $("#pdf").attr("src", url);
    $("#mdlPDF").modal("show");
  });

  $("#reporteServicios").on("click", function () {
    divLoading.css("display", "flex");
    url = $(this).data("lnh-url");
    $("#pdf").attr("src", url);
    $("#mdlPDF").modal("show");
  });

  $("#reporteCitas").on("click", function () {
    divLoading.css("display", "flex");
    url = $(this).data("lnh-url");
    $("#pdf").attr("src", url);
    $("#mdlPDF").modal("show");
  });

  $("#mdlPDF").on("show.bs.modal", function () {
    $("#pdf").attr("src", url);
  });

  $("#mdlPDF").on("shown.bs.modal", function () {
    divLoading.css("display", "none");
  });

  $("#mdlPDF").on("hidden.bs.modal", function () {
    $("#pdf").attr("src", "");
  });
});
