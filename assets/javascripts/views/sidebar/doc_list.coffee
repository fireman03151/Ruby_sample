class app.views.DocList extends app.View
  @className: '_list'

  @events:
    open:  'onOpen'
    close: 'onClose'
    click: 'onClick'

  @routes:
    after: 'afterRoute'

  @elements:
    disabledTitle: '._list-title'
    disabledList: '._disabled-list'

  init: ->
    @lists = {}

    @addSubview @listSelect = new app.views.ListSelect @el
    @addSubview @listFocus  = new app.views.ListFocus @el unless app.isMobile()
    @addSubview @listFold   = new app.views.ListFold @el

    app.on 'ready', @render
    return

  activate: ->
    if super
      list.activate() for slug, list of @lists
      @listSelect.selectCurrent()
    return

  deactivate: ->
    if super
      list.deactivate() for slug, list of @lists
    return

  render: =>
    @html @tmpl('sidebarDoc', app.docs.all())
    @renderDisabled() unless app.isSingleDoc() or app.disabledDocs.size() is 0
    return

  renderDisabled: ->
    @append @tmpl('sidebarDisabled', count: app.disabledDocs.size())
    @refreshElements()
    @renderDisabledList()
    return

  renderDisabledList: ->
    if (hidden = app.settings.get 'hideDisabled') is true
      @removeDisabledList()
    else
      app.settings.set 'hideDisabled', false unless hidden is false
      @appendDisabledList()
    return

  appendDisabledList: ->
    @append @tmpl('sidebarDisabledList', docs: app.disabledDocs.all())
    @disabledTitle.classList.add('open-title')
    @refreshElements()
    return

  removeDisabledList: ->
    $.remove @disabledList if @disabledList
    @disabledTitle.classList.remove('open-title')
    @refreshElements()
    return

  reset: (options = {}) ->
    @listSelect.deselect()
    @listFocus?.blur()
    @listFold.reset()
    @revealCurrent() if options.revealCurrent
    return

  onOpen: (event) =>
    $.stopEvent(event)
    doc = app.docs.findBy 'slug', event.target.getAttribute('data-slug')

    if doc and not @lists[doc.slug]
      @lists[doc.slug] = if doc.types.isEmpty()
        new app.views.EntryList doc.entries.all()
      else
        new app.views.TypeList doc
      $.after event.target, @lists[doc.slug].el
    return

  onClose: (event) =>
    $.stopEvent(event)
    doc = app.docs.findBy 'slug', event.target.getAttribute('data-slug')

    if doc and @lists[doc.slug]
      @lists[doc.slug].detach()
      delete @lists[doc.slug]
    return

  select: (model) ->
    @listSelect.selectByHref model?.fullPath()
    return

  reveal: (model) ->
    @openDoc model.doc
    @openType model.getType() if model.type
    @paginateTo model
    @scrollTo model
    return

  revealCurrent: ->
    if model = app.router.context.type or app.router.context.entry
      @reveal model
      @select model
    return

  openDoc: (doc) ->
    @listFold.open @find("[data-slug='#{doc.slug}']")
    return

  openType: (type) ->
    @listFold.open @lists[type.doc.slug].find("[data-slug='#{type.slug}']")
    return

  paginateTo: (model) ->
    @lists[model.doc.slug]?.paginateTo(model)
    return

  scrollTo: (model) ->
    $.scrollTo @find("a[href='#{model.fullPath()}']"), null, 'top', margin: 0
    return

  toggleDisabled: ->
    if @disabledTitle.classList.contains('open-title')
      @removeDisabledList()
      app.settings.set 'hideDisabled', true
    else
      @appendDisabledList()
      app.settings.set 'hideDisabled', false
    return

  onClick: (event) =>
    if @disabledTitle and $.hasChild(@disabledTitle, event.target)
      $.stopEvent(event)
      @toggleDisabled()
    else if slug = event.target.getAttribute('data-enable')
      $.stopEvent(event)
      doc = app.disabledDocs.findBy('slug', slug)
      app.enableDoc(doc, @onEnable, @onEnable)
    return

  onEnable: =>
    @reset()
    @render()
    return

  afterRoute: (route, context) =>
    if context.init
      @reset revealCurrent: true
    else
      @select context.type or context.entry
    return
