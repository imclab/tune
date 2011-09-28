(function() {
  window.App.Helpers.ErrorHelper = {
    initErrorHelper: function() {
      return $(".flash-error").delay(5000).fadeOut();
    }
  };
  window.App.include(window.App.Helpers.ErrorHelper);
}).call(this);
