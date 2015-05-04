class app.views.EntryPage extends app.View
  @className: '_page'
  @errorClass: '_page-error'

  @events:
    click: 'onClick'

  @routes:
    before: 'beforeRoute'

  init: ->
    @cacheMap = {}
    @cacheStack = []
    return

  deactivate: ->
    if super
      @empty()
      @entry = null
    return

  loading: ->
    @empty()
    @trigger 'loading'
    return

  render: (content = '') ->
    return unless @activated
    @empty()

    @subview = new (@subViewClass()) @el, @entry
    @subview.render(content)

    if app.disabledDocs.findBy 'slug', @entry.doc.slug
      @hiddenView = new app.views.HiddenPage @el, @entry

    @trigger 'loaded'
    return

  LINKS =
    home: 'Homepage'
    code: 'Source code'

  prepareContent: (content) ->
    return content unless @entry.isIndex() and @entry.doc.links

    links = for link, url of @entry.doc.links
      """<a href="#{url}" class="_links-link">#{LINKS[link]}</a>"""

    """<p class="_links">#{links.join('')}</p>#{content}"""

  empty: ->
    @subview?.deactivate()
    @subview = null

    @hiddenView?.deactivate()
    @hiddenView = null

    @resetClass()
    super
    return

  subViewClass: ->
    docType = @entry.doc.type
    app.views["#{docType[0].toUpperCase()}#{docType[1..]}Page"] or app.views.BasePage

  getTitle: ->
    @entry.doc.name + if @entry.isIndex() then '' else "/#{@entry.name}"

  beforeRoute: =>
    @abort()
    @cache()
    return

  onRoute: (context) ->
    isSameFile = context.entry.filePath() is @entry?.filePath()
    @entry = context.entry
    @restore() or @load() unless isSameFile
    return

  load: ->
    @loading()
    @xhr = @entry.loadFile @onSuccess, @onError
    return

  abort: ->
    if @xhr
      @xhr.abort()
      @xhr = null
    return

  onSuccess: (response) =>
    return unless @activated
    @xhr = null
    @render @prepareContent(response)
    return

  onError: =>
    @xhr = null
    @render @tmpl('pageLoadError')
    @addClass @constructor.errorClass
    app.appCache?.update()
    return

  cache: ->
    return if not @entry or @cacheMap[path = @entry.filePath()]

    @cacheMap[path] = @el.innerHTML
    @cacheStack.push(path)

    while @cacheStack.length > app.config.history_cache_size
      delete @cacheMap[@cacheStack.shift()]
    return

  restore: ->
    if @cacheMap[path = @entry.filePath()]
      @render @cacheMap[path]
      true

  onClick: (event) =>
    if event.target.hasAttribute 'data-retry'
      $.stopEvent(event)
      @load()
    return
