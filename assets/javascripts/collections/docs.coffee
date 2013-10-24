class app.collections.Docs extends app.Collection
  @model: 'Doc'

  # Load models concurrently.
  # It's not pretty but I didn't want to import a promise library only for this.
  CONCURRENCY = 3
  load: (onComplete, onError, options) ->
    i = 0

    next = =>
      if i < @models.length
        @models[i].load(next, fail, options)
      else if i is @models.length + CONCURRENCY - 1
        onComplete()
      i++
      return

    fail = (args...) ->
      if onError
        onError(args...)
        onError = null
      next()
      return

    next() for [0...CONCURRENCY]
    return

  clearCache: ->
    doc.clearCache() for doc in @models
    return
