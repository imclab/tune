window.App.Helpers.PrintHelper =
  initPrintHelper: ->
    $("canvas").attr("id", "print-canvas");
    $(".print").click ->
      canvas = document.getElementById("print-canvas")
      image  = canvas.toDataURL("image/png")
      $(this).attr("href", image)
      true
        
window.App.include window.App.Helpers.PrintHelper
