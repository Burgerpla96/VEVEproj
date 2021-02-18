<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<link rel="stylesheet"
	href="<c:url value="/resources/assets/css/galleryList.css"/>">

<script>
$(function() { //화면 다 뜨면 시작
	var arraydata;
	$.ajax({
		type : 'post',
		url : "<c:url value="/json"/>",
		dataType : "json",
		success : function(data) {
			console.log("%O", Object.values(data));
			arraydata = Object.values(data);
			console.log(arraydata);
			$("#search").autocomplete({
				source : arraydata,
				select : function(event, ui) {
					console.log(ui.item);
				},
				focus : function(event, ui) {
					return false;
				}
			});
		}
	});//ajax	
	
	
	
	$('#commentIcon').click(function(){
		console.log('댓글 아이콘 클릭');
		
		$('#commentInput').focus();
		
	});
	///스크랩 아이콘 클릭
	$('#scrapIcon').click(function(){
		
		//console.log($('#scrapIcon').attr('class'));
		var scrap = $('#scrapIcon').attr('class');
		var scrap_ = scrap.split(' ')[0];
		var for_no = $('#for_no').val();
		console.log(scrap_);
		
		if(scrap_=='far'){
			//scrap insert
			$('#scrapIcon').attr("class",'fas fa-bookmark fa-2x');
			
			 $.ajax({
                 url:"<c:url value='/Gallary/Scrap/addscrap.do'/>",
                 data:{"gallary_no":for_no},
                 dataType:'text',
                 type:'post',
                 success:function(data){            
               	  
                 },
                 error:function(e){console.log(e);}                 
              });
			
			
		}
		else{
			//scrap delete
			$('#scrapIcon').attr("class",'far fa-bookmark fa-2x');
			
			$.ajax({
                url:"<c:url value='/Gallary/Scrap/deletescrap.do'/>",
                data:{"gallary_no":for_no},
                dataType:'text',
                type:'post',
                success:function(data){            
              	  
                },
                error:function(e){console.log(e);}                 
             });
			
		}
		
	});
	///Dec
	$('#gallaryDec').click(function(){
		var for_no = $('#for_no').val();
		prompt_dec(for_no);
		
	});
	///
	$('#boardHeart').click(function(){
		console.log('하트 아이콘 클릭');
		var UserID = $('#logincheck').val(); 
		if(UserID==''){console.log('null이야'); login();}
		var for_no = $('#for_no').val();
		console.log('하트 게시물 번호',for_no)
		var color = $('#heartColor').attr("style");
		console.log(color);
		if(color=='color:black'){
			//heart insert
			$('#heartColor').attr("style",'color:red');
			 $.ajax({
                 url:"<c:url value='/Gallary/Like/addheart.do'/>",
                 data:{"gallary_no":for_no},
                 dataType:'text',
                 type:'post',
                 success:function(data){            
               	  
                 },
                 error:function(e){console.log(e);}                 
              });
			
			
		}
		else{
			//heart delete
			$('#heartColor').attr("style",'color:black');
			$.ajax({
                url:"<c:url value='/Gallary/Like/deleteheart.do'/>",
                data:{"gallary_no":for_no},
                dataType:'text',
                type:'post',
                success:function(data){            
              	  
                },
                error:function(e){console.log(e);}                 
             });
		}
		
	});
	
    
    $('#commentInput').keyup(function(e){
    	var UserID = $('#logincheck').val();    	
    	if(e.keyCode == 13){
    		if(UserID==''){console.log('null이야'); login();}
    		var for_no = $('#for_no').val();
    		var content = $('#commentInput').val();
    		
    		$.ajax({
                url:"<c:url value='/Gallary/Comment/write.do'/>",
                data:{"gallary_no":for_no,"content":content},
                dataType:'json',
                type:'post',
                success:function(data){
        			console.log('댓글 작성!');
        			$('#board_comment').html(" ");
        			$('#commentInput').val('');
        			
        			var comments = "";
        	    	   if (data.length == 0) {
        	    	      console.log("if문안에 들어옴")
        	    	      $('#board_comment').html("등록된 댓글이 없어요");
        	    	   }
        	    	   $.each(data,
        	    	      function(index, element) {
        	    	         comments += "<div>";
        	    	         comments += "<span style='padding-right: 1em; font-weight: bold;'>"+element['NICKNAME']+"</span>";
        	    	         comments += "<span style='padding-right: 1em'>"+element['CONTENT']+"</span>";
        	    	         comments += "<span>"+element['POSTDATE']+"</span>";
        	    	         comments += "</div>";
        	    	      });
        	    	   $('#board_comment').html(comments);
	  
                },
                error:function(e){console.log(e);}                
             });    		
    		
    	}
    	
    })	
	
	

	
	
});
</script>
<!-- 새로 만든 스타일 -->

<style>
/*==========================================
* 프로그래스바 CSS
* ==========================================*/
.progress {
	width: 100px;
	height: 100px;
	background: none;
	position: relative;
}

.progress::after {
	content: "";
	width: 100%;
	height: 100%;
	border-radius: 50%;
	border: 6px solid #eee;
	position: absolute;
	top: 0;
	left: 0;
}

.progress>span {
	width: 50%;
	height: 100%;
	overflow: hidden;
	position: absolute;
	top: 0;
	z-index: 1;
}

.progress .progress-left {
	left: 0;
}

.progress .progress-bar {
	width: 100%;
	height: 100%;
	background: none;
	border-width: 6px;
	border-style: solid;
	position: absolute;
	top: 0;
}

.progress .progress-left .progress-bar {
	left: 100%;
	border-top-right-radius: 80px;
	border-bottom-right-radius: 80px;
	border-left: 0;
	-webkit-transform-origin: center left;
	transform-origin: center left;
}

.progress .progress-right {
	right: 0;
}

.progress .progress-right .progress-bar {
	left: -100%;
	border-top-left-radius: 80px;
	border-bottom-left-radius: 80px;
	border-right: 0;
	-webkit-transform-origin: center right;
	transform-origin: center right;
}

.progress .progress-value {
	position: absolute;
	top: 0;
	left: 0;
}

sup {
	font-size: 60%;
	font-weight: 400
}

/*마이페이지 배경색*/
body {
	background: #ff7e5f;
	background: -webkit-linear-gradient(to right, #ff7e5f, #feb47b);
	background: linear-gradient(to right, #ff7e5f, #feb47b);
	min-height: 100vh;
}

.rounded-lg {
	border-radius: 1rem;
}

div.h4 {
	line-height: 1rem;
}

/*==========================================
* 피드&모달
* ==========================================*/
#profileImage {
	width: 150px;
	height: 150px;
	border-radius: 70%;
	overflow: hidden;
	border: 1px solid #dddddd;
}

.nav-item {
	padding: 0 30px;
}

.nav-item a {
	color: #000;
}

.nav-item a.active {
	background-color: #F3D55A !important;
}

.white_content {
	position: fixed;
	top: 0;
	right: 0;
	bottom: 0;
	left: 0;
	background: rgba(0, 0, 0, 0.6);
	opacity: 0;
	-webkit-transition: opacity 400ms ease-in;
	-moz-transition: opacity 400ms ease-in;
	transition: opacity 400ms ease-in;
	pointer-events: none;
	z-index: 10;
}

.white_content:target {
	opacity: 1;
	pointer-events: auto;
}

.white_content>div {
	position: absolute;
	top: 15%;
	left: 15%;
	width: 75%;
	height: 75%;
	background-color: white;
	overflow: hidden;
}

.gallery-item a:hover {
	color: white;
	text-decoration: underline;
}

#user_profile {
	width: 45px;
	height: 45px;
	border-radius: 70%;
	overflow: hidden;
}

#board_comment::-webkit-scrollbar {
	display: none;
}
</style>


<!--뷰페이지  -->
<!-- modal 모양 View -->

<div class="white_content" id="open">
	<div id="flex_container" style="display: flex;">
		<div style="display: flex; width: 60%;">
			<div id="demo" class="carousel slide" data-ride="carousel"
				style="height: 100%; width: 100%; box-sizing: border-box;">
				<ol class="carousel-indicators">

				</ol>
				<div class="carousel-inner"
					style="height: 100%; width: 100%; box-sizing: border-box;"></div>
				<a class="carousel-control-prev" href="#demo" data-slide="prev">
					<span class="carousel-control-prev-icon"></span>
				</a> <a class="carousel-control-next" href="#demo" data-slide="next">
					<span class="carousel-control-next-icon"></span>
				</a>
			</div>
		</div>
		<!-- div right -->

		<div
			style="display: flex; width: 40%; flex-direction: column; padding-left: 10px">
			<p align="right">
				<a href="#close" id="closeView">CLOSE&nbsp;&nbsp;</a>
			</p>
			<div class="flex" style="display: flex;">
				<img alt="#" src="#" id="user_profile"
					onerror="this.src='/veve/resources/assets/images/basic_profile.gif';" />
				<span id="user_nickname"
					style="width: 50%; padding-left: 20px; padding-top: 10px; font-weight: bold; font-size: 1.5em">nick</span>
				<span class="dropdown"> <a href="#" class="dropdown-toggle"
					data-toggle="dropdown"> <i class="fas fa-ellipsis-h"></i>
				</a>

					<ul class="dropdown-menu">
						<li><a id="gallaryDec">신고하기</a></li>
					</ul>
				</span>
			</div>
			<hr width="100%">

			<div id="board_title"
				style="padding-top: 10px; font-size: 1.5em; height: 50px"></div>
			<div id="board_content"
				style="padding-top: 10px; font-size: 1.5em; height: 100px"></div>
			<hr width="100%">
			<div id="board_comment"
				style="padding-top: 10px; height: 130px; overflow: scroll;"></div>
			<hr width="100%">
			<div style="padding-top: 10px; height: 50px">
				<span id="heartColor" style="color: red"><i id="boardHeart"
					class="fas fa-heart fa-2x" aria-hidden="true"></i></span> <i
					id="commentIcon" class="fas fa-comment fa-2x" aria-hidden="true"></i>
				<i id="scrapIcon" class="far fa-bookmark fa-2x"></i> <span
					style="padding-left: 150px" id="board_date"></span>
			</div>
			<hr width="100%">
			<input id="commentInput" type="text" placeholder="댓글 달기..."
				style="width: 95%;" />
			<div style="height: 20px">
				<input type="hidden" id="for_no" /> <input type="hidden"
					value="${UserID}" id="logincheck" />
			</div>
		</div>
		<!-- div left -->

	</div>
	<!-- 외곽 flex container -->
</div>
<!-- View -->



<!-- 네비게이션바 거리유지 -->
<section class="pad">
	<div class="container">
		<div class="row">
			<div class="col-sm-12">d</div>
		</div>
	</div>
</section>
<!--네비게이션바 거리유지 끝-->


<!--마이홈 기본정보-->
<section class="MyHome_info">
	<div class="container">
		<div class="card">
			<div class="card-body">
				<!--개인정보 편집 드롭다운-->
				<div class="row right">
				
				<div class="dropdown right" style="float:right;position: absolute; top: 62px; right: 205px;">
						<button type="button" class="btn btn-more dropdown-toggle "
							data-toggle="dropdown">
							<i class="fas fa-cog"></i>
						</button>
						<div class="dropdown-menu dropdown-menu-right">
							<a class="dropdown-item"
								href="<c:url value="/Member/Mypage.do"/>">개인정보 수정</a>

							<c:if test="${empty KakaoUserId}" var="isNotKakaologin">
								<a class="dropdown-item" href="javascript:logout()">로그아웃</a>
							</c:if>
							<c:if test="${not isNotKakaologin }">
								<a class="dropdown-item" href="<c:url value="/logout"/>">로그아웃</a>
							</c:if>
						</div>

						
					</div>
				
				
				<!-- 검색폼 -->
                  <form method="get" action="<c:url value="/Member/OtherHome.do"/>">
                     <div class="input-group mb-3">
                     <input type="text" class="form-control" placeholder="계정 검색" id="search" name="otherid" >
                     <div class="input-group-append">
                        <button class="btn btn-more" id="serarchBtn" type="submit"><i class="fas fa-search"></i></button>
                     </div>
                     </div>
                  </form>
				
					
				</div>
				<!--개인정보 편집 드롭다운 끝-->

				<!--프로필 사진-->
				<div class="row" style="clear: both;">
					<div class="col-md-12 text-center">
						<c:if test="${empty KakaoUserId}" var="isNotKakaologin">

							<img id="profileImage" alt="이미지 오류"
								src='<c:url value="/upload/${filedto.f_name}"/>'
								onerror="this.src='/veve/resources/assets/images/basic_profile.gif';" />

						</c:if>
						<c:if test="${not isNotKakaologin }">
							<img id="profileImage" alt="이미지 오류" src='${KakaoUserImg}'
								onerror="this.src='/veve/resources/assets/images/basic_profile.gif';" />

						</c:if>
					</div>
				</div>

				<!--채식 레벨-->
				<div class="row">
					<div class="col-md-12 text-center">
						<div class="vglevel_div">
							<img id="vg_level_img" alt="채식스타일"
								src='<c:url value="/resources/assets/images/level_default.png"/>'
								style="width: 30px; height: 30px;" /> <span
								class="vg_level_text"> ${userdto.vg_level}</span>
						</div>
					</div>
				</div>

				<!--닉네임-->
				<div class="row">
					<div class="col-md-12 text-center">
						<h2>${userdto.nickname}</h2>
					</div>
				</div>

				<!--팔로워/팔로잉   ${followerinfos} ${followinginfos}-->
				<div class="row">
					<div class="col-md-12 text-center">
						<div class="follow_div">
							<a id="modal-193710" href="#modal-container-193710"
								data-toggle="modal">
								<p>
									팔로워 <span>${followerinfos.size()}</span>
								</p>
							</a>

							<p style="font-family: basic-R; font-size: 10px;">ㅣ</p>

							<a id="modal-751188" href="#modal-container-751188"
								data-toggle="modal">
								<p>
									팔로잉 <span>${followinginfos.size()}</span>
								</p>
							</a>
						</div>
					</div>
				</div>

				<div class="row">
					<div class="col-md-12 text-center roomy-40">
						<hr />
					</div>
				</div>




				<!--마이홈 영양정보 -->
				<div class="m-bottom-30">
					<div class="row">
						<div class="col-md-12">
							<h3>오늘의 영양 섭취</h3>
						</div>
					</div>

					<div class="row">
						<div class="col-xl-0 col-lg-3 mb-4">
							<div class="bg-white rounded-lg shadow roomy-40">
								<h4 class="font-weight-bold text-center mb-4">단백질</h4>

								<div class="progress mx-auto" data-value='${strproteinPercent}'>
									<span class="progress-left"> <span
										class="progress-bar border-danger"></span>
									</span> <span class="progress-right"> <span
										class="progress-bar border-danger"></span>
									</span>
									<div
										class="progress-value w-100 h-100 rounded-circle d-flex align-items-center justify-content-center">
										<div class="h2 font-weight-bold" id="protein_percent">
											<span>${strproteinPercent}</span><sup>%</sup>
										</div>
									</div>
								</div>
							</div>
						</div>

						<div class="col-xl-0 col-lg-3 mb-4">
							<div class="bg-white rounded-lg shadow roomy-40">
								<h4 class="font-weight-bold text-center mb-4">아연</h4>
								<div class="progress mx-auto" data-value='${strzincPercent}'>
									<span class="progress-left"> <span
										class="progress-bar border-primary"></span>
									</span> <span class="progress-right"> <span
										class="progress-bar border-primary"></span>
									</span>
									<div
										class="progress-value w-100 h-100 rounded-circle d-flex align-items-center justify-content-center">
										<div class="h2 font-weight-bold" id="zinc_percent">
											<span>${strzincPercent}</span><sup>%</sup>
										</div>
									</div>
								</div>
							</div>
						</div>

						<div class="col-xl-0 col-lg-3 mb-4">
							<div class="bg-white rounded-lg shadow roomy-40">
								<h4 class="font-weight-bold text-center mb-4">칼슘</h4>
								<div class="progress mx-auto" data-value='${strcalPercent}'>
									<span class="progress-left"> <span
										class="progress-bar border-info"></span>
									</span> <span class="progress-right"> <span
										class="progress-bar border-info"></span>
									</span>
									<div
										class="progress-value w-100 h-100 rounded-circle d-flex align-items-center justify-content-center">
										<div class="h2 font-weight-bold" id="cal_percent">
											<span>${strcalPercent}</span><sup>%</sup>
										</div>
									</div>
								</div>
							</div>
						</div>

						<div class="col-xl-0 col-lg-3 mb-4">
							<div class="bg-white rounded-lg shadow roomy-40">
								<h4 class="font-weight-bold text-center mb-4">비타민 B12</h4>
								<div class="progress mx-auto" data-value='${strbPercent}'>
									<span class="progress-left"> <span
										class="progress-bar border-warning"></span>
									</span> <span class="progress-right"> <span
										class="progress-bar border-warning"></span>
									</span>
									<div
										class="progress-value w-100 h-100 rounded-circle d-flex align-items-center justify-content-center">
										<div class="h2 font-weight-bold" id="b_percent">
											<span>${strbPercent}</span><sup>%</sup>
										</div>
									</div>
								</div>
							</div>
						</div>

						<div class="col-xl-0 col-lg-3 mb-4">
							<div class="bg-white rounded-lg shadow roomy-40">
								<h4 class="font-weight-bold text-center mb-4">비타민 D</h4>
								<div class="progress mx-auto" data-value='${strdPercent}'>
									<span class="progress-left"> <span
										class="progress-bar border-success"></span>
									</span> <span class="progress-right"> <span
										class="progress-bar border-success"></span>
									</span>
									<div
										class="progress-value w-100 h-100 rounded-circle d-flex align-items-center justify-content-center">
										<div class="h2 font-weight-bold" id="d_percent">
											<span>${strdPercent}</span><sup>%</sup>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<!--마이홈 영양정보 끝 -->
				</div>
				<!--card-->
			</div>
		</div>
	</div>

</section>
<!--마이홈 기본정보 끝-->



<!-- 마이홈 게시글 정보 -->
<section class="MyHome_info m-bottom-100">
	<div class="container">
		<div class="card m-top-20">
			<div class="card-body">

				<!-- 컨텐츠 -->
				<div class="tabbable" id="category_tabs">
					<ul class="nav nav-pills justify-content-center">
						<li class="nav-item"><a class="nav-link active" href="#tab1"
							data-toggle="tab">내 피드</a></li>
						<li class="nav-item"><a class="nav-link" href="#tab2"
							data-toggle="tab">내 레시피</a></li>
						<li class="nav-item"><a class="nav-link" href="#tab3"
							data-toggle="tab">스크랩</a></li>
					</ul>
					<div class="tab-content">
						<!-- tab1 내 피드 -->
						<div class="tab-pane active" id="tab1">
							<!-- sumnail  -->
							<main style="padding-top: 10px">
								<div class="container_main">
									<div class="gallery" id="appendPosition">
										<c:forEach var="item" items="${boardList}" varStatus="var">
											<div class="gallery-item" tabindex="0">
												<img
													src="<c:url value='/upload/${fileList[var.index].fileName}'/>"
													class="gallery-image" alt=""
													style="width: 300px; height: 300px">
												<div class="gallery-item-info"
													onclick="view(${item.gallary_no})"
													style="width: 300px; height: 300px">
													<ul>
														<li class="gallery-item-likes"><span
															class="visually-hidden">Likes:</span><i
															class="fas fa-heart" aria-hidden="true"></i>
															${likeList[var.index] }</li>
														<li class="gallery-item-comments"><span
															class="visually-hidden">Comments:</span><i
															class="fas fa-comment" aria-hidden="true"></i>
															${commentList[var.index] }</li>
													</ul>
												</div>
											</div>
										</c:forEach>
									</div>
								</div>
								<!-- End of container -->
								<a id="a_open" href="#open" hidden=""></a>
							</main>
							<!-- sumnail  -->

						</div>
						<!-- tab1 내 피드 -->

						<!-- 두번째 tab 내 레시피 -->
						<div class="tab-pane" id="tab2">
							<c:forEach var="item" items="${reboardList}" varStatus="var">
								<div class="col-sm-3">
									<div class="list" style="background-color: #fffff0;">
										<c:forEach var="file" items="${refileList}" varStatus="var">
											<c:if test="${item.rec_no == file.rec_no}">
												<img src="<c:url value='/upload/${file.f_name}'/>"
													style="height: 255px; width: 100%;" />
											</c:if>
										</c:forEach>

										<div class="summary">
											<h2>
												<a
													href="<c:url value='/RecipeBBS/view.do?rec_no=${item.rec_no}'/>">${item.title}</a>
											</h2>

											<a
												href="<c:url value='/RecipeBBS/view.do?rec_no=${item.rec_no}'/>">${item.content }</a>
											<p></p>
											<p>${item.userID }</p>
											<p>${item.postDate }</p>
										</div>
									</div>
								</div>
							</c:forEach>
						</div>
						<!-- 두번째 tab 내 레시피 -->

						<!-- 세번째 tab 내 레시피 -->
						<div class="tab-pane" id="tab3">
							<main style="padding-top: 10px">
								<div class="container_main">
									<div class="gallery" id="appendPosition">
										<c:forEach var="item" items="${scrapboardList}"
											varStatus="var">
											<div class="gallery-item" tabindex="0">
												<img
													src="<c:url value='/upload/${scrapfileList[var.index].fileName}'/>"
													class="gallery-image" alt=""
													style="width: 300px; height: 300px">
												<div class="gallery-item-info"
													onclick="view(${item.gallary_no})"
													style="width: 300px; height: 300px">
													<ul>
														<li class="gallery-item-likes"><span
															class="visually-hidden">Likes:</span><i
															class="fas fa-heart" aria-hidden="true"></i>
															${scraplikeList[var.index] }</li>
														<li class="gallery-item-comments"><span
															class="visually-hidden">Comments:</span><i
															class="fas fa-comment" aria-hidden="true"></i>
															${scrapcommentList[var.index] }</li>
													</ul>
												</div>
											</div>
										</c:forEach>
									</div>
								</div>
								<!-- End of container -->
								<a id="a_open" href="#open" hidden=""></a>
							</main>
						</div>
						<!-- 세번째 tab 내 레시피 -->


					</div>
					<!-- 컨텐츠 목록 끝 -->

				</div>
			</div>
		</div>
	</div>
</section>



<!-- 모달-팔로워 -->
<div class="modal fade" id="modal-container-193710" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="myModalLabel">팔로워</h5>
				<button type="button" class="close" data-dismiss="modal">
					<span aria-hidden="true">×</span>
				</button>
			</div>
			<div class="modal-body">

				<table class="table">
					<thead>
						<tr>
							<th></th>
							<th>NickName</th>
							<th>ID</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="following" items="${followerinfos}"
							varStatus="stauts">
							<tr>
								<c:if test="${following.k1n0 eq '1'}" var="isNotKakaologin">
									<td><img alt="#" style="width: 30px; height: 30px"
										src='${followerfileinfos[stauts.index]}' /></td>
								</c:if>
								<c:if test="${!isNotKakaologin}">
									<td><img alt="이미지 오류" style="width: 30px; height: 30px"
										src='<c:url value="/upload/${followerfileinfos[stauts.index]}"/>' /></td>
								</c:if>
								<td>${following.nickname}</td>
								<td>${following.userID}</td>
							</tr>
						</c:forEach>

					</tbody>
				</table>


			</div>
			<div class="modal-footer">


				<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
			</div>
		</div>

	</div>

</div>
<!-- 모달-팔로워 끝-->

<!-- 모달 팔로잉-->
<div class="modal fade" id="modal-container-751188" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="myModalLabel">팔로잉</h5>
				<button type="button" class="close" data-dismiss="modal">
					<span aria-hidden="true">×</span>
				</button>
			</div>

			<div class="modal-body">


				<table class="table">
					<thead>
						<tr>
							<th></th>
							<th>NickName</th>
							<th>ID</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="following" items="${followinginfos}"
							varStatus="stauts">
							<tr>
								<c:if test="${following.k1n0 eq '1'}" var="isNotKakaologin">
									<td><img alt="#" style="width: 30px; height: 30px"
										src='${followingfileinfos[stauts.index]}' /></td>
								</c:if>
								<c:if test="${!isNotKakaologin}">
									<td><img alt="이미지 오류" style="width: 30px; height: 30px"
										src='<c:url value="/upload/${followingfileinfos[stauts.index]}"/>' /></td>
								</c:if>
								<td>${following.nickname}</td>
								<td>${following.userID}</td>
							</tr>
						</c:forEach>

					</tbody>
				</table>



			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
			</div>
		</div>

	</div>

</div>
<!-- 모달 팔로잉 끝-->









<script>

/*채식 레벨출력*/
$(document).ready(function(){
	var option_level = "${userdto.vg_level}";
	//비건레벨에 따라 채식 스타일 정보 출력
	if(option_level=="rac"){//락토
		$('#vg_level_img').attr("src","<c:url value='/resources/assets/images/filter_on2.png'/>");
		$('.vg_level_text').html("락토");
	}
	else if(option_level=="ov"){ //오보
		$('#vg_level_img').attr("src","<c:url value='/resources/assets/images/filter_on3.png'/>");
		$('.vg_level_text').html("오보");
	}
	else if(option_level=="racov"){//락토오보
		$('#vg_level_img').attr("src","<c:url value='/resources/assets/images/filter_on4.png'/>");
		$('.vg_level_text').html("락토-오보");
	}
	else if(option_level=="pesco"){//페스코
		$('#vg_level_img').attr("src","<c:url value='/resources/assets/images/filter_on5.png'/>");
		$('.vg_level_text').html("페스코");
	}
	else if(option_level=="polo"){ //폴로
		$('#vg_level_img').attr("src","<c:url value='/resources/assets/images/filter_on6.png'/>");
		$('.vg_level_text').html("폴로");
	}
	else if(option_level=="none"){ //논비건
		$('#vg_level_img').attr("src","<c:url value='/resources/assets/images/filter_on7.png'/>");
		$('.vg_level_text').html("채식주의자가 아니에요");
	}
	else if(option_level=="vegan"){ //비건
		$('#vg_level_img').attr("src","<c:url value='/resources/assets/images/filter_on1.png'/>");
		$('.vg_level_text').html("비건");
	}
	
	
});



/*소수점 이하 제거*/
var percent = $('#protein_percent span').html().split('.')[0];
$('#protein_percent span').html(percent);

var percent = $('#zinc_percent span').html().split('.')[0];
$('#zinc_percent span').html(percent);

var percent = $('#cal_percent span').html().split('.')[0];
$('#cal_percent span').html(percent);

var percent = $('#b_percent span').html().split('.')[0];
$('#b_percent span').html(percent);

var percent = $('#d_percent span').html().split('.')[0];
$('#d_percent span').html(percent);






function view(board_no){
	console.log("테이블 번호:",board_no);
	
	$.ajax({
		type:"post",
		url:"<c:url value='/Gallary/View.do'/>",
		dataType: 'json',
		//traditional: true,
		data:{'gallary_no':board_no},
		success:function(data){
			//var json = JSON.parse(data);
			var filenames = data["filenames"];
			console.log(filenames);
			var fileCount = filenames.split("/").length-1
			console.log(fileCount);
			var files = filenames.split("/");
			console.log(files);
			var src = '/veve/upload/';
			console.log(src)
			//$('#user_profile')
			var userk1n0 = data["userk1n0"];
			console.log(userk1n0);
			if(userk1n0=='1'){
				$('#user_profile').attr('src',data["userfile"]);
			}
			else{
				$('#user_profile').attr('src',src+data["userfile"]);
			}
			//userNickname
			$('#user_nickname').html(data["usernickname"]);
			$('#board_title').html(data["boardTitle"]);
			$('#board_content').html(data["boardContent"]);
			$('#board_date').html(data["boardDate"]);
			
		
			
			$(".carousel-inner *").remove();
			$(".carousel-indicators *").remove();

			$.each(files,function(index,value){
				if(index==0){
					//appendDivFirst(value,src);
					$('.carousel-indicators').append('<li data-target="#demo" data-slide-to="0" class="active"></li>');	
					$('.carousel-inner').append(`<div class="carousel-item active" style="height: 100%; width: 100%;">
				         <img src="`+src+value+`" class="gallery-image" alt="" style="height:100%; widhth:100%" > 
				        </div> `);	
					
				
					
				}
				else if(index != fileCount){
					$('.carousel-indicators').append('<li data-target="#demo" data-slide-to="'+index+'"></li>');	
					$('.carousel-inner').append(`
						<div class="carousel-item" style="height: 100%; width: 100%;">
				        <img src="`+src+value+`" class="gallery-image" alt="" style="height:100%; widhth:100%" > 
				        </div> `);	
						
				}

				
			});//each
			console.log('하트',data["myLike"])
			//1.좋아요 유무 확인
			if(data["myLike"]=='1'){
				console.log('하트 빨간색')
				$('#heartColor').attr('style','color:red');
			}
			else{
				$('#heartColor').attr('style','color:black');
			}
			
			//2.댓글 가져오기
			$('#for_no').val(data["boardNo"]);
			showComments(data["boardNo"]);
			
			console.log("scrap:"+data["myScrap"]);
			//3.scrap
			if(data["myScrap"]==1)
				$('#scrapIcon').attr('class',"fas fa-bookmark fa-2x")
			else
				$('#scrapIcon').attr('class',"far fa-bookmark fa-2x")
			
			
			$('#a_open').get(0).click();
			
		}//success	
		
	});//ajax	
	
	
	

}
//현재 글번호에 대한 모든 댓글을 요청하는 함수
function showComments(board_no){
   console.log('showComments board_no',board_no);
   $.ajax({
      url:"<c:url value='/Gallary/Comment/list.do'/>",
      data:{"gallary_no":board_no},
      dataType:'json',
      type:'post',
      success:function(data){
    	  console.log('댓글 완료!');
    	  console.log(data)
    	  var comments = "";
    	   if (data.length == 0) {
    	      console.log("if문안에 들어옴")
    	      $('#board_comment').html("등록된 댓글이 없어요");
    	   }
    	   $.each(data,
    	      function(index, element) {
    	         //console.log("댓글 리스트 확인:")
    	         comments += "<div>";
    	         comments += "<span style='padding-right: 1em; font-weight: bold;'>"+element['NICKNAME']+"</span>";
    	         comments += "<span style='padding-right: 1em'>"+element['CONTENT']+"</span>";
    	         comments += "<span>"+element['POSTDATE']+"</span>";
    	         comments += "</div>";
    	      });
    	   $('#board_comment').html(comments);
    	  
    	  
    	  
    	  
      },
      error:function(e){console.log(e);}
      
   });
   
}//////////////showComments

function prompt_dec(for_no) {
    var content = prompt("신고사유를 입력해주세요.");
    
    $.ajax({
        url:"<c:url value='/Gallary/Dec/insertdec.do'/>",
        data:{"gallary_no":for_no,"content":content},
        dataType:'text',
        type:'post',
        success:function(data){ 
        	alert("신고내용이 접수되었습니다.");
      	  
        },
        error:function(e){console.log(e);}                 
     });
    
    

    
}

</script>
<script>
/*원형 프로그레스바*/
$(function() {

$(".progress").each(function() {

  var value = $(this).attr('data-value');
  var left = $(this).find('.progress-left .progress-bar');
  var right = $(this).find('.progress-right .progress-bar');

  if (value > 0) {//양수고
    if (value <= 50) { //50%이하
      right.css('transform', 'rotate(' + percentageToDegrees(value) + 'deg)')
    } 
    else if(value>50 & value<=100) {//50%초과~100이하
      right.css('transform', 'rotate(180deg)')
      left.css('transform', 'rotate(' + percentageToDegrees(value - 50) + 'deg)')
    }
    else{
    	right.css('transform', 'rotate(180deg)')
    	left.css('transform', 'rotate(-180deg)')
    }
  }


})

function percentageToDegrees(percentage) {

  return percentage / 100 * 360

}

});
</script>