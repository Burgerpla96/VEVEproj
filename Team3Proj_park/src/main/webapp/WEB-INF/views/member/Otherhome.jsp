<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
	<link rel="stylesheet"
	href="<c:url value="/resources/assets/css/galleryList.css"/>">
	
<script>
$(function() {   
    	var arraydata;

  		$.ajax({
  			type : 'post',
  			url : "<c:url value="/json"/>",
  			dataType : "json",
  			success : function(data) {
  				console.log("%O",Object.values(data));
  				arraydata=Object.values(data);
  				console.log(arraydata);
  				$("#search").autocomplete({
  					source: arraydata,
  			        select: function(event, ui) {
  			            console.log(ui.item);
  			        },
  			        focus: function(event, ui) {
  			            return false;
  			        }
  			    });
  			}
  		});//ajax
  		
  		//follow버튼 클릭시
  		$('#follow').click(function(){
  			console.log('follow click');
  			$.ajax({
  				type : 'post',
  				url : "<c:url value="/Member/follow"/>",
  				dataType : "text",
  				success : function(data) {
  					console.log('follow success'); 
  					$('#follow').hide();
  					$('#following').removeAttr("hidden");
  					$('#following').show();
  					
  				}
  			});//ajax  			
  		});//follow
  		$('#following').click(function(){
  			console.log('following click');
  			$.ajax({
  				type : 'post',
  				url : "<c:url value="/Member/following"/>",
  				dataType : "text",
  				success : function(data) {
  					console.log('follow success'); 
  					$('#follow').show();
  					$('#follow').removeAttr("hidden");
  					$('#following').hide();
  					
  					
  				}
  			});//ajax
  		});//following
  		
});   	  

</script>








<!-- 새로 만든 스타일 -->
<style>
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
<section class="MyHome_info m-bottom-100">
	<div class="container">
		<div class="card">
			<div class="card-body">
				<!--개인정보 편집 드롭다운-->
				<div class="row right">
				
				
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
									팔로워 <span id="followerCountSpan">${followerinfos.size()}</span>
								</p>
							</a>

							<p style="font-family: basic-R; font-size: 10px;">ㅣ</p>

							<a id="modal-751188" href="#modal-container-751188"
								data-toggle="modal">
								<p>
									팔로잉 <span>32</span>
								</p>
							</a>
						</div>
					</div>
				</div>
				
				<!-- 팔로우 버튼 -->
				<div class="col-md-12 text-center m-top-25">
						<c:if test="${empty isfollowing}" var="isNotFollowing">
							<button id="follow" class="btn btn-nav" onclick='location.reload(true);'>팔로우</button>
							<button id="following" class="btn btn-nav" hidden="" onclick='location.reload(true);'>팔로잉</button>
							<script>
								var followerCountSpan = Number($('#followerCountSpan').html());
								$('#followerCountSpan').html(followerCountSpan);
							</script>
						</c:if>
						<c:if test="${not isNotFollowing }">
							<button id="following" class="btn btn-nav" onclick='location.reload(true);'>팔로잉</button>
							<button id="follow" class="btn btn-nav " hidden="" onclick='location.reload(true);'>팔로우</button>
							<script>
								var followerCountSpan = Number($('#followerCountSpan').html());
								$('#followerCountSpan').html(followerCountSpan);
							</script>
						</c:if>

					</div>

				<div class="row">
					<div class="col-md-12 text-center roomy-40">
						<hr />
					</div>
				</div>
				
				
				
				<!-- 컨텐츠 -->
				<div class="tabbable" id="category_tabs">
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
					</div>
					<!-- 컨텐츠 목록 끝 -->
				</div>
				<!--card-->
			</div>
		</div>
	</div>

</section>
<!--마이홈 기본정보 끝-->






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

</script>