<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>


<style>
.card-body{
padding-top: 40px;
}
.mainPic {
	width: 100%;
	height: 570px;
	overflow: hidden;
	justify-content: center;
	align-items: center;
	display: flex;
}

.recipe_content_title h6 {
	color: #F3D55A;
	font-family: "basic-EB";
	font-size: 16px;
}

.recipe_content_title h2 {
	font-size: 35px;
	line-height: 1.2;
}

.recipe_content_summary .card {
	background-color: #F9F8EF;
	border: none;
}

.dropdown-toggle::after {
	content: none;
}

.dropdown {
	display: inline-block;
}

.recipe_content_title h4{
	font-family: "basic-B";
	color: #222222;
	font-size: 18px;
}
.recipe_content_profile td {
	font-family: "basic-B";
	color: #797979;
	font-size: 14px;
}

.recipe_content_profile #nick {
	font-family: "basic-EB";
	color: #222222;
	font-size: 18px;
	padding-top: 10px;
	padding-bottom: 0;
}

.commentform {
	border-right: none;
}

.input-group>.custom-select:not(:first-child), .input-group>.form-control:not(:first-child)
	{
	border-top-left-radius: 0.25rem;
	border-bottom-left-radius: 0.25rem;
}

.scrap {
	margin-left: 20px;
}

.like, .scrap {
	display: inline-block;
	float: right;
}

.like h2, .scrap h2 {
	margin: 0;
	line-height: 1;
}

.like h2 i, .scrap h2 i{
color: #797979;
}

.like h5, .scrap h5 {
	color: #797979;
	font-family: "basic-EB";
}

.profile_img {
	border: 1px solid rgba(0, 0, 0, .1);
}

.miniprofile {
	display: inline;
	float: left;
	margin-right: 10px;
}

.comment-write {
	display: flex;
}
</style>

<!-- 네비게이션바 거리유지 -->
<section class="pad2">
	<div class="container">
		<div class="row">
			<div class="col-sm-12">d</div>
		</div>
	</div>
</section>
<!--네비게이션바 거리유지 끝-->


<!-- 메인사진 -->
<div class="container-fluid">
	<div class="row">
		<div class="mainPic">
			<c:forEach var="file" items="${recipeFile}" varStatus="var">
				<c:if test="${recipe.rec_no == file.rec_no}">
					<img src="<c:url value='/upload/${file.f_name}'/>"
						style="width: 100%; height: auto;" />
				</c:if>
			</c:forEach>
		</div>
	</div>
</div>
<!-- 메인사진 끝-->




<!-- 레시피 제목부분 -->
<section class="recipe_content_title bg-white m-top-45">
	<div class="container">
		<div class="row">
			<div class="col-sm-8 offset-2">
				<h6>${recipe.category}</h6>
			</div>
		</div>
		<div class="row">
			<div class="col-sm-6 offset-2">
				<h2>${recipe.title}</h2>
			</div>
			<div class="col-sm-2 text-center">
				<div class="scrap">
					<h2>
						<i class="far fa-bookmark" id="mark"></i>
					</h2>
					<h5>스크랩</h5>
				</div>
				<div class="like">
					<h2>
						<i class="far fa-heart" id="heart"></i>
					</h2>
					<h5>좋아요</h5>
				</div>

			</div>
		</div>
	</div>
</section>
<!-- 레시피 제목부분 끝-->





<!--작성자 정보-->

<section class="recipe_content_profile bg-white roomy-40">
	<div class="container">
		<div class="row">
			<div class="col-sm-8 offset-2">
				<table class="table table-borderless table-sm">
					<tbody>
						<tr>
							<td rowspan="2" width="80px"><img
								src="<c:url value='/upload/${file.f_name}'/>"
								class="rounded-circle profile_img" alt="프로필사진" width="65px"
								height="65px"></td>
							<td id="nick">${member.nickname}</td>

							<td rowspan="2"
								style="text-align: right; vertical-align: middle;">
								<div class="buttons">
									<button>
										<a href="#" class="btn btn-more">팔로우</a>
									</button>
									<div class="dropdown">
										<button type="button" class="btn btn-more dropdown-toggle"
											data-toggle="dropdown">
											<i class="fas fa-ellipsis-v"></i>
										</button>
										<div class="dropdown-menu dropdown-menu-right">
											<a class="dropdown-item" href="#">신고하기</a>
										</div>
									</div>
								</div>
							</td>
						</tr>
						<tr>
							<td id="resipe_postdate">${recipe.postDate}</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</section>
<!--작성자 정보 끝-->


<!-- 레시피 정보 -->
<section class="recipe_content_summary bg-white roomy-40">
	<div class="container">
		<div class="row">
			<div class="col-sm-8 offset-2">
				<div class="card">
					<div class="card-body">
					<style>
					.rec_info img{
					display: inline-block;
					}
					.rec_info:after{content:""; display: inline-block; width: 100%; height: 0;}
					</style>
						<div class="rec_info" style="text-align: justify;">
							<img src="<c:url value="/resources/assets/images/요약1.png"/>" alt="레벨" width="auto" height="50px">
							<span style="color:#cccccc">ㅣ</span>
							<img src="<c:url value="/resources/assets/images/요약2.png"/>" alt="레벨" width="auto" height="42px">
							<span style="color:#cccccc">ㅣ</span>
							<img src="<c:url value="/resources/assets/images/요약3.png"/>" alt="레벨" width="auto" height="42px">
							<span style="color:#cccccc">ㅣ</span>
							<img src="<c:url value="/resources/assets/images/요약4.png"/>" alt="레벨" width="auto" height="43px">
						</div>
						
						<hr>
						
						<p><span style="color:#555555; font-family:basic-B;">재료</span> &nbsp;&nbsp;${recipe.ingredients}</p>
						<p><span style="color:#555555; font-family:basic-B;">도구</span> &nbsp;&nbsp;${recipe.tools}</p>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>
<!-- 레시피 정보 끝-->


<!-- 레시피 완성샷 & 레시피 설명 -->
<section class="recipe_content_complete bg-white roomy-20">
	<div class="container">
		<div class="row">
			<div class="col-sm-8 offset-2">
			
				<div id="demo" class="carousel slide" data-ride="carousel">

					<!-- Indicators -->
					<ul class="carousel-indicators">
						<li data-target="#demo" data-slide-to="0" class="active"></li>
						<li data-target="#demo" data-slide-to="1"></li>
						<li data-target="#demo" data-slide-to="2"></li>
					</ul>

					<!-- The slideshow -->
					<div class="carousel-inner">
						<div class="carousel-item active">
							<img src="<c:url value="/resources/assets/images/딸기1.png"/>"
								alt="Los Angeles" width="100%" height="500">
						</div>
						<div class="carousel-item">
							<img src="<c:url value="/resources/assets/images/딸기2.png"/>"
								alt="Chicago" width="100%" height="500">
						</div>
						<div class="carousel-item">
							<img src="<c:url value="/resources/assets/images/딸기3.png"/>"
								alt="New York" width="100%" height="500">
						</div>
						<div class="carousel-item">
							<img src="<c:url value="/resources/assets/images/딸기4.png"/>"
								alt="New York" width="100%" height="500">
						</div>
					</div>

					<!-- Left and right controls -->
					<a class="carousel-control-prev" href="#demo" data-slide="prev">
						<span class="carousel-control-prev-icon"></span>
					</a> <a class="carousel-control-next" href="#demo" data-slide="next">
						<span class="carousel-control-next-icon"></span>
					</a>
				</div>

				<div class="">
					<p>${recipe.content}</p>
				</div>
			</div>
		</div>
</section>
<!-- 레시피 완성샷 & 레시피 설명 끝-->



<!-- 레시피 단계 -->
<section class="recipe_content_title bg-white">
	<div class="container">
		<div class="row">
			<div class="col-sm-8 offset-2 m-top-40">
			<h2 style="font-size:23px;">요리 방법</h2>
				<img src="<c:url value="/resources/assets/images/요리.png"/>" alt="요리순서" width="100%">
			</div>
		</div>
	</div>


	<!-- 수정, 삭제, 목록 버튼 -->
	<div class="container">
	<div class="row">
		<div class="offset-2 col-md-8 m-top-40 m-bottom-20" style="text-align: center;">
			<!-- .center-block 사용시 해당 블락의 크기를 지정하자 -->
			
			
				<c:if test="${sessionScope.UserID == recipe.userID }">
				<a href="<c:url value='/RecipeBBS/edit.do?rec_no=${recipe.rec_no}'/>"><button type="button" class="btn btn-nav">수정</button></a>
					<button type="button" class="btn btn-nav" onclick="javascript:isDelete();">삭제</button>
				</c:if>
				<a href="<c:url value='/recipe.do'/>"><button type="button" class="btn btn-nav">목록</button></a>

		</div>
	</div>
	</div>
	<!-- 수정, 삭제, 목록 버튼 -->

</section>
<!-- 레시피 단계 끝-->




<!-- 댓글 -->
<section class="recipe_content_title bg-white">
	<div class="container">
		<div class="row">
			<div class="col-sm-8 offset-2">
				<hr>

				<div class="m-top-40">
					<h4>댓글</h4>
				</div>

				<div class="miniprofile"> <!-- 로그인중인 유저 프사 -->
					<img src="<c:url value='/upload/${sessionFile.f_name}'/>"
						class="rounded-circle profile_img" alt="프로필사진" width="35px"
						height="35px">
				</div>

				<form class="form comment-write m-bottom-20" id="frm" method="post">
					<!-- 씨큐리티 적용:csrf취약점 방어용 -->
					<input type="hidden" name="${_csrf.parameterName}"
						value="${_csrf.token}" /> <input type="hidden" name="rec_no"
						value="${recipe.rec_no}" />
					<!-- 수정 및 삭제용 파라미터 -->
					<div class="input-group">
						<input type="hidden" name="rec_com_no" /> <input type="text"
							name="content" id="title" class="form-control commentform"
							placeholder="댓글을 입력해주세요.">
						<div class="input-group-append">
							<input class="btn btn-more" id="submit" type="button"
								value="등록" />
						</div>
					</div>
				</form>



			</div>
		</div>

		<!-- 댓글 목록 뿌리는곳 -->
		<div class="row">
			<div id="comments" class="col-sm-8 offset-2"></div>

			<div id="comments" class="col-sm-8 offset-2 m-bottom-250">
				<!-- <table class="table table-sm table-borderless">
					<tbody>
						<tr>
							<td rowspan="2" width="50px" style="vertical-align: middle;">
								<img src="<c:url value="/resources/assets/images/댕.jpg"/>"
								class="rounded-circle profile_img" alt="프로필사진" width="35px"
								height="35px">
							</td>
							<td><strong>푸키푸키</strong> 저도 이번에 만들어봐야겠어요~ :)</td>

							<td rowspan="2"
								style="text-align: right; vertical-align: middle;">
								<div class="like">
									<a href="#" class="like"><i class="far fa-heart"
										style="color: #797979;"></i></a>
								</div>
							</td>
						</tr>

						<tr>
							<td id="resipe_postdate">2021-02-02</td>
						</tr>
					</tbody>
				</table> -->
			</div>
		</div>
		<!-- 댓글 목록 뿌리는곳 끝-->
	</div>


<!-- 추천 기능 -->

</section>
<!-- 댓글 끝-->



<script>
	//페이지 로드시 코멘트 목록 뿌려주기]		
	showComments();
	//코멘트 입력 및 수정처리]
	var action;
	$("#submit").click(function() {

		if ($(this).val() == "등록")
			action = "<c:url value='/RecipeBBS/Comment/write.do'/>";
		else
			action = "<c:url value='/RecipeBBS/Comment/edit.do'/>";
		//ajax로 요청]
		$.ajax({
			url : action,
			data : $('#frm').serialize(),
			dataType : 'text',
			type : 'post',
			success : function(data) {
				console.log(data);
				//글 등록후 코멘트 목록 뿌려주는 함수 다시 호출
				showComments();
				//입력댓글 클리어 및 포커스 주기
				$('#title').val('');
				$('#title').focus();
				//글 수정후 등록버튼으로 다시 교체하기
				if ($('#submit').val() == '수정')
					$('#submit').val('등록');

			}

		});

	});/////////////////
	

	
	
	//현재 글번호에 대한 모든 댓글을 요청하는 함수
	function showComments() {
		$.ajax({
			type : 'post',
			url : "<c:url value='/RecipeBBS/Comment/list.do'/>",
			data : {"rec_no" : "${recipe.rec_no}"},
			dataType : 'json',
			success : showComments_,
			error : function(e) {
				console.log(e);
			}

		});
	}//////////////showComments
	//실제 댓글 목록을 뿌려주는 함수]
	function showComments_(data) {
		console.log('코멘트 목록:', data);
		var comments = "";
		comments += "<table class='table table-sm table-borderless'><tbody>";
		if (data.length == 0) {
			comments += "<tr><td colspan='4'>등록된 한줄 댓글이 없어요</td></tr>";
		}

		$.each(data, function(index, element) {
				//프로필사진
				console.log(element['NICKNAME']);
				console.log(element['F_NAME']);
				comments += '<tr><td rowspan="2" width="50px" style="vertical-align: middle;">'+ '<img src="/veve/upload/'+ element['F_NAME'] + '" class="rounded-circle profile_img" alt="프로필사진" width="35px" height="35px"></td>';
					
				comments += "<td><span class='nick'>" + element['NICKNAME'] + "</span>&nbsp;";
	
				if ("${sessionScope.UserID}" == element['USERID'])//씨큐리티 미 사용시 (본인인경우)
					comments += "<span class='commentEdit' title='"+element['REC_COM_NO']+"' style='cursor:pointer'>"
							+ element['CONTENT'] + '</span></td>';
				else
					//타인이 보는경우
					comments += element['CONTENT'] + "</td>";
	
				//좋아요
				comments += '<td rowspan="2" style="text-align: right; vertical-align: middle;" ><div class="like"><a href="#" class="like"><i class="far fa-heart" style="color: #797979;"></i></a></div></td></tr>'
	
				//날짜
				comments += "<tr><td>" + element['POSTDATE']
						+ "&nbsp;";
	
				if ("${sessionScope.UserID}" == element['USERID'])
					comments += "<span class='commentDelete' title='"+element['REC_COM_NO']+"' style='cursor:pointer'>삭제</span>";
				else
					comments += "<span style='color:gray;font-size:.7em'></span>";
				comments += "</td></tr>";
			});

		comments += "</tbody></table>";

		$('#comments').html(comments);

		//반드시 showComments_() 함수 안에
		//코멘트 제목 클릭시 코멘트 수정처리를 위한 UI변경부분]	
		$(".commentEdit").click(function() {
			console.log('클릭한 댓글의 키값(REC_COM_NO):', $(this).attr('title'));
			//클릭한 제목으로 텍스트박스 값 설정
			$('#title').val($(this).html());
			//버튼은 등록에서 수정으로
			$('#submit').val('수정');
			//form의 hidden속성중 name="cno"값 설정
			$('input[name=rec_com_no]').val($(this).attr('title'));
		});

		//코멘트 삭제 처리]
		$(".commentDelete").click(function() {
			$.ajax({
				url : "<c:url value='/RecipeBBS/Comment/delete.do'/>",
				data : {
					"rec_com_no" : $(this).attr('title'),
					"_csrf" : "${_csrf.token}"
				},
				dataType : 'text',
				type : 'post',
				success : function() {
					showComments();
				}
			});

		});

	}////////////////////	
	function isDelete() {
		if (confirm("정말로 삭제 하시겠습니까?")) {
			location
					.replace("<c:url value='/RecipeBBS/delete.do?rec_no=${recipe.rec_no}'/>");
		}
	}////////////isDelete
	
	
	
	

// 좋아요 버튼 처리
// 버튼 클릭 > ajax통신 (like url로 전달) > views의 like 메소드에서 리턴하는 값 전달받기 > 성공시 콜백 호출
	$('#heart').click(function(){
		if($('#heart').attr("class") == 'far fa-heart'){//좋아요 클릭했을때
			$('#heart').attr("class",'fas fa-heart');
			$('#heart').attr('style','color:#F3D55A');
			 $.ajax({
                 url:"<c:url value='/RecipeBBS/Like/addheart.do'/>",
                 data:{"rec_no":for_no},//게시글번호 전송
                 dataType:'text',
                 type:'post',
                 success:function(data){            
               	  
                 },
                 error:function(e){console.log(e);}                 
              });
			
			
		}
		else{//좋아요 취소
			$('#heart').attr("class",'far fa-heart');
			$('#heart').attr('style','color:#797979');
			$.ajax({
                url:"<c:url value='/RecipeBBS/Like/deleteheart.do'/>",
                data:{"rec_no":for_no},
                dataType:'text',
                type:'post',
                success:function(data){            
              	  
                },
                error:function(e){console.log(e);}                 
             });
		}
		
	});
	
	
	// 스크랩 버튼 처리
		$('#mark').click(function(){
			if($('#mark').attr("class") == 'far fa-bookmark'){//좋아요 클릭했을때
				$('#mark').attr("class",'fas fa-bookmark');
				$('#mark').attr('style','color:#F3D55A');
				 $.ajax({
	                 url:"<c:url value='/RecipeBBS/Like/addheart.do'/>",
	                 data:{"rec_no":for_no},//게시글번호 전송
	                 dataType:'text',
	                 type:'post',
	                 success:function(data){            
	               	  
	                 },
	                 error:function(e){console.log(e);}                 
	              });
				
				
			}
			else{//좋아요 취소
				$('#mark').attr("class",'far fa-bookmark');
				$('#mark').attr('style','color:#797979');
				$.ajax({
	                url:"<c:url value='/RecipeBBS/Like/deleteheart.do'/>",
	                data:{"rec_no":for_no},
	                dataType:'text',
	                type:'post',
	                success:function(data){            
	              	  
	                },
	                error:function(e){console.log(e);}                 
	             });
			}
			
		});	
	
	
	
	
	
	
	
	
	
	
</script>
