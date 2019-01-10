<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
	<h1 class="h2">Dashboard</h1>
		<div class="btn-toolbar mb-2 mb-md-0">
			<div class="btn-group mr-2">
				<button class="btn btn-sm btn-outline-secondary">${user.PNAME }</button>
				<button class="btn btn-sm btn-outline-secondary">${user.DNAME }</button>
			</div>
			<button id="drop6" href="#" class="btn btn-sm btn-outline-secondary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" role="button" aria-expanded="true" >${user.NAME }</button>
			<span class="caret"></span>
				<ul id="menu3" class="dropdown-menu" role="menu" aria-labelledby="drop6">
					<li role="presentation"><a role="menuitem" tabindex="-1" class="btn btn-sm"  href="${pageContext.servletContext.contextPath }/password_change.do">Password Change</a></li>
					<li role="presentation"><a role="menuitem" tabindex="-1" class="btn btn-sm"  href="${pageContext.servletContext.contextPath }/message_box.do">Message Box</a></li>
				</ul>
		</div>
</div>
