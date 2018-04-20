# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(".new-todo").on "click", ->
    $.ajax({type: "Get",url: "todo_lists/new"});

$("#tableWithSearch button").on "click", ->
    $.ajax({type: "Get",url: $(this).data('url')});


$('.completed-checkbox').on 'change', ->
    $(this).closest("form").submit();
