#= require views/pages/base

class app.views.BowerPage extends app.views.BasePage
  afterRender: ->
    @highlightCode @findAll('pre[data-lang="js"], pre[data-lang="javascript"], pre[data-lang="json"]'), 'javascript'
    return
