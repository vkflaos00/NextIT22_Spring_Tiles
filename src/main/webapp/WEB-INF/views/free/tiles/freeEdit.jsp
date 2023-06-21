<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/freeBoardEdit.css">
<style type="text/css">
	.file_area > div > div:first-child > span{
		float: left;
	}
	.file_area > div > div:first-child > a{
		float: left;
	}
	.file_area > div > div:first-child > button{
		float: right;
	}
	.file_area > div > div:last-child{
		clear:both;
	}
	.btn_delete{
		float: right;
	}
	.td_right a{
		color: #166cea;
	}
	.td_right a:hover{
		color: #ed5422;
	}
</style>

<script>
function fn_submitCheck(){
	
	/* console.log("fn_submitCheck");
	
	if($("input[name='boTitle']").val() == ""){
		alert("제목을 작성해주세요");
		return;
	}else if($("input[name='boPass']").val() == ""){
		alert("비밀번호를 입력해주세요");
		return;
	}else if($("input[name='boCategory']").val()==""){
		alert("글 분류를 선택해주세요");
		return;
	} */
	
	let ret = confirm("저장하시겠습니까?");
	if(ret){
		let f= document.freeModify;
		f.submit();
	}else{
		alert("취소하셧습니다.");
	}
}
</script>
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
            
				<c:if test="${bne ne null or de ne null }">
					<div class="alert alert-warning">
							해당글을 불러오지 못하였습니다. 전산실에 문의 부탁드립니다. 042-719-8850
					</div>	
					<div class="div_button">
	                      <%-- <input type="button" onclick="location.href='${pageContext.request.contextPath}/free/freeList.do'" value="목록"> --%>
	                      <input type="button" onclick="location.href='${pageContext.request.contextPath}/free/freeList'" value="목록">
	                </div>
                </c:if>
            
            	<c:if test="${bne eq null and de eq null }">
            		<form:form name="freeModify" 
            			action="${pageContext.request.contextPath }/free/freeModify" 
            			method="post"
            			modelAttribute="freeBoard" 
            			enctype="multipart/form-data">
            	      <div id="div_table">
	                      <table>
	                          <colgroup>
	                              <col width="200">
	                              <col width="400">
	                          </colgroup>
	                          <tr>
	                              <td class="td_left">글번호</td>
	                              <td class="td_right">
	                                  ${freeBoard.boNo }
	                                  <input type="hidden" name="boNo" value="${freeBoard.boNo }">
	                              </td>
	                          </tr>
	                          <tr>
	                              <td class="td_left">글제목</td>
	                              <td class="td_right">
										<form:input path="boTitle"/>
										<form:errors path="boTitle"/>
	                              </td>
	                          </tr>
	                          <tr>
	                              <td class="td_left">작성자명</td>
	                              <td class="td_right">
										${freeBoard.boWriter } 
										<input type="hidden" name="boWriter" value="${freeBoard.boWriter }">
										<form:errors path="boWriter"/>
	                              </td>
	                          </tr>
	                          <tr>
	                              <td class="td_left">글 비번</td>
	                              <td class="td_right">
										<form:password path="boPass"/>
										<form:errors path="boPass"/>	                              		
	                              </td>
	                          </tr>
	                          <tr>
	                              <td class="td_left">글 분류</td>
	                              <td class="td_right">
	                              		<form:select path="boCategory">
	                              			<form:option value="">-- 선택하세요--</form:option>
	                              			<form:options items="${categoryList}" itemLabel="commNm" itemValue="commCd"/>
	                              		</form:select>
	                              		<form:errors path="boCategory"/>
	                              		
	                              </td>
	                          </tr>
	                          <tr>
	                              <td class="td_left">내용</td>
	                              <td class="td_right">
	                              		<form:textarea path="boContent" rows="10"/>
	                              		<form:errors path="boContent"/>
	                              </td>
	                          </tr>
	                          <tr>
	                              <td class="td_left">IP</td>
	                              <td class="td_right">
	                              		${pageContext.request.remoteAddr}
	                              		<input type="hidden" name="boIp" value="${pageContext.request.remoteAddr}">
	                              </td>
	                          </tr>
	                          <tr>
	                              <td class="td_left">조회수</td>
	                              <td class="td_right">
	                              		${freeBoard.boHit }
	                              </td>
	                          </tr>
	                          
	                          <%-- ${freeBoard.attachList } --%>
	                          <tr>
                         			<td class="td_left">첨부파일
                         				<button type="button" id="id_btn_new_file">추가</button>
                         			</td>
                         			<td class="td_right file_area">
                       					<c:forEach items="${ freeBoard.attachList }" 
                       						var="attach" varStatus="status">
                    							<div>
                    								<div>
                    									<span>${status.count } &#46;&nbsp;&nbsp;</span> <!--1부터 시작  -->
                    									<a href="">
                    										${attach.atchOriginalName }	
                    									</a>
                    									<button type="button" class="btn_file_delete"
                    										data-atch-no="${attach.atchNo }">삭제</button>
                    								</div>	
                    								<div>
                    									&nbsp;&nbsp;&nbsp; 크기 : ${attach.atchConvertSize }
                    									, 다운로드 횟수 : ${attach.atchDownHit }
                    								</div>	
                    							</div>
                       					</c:forEach>
                    						<div class="form-inline">
                    							<input type="file" name="boFiles">
                    							<button type="button" class="btn_delete">삭제</button>
                    						</div>
                         			</td>
                         				
	                          </tr>
	                          	 	 	
	                          
	                          
	                      </table>
	                  </div>
		                  
		                  
                  
                  
		                <!-- 버튼 -->
		                <div class="div_button">
		                	<c:if test="${freeBoard.boWriter eq memberVO.memId  }">
			                    <input type="button" onclick="fn_submitCheck()" value="저장">
		                	</c:if>
		                    <input type="button" onclick="location.href='${pageContext.request.contextPath}/free/freeList'" value="목록">
		                </div>
                  	</form:form>
             	</c:if>
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

$(".btn_file_delete").click(function(){
	//alert(".btn_file_delete: " + $(this).data("atch-no"));
	
	$(this).closest('.file_area')
		.append('<input type="hidden" name="delAtchNos" value="'+$(this).data("atch-no")+'" />')
		
	$(this).closest('div').parent().remove();
})
</script>