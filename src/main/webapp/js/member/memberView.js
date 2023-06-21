function fn_memberEdit(memId){
	console.log("memId:"+ memId);
	
	//console.log("location.href.indexOf(location.host): ", location.href.indexOf(location.host));
	//console.log("location.host.length: ", location.host.length);
	
	let hostIndex = location.href.indexOf(location.host)+ location.host.length;
	let contextPath 
		= location.href.substring(
				hostIndex
				, location.href.indexOf('/', hostIndex+1));
	
	console.log("hostIndex : ", hostIndex);
	console.log("contextPath : ", contextPath);
	
	//location.href = "${pageContext.request.contextPath}/member/memberEdit?memId="+memId;
	location.href = contextPath+"/member/memberEdit?memId="+memId;
	
}

function fn_memberDelete(){
	console.log("fn_memberDelete");
	$("#modal_div1").fadeIn();
}

function fn_memberDeleteSubmit(){
	console.log("fn_memberDeleteSubmit");
	let ret = confirm("탈퇴를 진행하시겠습니까?");
	if(ret){
		let f = document.deleteForm;
		console.log("f : ", f);
		f.submit();
	}else{
		$("#modal_div1").fadeOut();	
	}
}

function fn_cancel(){
	$("#modal_div1").fadeOut();
}
