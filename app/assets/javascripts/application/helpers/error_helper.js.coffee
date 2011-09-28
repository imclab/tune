window.App.Helpers.ErrorHelper =
  initErrorHelper: ->
    $(".flash-error").delay(5000).fadeOut();
        
window.App.include window.App.Helpers.ErrorHelper
