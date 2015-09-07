define ['backbone','templates/about'], (Backbone, AboutTemplate) ->

  class AboutView extends Backbone.View

    el: ".content"

    events: {}

    template: AboutTemplate

    initialize: ->
      @render()

    render: ->
      @$el.html @template({'useless':'data'})
      return this
