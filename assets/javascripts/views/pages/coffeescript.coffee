#= require views/pages/base

class app.views.CoffeescriptPage extends app.views.BasePage
  afterRender: ->
    @highlightCode @findAll('.code > pre:first-child'), 'coffeescript'
    @highlightCode @findAll('.code > pre:last-child'), 'javascript'
    return
