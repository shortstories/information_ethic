var assignedExercise = (function() {
  // module variables start
  var state_map = {},
      jquery_map = {},
      initModule,         attachEventHandlers, onModalShow,
      onCheckButtonClick;
  // module variables end
  // DOM methods start
  attachEventHandlers = function() {
    $('#contentsModal').on('show.bs.modal', onModalShow);
    $('.btn-exerciseCheck').on('click', onCheckButtonClick);
  }
  // DOM methods end
  // Utility methods start
  // Utility mehtods end
  // Event Handlers start
  onModalShow = function(e) {
    var button = $(e.relatedTarget), // Button that triggered the modal
        recipient = button.data('id'), // Extract info from data-* attributes
        title = button.data('title'),
        this_id = button.data('this'),
        html,
        modal = $(this);
    // If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
    // Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.

    modal.find('.modal-body').html('');

    $.ajax({
      url: "/exercises/" + recipient + "/content",
      type: "GET",
      dataType: "json",
      success: function(responseData) {
        modal.find('.modal-title').text(title);
        modal.find('.modal-body').html(responseData.content);   
        modal.find('.btn-exerciseCheck').attr('data-id', this_id);     
      },
    });
  }

  onCheckButtonClick = function(e) {
    var $form = $(this).parent(),
        $button = $(this),
        target_id = $(this).data('id');

    e.preventDefault();

    console.log(target_id);
    $form.find('input[name=id]').attr('value', target_id);
    $form.submit();
  }
  // Event Handlers end
  // Public methods start
  initModule = function() {
    attachEventHandlers();
  }
  // Public methods end
  // return Public object
  return {
    initModule : initModule
  }
}());
