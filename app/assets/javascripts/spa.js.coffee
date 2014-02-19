# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
#= require jquery
#= require jquery_ujs
#= require turbolinks

#= require underscore-min
#= require handlebars-v1.1.2
#= require bootstrap.min
#= require spa/glue
#= require spa/gui
#= require spa/usecase
#= require spa/serverside



class App
  constructor: ->
    @useCase = new UseCase()
    @serverSide = new ServerSide(@useCase)
    @gui = new Gui(@useCase)
    @glue = new Glue(@useCase, @serverSide, @gui)
    window.usecase = @useCase
    # console.log("halo")

  start: =>
    @useCase.start()

  users: =>
    #[new User("Jan Kowalski"), new User("Jan Nowak")]



#window.ServerSide = ServerSide
$ ->
  app = new App()
  app.start()