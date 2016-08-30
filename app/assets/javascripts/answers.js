document.addEventListener("turbolinks:load", function() {
  newAnswer();
  submitAnswer();
  submitQuestion();
});

function newAnswer() {
  $('#new_answer').submit(function(e) {
    console.log(this);
  });
}

function submitAnswer() {
  toggle('answer');

  $('.save-edit-answer').click(function() {

    var answer_id = $(this).attr('answer_id');
    var question_id = $(this).attr('question_id');
    var body = $('#form-'+answer_id + ' .edit-body').val();

    $.ajax({
      url: '/questions/'+question_id+'/answers/'+answer_id,
      type: 'PUT',
      dataType: "json",
      data: {'body': body, 'question_id': question_id, 'answer_id': answer_id},
      success: function(response) {
        $('#answer-'+answer_id).html(response.body).show();
        $('#form-'+answer_id).hide();

      },
      error: function(response) {
        console.log(response);
      }
    });


  });

}

function submitQuestion() {
  toggle('question');

  $('.save-edit-question').click(function() {

    var question_id = $(this).attr('question_id');
    var body = $('#form-'+question_id + ' .edit-body').val();


    $.ajax({
      url: '/questions/'+question_id,
      type: 'PUT',
      dataType: "json",
      data: {'body': body, 'question_id': question_id},
      success: function(response) {
        $('#question-'+question_id).html(response.body).show();
        $('#form-'+question_id).hide();

      },
      error: function(response) {
        console.log(response);
      }
    });
  });

}

function toggle(el) {
  $('.edit-btn-' + el).click(function(){
    var id = $(this).attr('id');
    $('#' + el + '-' + id).toggle();
    $('#form-'+id).toggle();
  });
}
