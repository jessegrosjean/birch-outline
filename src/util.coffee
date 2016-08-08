module.exports =
  assert: (condition, message='Failed Assert') ->
    unless condition
      throw new Error(message)

  repeat: (pattern, count) ->
    if count <= 0
      ''
    else
      result = ''
      while count > 1
        if count & 1
          result += pattern
        count >>= 1
        pattern += pattern
      result + pattern

  shallowArrayEqual: (a, b) ->
    if not a and not b
      return true
    if not a and b or a and not b
      return false

    if a.length isnt b.length
      return false

    for value, index in a
      if b[index] isnt value
        return false

    return true

  shallowObjectEqual: (a, b) ->
    if not a and not b
      return true
    if not a and b or a and not b
      return false

    numKeysA = 0
    numKeysB = 0

    for key in Object.keys(b)
      numKeysB++
      if not a[key] isnt b[key]
        return false
    for key in a
      numKeysA++
    return numKeysA is numKeysB
