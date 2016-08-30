document.addEventListener("turbolinks:load", function() {

    $('.edit-role').click(function(){
      var user_id = $(this).attr('id');
      $('.edit-role').show();
      $(this).hide();
      $('.edit-role-form').hide();
      $('#role-form-' + user_id).show();
    });

    $('.edit-role-select').change(function() {

      var user_id = $(this).attr('user-id');
      var role = $(this).val();

      console.log(user_id, role);

      $.ajax({
        url: '/profiles/edit-role',
        type: 'POST',
        dataType: "json",
        data: {'role': role, 'user_id': user_id},
        success: function(response) {
          $('#role-'+user_id).html(response.role).show();
          $('#role-form-'+user_id).hide();

        },
        error: function(response) {
          console.log(response);
        }
      });
    });
});
