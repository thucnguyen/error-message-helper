class Hire.Modules.ErrorMessageHelper
  @displayErrors: (object, errors, container)->
    @highlightErrorFields(object, errors, container)
    @showErrorMessages(object, errors, container)

  @highlightErrorFields: (object, errors, container)->
    @resetHilightedFields(container)
    $.each errors, (k, _v)=>
      field = @findErrorField(object, k, container)
      return true unless field.length
      field.wrapAll("<div class='field_with_errors'>")

  @resetHilightedFields: (container)->
    container.find('.field_with_errors')
             .contents()
             .unwrap()

  @findErrorField: (object, field, container)->
    # include chosen element
    container.find("##{object}_#{field}, ##{object}_#{field}_chosen")

  @showErrorMessages: (object, errors, container)->
    errorExplanation = @errorExplanation(container)
    errorExplanation.html('')

    ul = $('<ul/>').appendTo(errorExplanation)
    $.each errors, (k, v)=>
      $("<li>#{@fullMessage(k, v)}</li>").appendTo(ul)

  @errorExplanation: (container)->
    errorExplanation = container.find('#error_explanation')
    unless errorExplanation.length
      errorExplanation = $('<div/>', id: 'error_explanation')
      container.prepend(errorExplanation);
    errorExplanation

  @fullMessage: (field, message)->
    field = field.split('.').pop() if field.split('.').length > 1
    humanField = _.str.humanize(field)
    "#{humanField} #{message[0]}"
