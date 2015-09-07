requirejs.config
  baseUrl: 'js'
  shim:
    'underscore':
      exports: '_'
    'backbone':
      deps: ['underscore', 'jquery']
      exports: 'Backbone'
    'bootstrap':
      deps: ['jquery']
    'handlebars':
      exports: 'Handlebars'

  paths:
    'underscore': '../components/underscore/underscore'
    'backbone': '../components/backbone/backbone'
    'jquery': '../components/jquery/dist/jquery'
    'bootstrap': '../components/bootstrap/dist/js/bootstrap'
    'text': '../components/text/text'
    'handlebars': '../components/handlebars/handlebars'


require ['app/vendors'], ->
  require ['app/app'], (App) ->
    App.initialize()
