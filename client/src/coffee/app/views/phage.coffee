define ['backbone','templates/phage'], (Backbone, phageTemplate) ->

  class PhageView extends Backbone.View

    el: ".content"

    events: {}

    template: phageTemplate

    initialize: (model)->
      console.log('initialized')
      @model = model
      @listenTo(@model, 'sync', @render)
      @render()

    render: ->
      console.log @model.toJSON()
      @$el.html @template( phage: @model.toJSON() )
      return this
