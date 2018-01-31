# TODO - refactor

md_editor = () ->
  $('.btn-toolbar .btn-group button').click ->
    att_class = this.classList
    rgex = /md_/

    option = $.grep att_class, (item) ->
      return rgex.test(item)

    if option.length != 0
      option = option[0].toString()

      sel_text = getSelectionText()
      text = switch option
        when 'md_h1'
          "##{sel_text}"
        when 'md_h2'
          "###{sel_text}"
        when 'md_h3'
          "####{sel_text}"
        when 'md_h4'
          "#####{sel_text}"
        when 'md_h5'
          "######{sel_text}"
        when 'md_italic'
          "_#{sel_text || 'italic text'}_"
        when 'md_bold'
          "__#{sel_text}__"
        when 'md_list-ul'
          "\n\n* Item 1\n* Item 2\n* Item 3 \n\n"
        when 'md_list-ol'
          "\n\n1. Item 1\n2. Item 2\n3. Item 3 \n\n"
        when 'md_indent'
          ">#{sel_text || 'Indented text'}"
        when 'md_underline'
          "<u>#{sel_text || 'Undelined text'}</u>"
        when 'md_table'
          "\n|Header|Header|Header|\n|:------|:-------:|------:|\n|Left alignment|Centered|Right alignment|\n\n"
        when 'md_minus'
          "\n<hr>\n"
        when 'md_square'
          "\n\t #{sel_text || 'Some text here'}\n\n"
        when 'md_link'
          "\n[#{sel_text || 'This is link'}](#{sel_text || 'https://test.com'})\n"
        when 'md_camera-retro'
          "\n![Alt](https://www.google.com.co/images/srpr/logo11w.png)\n"
        when 'md_first_letter'
          "<p><span class=\"first-letter\">#{sel_text}</span></p>"


      textarea = $('#md-editor #md-text textarea')
      replaceAtCaret(textarea.attr('id'), text)

preview = ->
  if $('#md-text').prop('hidden')
    $('.preview_md').text('Preview')
    $('#md-text').removeAttr('hidden')
    $('.preview-panel').attr('hidden', 'true')
    false
  else
    $.post(
      '/md_preview',
      {md: $('#md-text textarea').val()},
      (data) ->
        h = $('#md-text').outerHeight();
        $('.preview_md').text('Editor')
        $('#md-text').attr('hidden', 'true')
        $('.preview-panel').removeAttr('hidden').attr('style', "height: #{h}px;")
        $('#md-preview').html(data)
    )

getSelection = (elem) ->
  start: elem.selectionStart
  end: elem.selectionEnd

setCaret = (elem, start, end) ->
  elem.selectionStart = start
  elem.selectionEnd = end

replaceAtCaret = (elem_id, txtToAdd) ->
  caretPos = document.getElementById(elem_id).selectionStart
  caretEnd = document.getElementById(elem_id).selectionEnd
  textArea = $("##{elem_id}")
  textAreaTxt = textArea.val()
  textArea.val textAreaTxt.substring(0, caretPos) + txtToAdd + textAreaTxt.substring(caretEnd)
  textArea.focus()
  document.getElementById(elem_id).selectionStart = caretPos
  document.getElementById(elem_id).selectionEnd = caretPos + txtToAdd.length

getSelectionText = ->
  text = ''
  activeEl = document.activeElement
  activeElTagName = if activeEl then activeEl.tagName.toLowerCase() else null
  if activeElTagName == 'textarea' or activeElTagName == 'input' and /^(?:text|search|password|tel|url)$/i.test(activeEl.type) and typeof activeEl.selectionStart == 'number'
    text = activeEl.value.slice(activeEl.selectionStart, activeEl.selectionEnd)
  else if window.getSelection
    text = window.getSelection().toString()
  text

saveTextareaState = (elem) ->
  sel = getSelection(elem)
  $(elem).data('start', sel.start).data('end', sel.end).data('scroll', $(elem).scrollTop())

initializeEditor = ->
  if $('.js_wrap_dropzone_editor .js_editor_dropzone').length
    md_editor()
    $(document).off 'turbolinks:load page:load ready', initializeEditor
    $('.preview_md').click ->
      preview()

    $('.js_wrap_dropzone_editor #md-text textarea').change ->
      saveTextareaState(this)
    $('.js_wrap_dropzone_editor #md-text textarea').click ->
      saveTextareaState(this)

    $('.js_wrap_dropzone_editor .js_editor_dropzone').dropzone({
      url: '/images',
      headers: {'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')},
      success: (event, response) ->
        $textarea = $(event.previewElement).closest('.js_wrap_dropzone_editor').find('#md-text textarea')
        setCaret($textarea[0], $textarea.data('start'), $textarea.data('end'))
        replaceAtCaret($textarea.attr('id'), "\n![#{response.name}](#{response.url})\n")
        $textarea.scrollTop($textarea.data('scroll'))
        return
    })

  $('.js_simple_dropzone').dropzone({
    url: '/images',
    headers: {'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')},
    maxFiles: 1,
    success: (event, response) ->
      $target = $($(this)[0].element)
      $target.find('.js_dropzone_value').val(response.id)
  })

$(document).ready ->
  initializeEditor()
