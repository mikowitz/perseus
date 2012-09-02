$(document).ready ->
  $(document).on 'change', '#show-checked', (e) ->
    if @.checked
      alert "checked"
    else
      alert "nope"

  $(document).on 'keyup', '#author-search', (e) ->
    query = $(@).val().toLowerCase()
    if query == ""
      $('li.author').removeClass('no-match match')
    else
      $('li.author[name*="' + query + '"]').addClass('match').removeClass('no-match')
      $('li.author:not([name*="' + query + '"])').addClass('no-match').removeClass('match')

  $(document).on 'keyup', '#title-search', (e) ->
    query = $(@).val().toLowerCase()
    if query == ""
      $('li.writing').removeClass('no-match match')
    else
      $('li.writing[name*="' + query + '"]').addClass('match').removeClass('no-match')
      $('li.writing:not([name*="' + query + '"])').addClass('no-match').removeClass('match')
      $('ul.writings').each (i, ul) ->
        if $(ul).children('li.match').length == 0
          $(ul).parent('li.author').addClass('no-match').removeClass('match')
        else
          $(ul).parent('li.author').addClass('match').removeClass('no-match')
