ApplicationController = Spine.Controller.create
  init: ->
    @Helpers =      ApplicationController.Helpers
    @Models =       ApplicationController.Models
    @Views =        ApplicationController.Views
    @Controllers =  ApplicationController.Controllers
    
  include: (x) ->
    App.include(x)
    
  ready: ->
    @initErrorHelper()

ApplicationController.extend
  Helpers: {}
  Models:  {}
  Views:   {}
  Controllers: {}

window.ApplicationController = ApplicationController
window.App = ApplicationController

$(document).ready -> window.App = window.App.init() ; window.App.ready()
