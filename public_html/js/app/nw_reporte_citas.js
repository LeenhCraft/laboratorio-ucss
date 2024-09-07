$(document).ready(function () {
  let url = "";

  // $("#desde, #hasta").flatpickr({
  //   altInput: true,
  //   altFormat: "l j F, Y",
  //   dateFormat: "Y-m-d",
  //   inline: false,
  //   locale: "es",
  // });

  $("#rango").flatpickr({
    altInput: true,
    altFormat: "l j F, Y",
    dateFormat: "Y-m-d",
    inline: false,
    locale: "es",
    mode: "range",
    // maxDate: function (date) {
    //   if (this.selectedDates.length === 0) {
    //     return null;
    //   }
    //   return new Date(
    //     this.selectedDates[0].getTime() + 6 * 24 * 60 * 60 * 1000
    //   );
    // },
    // onChange: function (selectedDates, dateStr, instance) {
    //   if (selectedDates.length === 2) {
    //     const diffTime = Math.abs(selectedDates[1] - selectedDates[0]);
    //     const diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24));

    //     if (diffDays > 7) {
    //       const newEndDate = new Date(
    //         selectedDates[0].getTime() + 6 * 24 * 60 * 60 * 1000
    //       );
    //       instance.setDate([selectedDates[0], newEndDate]);
    //     }
    //   }
    // },
  });

  $("#reporteCitas").on("click", function () {
    let rango = $("#rango").val();
    divLoading.css("display", "flex");
    url = $(this).data("lnh-url");
    url += `?rango=${rango}`;
    console.log(url);
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
