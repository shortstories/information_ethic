var main = (function() {
  // module variables start
  var state_map = {},
      jquery_map = {},
      initModule, attachEventHandlers, onMainWindowScroll;
  // module variables end
  // DOM methods start
  attachEventHandlers = function() {
    $(window).on("scroll", onMainWindowScroll);
  }
  // DOM methods end
  // Utility methods start
  // Utility mehtods end
  // Event Handlers start
  onMainWindowScroll = function(e) {
    if ($(this).scrollTop() > 0) {
      $("nav").addClass("navbar_scrolled");
    }
    else {
      $("nav").removeClass("navbar_scrolled");
    }
    return false;
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
