$(document).ready(function() {
	function checkWidth() { // 윈도우 사이즈가 바뀔 때 보여주는 아이템 변경
		$("#tags").toggle($(window).width() > 500);
		$("span[name='more']").toggle($(window).width() > 1000);
	}
	checkWidth();

	$(window).resize(checkWidth);
});  

$(document).ready(function() {
	var options = {
		minMargin : 5,
		maxMargin : 15,
		itemSelector : ".item",
		firstItemClass : "first-item"
	};
	$(".mcontainer").rowGrid(options);
});

function veiwDetail(seq) {
	console.log(seq);
	location.href = "PdsController?command=detailview&seq=" + seq;
};

function doDown(item, seq, fsavename, filename) {
	location.href = "FileController?command=download&rate=100&pdsSeq=" + seq
			+ "&fsavename=" + fsavename + "&filename=" + filename;
	var dCount = parseInt($(item).siblings().text());
	$(item).siblings().text(dCount + 1);
}