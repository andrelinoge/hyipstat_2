class @UserAvatarCropper
  constructor: ->
    document.jcrop.init({ file_input_id: 'user_avatar' })


class @UserForm
  constructor: ->
    $('.datepicker').datepicker();
    