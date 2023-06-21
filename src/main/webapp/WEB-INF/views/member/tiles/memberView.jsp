<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/memberView.css">
<script type="text/javascript" src="${pageContext.request.contextPath }/js/member/memberView.js"></script>

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
             		<c:when test="${bne ne null or de ne null}">
             			<h3>회원 정보 조회 실패</h3>
						<div class="alert alert-success">
							<p>회원 정보 조회 실패 하였습니다. 전산실에 문의 부탁드립니다. 042-719-8850</p>
							<div class="btn-area">
								<button type="button" onclick="history.back();">뒤로가기</button>
							</div>
						</div>
             		</c:when>
             		<c:when test="${bne eq null and de eq null }">
						<c:if test="${not empty member.atchNo }">
	             			<img alt="프로필사진" src="<c:url value='/image/${member.atchNo } '/>">
						</c:if>	
             			<table >
							<tbody>
								<tr>
									<td class="td_left">아이디</td>
									<td class="td_right">${member.memId }</td>
								</tr>
								<tr>
									<td class="td_left">회원명</td>
									<td class="td_right">${member.memName }</td>
								</tr>
								<tr>
									<td class="td_left">우편번호</td>
									<td class="td_right">${member.memZip }</td>
								</tr>
								<tr>
									<td class="td_left">주소</td>
									<td class="td_right">${member.memAdd1 } ${member.memAdd2 }</td>
								</tr>
								<tr>
									<td class="td_left">생일 </td>
									<!-- 'YYYY-MM-DD'형태만 value값으로 들어갈수있어요 --> 
									<td class="td_right"><input type="date" name="memBir"  value="${fn:substring(member.memBir ,0,10) }" readonly="readonly"></td> 
								</tr>
								<tr>
									<td class="td_left">핸드폰</td>
									<td class="td_right">${member.memHp }</td>
								</tr>
								<tr>
									<td class="td_left">직업</td>
									<td class="td_right">${member.memJob }</td>
								</tr>
								<tr>
									<td class="td_left">취미</td>
									<td class="td_right">${member.memHobby }</td>
								</tr>
								<tr>
									<td class="td_left">마일리지</td>
									<td class="td_right">${member.memMileage}</td>
								</tr>
							</tbody>
						</table>
						<div class="div_button">
		                     <input type="button" onclick="location.href='${pageContext.request.contextPath}/home'" value="HOME">
		                     <input type="button" onclick="fn_memberEdit('${member.memId }')" value="수정"><%-- ${member.memId }는 '' 필요  --%>
		                     <input type="button" onclick="fn_memberDelete()" value="탈퇴">
		                 </div>
             		</c:when>
             	</c:choose>
             </div>
         </div>
     </div>

	<!-- 회원탈퇴 모달 -->
	<div id="modal_div1" >
		<div id="modal_div2" >
			<form name="deleteForm" action="<c:out value='${pageContext.request.contextPath }/member/memberDelete'/>" method="post">
				<input type="hidden" id="memId" name="memId" value="<c:out value='${searchVO.pageIndex}'/>"/>
	            <div class="int-area">
	                <input type="password" id="memPass" name="memPass" value="" placeholder="PASSWORD" autocomplete="off" required/>
	            </div>
	            <div class="btn-area">
	                <button type="button" onclick="fn_memberDeleteSubmit()">탈퇴</button>
	                <button type="button" onclick="fn_cancel()">취소</button>
	            </div>
	        </form>
			
		</div>
	</div>
		
