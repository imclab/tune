(function() {
  var ApplicationController;
  ApplicationController = Spine.Controller.create({
    init: function() {
      this.Helpers = ApplicationController.Helpers;
      this.Models = ApplicationController.Models;
      this.Views = ApplicationController.Views;
      return this.Controllers = ApplicationController.Controllers;
    },
    include: function(x) {
      return App.include(x);
    },
    ready: function() {
      return this.initErrorHelper();
    }
  });
  ApplicationController.extend({
    Helpers: {},
    Models: {},
    Views: {},
    Controllers: {}
  });
  window.ApplicationController = ApplicationController;
  window.App = ApplicationController;
  $(document).ready(function() {
    window.App = window.App.init();
    return window.App.ready();
  });
}).call(this);
//
//
;
