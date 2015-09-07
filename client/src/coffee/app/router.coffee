define [
  'backbone'
  'app/views/app'
  'app/views/about'
  'app/models/phage'
  'app/views/phage'
  'app/collections/phages'
  'app/views/phages'], (Backbone, AppView, AboutView, PhageModel, PhageView, PhagesCollection, PhagesView) ->

  class Router extends Backbone.Router

    initialize: ->
      AppView.render()
      Backbone.history.start()

    routes:
      '': 'phagesRequested'
      'about(/)': 'aboutRequested'
      'phage(/)': 'phagesRequested'
      'phage/:ppa(/)': 'singlePhageRequested'
      'phage/host_isolation/:host(/)': 'hostIsolationRequested'

    aboutRequested: ->
      new AboutView()

    singlePhageRequested: (ppa)->
      console.log "trying"
      phageModel = new PhageModel()
      phageView = new PhageView(phageModel)
      phageModel.url = "http://localhost:5000/api/phage/#{ppa}/"
      phageModel.fetch({
        success: (model, response, options) =>
          console.log model
          return
        error: (model, response, options) ->
          console.log "error:", response
      })

    phagesRequested: ->
      url = 'http://localhost:5000/api/phage/'
      phagesCollection = new PhagesCollection([], {url: url})
      phagesView = new PhagesView(phagesCollection)
      phagesCollection.fetch({
        url: phagesCollection.url
        success: (collection, response, options)->
          return
        error: (collection, response, options) ->
          console.log("error")
          console.log(collection)
          console.log(options)
          console.log(response)
      })

    hostIsolationRequested: (host)->
      url = "http://localhost:5000/api/phage/host_isolation/#{host}"
      phagesCollection = new PhagesCollection([], {url: url})
      phagesView = new PhagesView(phagesCollection)
      phagesCollection.fetch({
        url: phagesCollection.url
        success: (collection, response, options)->
          return
        error: (collection, response, options) ->
          console.log("error")
          console.log(collection)
          console.log(options)
          console.log(response)
      })
