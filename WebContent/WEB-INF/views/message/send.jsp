<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
	<h1 class="h2">Dashboard</h1>
		<div class="btn-toolbar mb-2 mb-md-0">
			<div class="btn-group mr-2">
				<button class="btn btn-sm btn-outline-secondary">${user.DNAME }</button>
				<button class="btn btn-sm btn-outline-secondary">${user.PNAME }</button>
			</div>
			<button id="drop6" href="#" class="btn btn-sm btn-outline-secondary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" role="button" aria-expanded="true" >${user.NAME }</button>
			<span class="caret"></span>
				<ul id="menu3" class="dropdown-menu" role="menu" aria-labelledby="drop6">
					<li role="presentation"><a role="menuitem" tabindex="-1" class="btn btn-sm"  href="${pageContext.servletContext.contextPath }/password_change.do">Password Change</a></li>
					<li role="presentation"><a role="menuitem" tabindex="-1" class="btn btn-sm"  href="${pageContext.servletContext.contextPath }/message_box.do">Message Box</a></li>
				</ul>
		</div>
</div>
<h2>Message Send</h2>
<c:if test="${!empty err }">
<div class="alert alert-danger" role="alert">
   	메세지 전송에 실패 하였습니다. 다시 시도 바랍니다.
</div>
</c:if>
<form action="${pageContext.servletContext.contextPath }/message_send.do" method="post">
	<div class="form-group">
		<label>받는 사람 아이디 (*)</label> 
			<input id="receiver" name="receiver" onkeyup="str(this);" list="some" type="text" class="form-control" placeholder="receiver">
			<datalist id="some">
					<option></option>
			</datalist>
	</div>
	<div class="form-group">
		<label>내용 (*)</label>
			<input id="content" name="content" type="text" class="form-control" placeholder="content">
	</div>
	<div class="form-group">
		<button type="submit"  class="form-control btn btn-outline-primary">Send</button>
	</div>
</form>
<script>
	var str = function(t) {
		var id = t.value;
		console.log(id);
		var xhr = new XMLHttpRequest();
		xhr.open("get","${pageContext.servletContext.contextPath }/emplyoee_serch.do?id=" + id,"true");
		xhr.send();
		xhr.onreadystatechange = function() {
			if(this.readyState == 4) {
				var html = "";
				console.log(this.responseText);
				var obj = JSON.parse(this.responseText);
				for(var i = 0; i < obj.length; i++) {
				console.log(obj);
					html += "<option value=\"" + obj[i].ID + "\">" + obj[i].NAME + "(" + obj[i].DNAME + " / " + obj[i].PNAME + ")</option>";
					console.log(html);
				}
			document.getElementById("some").innerHTML = html;
			}
		}
		
	}
</script>