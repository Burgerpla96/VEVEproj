<%@ page contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<!-- 회원가입 완료화면 -->
<div class="complete text-center">
    <div class="roomy-200">
        <img class="character" src="<c:url value="/resources/assets/images/캐릭터.jpg"/>" alt="캐릭터">
        <h1>베리베지 회원가입을 환영합니다!</h1>
        <p>가입하신 아이디로 로그인하고 VERY VEGGI.의 다양한 서비스를 이용해보세요.<br/>당신의 건강한 채식라이프를 언제나 응원합니다 :)</p>
        
    <button type="submit" class="btn btn-complete m-top-20 m-bottom-20" onclick = "location.href = '<c:url value="/Member/Auth/Login.do"/>' ">로그인 페이지로 이동</button>
    </div>
</div>
<!-- 회원가입 완료화면 끝 -->
    