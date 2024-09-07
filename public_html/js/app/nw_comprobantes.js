let tbl;
$(document).ready(function () {
  // antes de mostrar el modal
  $("#mdlDescargar").on("show.bs.modal", function (e) {
    // obtener la url de data-lnh-url del boton
    let url = $("#btnImprimir").data("lnh-url");
    console.log(url);
    // obtener el iframe
    let iframe = $("#ifrmDescargar");
    // cambiar la url del iframe
    iframe.attr("src", url);
  });
  $("#btnImprimir").on("click", function () {
    $("#mdlDescargar").modal("show");
  });
});
