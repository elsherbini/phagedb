define ['backbone','templates/phages'], (Backbone, phagesTemplate) ->

  class PhagesView extends Backbone.View

    el: ".content"

    events: {}

    template: phagesTemplate

    initialize: (collection)->
      @collection = collection
      @listenTo(@collection, 'sync', @render)
      @render()

    render: ->
      @$el.html @template( phages: @collection.toJSON() )
      return this
