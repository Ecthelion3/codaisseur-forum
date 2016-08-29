$(document).ready(function() {
  bindVoteButtons();
});

function bindVoteButtons() {
  $('.vote-widget .plus a').click(function(e) {
    e.preventDefault();

    var $this = $(this);
    var url = $this.data('url');
    $this.parent().parent().find('a').removeClass('active');
    var rating = $this.parent().parent().find('.rating');

    if (url === '#') return;

    $.ajax({
      url: url,
      type: 'POST',
      dataType: "json",
      success: function(response) {
        console.log(response);
        console.log(rating);
        if (response.voted_up) $this.addClass('active');

        rating.html(response.rating);
      },
      error: function(response) {
        console.log(response);
      }
    });
  });

  $('.vote-widget .minus a').click(function(e) {
    e.preventDefault();

    var $this = $(this);
    var url = $this.data('url');
    $this.parent().parent().find('a').removeClass('active');
    var rating = $this.parent().parent().find('.rating');

    $.ajax({
      url: url,
      type: 'DELETE',
      dataType: "json",
      success: function(response) {
        console.log(response);
        console.log(rating);
        if (response.voted_down) $this.addClass('active');
        rating.html(response.rating);
      },
      error: function(response) {
        console.log(response);
      }
    });
  });

  function updateStats(response, rating) {
    rating.html(response.rating);
  }
}
