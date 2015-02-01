class app.collections.Types extends app.Collection
  @model: 'Type'

  groups: ->
    result = []
    for type in @models
      (result[@_groupFor(type)] ||= []).push(type)
    result.filter (e) -> e.length > 0

  GUIDES_RGX = /guide|tutorial|getting\ started/i

  _groupFor: (type) ->
    if GUIDES_RGX.test(type.name)
      0
    else
      1
