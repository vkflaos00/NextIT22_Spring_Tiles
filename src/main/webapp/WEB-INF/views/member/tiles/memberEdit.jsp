<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/memberView.css">

<script type="text/javascript">
function fn_memberModify(){
	console.log("fn_memberModify");

	let memPassNew = $("#memPassNew").val();
	let memPassNew_check = $("#memPassNew_check").val();
	if( memPassNew == "" ||  memPassNew_check == "" ){
		alert("신규 비밀번호 또는 신규비밀번호 확인이 입력되지 않았습니다. 입력부탁드려요");
		return;
	}
	if(memPassNew != memPassNew_check ){
		alert("신규 비밀번호 와 신규 비밀번호 확인 값이 일치 하지 않습니다. 다시 입력 해주세요.");
		$("#memPassNew").val("");
		$("#memPassNew_check").val("");
		return;
	}else{
		$("form[name='memberModifyForm']").submit(); 
	}
}

function fn_cancel(){
	let ret = confirm("수정을 취소하시겠습니까? 확인을 누르시면 이전 페이지로 돌아갑니다.");
	if( ret){
		history.back();
	}
}
</script>

<style type="text/css">
.profile_image{
	width: 300px; 
	height: 300px; 
	background-color: lightgray;
	position: relative;
}
.upload {
	width: 300px;
	height: 250px;
	/* background-color: antiquewhite; */
}
li {
  list-style: none;
}
.profile_image img{
  width: 300px;
  height: 250px;
}
.image-preview {
	width: 300;
	height: 250px;
	background-color: #9b9b9d;
	position: absolute;
	top: 0px;
}
.profile_image input{
	width: 250px;
	margin-top: 15px;
	float:right;
}
</style>

     <div class="intro_bg">
         <div class="intro_text">
             <h1>NextIT</h1>
             <h4>넥스트아이티</h4>
         </div>
     </div>
     <!-- intro_bg e -->

     <!-- 전체 영역잡기 -->
     <div class="contents">
         <!-- 사용할 영역잡기 -->
         <div class="content01">
             <div class="content01_h1">
                 <h1>회원 정보 상세</h1>
             </div>
             <!-- 회원 정보 테이블 -->
             <div id="div_table">
             
             	<c:choose>
             		<c:when test="${bne ne null or de ne null }">
             			<h3>회원 정보 조회 실패</h3>
						<div class="alert alert-success">
							<p>회원 정보 조회 실패 하였습니다. 전산실에 문의 부탁드립니다. 042-719-8850</p>
							<div class="btn-area">
								<button type="button" onclick="history.back();">뒤로가기</button>
							</div>
						</div>
             		</c:when>
             		<c:when test="${bne eq null and de eq null }">
		             	<form:form name="memberModifyForm" action="${pageContext.request.contextPath }/member/memberModify"  method="post"  modelAttribute="member" enctype="multipart/form-data">
							<input type="hidden" name="memId" value="${member.memId }">
							<div class="profile_image" >
								<div class="upload"></div>
 								<input type="file" class="real-upload" name="profilePhoto" accept="image/*" required multiple>
								<ul class="image-preview">
									<c:if test="${not empty member.atchNo }">
										<li>
											<img alt="프로필사진" src="<c:url value='/image/${member.atchNo } '/>">
										</li>
									</c:if>
								</ul>
							</div>
			              	<table >
								<tbody>
									<tr>
										<td class="td_left">아이디</td>
										<td class="td_right">${member.memId }</td>
									</tr>
									<!-- 수업은 비밀번호와 회원정보를 모두 변경하고 싶은 경우 로 진행 -->
									<tr>
										<td class="td_left">기존 비밀번호</td>
										<td class="td_right">
											<form:password path="memPass"/>
											<form:errors path="memPass"/>
										</td>
									</tr>
									<tr>
										<td class="td_left">신규 비밀번호</td>
										<td class="td_right">
											<form:password path="memPassNew"/>
											<form:errors path="memPassNew"/>
										</td>
									</tr>
									<tr>
										<td class="td_left">신규 비밀번호 확인</td>
										<td class="td_right"><input type="password" id="memPassNew_check" pattern="\w{4,}" value="" title="알파벳과 숫자로 4글자 이상 입력" ></td>
									</tr>
									
									<tr>
										<td class="td_left">회원명</td>
										<td class="td_right">
											<form:input path="memName"/>
											<form:errors path="memName"/>
										</td>
									</tr>
									<tr>
										<td class="td_left">우편번호</td>
										<td class="td_right"><input type="text" name="memZip" value='${member.memZip}'></td>
									</tr>
									<tr>
										<td class="td_left">주소</td>
										<td class="td_right">
											<input type="text" name="memAdd1" value='${member.memAdd1 }'>
											<input type="text" name="memAdd2" value='${member.memAdd2 }'>
										</td>
									</tr>
									<tr>
										<td class="td_left">생일</td>
										<td class="td_right"><input type="date" name="memBir" value='${fn:substring(member.memBir ,0,10) }'></td>
									</tr>
									<tr>
										<td class="td_left">메일</td>
										<td class="td_right"><input type="email" name="memMail" value='${member.memMail }' required></td>
									</tr>
									<tr>
										<td class="td_left">핸드폰</td>
										<td class="td_right"><input type="tel" name="memHp" value='${member.memHp }'></td>
									</tr>
									<tr>
										<td class="td_left">직업</td>
										<td class="td_right">
											<select name="memJob">
												<option value="">-- 직업 선택 --</option>
												<c:forEach items="${jobList }" var="job">
										          <option value="${job.commCd }"  ${ job.commCd eq member.memJob ? "selected='selected'" :"" }>${job.commNm}</option>
												</c:forEach>
											</select>			
										</td>
									</tr>
									<tr>
										<td class="td_left">취미</td>
										<td class="td_right">
											<select name="memHobby"  >
										 		<option value="">-- 취미 선택 --</option>
											 	<c:forEach items="${hobbyList }" var="hobby">
										          <option value="${hobby.commCd }" ${ hobby.commCd eq member.memHobby ? "selected='selected'" :"" } >${hobby.commNm}</option>
												</c:forEach>
											</select>			
										</td>
									</tr>	
									<tr>
										<td class="td_left">마일리지</td>
										<td class="td_right">${member.memMileage }</td>
									</tr>	
								</tbody>
							</table>
							<div class="div_button">
			                     <input type="button" onclick="location.href='${pageContext.request.contextPath}/home'" value="HOME">
			                     <input type="button" onclick="fn_memberModify()" value="저장">
			                     <input type="button" onclick="fn_cancel()" value="취소">
			                </div>
						</form:form>
	                 </c:when>
             	</c:choose>
             </div>
         </div>
     </div>

	<script>
		function getImageFiles(e) {
			const files = e.currentTarget.files;
			const imagePreview = document.querySelector('.image-preview');
			const file = files[0];
			const reader = new FileReader();
			reader.readAsDataURL(file);
			reader.onload =  function(e){
				const preview = createElement(e, file);
				let imageLiTag = document.querySelector('.image-preview > li');
				if(imageLiTag){
					imagePreview.removeChild(imagePreview.firstElementChild);
				}
				imagePreview.appendChild(preview);
			};
		}
		function createElement(e, file) {
			const li = document.createElement('li');
			const img = document.createElement('img');
			img.setAttribute('src', e.target.result);
			img.setAttribute('data-file', file.name);
			li.appendChild(img);
			return li;
		}
	
		const realUpload = document.querySelector('.real-upload');
		const upload = document.querySelector('.upload');
		upload.addEventListener('click', function(e){
			realUpload.click()
		});

		realUpload.addEventListener('change', getImageFiles);
	</script>
	   