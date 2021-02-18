<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html lang="ko">
<head>
<meta charset="utf-8">
<link rel="icon" type="image/png" href="/veve/resources/assets_admin/img/veve_admin_favicon.png">
<title>VEVE-TALK</title>
<style>
#send_message_icon{
	cursor: pointer;
}
#send_message_icon:hover{
	-webkit-filter: opacity(.5) drop-shadow(0 0 0 gray);
	filter: opacity(.5) drop-shadow(0 0 0 gray);
}

</style>
</head>

<body onresize="parent.resizeTo(550,725)" onload="parent.resizeTo(550,725)">
<!-- jq -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">	
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link rel="stylesheet" href="<c:url value="/resources/assets/css/style.css"/>"><!-- 템플릿 베이직 CSS -->
<link href="/veve/resources/assets/css/websocket.css" rel="stylesheet">


<section class="logobar bg-black roomy-15">
    <div class="container">
        <div class="logo2" style="text-align: right; margin-right:14px;">
            <img src="<c:url value="/resources/assets/images/로고2.png"/>" alt="로고" >
        </div>
    </div>
</section>


<section class="introduce">
    <div class="container">
        <div class="sign-title m-top-40">
            <h3 style="margin-bottom:0;"><strong>베베톡 채팅 (VEVE-TALK)</strong></h3>
        </div>
    </div>
</section>


<div class="container">

	<fieldset>
		<p style="text-align: right; padding:0; margin-bottom:-10px;"> 현재 참여자 수 : <span id="connectionMemberCount" style="color:#00a885"></span></p>
		<p style="text-align: right"> 닉네임: <span id="nickname">${nickname}</span> </p>
		
        <div id="chatArea">
        	<div id="chatMessage" style="height: 350px; border-radius:6px; overflow: auto; background:url(<c:url value="/resources/assets/images/베베톡배경.jpg"/>) no-repeat 0 0;background-size:100% auto; background-position:center;"></div>
        </div> <!-- overflow 내용이 많으면 자동으로 스크롤바가 생긴다. -->


		<form>​
			<div class="form-group">
				<div class="col-xs-5" style="text-align: center;">
					<input class="form-control" type="text" id="message" placeholder="전송할 내용을 입력해주세요 :)"/>
					<img id="send_message_icon" src="/veve/resources/chatbot/send_message_icon.png" alt="보내기 이미지" style="width:28px;height:auto; position: absolute;left:477px;top:563px;"/>
				</div>
				<input type="text" style="display:none;"/> <!-- 의미없는 텍스트 박스 -->
			</div>
		</form>

	
		​
	</fieldset>
</div><!-- container -->


<!-- pure speech bubble로 검색 -->
<!-- codepen 사이트에서 가져온다. -->
<script>
	var wsocket;//웹 소켓 저장용
	var nickname;//닉네임 저장용
	var time;//시간 출력 저장용
	
	//서버와 연결된 소켓 클라이언트 생성
	$(document).ready(function(){
		wsocket = new WebSocket("ws://localhost:8080<c:url value='/chat-ws.do'/>");
		//서버와 연결된 소켓에 이벤트 등록(open,close,message,error)
		wsocket.onopen = open;
		wsocket.onclose=function(){
			appendServerMessage('연결이 끊어졌어요.');
		};
		wsocket.addEventListener('message',receiveMessage);
		wsocket.onerror=function(e){
			console.log('에러발생: '+e);
		};
		
	});
	
	
	//퇴장 버튼 클릭시
	$('#exitBtn').one('click',function(){
		//서버로 메세지를 보내는 메서드 send()
		wsocket.send('ser: '+nickname+'가(이) 퇴장했어요.');
		wsocket.close();
	});
	
	
	//전송버튼 이벤트 처리-클릭시
	$('#send_message_icon').click(function(){
		sendMessage();
	});
	//전송버튼 이벤트 처리-enter입력시
	$('#message').on('keypress',function(e){
		//브라우저마다 다른 엔터 입력값 처리를 위해 e.keyCode,e.which 모두 처리해준다.
		console.log('e.keyCode: %s, e.which: %s',e.keyCode, e.which);
		var keyValue = e.keyCode ? e.keyCode : e.which;
		if(keyValue == 13) {//enter 입력시
			sendMessage();
		}
	});
	
	
	
	/////////////////////////////////////////////////함수 정의
	//서버에 연결되었을 때 호출되는 함수
	var open = function(){
		//연결시 닉네임 전송
		//사용자가 입력한 닉네임 저장
		nickname = $('#nickname').html();
		wsocket.send('ser: '+nickname+"님이 입장했어요.");
		appendServerMessage('연결이 되었어요.');
		$('#nickname').html();
	};
	
	//서버의 메세지를 뿌려주기 위한 함수
	var appendServerMessage =function(msg){
       $('#chatMessage').append("<div style='clear:both;text-align:center; color:white; background-color: #ffF3D55A; margin-top:10px; margin-bottom:10px; padding:10px'>" + msg + "</div>");
       $("#chatMessage").scrollTop($("#chatMessage")[0].scrollHeight);//스크롤 내리기
    };
    //상대방의 닉네임을 뿌려주기 위한 함수
    var appendNickname = function(nickname){
    	$('#chatMessage').append(
   			"<div style='margin-top:13px;clear:both;'>"+
   				"&nbsp;&nbsp;<span style='padding:5px;background:#ffF3D55A ;color:white;border-radius: 9px;'>"+nickname+"</span>"+
   			"</div>");
    };
	//메시지를 DIV태그에 뿌려주기 위한 함수
    var appendMessage =function(msg){
       $('#chatMessage').append(
	  		   "<div style='text-align:left; width:100%;clear:both;'>"+
	  		   		"<div class='balloon test_3' style='float: left;'>" + 
	  		   			"<span>" + msg + "</span>" +
	  		   		"</div>"+
	  		   		"<div style='position: relative; bottom: -27px;color:white;font-size: 7px;'>"+time+"</div>"+
	  		   "</div>");
       $("#chatMessage").scrollTop($("#chatMessage")[0].scrollHeight);//스크롤 내리기
    };
    //나의 메시지를 출력하기 위한 함수
    var appendMyMessage = function(msg){
       $('#chatMessage').append(
    			"<div style='text-align:right; width:100%;clear:both;'>"+
    				"<div class='balloon test_4' style='float: right;'>" + 
    					"<span>" + msg + "</span>"  + 
    				"</div>"+
    				"<div style='position: relative;color:white; bottom: -27px;font-size: 7px'>"+time+"</div>"+
    			"</div>");
       $("#chatMessage").scrollTop($("#chatMessage")[0].scrollHeight);//스크롤 내리기
    };
   
    
	
	//서버에서 메세지를 받을 때의 함수
	var receiveMessage = function(e){//e는 message 이벤트 객체
		//서버로 부터 받은 데이터는 이벤트 객체(e).data속성에 저장되어 있다.
		var receiveData = e.data;
		if(receiveData.substring(0,4)=='msg:'){//대화 출력
			var nicknameAndMessage = receiveData.substring(4).split(":");
			appendNickname(nicknameAndMessage[0]);
			appendMessage(nicknameAndMessage[1]);
			return;
		}
		if(receiveData.substring(0,4)=='ser:'){//server 메세지 출력
			appendServerMessage(receiveData.substring(4));
			return;
		}
		if(receiveData.substring(0,5)=='time:'){//시간 표출
			time = receiveData.substring(5);
			return;
		}
		if(receiveData.substring(0,6)=='total:'){//총 인원수 출력
			$('#connectionMemberCount').html(receiveData.substring(6));
			return;
		}
		
	};
	
	
	//서버로 메세지를 전송하는 함수
	function sendMessage(){
		if($('#message').val().trim()!=""){
			//서버로 메세지 전송
			wsocket.send("msg: "+nickname+':'+$('#message').val()); //msg:Superman:안녕
			//div(대화영역)에 메세지 출력
			appendMyMessage($('#message').val());
			//기존 메세지 클리어
			$('#message').val("");
			$('#message').focus();
			
		}
		else{
			$('#message').val("");
			$('#message').focus();
		}
		
	};
	
</script>

</body>
</html>
