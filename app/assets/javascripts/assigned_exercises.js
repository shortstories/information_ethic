var assignedExercise = (function() {
  // module variables start
  var state_map = {},
      jquery_map = {},
      initModule, attachEventHandlers, onModalShow;
  // module variables end
  // DOM methods start
  attachEventHandlers = function() {
    $('#contentsModal').on('show.bs.modal', onModalShow);
  }
  // DOM methods end
  // Utility methods start
  // Utility mehtods end
  // Event Handlers start
  onModalShow = function(e) {
    var button = $(e.relatedTarget), // Button that triggered the modal
        recipient = button.data('whatever'), // Extract info from data-* attributes
        modal = $(this);
    // If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
    // Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.

    modal.find('.modal-title').text('New message to ' + recipient);
    modal.find('.modal-body input').val(recipient);
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
