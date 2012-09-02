$(document).ready ->
  $(document).on 'keyup', '#search', (e) ->
    query = $(this).val()
    if query == ""
      $('li.author').removeClass('no-match match')
    else
      $('li.author[name*="' + query + '"]').addClass('match').removeClass('no-match')
      $('li.author:not([name*="' + query + '"])').addClass('no-match').removeClass('match')
