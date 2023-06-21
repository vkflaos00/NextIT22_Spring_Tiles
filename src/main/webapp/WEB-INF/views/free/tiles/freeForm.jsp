<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/freeBoardView.css">
<style type="text/css">
.btn_delete{
	float: right;
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
                <h1>자유게시판</h1>
            </div>
            <form:form id="freeForm" 
	            	action="${pageContext.request.contextPath }/free/freeRegister" 
	            	method="post" 
	            	modelAttribute="freeBoard"
	            	enctype="multipart/form-data"
	            	>
                  <div id="div_table">
                      <table>
                          <colgroup>
                              <col width="200">
                              <col width="400">
                          </colgroup>
                          <tr>
                              <td class="td_left">제목</td>
                              <td class="td_right">
                                  <form:input path="boTitle" autocomplete="off"/> 
                                  <form:errors path="boTitle"></form:errors>
                              </td>
                          </tr>
                          <tr>
                              <td class="td_left">작성자</td>
                              <td class="td_right">
                                  <input type="hidden" name="boWriter" value="${memberVO.memId}" >
                                  <c:out value="${memberVO.memId}"/> 
								  <form:errors path="boWriter"></form:errors>
                                  
                              </td>
                          </tr>
                          <tr>
                              <td class="td_left">글 비번</td>
                              <td class="td_right">
                                  <form:password path="boPass" autocomplete="off" />
		  						 		수정 또는 삭제시에 필요합니다.
  						 		  <form:errors path="boPass"></form:errors>	
                              </td>
                          </tr>
                          <tr>
                              <td class="td_left">글 분류</td>
                              <td class="td_right">
								<form:select path="boCategory">
									<form:option value="">-- 선택하세요--</form:option>
									<form:options items="${categoryList}" itemLabel="commNm" itemValue="commCd"/>
								</form:select>
								<form:errors path="boCategory"></form:errors>
                              </td>
                          </tr>
                          <tr>
                              <td class="td_left">IP</td>
                              <td class="td_right">
								${pageContext.request.remoteAddr}
								<input type="hidden" name="boIp" value="${pageContext.request.remoteAddr}">
								<form:errors path="boIp"></form:errors>	
                              </td>
                          </tr>
                          <tr>
                              <td class="td_left">내용</td>
                              <td class="td_right">
                                  <form:textarea path="boContent" rows="10"/>
                                  <form:errors path="boContent"></form:errors>
                              </td>
                          </tr>
                          		
                          		<!-- 파일업로드 -->	
                         <tr>
								<td class="td_left">첨부파일
									<button type="button" id="id_btn_new_file">추가</button>
								</td>	                         
								<td class="td_rigth file_area">
									<div class="file_div">
										<input type="file" name="boFiles"/>
										<button type="button" class="btn_delete">삭제</button>
									</div>
								</td>
								
								
                         
                         </tr>
                      </table>
                  </div>
                  <!-- 버튼 -->
                  <div class="div_button">
                      <input type="button" onclick="location.href='${pageContext.request.contextPath}/free/freeList'" value="목록">
                      <input type="submit" value="등록">
                  </div>
       		</form:form>
        </div>
    </div>


<script type="text/javascript">
$("#id_btn_new_file").click(function(){
	//alert("id_btn_new_file");
	$(".file_area").append(
		'<div class="file_div">'
		+	'<input type="file" name="boFiles" />'
		+	'<button type="button" class="btn_delete" >삭제</button>'
		+'</div>'
	);
});


$(".file_area").on("click" , '.btn_delete', function(){
	//alert(".file_area .btn_delete");
	$(this).closest('div').remove();
});
</script>