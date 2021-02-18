<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <link rel="icon" type="image/png" href="/veve/resources/assets_admin/img/veve_admin_favicon.png">
  <title>VEVE</title>
  <meta name="description" content="">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  

  <!-- 부트스트랩 4.5.2 --> <!--부트스트랩4 튜토리얼 : https://www.w3schools.com/bootstrap4/default.asp-->
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  
  
  
  <!--아이콘(폰트어썸)-->
  <script src="https://kit.fontawesome.com/01f3b3b8bd.js" crossorigin="anonymous"></script>
  <!-- owl 캐러셀 -->
  <link rel="stylesheet" href="<c:url value="/resources/assets/css/owl.carousel.min.css"/>">
  <link rel="stylesheet" href="<c:url value="/resources/assets/css/owl.theme.default.min.css"/>">
  <!-- summernote -->
  <link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
  
  <!-- CSS -->
  <link rel="stylesheet" href="<c:url value="/resources/assets/css/style.css"/>"><!-- 템플릿 베이직 CSS -->
  <link rel="stylesheet" href="<c:url value="/resources/assets/css/nav.css"/>"><!-- 네비게이션바 CSS-->
  <link rel="stylesheet" href="<c:url value="/resources/assets/css/owl.css"/>"><!-- owl캐러셀 CSS-->
  

   
   <!-- 전체 jquery 필수 -->
   <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
   <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">   

   
  <!-- datepicker
  <link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css"> -->
  <!-- datepicker js -->
  <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
  
    
  


  

</head>
<body>




<script>
/*
   function isLogin(){
   //ajax로 요청-로그인 여부 판단
   $.ajax({
      url:"<c:url value='/Member/Auth/IsLogin.do'/>",
      dataType:'json',
      success:function(data){
         if(data.isLogin =='YES')//로그인 되었다면
            //목록페이지로 이동
            location.replace("<c:url value='/BBS/List.do'/>");
         else{//로그인 안되었다면
            alert("로그인 후 이용하세요");
            location.replace("<c:url value="/Member/Auth/Login.do"/>");
            
         }
            
      },
      error:function(e){console.log(e);}
      
   });
   
   }
   */

   function logout(){
      //location.replace("<c:url value="/OneMemo/Auth/Logout.do"/>");
      $('#logoutForm').submit();//스프링 씨큐리티의 csrf공격 사용시
   }
   function login(){
      alert("로그인 후 이용하세요");
      $('#islogin').get(0).click();
   }

</script>

<!-- 로그아웃 GET->POST방식으로 변경하기 위한 폼 추가 -->
<form id="logoutForm" method="post"
   action="<c:url value="/Member/Auth/Logout.do"/>">
   <input type="hidden" name="${_csrf.parameterName}"
      value="${_csrf.token}" />
</form>


    <!-- 네비게이션바 -->
    <nav class="navbar" style="z-index: 9">
        <div class="content text-center">
          <div class="logo">
            <a href="<c:url value="/"/>"><img src="<c:url value="/resources/assets/images/로고.png"/>" alt=""></a>
          </div>
          <div class="logo2">
            <a href="<c:url value="/"/>"><img src="<c:url value="/resources/assets/images/로고2.png"/>" alt=""></a>
          </div>

            <ul class="menu-list">
                <div class="icon cancel-btn">
                <i class="fas fa-times"></i>
                </div>
                <li><a href="<c:url value="/"/>">홈</a></li>
                <c:if test="${empty UserID}" var="IsLogin">
                <li><a href="javascript:login()">베지식단 코칭</a>
                <li><a href="javascript:login()">베지맛집 찾기</a></li>
                </c:if>
                <c:if test="${! IsLogin}">
                   <li><a href="<c:url value="/Member/MemberDiet.do"/>">베지식단 코칭</a>
                   <li><a href="<c:url value="/Board/Restaurant.do"/>">베지맛집 찾기</a></li>
                </c:if>
                <li><a href="<c:url value="/recipe.do"/>">채식 레시피</a></li>
                <li><a href="<c:url value="/Gallary/List.do"/>">커뮤니티</a></li>
                <li><a href="<c:url value="/Board/Notice/NoticeList.do"/>">공지사항</a></li>
            <a id="islogin" href="<c:url value="/Member/Auth/Login.do"/>" hidden="" ></a>
            </ul>



       <c:if test="${empty KakaoUserId}" var="isNotKakaologin">
       <!-- 
       <sec:authorize access="isAnonymous()">
          <div class="login">
            <button><a href="<c:url value="/Member/Auth/Login.do"/>" class="btn btn-nav"><i class="fas fa-user"></i>&nbsp;&nbsp;Login</a></button>
          </div>         
          </sec:authorize>
           -->
          <sec:authorize access="isAuthenticated()">
             <c:if test="${empty Admin}">
                 <button><a href="<c:url value="/Member/MyHome.do"/>" class="btn btn-nav"><i class="fas fa-user"></i>&nbsp;&nbsp;마이홈</a></button>   
            </c:if>
            <c:if test="${!empty Admin}">
                 <button><a href="<c:url value="/Admin/Main.do"/>" class="btn btn-nav"><i class="fas fa-user"></i>&nbsp;&nbsp;Admin</a></button>   
             </c:if>
          </sec:authorize>
          </c:if>
          <c:if test="${not isNotKakaologin }">
             <button><a href="<c:url value="/Member/MyHome.do"/>" class="btn btn-nav"><i class="fas fa-user"></i>&nbsp;&nbsp;MyHome</a></button>  
          </c:if>
    
          <div class="icon menu-btn">
            <i class="fas fa-bars"></i>
          </div>
    
          
    
        </div>
      </nav>
    <!-- 네비게이션바 끝 -->



<!-- 에러 화면 시작 -->
<div class="complete text-center">
    <div class="roomy-200">
        <img class="character" src="<c:url value="/resources/assets/images/캐릭터.jpg"/>" alt="캐릭터">
        <h1>ERROR</h1>
        <p>관리자에게 문의해주세요.</p>
        
    <button type="submit" class="btn btn-complete m-top-20 m-bottom-20" onClick="history.go(-1);">이전 페이지로 이동</button>
    </div>
</div>






<!------------------------------------------------------------ chatbot -->
<!-- 챗봇 스타일 -->
<link rel="stylesheet" href="<c:url value="/resources/chatbot/chatbot_style.css"/>">

<!-- 챗봇 다이브 -->
<div id="chatbot_container">
   <!-- chatbot_header -->
   <div id="chatbot_header">
      <img id="vevebot_icon" src="/veve/resources/chatbot/VEVE_chatbot2.jpg" alt="베베봇"/>
      <div id="chatbot_name"><strong>베베봇</strong></div>
      <div id="chatbot_header_close">
         <svg height="20" width="20">
             <line x1="1" y1="19"  x2="19" y2="1"   stroke="white"  stroke-width="3"/>
             <line x1="1" y1="1"   x2="19" y2="19"   stroke="white"   stroke-width="3"/>
         </svg>
      </div>
   </div><!-- chatbot_header -->
   
   <!-- chatbot_chatlog -->
   <div id="chatbot_chatlog">
      <ul class="chatbot__messages">
         <li class="is-ai">
            <span class="chatbot__arrow chatbot__arrow--left"></span>
            <p class='chatbot__message'>
               안녕하세요? 베베봇이에요! 😀<br/>
               저는 비건등급, 중요 영양소, 홈페이지 기능을 알려드릴 수 있어요~
            </p>
         </li>
         <!-- 대화가 추가되는 곳 -->
      </ul>
   </div><!-- chatbot_chatlog -->
   
   <!-- chatbot_input -->
   <div id="chatbot_input">
      <input type="text" placeholder="질문을  써주세요." id="query"/>
      <img id="send_message_icon" src="/veve/resources/chatbot/send_message_icon.png" alt="보내기 이미지"/>
   </div><!-- chatbot_input -->
  
</div><!-- chatbot_container -->

<!-- 챗봇, 채팅 js -->
<script src="<c:url value="/resources/chatbot/chatbot.js"/>"></script>

<!-- 우측 하단의 버튼 -->
<c:if test="${empty UserID}" var="IsLogin">
<a href="javascript:login()">
   <img id="userChat_img" src="/veve/resources/chatbot/VEVE_userchat2.jpg" alt="유저  채팅 이미지"/>
</a>
</c:if>
<c:if test="${! IsLogin}">
<a href="javascript:openChatPop('<c:url value="/chatting/WebSocket.do"/>', 'userChat');">
   <img id="userChat_img" src="/veve/resources/chatbot/VEVE_userchat2.jpg" alt="유저  채팅 이미지"/>
</a>
</c:if>

<img id="chatbot_img" src="/veve/resources/chatbot/VEVE_chatbot1.jpg" alt="베베봇"/>
<!--  
<img id="chatbot_img" src="/veve/resources/chatbot/VEVEbot.png" alt="베베봇"
   onmouseover="this.src='/veve/resources/chatbot/VEVEbot_hover.png'" 
   onmouseout="this.src='/veve/resources/chatbot/VEVEbot.png'" />
-->
<!-- ----------------------------------------------------------chatbot -->




<!-- footer -->
<section class="footer bg-black roomy-40">
        
    <div class="main_footer fix bg-mega text-center p-bottom-30">
        <div class="col-md-12">
            <p class="wow fadeInRight" data-wow-duration="1s">
                <a target="_blank" href="#">3조</a> 
                2020. All Rights Reserved
            </p>
        </div>
    </div>
</section>
<!-- footer 끝 -->






<!-- 부트스트랩 4.5.2 플러그인들 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<!-- summernote -->
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>

<!-- owl 캐러셀 -->
<script src="<c:url value="/resources/assets/js/owl.carousel.min.js"/>"></script>

<!-- 커스텀 js -->
<script src="<c:url value="/resources/assets/js/nav.js"/>"></script><!--네비게이션 바-->
<script src="<c:url value="/resources/assets/js/day.js"/>"></script><!--메인화면 요일 표기-->
<script src="<c:url value="/resources/assets/js/rolling.js"/>"></script><!--메인화면 채식메뉴 롤링-->
<script src="<c:url value="/resources/assets/js/carousel.js"/>"></script><!--캐러셀 -->




</body>
</html>