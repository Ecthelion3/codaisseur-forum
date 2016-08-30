document.addEventListener("turbolinks:load", function() {
  newAnswer();
  submitAnswer();
  submitQuestion();
});

$(document).ready(function() {
  newAnswer();
  submitAnswer();
  submitQuestion();
});

function newAnswer() {
  $('#new_answer_button').click(function(e) {
    // UGLY HACK to clear textarea after 1 sec
    window.setTimeout(function() {
      $("#answer_body").val('');
    }, 1000);
  });
}

function submitAnswer() {
  toggle('answer');

  $('.save-edit-answer').click(function() {
    var answer_id = $(this).data('answerId');
    var question_id = $(this).data('questionId');
    var body = $('#form-'+answer_id + ' .edit-body').val();

    $.ajax({
      url: '/questions/'+question_id+'/answers/'+answer_id,
      type: 'PUT',
      dataType: "json",
      data: {
        answer: {
          body: body,
          question_id: question_id,
          answer_id: answer_id
        }
      },
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
    console.log(id)
    $('#' + el + '-' + id + ' .td-' + el).toggle();
    $('#form-'+id).toggle();
  });
}
