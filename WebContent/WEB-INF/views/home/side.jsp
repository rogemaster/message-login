<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div class="sidebar-sticky">
	<ul class="nav flex-column">
		<li class="nav-item">
			<a class="nav-link active" href="#">
				<span data-feather="home"></span>
				Dashboard <span class="sr-only">(current)</span>
			</a>
		</li>
		<li class="nav-item">
			<a class="nav-link" href="${pageContext.servletContext.contextPath }/index.do">
				<span data-feather="file"></span>
				Index
			</a>
		</li>
		<li class="nav-item">
			<a class="nav-link" href="#">
				<span data-feather="shopping-cart"></span>
				Products
			</a>
		</li>
		<li class="nav-item">
			<a class="nav-link" href="${pageContext.servletContext.contextPath }/chat/room.do">
				<span data-feather="users"></span>
				Chat
			</a>
		</li>
		<li class="nav-item">
			<a class="nav-link" href="${pageContext.servletContext.contextPath }/depchat/room.do">
				<span data-feather="bar-chart-2"></span>
				Department Chat
			</a>
		</li>
	<hr/>
	<div id="alert" style="font-size: .75em">

	</div>
	<script>
		var ws =new WebSocket("ws://" + location.host + "${pageContext.servletContext.contextPath }/alert.do"); 
			ws.onmessage = function(evt) {
				var obj = JSON.parse(evt.data);
				console.log(obj);
		 		switch(obj.mode) {
		 		case "login" :
		 			loginAlertHandle(obj);
		 			break;
		 		case "duplicate" :
		 			duplicateAlertHandle(obj);
		 			break;
		 		case "message" :
		 			messageAlertHandle(obj);
		 			break;
		 		case "newtalk" :
		 			newtalkAlertHandle(obj);
		 			break;
		 		}
			}
	
		var loginAlertHandle = function(obj) {
	 		var html = "<div class=\"alert alert-warning alert-dismissible fade show\" role=\"alert\">";
	 			html += "<strong>로그인</strong><br/>" + obj.actor.PNAME + " " + obj.actor.DNAME + " " + obj.actor.NAME;
	 			html += "<button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-label=\"Close\">";
	 			html += "<span aria-hidden=\"true\">&times;</span>";
	 			html += "</button>";
	 			html += "</div>";
	
	 		document.getElementById("alert").innerHTML += html;
		}
	
		var duplicateAlertHandle = function(obj) {
			var html = "<div class=\"alert alert-danger px-3 mt-4 mb-1 \" role=\"alert\">";
				html += "<strong>【중복로그인】</strong><br/>다른 기기에서 로그인 되었습니다.<br/>재 로그인 해주십시요.";
				html += "</div>";
			document.getElementById("alert").innerHTML += html;
			document.getElementById("alert").id="";
		}
	
		var messageAlertHandle = function(obj) {
	 		var html = "<div class=\"alert alert-warning alert-dismissible fade show\" role=\"alert\">";
	 			html += "<strong>" + obj.element.SENDER +"</strong><br/>"
	 			html += "메세지가 도착 했습니다.";
	 			html += "<button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-label=\"Close\">";
	 			html += "<span aria-hidden=\"true\">&times;</span>";
	 			html += "</button>";
	 			html += "</div>";
	
	 		document.getElementById("alert").innerHTML += html;
		}
		
		var newtalkAlertHandle = function(obj) {
	 		var html = "<div class=\"alert alert-warning alert-dismissible fade show\" role=\"alert\">";
 			html += "새로운 채팅내용이 있습니다.";
 			html += "<button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-label=\"Close\">";
 			html += "<span aria-hidden=\"true\">&times;</span>";
 			html += "</button>";
 			html += "</div>";

 		document.getElementById("alert").innerHTML += html;
		}

	</script>
</div>
