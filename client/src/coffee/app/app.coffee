define ['app/router'], (Router) ->

  router = null

  initialize = ->

    App = window.App = {}
    App.vent = _.extend({}, Backbone.Events)

    router = new Router()

  {router: router, initialize: initialize}
