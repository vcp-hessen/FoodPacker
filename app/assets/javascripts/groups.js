function count_changed(element) {
	total = parseInt($('#total_count')[0].value);
	$.each($('.meal_count'), function(i,l){
		value = parseInt(l.previousSibling.previousSibling.childNodes[0].value);
		l.innerHTML = "= " + (total + value);
	});
}