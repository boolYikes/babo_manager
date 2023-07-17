<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!-- USE THESE THIGNS TO SET GLOBALS -->
<c:set var="contextPath" value="${pageContext.request.contextPath }"></c:set>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible;Content-Type" content="IE=edge;image/png;">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>메뉴 관리</title>
    <link href="resources/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="resources/css/bootstrap.css" type="text/css" />
    <link rel="stylesheet" href="resources/css/dyrmwyrm.css"/>
</head>

<body>
    <script>
 		// active 클래스 추가용 함수 (형제 태그에서 active없애고 클릭한거 active 토글함)
    	// 주의 :: 부트스트랩 active pseudo class 아님!!
        function cat_clicked(tag){
            let siblings = $(tag).siblings();
            for(i = 0 ; i < siblings.length ; i ++){
                if($(siblings[i]).hasClass("active")){
                    $(siblings[i]).toggleClass("active");
                }
            };
            $(tag).toggleClass("active");
            console.log($(tag).text());
        }

     	// 주문내역 불러오는 함수
        function load_this_and_rid_that(tag){
            if($(tag).hasClass("manage-menus")){
                console.log("menu clicked!!!");
                //not 임 주의
                if(!$(".bdgroupA").hasClass("active")){
                    $(".bdgroupA").toggleClass("active");
                    $(".bdgroupB").toggleClass("active");
                    $(".cat-names").toggleClass("hidden");
                }
            }else if($(tag).hasClass("manage-orders")){
                console.log("orders clicked!!!");
                if(!$(".bdgroupB").hasClass("active")){
                    $(".bdgroupB").toggleClass("active");
                    $(".bdgroupA").toggleClass("active");
                    $(".cat-names").toggleClass("hidden");
                }
            }
        }
    </script>

    <div class="content">
        <div class="row">
            <div class="col-lg-2 bigdaddy01">
                <div class="card">

                    <div class="row management-row">
                        <div class="col-lg-6 manage-menus" onclick="cat_clicked(this);load_this_and_rid_that(this)">
                            <div class="row">
                                <div class="col-lg-12 manage-menus-icon">
                                    <img src="resources/img/menu3.png" width="70px" style="margin-bottom: 10px;" alt="menu">
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-lg-12 manage-menus-text"><b>메뉴관리</b></div>
                            </div>
                        </div>
                        <div class="col-lg-6 manage-orders" onclick="cat_clicked(this);load_this_and_rid_that(this)">
                            <div class="row">
                                <div class="col-lg-12 manage-orders-icon">
                                    <img src="resources/img/order3.png" width="70px" style="margin-bottom: 10px;" alt="orders">
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-lg-12 manage-menus-text"><b>주문관리</b></div>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-lg-12">
                            <ul class="cat-names-list">
                            	<c:forEach items="${categories}" var="cat">
	                                <li class="cat-names" onclick="cat_clicked(this)">
	                                    <span>${cat.category_name}</span>
	                                </li>
                                </c:forEach>
                            </ul>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-lg-12">
                            <div style="height:400px"></div>
                        </div>
                    </div>
                    <div class="row home">
                        <div class="col-lg-12">
                            <div class="home-icon row">
                            	<div class="col-lg-12">
                                	<img src="resources/img/home2.png" width="100px" alt="home">
                                </div>
                            </div>
                            <div class="row">
		                        <div class="col-lg-12">
		                            <span><h3>메인으로</h3></span>
		                        </div>
                  			</div>
                        </div>
                        
                    </div>
                </div>
            </div>
            <div class="col-lg-7 bigdaddy02 bdgroupA active">
                <div class="card" style="overflow:auto">
                
					<c:forEach items="${menus}" var="menu">
	                    <div class="row" id="rownum1">
	                        <div class="col-lg-12">
	                            <a href="#">
	                                <div class="card-body menu-card">
	                                    <div class="row">
	                                        <div class="col-lg-3 photo-zone">
	                                            <img src="${menu.menu_img}" width="160px" alt="menu-pic">
	                                        </div>
	                                        <div class="col-lg-9">
	                                            <div class="row">
	                                                <div class="col-lg-4 menu-title"><h3>${menu.menu_name}</h3></div>
	                                                <div class="col-lg-3"></div> <!-- FOR SPACING -->
	                                                <div class="col-lg-3"></div> <!-- FOR SPACING -->
	                                                <div class="col-lg-2 menu-price"><h4>${menu.menu_price}원</h4></div>
	                                            </div>
	                                            <div class="row menu-desc-row">
	                                                <div class="col-lg-12 menu-desc">${menu.menu_desc}</div>
	                                            </div>
	                                            
	                                        </div>
	                                    </div>
	                                    <div class="row">
	                                        <div class="col-lg-12 arrow-row">
	                                            <img src="resources/img/arrowdown.png" style="width:25px" alt="arrow">
	                                        </div>
	                                    </div>
	                                </div>
	                            </a>
	                        </div>
	                    </div>
                    </c:forEach>
                    
                </div>
            </div>

            <div class="col-lg-3 bigdaddy03 bdgroupA active">
                <div class="card menu-details border-dark">
                    <div class="row" style="margin-top:20px;font-size:1.7rem">
                        <div class="col-lg-12" style="background-color: #1c1c1b; color:#ffdc00">
                            정보 입력
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-12">
                            <form action=""> <!-- MENU INFO -->
                                <div class="div div-borderless input-div">
                                    <div> <!-- CATEGORY SELECTION -->
                                        <div class="category" colspan="3" style="margin-bottom:10px;">
                                            <div class="row">
                                                <div class="col-lg-12">
                                                    <span style="font-size:0.7rem;"><b>카테고리</b></span>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-lg-8 form-group" style="padding-right:0px">
                                                    <select class="form-control" style="border-top-right-radius:0px;border-bottom-right-radius:0px;" name="category" type="text">
                                                        <option value="í´ë¹ë¶ë¥ID">국밥</option>
                                                        <option value="í´ë¹ë¶ë¥ID">고기</option>
                                                        <option value="í´ë¹ë¶ë¥ID">커피</option>
                                                        <option value="í´ë¹ë¶ë¥ID">과일</option>
                                                        <option value="í´ë¹ë¶ë¥ID">ㅇㅇ</option>
                                                    </select>
                                                </div>
                                                <div class="col-lg-1 appendage">
                                                    <div>
                                                        <img src="resources/img/arrowdown.png" style="width:15px" alt="arrow">
                                                    </div>
                                                </div>
                                                <div class="col-lg-1" style="text-align: left; margin-top:5px;">
                                                    <img src="resources/img/plus_button.png" width="15px" alt="plus">
                                                </div>
                                                <div class="col-lg-1" style="text-align: left; margin-top:5px;">
                                                    <img src="resources/img/minus_button.png" width="15px" alt="plus">
                                                </div>
                                            </div>
                                                <div class="col-lg-1"></div>
                                            </div>
                                        </div>
                                    </div> <!-- CATEGORY SEL ENDS-->

                                    <div> <!-- MENU NAME INPUT -->
                                        <div class="menu-name" colspan="3" style="margin-bottom:20px;">
                                            <div class="row">
                                                <div class="col-lg-12">
                                                    <span style="font-size:0.7rem"><b>메뉴이름</b></span>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-lg-9 border-bottom border-dark form-group">
                                                    <input name="name" placeholder="메뉴이름 입력" class="form-control border-0" type="text">
                                                </div>
                                                <div class="col-lg-3"></div>
                                            </div>
                                        </div>
                                    </div> <!-- MENU NAME INPUT ENDS -->

                                    <div> <!-- MENU PRICE INPUT -->
                                        <div class="price" style="margin-bottom:20px;">
                                            <div class="row">
                                                <span style="font-size:0.7rem"><b>메뉴가격</b></span>
                                            </div>
                                            <div class="row">
                                                <div class="col-lg-9 form-group border-bottom border-dark">
                                                    <input class="form-control border-0" name="price" type="text" placeholder="가격입력">
                                                </div>
                                                <div class="col-lg-3"><b>원</b></div>
                                            </div>
                                        </div>
                                    </div> <!-- MENU PRICE INPUT ENDS-->

                                    <div> <!-- MENU DISCOUNT INPUT -->
                                        <div class="discount" style="margin-bottom:20px;">
                                            <div class="row">
                                                <span style="font-size:0.7rem;"><b>할인</b></span>
                                            </div>
                                            <div class="row">
                                                <div class="col-lg-5 form-group border-bottom border-dark">
                                                    <input class="form-control border-0" name="discount" type="text" placeholder="할인입력">
                                                </div>
                                                <div class="col-lg-2"><b>원</b></div>
                                                <div class="col-lg-1 vat form-group">
                                                    <input type="checkbox" class="form-check-input" name="vat">
                                                </div>
                                                <div class="col-lg-3"><b>VAT포함</b></div>
                                                <div class="col-lg-1"></div>
                                            </div>
                                        </div> 
                                    </div> <!-- MENU DISCOUNT INPUT ENDS-->

                                    <div> <!-- OPTIONS CHECKBOXES -->
                                        <div class="menu-options" colspan="3" style="margin-bottom:20px;">
                                            <div class="row">
                                                <div class="col-lg-12">
                                                    <span style="font-size:0.7rem"><b>옵션</b></span>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-lg-2"></div>
                                                <div class="col-lg-2 form-group">
                                                    <input type="checkbox" class="form-check-input" name="options01">얼음
                                                </div>
                                                <div class="col-lg-2 form-group">
                                                    <input type="checkbox" class="form-check-input" name="options02">샷
                                                </div>
                                                <div class="col-lg-2 form-group">
                                                    <input type="checkbox" class="form-check-input" name="options03">당도
                                                </div>
                                                <div class="col-lg-2 form-group">
                                                    <input type="checkbox" class="form-check-input" name="options04">등등
                                                </div>
                                                <div class="col-lg-2"></div>
                                            </div>
                                        </div>
                                    </div> <!-- OPTIONS CHECKBOXES ENDS -->

                                    <div> <!-- MENU DESC INPUT -->
                                        <div class="menudesc" style="margin-bottom:20px;">
                                            <div class="row">
                                                <span style="font-size:0.7rem"><b>메뉴설명</b></span>
                                            </div>
                                            <div class="row">
                                                <div class="col-lg-9 form-group border-bottom border-dark">
                                                    <textarea class="form-control border-0" name="desc" placeholder="뜨끈하게 한사발" rows="1"></textarea>
                                                </div>
                                                <div class="col-lg-3"></div>
                                            </div>
                                        </div>
                                    </div> <!-- MENU DESC ENDS-->

                                    <div> <!-- MENU IMAGE AND TAGS INPUT -->
                                        <div class="image_and_tags" style="margin-top:60px;">
                                            <div class="row">
                                                <span style="font-size:0.7rem"><b>메뉴 이미지</b></span>
                                            </div>
                                            <div class="row">
                                                <div class="col-lg-6 menu-img" style="text-align: center;">
                                                    <img src="resources/img/purple.png" style="width:200px;" alt="menuimg"s>
                                                </div>
                                                <div class="col-lg-6 form-group">
                                                    <div class="row">
                                                        <div class="col-lg-12">
                                                            <input type="checkbox" name="newmenu" class="form-check-input">신규메뉴
                                                            <br>
                                                            <input type="checkbox" name="recom" class="form-check-input">추천
                                                            <br>
                                                            <input type="checkbox" name="dog" class="form-check-input">개쩌는
                                                        </div>
                                                    </div>

                                                    <div class="row" style="margin-top:10px">
                                                        <div class="col-lg-12">
                                                            <label for="more_tag">추가 태그</label>
                                                            <select id="more_tag" name="moretag" class="form-control" value="추가태그">추가태그
                                                                <option value="123">핫템</option>
                                                                <option value="324">엠디픽</option>
                                                                <option value="345">잇템</option>
                                                                <option value="345">힝</option>
                                                            </select>
                                                        </div>
                                                    </div>

                                                    <div class="row" style="margin-top:10px">
                                                        <div class="col-lg-12 form-group">
                                                            <label for="upload">이미지 업로드</label>
                                                            <input id="upload" type="file" class="form-control bg-warning">
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div> <!-- MENU IMAGE AND TAGS ENDS -->
                                    
                                </div>
                            </form>
                        </div>
                        <div class="row last_buttons" style="margin-top:90px;text-align: center;">
                            <div class="col-lg-1"></div>
                            <div class="col-lg-5">
                                <input type="reset" class="btn" value="다시입력" style="background-color: #1c1c1b;color:#ffdc00">
                            </div>
                            <div class="col-lg-5">
                                <input type="button" class="btn" value="메뉴추가" style="background-color:#ffdc00; color:#1c1c1b">
                            </div>
                            <div class="col-lg-1"></div>
                        </div>
                    </div>
                </div>

                <!-- ######### 주 문 관 리 영 역 ######### -->
                <!-- 주문목록 -->
                <div class="col-lg-7 bigdaddy04 bdgroupB">
                    <div class="card">
                        <div class="row">
                            <div class="col-lg-12">
                                <div class="order-logs-title">
                                    <h1>주문내역</h1>
                                </div>
                            </div>
                        </div>

                        <!-- prolly need to move the styles to css-->
                        <div class="row" style="margin-top:30px; padding:30px; overflow:auto;">
                            <table class="table table-hover col-lg-12">
                               <tr style="font-size:1.3rem;">
                                    <td>주문번호</td>
                                    <td>회원번호</td>
                                    <td>메뉴가격</td>
                                    <td>주문일시</td>
                               </tr>
                               <tr>
                                    <td>12345</td>
                                    <td>010-9470-3337</td>
                                    <td>2,000원</td>
                                    <td>2023/23/23</td>
                               </tr>
                               <tr>
                                    <td>123456</td>
                                    <td>010-0101-1010</td>
                                    <td>85,000원</td>
                                    <td>1212/12/12</td>
                               </tr>
                               
                               <tr>
                                    <td>12344</td>
                                    <td>010-2121-2323</td>
                                    <td>23,233</td>
                                    <td>2023/20/23</td>
                               </tr>
                            </table>
                        </div>
                    </div>
                </div>

                <!-- 주문상세 -->
                <div class="col-lg-3 bigdaddy05 bdgroupB">
                    <div class="card border-dark menu-details">
                        <div class="row" style="margin-top:20px;font-size:1.7rem">
                            <div class="col-lg-12" style="background-color: #1c1c1b; color:#ffdc00">
                            	주문 정보
                            </div>
                        </div>

                        <div class="row" style="margin-top:20px;">
                            <div class="col-lg-12">
                                <div class="card fine-print" style="height: auto">
                                    <div class="row">
                                        <div class="col-lg-12">
                                            <span style="font-size:1.5rem" id="store_name">메가커피 팡주CGI점</span>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-lg-12">
                                            <span style="font-size:1.6rem;font-weight:900;" id="menu_price">9,900</span>
                                            <span style="font-size:1.2rem">원</span>
                                        </div>
                                    </div>
                                    <div class="row" style="margin-top:20px">
                                        <div class="col-lg-12" style="text-align: end;">
                                            <span id="payment_method">꿀꿀이저축카드(1234)</span>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-lg-7 pthead">
                                            <span>상품명</span>
                                        </div>
                                        <div class="col-lg-2 pthead">
                                            <span>수량</span>
                                        </div>
                                        <div class="col-lg-3 pthead">
                                            <span>금액</span>
                                        </div>
                                    </div>
                                    <div class="row pseudo-table menu_name">
                                        <div class="col-lg-7">
                                            <span id="the_name">아아</span>
                                        </div>
                                        <div class="col-lg-2">
                                            <span id="the_amount">2</span>
                                        </div>
                                        <div class="col-lg-3">
                                            <span id="the_price">3,500</span>
                                        </div>
                                    </div>
                                    <div class="row pseudo-table menu_options">
                                        <div class="col-lg-7">
                                            >><span id="option_name">Tall</span>
                                        </div>
                                        <div class="col-lg-2">
                                            <span id="option_amount">1</span>
                                        </div>
                                        <div class="col-lg-3">
                                            <span id="option_price">-</span>
                                        </div>
                                    </div>
                                    <div class="row summary">
                                        <div class="col-lg-6 fine-print-left"> <span>주문합계</span> </div>
                                        <div class="col-lg-6 fine-print-right"> <span id="sum_total">3,500</span> </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-lg-6 fine-print-left"> <span>공급가액</span> </div>
                                        <div class="col-lg-6 fine-print-right"> <span id="retail_val">3,182</span> </div>
                                    </div>
                                    <div class="row summary-ends">
                                        <div class="col-lg-6 fine-print-left"> <span>주문합계</span> </div>
                                        <div class="col-lg-6 fine-print-right"> <span id="the_vat">318</span> </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-lg-12" style="border-bottom:2px dotted #1c1c1b;padding-top:5px;padding-bottom:5px">
                                            <span style="font-weight:900;font-size:1.7rem" id="total-total">3,500</span>
                                        </div>
                                    </div>
                                    <div class="row trans">
                                        <div class="col-lg-3 trans-sub">
                                            <span>거래종류: </span>
                                        </div>
                                        <div class="col-lg-9 trans-sub">
                                            <span id="transaction_type">카드거래</span>
                                        </div>
                                    </div>
                                    <div class="row trans-ends">
                                        <div class="col-lg-3 trans-sub">
                                            <span>거래일시: </span>
                                        </div>
                                        <div class="col-lg-9 trans-sub">
                                            <span id="transaction_date">2023-13-32</span>
                                        </div>
                                    </div>
                                    <div class="row buttons-area">
                                        <div class="col-lg-12">
                                            <input type="button" class="btn" value="반품처리">
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script src="resources/js/bootstrap.js"></script>
    <script src="resources/js/jquery.js"></script>
    
</body>
</html>