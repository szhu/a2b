do ($, _) ->
  debounce = (wait, immediateOrFn, fn) ->
    if fn?
      immediate = immediateOrFn
    else
      fn = immediateOrFn
      immediate = undefined
    _.debounce(fn, wait, immediate)

  window.localStorage ?= {}

  identity = (input) -> input

  xforms =
    '#upper': (input) -> input.toUpperCase()
    '#lower': (input) -> input.toLowerCase()
    '#identity': identity
    

  xform = identity

  $ ->
    $input = $('.input-field .field-textarea')
    $output = $('.output-field .field-textarea')

    $(window).on 'hashchange', ->
      if xforms[location.hash]?
        xform = xforms[location.hash]
      else
        location.hash = '#identity'

      $('.xform-mode-link').each (i, e) ->
        $(e).removeClass('xform-mode-link-active')
        if e.href == location.href
          $(e).addClass('xform-mode-link-active')

      $input.trigger('change')

    $input.on 'keyup keypress change', debounce 10, ->
      localStorage[location.href.split('#')[0]] = $input.val()
      $output.val xform $input.val()

    $output.on 'focus', debounce 0, ->
      $output.select()

    $('.last-input').on 'focus', ->
      $input.focus()

    $input.val(localStorage[location.href.split('#')[0]])
    $(window).trigger('hashchange')
