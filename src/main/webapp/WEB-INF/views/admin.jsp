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
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>

<body>
    <script>
    	const CPATH = "${contextPath}"
    	// 현재 기본 페이지는 카테고리 전부 보여줌 . 카테고리 클릭시 카테고리별로 바뀜
 		// active 클래스 추가용 함수 (형제 태그에서 active없애고 클릭한거 active 토글함)
    	// 주의 :: 부트스트랩 active pseudo class 아님!!
    	let selected_category = "";
        function cat_clicked(tag){
            let siblings = $(tag).siblings();
            for(i = 0 ; i < siblings.length ; i ++){
                if($(siblings[i]).hasClass("active")){
                    $(siblings[i]).toggleClass("active");
                }
            };
            $(tag).toggleClass("active");
            let catName = $(tag).text();
            selected_category = catName;
            $.ajax({
            	url: CPATH + '/sortByCat',
            	data: {categoryName : catName},
            	success:function(corresp_menus){
            		//console.log(corresp_menus);
            		$(".bigdaddy02 .card").empty();
            		for(i = 0 ; i < corresp_menus.length ; i ++){ // MUAHAHAHAHAHHAHAHAHAHAHA
            			$(".bigdaddy02 .card").append("<div class='row' id='rownum"+ i +"'>"
            											+"<div class='col-lg-12'>"
    	                            						+"<div onclick='details("+ corresp_menus[i].menu_seq +")'>"
    	                                						+"<div class='card-body menu-card'>"
    	                                    						+"<div class='row'>"
    	                                        						+"<div class='col-lg-3 photo-zone'>"
    	                                            						+"<img src='"+ corresp_menus[i].menu_img +"' width='160px' alt='menu-pic'>"
    	                                        						+"</div>"
    	                                        						+"<div class='col-lg-9'>"
    	                                            						+"<div class='row'>"
	    	                                                					+"<div class='col-lg-4 menu-title'><h3>"+ corresp_menus[i].menu_name +"</h3></div>"
	    	                                                					+"<div class='col-lg-3'></div>"
	    	                                                					+"<div class='col-lg-3'></div>"
	    	                                                					+"<div class='col-lg-2 menu-price'><h4>"+ corresp_menus[i].menu_price +"원</h4></div>"
    	                                            						+"</div>"
    	                                            						+"<div class='row menu-desc-row'>"
    	                                                						+"<div class='col-lg-12 menu-desc'>"+ corresp_menus[i].menu_desc +"</div>"
    	                                            						+"</div>"
    	                                        						+"</div>"
    	                                    						+"</div>"
    	                                    						+"<div class='row'>"
    	                                        						+"<div class='col-lg-12 arrow-row'>"
    	                                            						+"<img src='resources/img/arrowdown.png' style='width:25px' alt='arrow'>"
    	                                        						+"</div>"
    	                                    						+"</div>"
    	                                						+"</div>"
    	                            						+"</div>"
    	                        						+"</div>"
    	                    						+"</div>"); // APPENDAGE ENDS
            		} // FOR ENDS
            	}, // SUCCESS ENDS
            	error: function(xhr, status, error){
            		console.log(xhr);
            	}
            });
        }
		
     // DEFAULT GRAPH
		$.ajax({
			url: CPATH + "/getPref",
			data: {menu_seq:23},
			success:function(pref){
				console.log(pref);
				let chartCanvas = $("#chart_canvas");
				ages = []
				counts = []
				for(i=0; i<pref.length ;i++){
					ages.push(pref[i].order_age+"대");
					counts.push(parseInt(pref[i].count));
				}
				let data={
						labels: ages,
						datasets:[{
							label:menuInfo.menu_name,
							data:counts,
							backgroundColor:"#ffdc00",
							borderColor:"#1c1c1b",
							borderWidth:1
						}]
				}
				let options = {
						scales:{
							y:{
								beginAtZero: true
							}
						},
						plugins:{
							legend:{
								display:false
							}
						}
				}
				if(window.chart !== undefined){
					window.chart.destroy();
				}
				window.chart = new Chart(chartCanvas, {
					type:"bar",
					data:data,
					options:options
				});
			},
			error:function(xhr, error){
				console.log(error);
			}
		});
        
        // 선택한 메뉴 가져오는 펑션
    	let selected_menu;
    	function details(menu_id){
    		$.ajax({
    			url: CPATH + "/getOneMenu",
    			data:{menu_seq:menu_id},
    			success:function(menuInfo){
    				//console.log(menuInfo);
    				selected_menu = menuInfo;
    				$(".category select").val(menuInfo.category_seq);
    				$(".menu-name input").val(menuInfo.menu_name);
    				$(".price input").val(menuInfo.menu_price);
    				$("#img_address").val(menuInfo.menu_img);
    				//옵션 불러오기
    				$.ajax({
		    			url:CPATH + '/getCorrespOtions',
		    			data:{menu_seq:menuInfo.menu_seq},
		    			success:function(options){
		    				//console.log(options);
		    				$(".menu-options input").prop("checked", false);
		    				if(options.op_cup !== null || options.op_cup !== undefined){
								$(".menu-options .opt_cont").prop("checked", true);		    				
		    				}
		    				if(options.op_shot !== null || options.op_shot !== undefined){
		    					$(".menu-options .opt_shot").prop("checked", true);
		    				}
		    				if(options.op_size_s !== null || options.op_size_s !== undefined){
		    					$(".menu-options .opt_size").prop("checked", true);
		    				}
		    				if(options.op_ice !== null || options.op_ice !== undefined){
		    					$(".menu-options .opt_ice").prop("checked", true);
		    				}
		    			},
		    			error:function(xhr, error, status){
		    				console.log(status);
		    			}
    				});
    				// DRAW GRAPH ON PREFERENCES BY AGES
    	    		$.ajax({
    	    			url: CPATH + "/getPref",
    	    			data: {menu_seq:menu_id},
    	    			success:function(pref){
    	    				console.log(pref);
    	    				let chartCanvas = $("#chart_canvas");
    	    				ages = []
    	    				counts = []
    	    				for(i=0; i<pref.length ;i++){
    	    					ages.push(pref[i].order_age+"대");
    	    					counts.push(parseInt(pref[i].count));
    	    				}
    	    				let data={
    	    						labels: ages,
    	    						datasets:[{
    	    							label:menuInfo.menu_name,
    	    							data:counts,
    	    							backgroundColor:"#ffdc00",
    	    							borderColor:"#1c1c1b",
    	    							borderWidth:1
    	    						}]
    	    				}
    	    				let options = {
    	    						scales:{
    	    							y:{
    	    								beginAtZero: true
    	    							}
    	    						},
    	    						plugins:{
    	    							legend:{
    	    								display:false
    	    							}
    	    						}
    	    				}
    	    				if(window.chart !== undefined){
    	    					window.chart.destroy();
    	    				}
    	    				window.chart = new Chart(chartCanvas, {
    	    					type:"bar",
    	    					data:data,
    	    					options:options
    	    				});
    	    			},
    	    			error:function(xhr, error){
    	    				console.log(error);
    	    			}
    	    		});
    				
    				$(".menudesc textarea").val(menuInfo.menu_desc);
    				$(".image_and_tags img").attr("src", menuInfo.menu_img);
    			},
    			error:function(xhr, status, error){
    				console.log(error);
    			}
    		});
    		
    		
    	}
    	
    	// CRUD OPS
    	function crud(tag, event){
    		let formToGo = $("#crud_form");
    		console.log(formToGo);
    		let url = $(tag).hasClass("delBtn") > $(tag).hasClass("subBtn") ? "/delete":"/addOrSet";
    		event.preventDefault();
    		console.log(url+"clicked");
    		formToGo.attr("action", CPATH + url);
    		formToGo.submit();
    	}

     	// 주문내역 불러오는 함수
        function load_this_and_rid_that(tag){
            if($(tag).hasClass("manage-menus")){
            	$(".bigdaddy02 .card").empty();
                console.log("menu clicked!!!");
                //not 임 주의
                if(!$(".bdgroupA").hasClass("active")){
                    $(".bdgroupA").toggleClass("active");
                    $(".bdgroupB").toggleClass("active");
                    $(".cat-names").toggleClass("hidden");
                }
                window.location.href="${contextPath}/admin";                
            }else if($(tag).hasClass("manage-orders")){
                console.log("orders clicked!!!");
                if(!$(".bdgroupB").hasClass("active")){
                    $(".bdgroupB").toggleClass("active");
                    $(".bdgroupA").toggleClass("active");
                    $(".cat-names").toggleClass("hidden");
                }
            }
        }
     	
     	function getOrderDetail(order_seq){
     		console.log(order_seq);
     		$.ajax({
     			url:CPATH + '/getCorrespOrders',
     			data:{order_seq:order_seq},
     			success:function(orderDetails){
     				console.log(orderDetails);
     				let total = 0;
     				for(i = 0 ; i < orderDetails.length ; i ++){
     					total += orderDetails[i].menu_price;
     					
     					$(".menu_name").empty();
     					$(".menu_options").empty();
     					$(".menu_name").append("<div class='col-lg-7'>"
                        						  +"<span>"+ orderDetails[i].menu_name +"</span>"
                        					  +"</div>"
                        					  +"<div class='col-lg-2'>"
                            				      +"<span>"+ orderDetails[i].menu_cnt +"</span>"
                        					  +"</div>"
                        					  +"<div class='col-lg-3'>"
                            				  	  +"<span>"+ orderDetails[i].menu_price +"</span>"
                        					  +"</div>");
     					$(".menu_options").append("<div class='col-lg-7'>"
     												+">><span>"+ orderDetails[i].od_size +"</span>"
                        						+"</div>"
                        						+"<div class='col-lg-2'>"
                            						+"<span>"+orderDetails[i].od_ice+"</span>"
                        						+"</div>"
                        						+"<div class='col-lg-3'>"
                            						+"<span>"+ orderDetails[i].od_shot +"</span>"
                        						+"</div>");
     				}
     				$("#sum_total").text(total);
     				$("#retail_val").text(total-total*0.1);
     				$("#the_vat").text(total*0.1);
     				$("#total-total").text(total);
     			},
     			error:function(xhr, status, error){
					console.log(error);     				
     			}
     		});
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
	                            <div onclick="details('${menu.menu_seq}')">
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
	                                    
	                                </div>
	                            </div>
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
                            <form id="crud_form"> <!-- MENU INFO -->
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
                                                    <select class="form-control" style="border-top-right-radius:0px;border-bottom-right-radius:0px;" name="category_seq" type="text">
                                                        <c:forEach items="${categories}" var="cat">
	                                                        <option value="${cat.category_seq}">${cat.category_name}</option>
                                                        </c:forEach>
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
                                                    <input name="menu_name" placeholder="메뉴이름 입력" class="form-control border-0" type="text">
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
                                                    <input class="form-control border-0" name="menu_price" type="text" placeholder="가격입력">
                                                </div>
                                                <div class="col-lg-3"><b>원</b></div>
                                            </div>
                                        </div>
                                    </div> <!-- MENU PRICE INPUT ENDS-->

                                    <div> <!-- MENU DISCOUNT INPUT...NOT SUBMITTED TO FORM YET -->
                                        <div class="discount" style="margin-bottom:20px;">
                                            <div class="row">
                                                <span style="font-size:0.7rem;"><b>할인</b></span>
                                            </div>
                                            <div class="row">
                                                <div class="col-lg-5 form-group border-bottom border-dark">
                                                    <input class="form-control border-0" type="text" placeholder="할인입력">
                                                </div>
                                                <div class="col-lg-2"><b>원</b></div>
                                                <div class="col-lg-1 vat form-group">
                                                    <input type="checkbox" class="form-check-input">
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
                                                    <input type="checkbox" class="form-check-input opt_size" >크기
                                                </div>
                                                <div class="col-lg-2 form-group">
                                                    <input type="checkbox" class="form-check-input opt_ice" >얼음
                                                </div>
                                                <div class="col-lg-2 form-group">
                                                    <input type="checkbox" class="form-check-input opt_shot" >샷
                                                </div>
                                                <div class="col-lg-2 form-group">
                                                    <input type="checkbox" class="form-check-input opt_cont" >용기
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
                                                    <textarea class="form-control border-0" name="menu_desc" placeholder="뜨끈하게 한사발" rows="1"></textarea>
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
                                                    <img src="resources/img/purple.png" style="width:200px;" alt="menuimg">
                                                </div>
                                                <div class="col-lg-6 form-group">
                                                	<div class="row">
                                                		<div class="col-lg-12 the_chart">
                                                			<canvas id="chart_canvas">PREPARING</canvas>
                                                		</div>
                                                	</div>
													<!-- 
                                                    <div class="row">
                                                        <div class="col-lg-12">
                                                            <input type="checkbox" class="form-check-input">신규
                                                            <br>
                                                            <input type="checkbox" class="form-check-input">추천
                                                            <br>
                                                            <input type="checkbox" class="form-check-input">핫템
                                                        </div>
                                                    </div>  
                                                    <div class="row" style="margin-top:10px">
                                                        <div class="col-lg-12">
                                                            <label for="more_tag">추가태그</label>
                                                            <select id="more_tag" class="form-control">추가태그
                                                                <option value="10">10대</option>
                                                                <option value="20">20대</option>
                                                                <option value="30">30대</option>
                                                                <option value="40">40대</option>
                                                                <option value="50">50대이상</option>
                                                            </select>
                                                        </div>
                                                    </div>
                                                    -->
                                                    <div class="row" style="margin-top:10px">
                                                        <div class="col-lg-12">
                                                            <label for="img_address">사진링크</label>
                                                            <input id="img_address" class="form-control" name="menu_img" type="text" placeholder="이미지 주소 입력">
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
                            <div class="col-lg-4">
                            	<input type="button" class="btn delBtn" value="메뉴삭제" onclick="crud(this, event)" style="background-color:#fffff0;color:#1c1c1b">
                            </div>
                            <div class="col-lg-4">
                                <input type="reset" class="btn resetBtn" value="다시입력" style="background-color: #1c1c1b;color:#ffdc00">
                            </div>
                            <div class="col-lg-4">
                                <input type="button" class="btn subBtn" value="추가/수정" onclick="crud(this, event)" style="background-color:#ffdc00; color:#1c1c1b">
                            </div>
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
                               <c:forEach items="${orders}" var="order">
	                               <tr class="orders_list" onclick="getOrderDetail('${order.order_seq}')">
	                                    <td>${order.order_seq}</td>
	                                    <td>011-123-4567</td>
	                                    <td>${order.sum}원</td>
	                                    <td>2023/23/23</td>
	                               </tr>
                               </c:forEach>
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
                                            <input type="button" onclick="location.href='${contextPath}/errandBoy'" class="btn" value="반품처리">
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