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
    @addSubview @listFocus  = new app.views.ListFocus @el unless $.isTouchScreen()
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
    @renderDisabled() unless app.isSingleDoc()
    @refreshElements()
    return

  renderDisabled: ->
    @append @tmpl('sidebarDisabled', count: app.disabledDocs.size())
    @renderDisabledList()
    return

  renderDisabledList: ->
    @append @tmpl('sidebarDisabledList', docs: app.disabledDocs.all())
    @refreshElements()
    @disabledTitle.classList.add('open-title')
    return

  removeDisabledList: ->
    @disabledList.remove()
    @disabledTitle.classList.remove('open-title')
    return

  reset: ->
    @listSelect.deselect()
    @listFocus?.blur()
    @listFold.reset()

    if model = app.router.context.type or app.router.context.entry
      @reveal model
      @select model
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

  onClick: (event) =>
    return unless @disabledTitle and $.hasChild @disabledTitle, event.target
    $.stopEvent(event)
    if @disabledTitle.classList.contains('open-title')
      @removeDisabledList()
    else
      @renderDisabledList()


  afterRoute: (route, context) =>
    if context.init
      @reset()
    else
      @select context.type or context.entry
    return
