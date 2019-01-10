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
<h2>Chat Room(All Department)</h2>
	<div class="form-group">
		<div style="height: 520px; overflow-y: scroll; " id="chatView">
			<c:forEach var="c" items="${chatlist }">
				<div class="alert alert-primary" role="alert">
					<small>【 ${c.user.DNAME } 】 【 ${c.user.PNAME } ${c.user.NAME } 】</small><br/>
						${c.text }
				</div>
			</c:forEach>
		</div>
	</div>
	<div class="form-group">
		<label>채팅 내용 (*)</label>
			<input id="input" name="content" type="text" class="form-control" placeholder="content">
	</div>
	
<script>
	var chatws = new WebSocket("ws://"+ location.host + "${pageContext.servletContext.contextPath}/chat.do");
	chatws.onmessage = function(evt) {
		console.log(evt.data);
		var obj = JSON.parse(evt.data);
		switch(obj.mode) {
 		case "public" :
 			publicHandle(obj);
 			break;
		}
	}
	
	var publicHandle = function(obj) {
		var txt = obj.text
		var html = "<div class=\"alert alert-primary\" role=\"alert\">";
		html += "<small>【 " + obj.user.DNAME + " 】 【 " + obj.user.PNAME + " " + obj.user.NAME + " 】</small><br/>";
		html += obj.text;
		html += "</div>";
		document.getElementById("chatView").innerHTML += html;
		document.getElementById("chatView").scrollTop = document.getElementById("chatView").scrollHeight;

	}
	
	document.getElementById("input").onchange = function() {
		console.log(this.value);
		var msg = {"mode" : "public", "text" : this.value};
		chatws.send(JSON.stringify(msg));
		this.value = "";
	}
</script>

