function entryComplete() {
    $(".form-animation").addClass("completed-task");
    setTimeout(function() {
        $(".form-animation").removeClass("completed-task");
    }, 2000);
}

function entryFail() {
    $(".form-animation").addClass("failed-task");
    setTimeout(function() {
        $(".form-animation").removeClass("failed-task");
    }, 2000);
}

function todoItemUpdated(row) {

  $('.check-message').removeClass("missing");
  setTimeout(function() {
    $('.check-message').addClass("missing");
  }, 2000);
}

function todoItemNotUpdated(row) {
  $('.fail-message').removeClass("missing");
  setTimeout(function() {
    $('.fail-message').addClass("missing");
  }, 8000);

}

$('.select2-container').addClass('full-width');
