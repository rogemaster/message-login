<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<link rel="stylesheet" href="${pageContext.servletContext.contextPath }/css/signin.css">
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.3/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js"></script>
<title>Password - Change</title>
	<body class="text-center">
		<form class="form-signin" action="${pageContext.servletContext.contextPath }/change.do" method="post" >
			<h1 class="h3 mb-3 font-weight-normal">Please Password Change</h1>
      
			<c:if test="${!empty err }">
				<div class="alert alert-danger alert-dismissible fade show" role="alert">
					<strong>실패!</strong> 입력하신 기존 비밀번호가 다릅니다. 확인 하시고 다시 입력 부탁 드립니다.
					<button type="button" class="close" data-dismiss="alert" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
      		</c:if>
      
	      	<label for="id" class="sr-only">기존 비밀번호</label>
	      		<input type="password" id="originpass" name="originpass" class="form-control" placeholder="기존 비밀번호" required autofocus>
	      	<label for="pass" class="sr-only">변경할 비밀번호</label>
	      		<input type="password" id="newpass" name="newpass" class="form-control" placeholder="변경할 비밀번호" required>
	     	 <button class="btn btn-lg btn-primary btn-block" type="submit">Change</button>
		</form>
	</body>
</html>