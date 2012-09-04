$(document).ready ->
  $(document).on 'change', '#show-checked', (e) ->
    if @.checked
      $('li.author').addClass('no-match')
      $('li.work').addClass('no-match')
      $('input[type=checkbox]:checked').each (i, checkbox) ->
        $(checkbox).parent('li.work').addClass('match').removeClass('no-match')
      $('ul.works').each (i, ul) ->
        if $(ul).children('li.match').length > 0
          $(ul).parent('li.author').addClass('match').removeClass('no-match')

    else
      $('li.author').removeClass('no-match match')
      $('li.work').removeClass('no-match match')

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
      $('li.author').removeClass('no-match match')
      $('li.work').removeClass('no-match match')
    else
      $('li.work[name*="' + query + '"]').addClass('match').removeClass('no-match')
      $('li.work:not([name*="' + query + '"])').addClass('no-match').removeClass('match')
      $('ul.works').each (i, ul) ->
        if $(ul).children('li.match').length == 0
          $(ul).parent('li.author').addClass('no-match').removeClass('match')
        else
          $(ul).parent('li.author').addClass('match').removeClass('no-match')

  $(document).on 'submit', 'form#search', (e) ->
    e.preventDefault()
    url = "http://www.perseus.tufts.edu/hopper/vocablist?sort=weighted_freq&filt=25&output=table&lang=" + $('input#language').attr('value')
    keys = $('input.work-input[type=checkbox]:checked').map (index, checkbox) -> "works=" + checkbox.value
    if keys.length == 0
      false
    else
      url += "&" + keys.toArray().join("&")
      document.location.href = url
