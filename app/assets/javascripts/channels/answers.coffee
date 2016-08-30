App.answers = App.cable.subscriptions.create "AnswersChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
    container = $("tbody.border-top-answers")
    return unless $(data).data("questionId") == $(container).data("questionId")
    toAdd = $(data).addClass("just-loaded")

    if $("##{$(data).attr("id")}").length > 0
      $("##{$(data).attr("id")}").replaceWith(toAdd)
    else
      $(toAdd).appendTo(container)

    window.setTimeout(->
      $(toAdd).removeClass('just-loaded');
    , 5000)
