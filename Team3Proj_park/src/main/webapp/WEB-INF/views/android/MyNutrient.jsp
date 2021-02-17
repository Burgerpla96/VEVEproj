<%@ page language="java" contentType="text/html; charset=EUC-KR"
   pageEncoding="EUC-KR"%>
<script
   src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script
   src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script
   src="https://cdn.jsdelivr.net/npm/@tensorflow/tfjs@1.3.1/dist/tf.min.js"></script>
<script
   src="https://cdn.jsdelivr.net/npm/@teachablemachine/image@0.8/dist/teachablemachine-image.min.js"></script>

  <!-- 부트스트랩 4.5.2 --> <!--부트스트랩4 튜토리얼 : https://www.w3schools.com/bootstrap4/default.asp-->
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
   
   <!-- 전체 jquery 필수 -->
   <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
   <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">   

   
  <!-- datepicker
  <link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css"> -->
  <!-- datepicker js -->
  <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>   
   
<div class="col-md-12">
   <div class="col-md-12">
      단백질
      <div class="progress">
         <div id="todayProtein" class="progress-bar progress-bar-striped"
            style="width: ${strproteinPercent}%"></div>
      </div>
      <br> 비타민B12
      <div class="progress">
         <div id="todayB12"
            class="progress-bar bg-success progress-bar-striped progress-bar-animated"
            style="width: ${strbPercent}%"></div>
      </div>
      <br> 비타민D
      <div class="progress">
         <div id="todayD"
            class="progress-bar bg-info progress-bar-striped progress-bar-animated"
            style="width: ${strdPercent}%"></div>
      </div>
      <br> 아연
      <div class="progress">
         <div id="todayAyen"
            class="progress-bar bg-warning progress-bar-striped progress-bar-animated"
            style="width: ${strzincPercent}%"></div>
      </div>
      <br> 칼슘
      <div class="progress">
         <div id="todayCal"
            class="progress-bar bg-danger progress-bar-striped progress-bar-animated"
            style="width: ${strcalPercent}%"></div>
      </div>
   </div>
</div>