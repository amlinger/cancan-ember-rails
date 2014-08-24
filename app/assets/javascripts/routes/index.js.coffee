CancanEmberRails.IndexRoute = Em.Route.extend
    model: ->
        console.log(@store.findAll('Rule'))