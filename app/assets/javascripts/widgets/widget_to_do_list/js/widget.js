/*
    Widget specific JS (ie: init scripts of
    plugins used in the widget) go here
*/


(function() {
	$('[data-toggler="task"]').on("click",function(){
		$(this).parent().parent().find(".task-name").toggleClass('strikethrough');
	});
})();
(function() {
	$('.pg-close ').on("click",function(){
		$(this).parent().parent().hide();
	});
})();
(function() {
	$('.plus').on("click",function(){
		var length = $('.task-list li').size() + 1
$("ul.task-list").append('<li class="task m-b-10 clearfix row"><div class="task-list-title"><a href="#" class="text-master task-name" data-task="name">' + $('#new-task').val() + '</a><i class="fs-14 pg-close pull-right hidden"></i></div><div class="checkbox checkbox-circle no-margin text-center"><input type="checkbox" value="1" id="todocheckbox'+length+'" data-toggler="task"><label for="todocheckbox'+length+'" class=" no-margin no-padding"></label></div></li>');
$('#new-task').val('')
});
})();
