#= require views/pages/base

class app.views.MeteorPage extends app.views.BasePage
  afterRender: ->
    @highlightCode @findAll('pre.js, pre.javascript'), 'javascript'
    @highlightCode @findAll('pre.html'), 'markup'
    return
