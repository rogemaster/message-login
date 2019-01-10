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
<h6 class="border-bottom border-gray pb-2 mb-0">받은 쪽지</h6>
	<c:forEach var="n" items="${notelist }">
		<div class="media text-muted pt-3">
		 		<p class="media-body pb-3 mb-0 small lh-125 border-bottom border-gray">
		 		<span class="text-black" >NO. ${n.CODE }</span>
		   		<strong class="d-block text-gray-dark">보낸사람 : ${n.SENDER }</strong>
		   		<span class="text-gray">받는 사람 : ${n.RECEIVER }</span> <span class="text-gray">보낸 날짜 : ${n.SENDDATE }</span><br/>
					<a class="text-black" name="code" onclick="code(this.value);" value="${n.CODE }" href="#">${n.CONTENT }</a>
				</p>
		</div>
	</c:forEach>

	<small class="d-block text-right mt-3">
	 		<a href="${pageContext.servletContext.contextPath }/message_send.do">Message Send</a>
	</small>

