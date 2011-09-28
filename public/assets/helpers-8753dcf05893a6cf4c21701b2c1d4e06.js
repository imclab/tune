(function() {
  window.App.Helpers.ErrorHelper = {
    initErrorHelper: function() {
      return $(".flash-error").delay(5000).fadeOut();
    }
  };
  window.App.include(window.App.Helpers.ErrorHelper);
}).call(this);
(function() {
  window.App.Helpers.PrintHelper = {
    initPrintHelper: function() {
      $("canvas").attr("id", "print-canvas");
      return $(".print").click(function() {
        var canvas, image;
        canvas = document.getElementById("print-canvas");
        image = canvas.toDataURL("image/png");
        $(this).attr("href", image);
        return true;
      });
    }
  };
  window.App.include(window.App.Helpers.PrintHelper);
}).call(this);
