define [
  "backbone"
  "app/models/phage"
], (Backbone, PhageModel) ->

    class Phages extends Backbone.Collection

      model: PhageModel

      initialize: (models, options) ->
        @url = options.url

      sync: (method, model, options) ->
        options.timeout = 8000
        options.dataType = 'jsonp'
        return Backbone.sync(method, model, options)

      parse: (response) ->
        response
