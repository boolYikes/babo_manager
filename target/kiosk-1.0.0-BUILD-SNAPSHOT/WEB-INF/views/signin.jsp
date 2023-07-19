<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<link href="resources/css/bootstrap.min.css" rel="stylesheet"/>
<link rel="stylesheet" href="resources/css/bootstrap.css"/>
<link rel="stylesheet" href="resources/css/dyrmwyrm.css"/>
</head>
<body>

	<div class="content">
		
		<div class="row" style="height:33vh">
			<div class="col-lg-12"></div>
		</div>
		 
		<div class="row">
			<div class="col-lg-4"></div>
			<div class="col-lg-4">
				<div class="login-card" style="background-color: #ffffff;box-shadow:1px 2px 1px 1px rgba(0,0,0,0.2)">
					<div class="row">
                        <div class="col-lg-4" style="height:200px">
                            <img src="resources/img/mega-icon.jpg" style="height:inherit;" alt="logo">
                        </div>
                        <div class="col-lg-8">
                            <div class="row title-row" style="margin-left:30px;margin-top:10px">
                                <h4>관리자로그인</h4>
                            </div>
                            <form action="${contextPath}/admin" method="post" style="margin-left:30px">
                                <div class="row id-row" style="margin-top:5px;">
                                    <div class="col-lg-2 prepend" style="background-color: #36322e;color:#ffdc00;text-align: center;border-top-left-radius:5px;border-bottom-left-radius:5px;padding-right:0px;margin-right:0px">
                                        ID
                                    </div>
                                    <div class="col-lg-10" style="margin-left:0px;padding-left:0px;">
                                        <input name="admin_id" type="text" style="border-top-right-radius: 5px;border-bottom-right-radius: 5px;">
                                    </div>
                                </div>
                                <div class="row pw-row" style="margin-top:20px">
                                    <div class="col-lg-2 prepend" style="background-color: #36322e;color:#ffdc00;text-align: center;border-top-left-radius:5px;border-bottom-left-radius:5px;padding-right:0px;margin-right:0px">
                                        PW
                                    </div>
                                    <div class="col-lg-10" style="margin-left:0px;padding-left:0px;">
                                        <input name="admin_pw" type="text" style="border-top-right-radius: 5px;border-bottom-right-radius: 5px;">
                                    </div>
                                </div>
                                <div class="row button-row" style="margin-top:20px">
                                    <div class="col-lg-4">
                                        <input type="reset" class="btn btn-secondary" value="다시">
                                    </div>
                                    <div class="col-lg-4" >
                                        <input type="submit" class="btn btn-success" value="로그인">
                                    </div>
                                    <div class="col-lg-4">
                                        <input type="button" class="btn btn-primary" value="정보조회">
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
				</div>
			</div>
			<div class="col-lg-4"></div>
		</div>
		
		<div class="row" style="height:33vh">
			<div class="col-lg-12"></div>
		</div>

	</div>

</body>
</html>