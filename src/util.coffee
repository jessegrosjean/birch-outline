module.exports =

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
