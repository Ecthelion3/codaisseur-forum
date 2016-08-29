App.votes = App.cable.subscriptions.create "VotesChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
    console.log(data)
    App.votes.updateWidget(data)

  updateWidget: (data) ->
    widget = $("##{data.dom_id}")
    return unless widget

    $(widget).find('a').removeClass('active')

    $(widget).find(".rating").html(data.rating)
    current_user_vote = $("body").data("userId") == data.user_id

    $(widget).find('.plus a').addClass('active') if (current_user_vote && data.voted_up)
    $(widget).find('.minus a').addClass('active') if (current_user_vote && data.voted_down)
