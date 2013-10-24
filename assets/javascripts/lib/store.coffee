class @Store
  get: (key) ->
    try
      JSON.parse localStorage.getItem(key)
    catch

  set: (key, value) ->
    try
      localStorage.setItem(key, JSON.stringify(value))
      true
    catch

  del: (key) ->
    try
      localStorage.removeItem(key)
      true
    catch

  clear: ->
    try
      localStorage.clear()
      true
    catch
