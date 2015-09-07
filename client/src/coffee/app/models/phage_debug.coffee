define ["backbone"], (Backbone) ->
  class Phage extends Backbone.Model

    defaults:
      ppa: ''
      name: ''
    
    parse: (data) ->
      return {ppa: data.ppa, name: data.name}
