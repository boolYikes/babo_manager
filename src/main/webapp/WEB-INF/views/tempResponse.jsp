<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }"></c:set>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
</head>
<style>
	body{
		background-color:#fffff0;
		display:block;
		flex-direction: column;
		justify-content: center;
		text-align:center;
	}
	button{
		background-color:#1c1c1b;
		color:#ffdc00;
		border-radius:10px;
		border:2px #ffdc00 solid;
		box-shadow:-6px 2px 1px 1px rgba(0,0,0,0.3);
		width:300px;
		height:100px;
		font-size:inherit;
	}
	button:hover{
		background-color:#ffdc00;
		color:brown;
		border: 2px #1c1c1b solid;
	}
</style>
<body>
	
	<button id="cocoaBtn">ㅋ코코아페이ㅅㅂ어</button>
	
	<script>
	$(document).ready(function(){
		$("#cocoaBtn").click(function(){
			
			// CUSTOM AUTHENTICATION LOGIC GOES HERE
			console.log("clicked");
			$.ajax({
				type:'get',
				url:'${contextPath}/pay',
				data:{ // the info i get from the view initially. the rest is handled from the controller
					item_name:"머가리카노",
					quantity:"1",
					total_amount: "1000000",
					tax_free_amount: "990000",
				},
				success:function(rsps){
					console.log("yes");
					location.href=rsps.next_redirect_pc_url;
				},
				error:function(xhr, status, error){
					console.error(error);
					console.error(xhr);
				}
			});
		});
	});
	</script>
	
</body>
</html>