﻿<!DOCTYPE html>

<html lang="en">

    <head>

        <meta charset="UTF-8"/>

        <title>Moodle Video Platform</title>
      	
      	<link href="http://www.jq22.com/jquery/bootstrap-3.3.4.css" rel="stylesheet">
      	<script src="http://www.jq22.com/jquery/1.11.1/jquery.min.js"></script>

        <link href="/moodlevideo/css/pure-min.css" rel="stylesheet">

        <link href="/moodlevideo/css/main.css" rel="stylesheet">
        
        <script src="http://apps.bdimg.com/libs/jquery/2.1.4/jquery.js"></script>

        <script src="/moodlevideo/js/jquery-1.9.0.min.js"></script>

        <script src="/moodlevideo/js/main.js" type="text/javascript"></script>
        
        <script src="/moodlevideo/js/videoAnimation.js" type="text/javascript"></script>
        
        <link href="/moodlevideo/css/star-rating.css" media="all" rel="stylesheet" type="text/css"/>

        <script src="/moodlevideo/js/star-rating.js" type="text/javascript"></script>

	<script src="/moodlevideo/js/recorder.js"></script>
<!--  you can use recorder1.js or recorder2.js for half size of wav and recorder3.js for 1/4 size of wav file-->
        <!--  <script src="/moodlevideo/js/audio.js"></script>-->

        <script src="/moodlevideo/js/wav2mp3.js"></script>
        
       <script type="text/javascript">

       function show_video()
       {
    	   var v =document.getElementById("video");
    	   v.style.display="block";
    	   var s =document.getElementById("show_btn");
    	   s.style.display="none";
    	   var h =document.getElementById("hidden_btn");
    	   h.style.display="block";
       }
       function hidden_video()
       {
    	   var v =document.getElementById("video");
    	   v.style.display="none";
    	   var s =document.getElementById("show_btn");
    	   s.style.display="block";
    	   var h =document.getElementById("hidden_btn");
    	   h.style.display="none";
       }
       
      
       
       </script>
       
      
       
       <style type="text/css">
       #contentHolder{position:relative;top:100px;left:150pxx;}
       #video{position: absolute;top:15%;left:6%;}
       #show_btn{position: absolute;top:40%;left:10%;}
       #hidden_btn{position: absolute;top:40%;left:10%;}
       #canvas{display:none;}
       #btn{margin:0 auto;}
       </style>
       
        
    </head>

    <body onfocus="getFocus()" onblur="Empty_Focus()">
    <div class="container">
    <img src="/moodlevideo/images/bg.jpg" onload="rcOpen(this,'${recommendList}')" class="bg" /> 
	    <div class="top">
			<a class="topL"href="videoheatmap">${login_username}(${login_userid})</a>
	        <a class="topC"href="videorank">本周视频观看排行榜</a>
	       	<a class="topR"href="${video_moodle_url}">返回平台</a>
	    </div>

    			<video id="video" width="170" height="170	" autoplay ></video>  
    			<canvas id="canvas" width="640" height="480"></canvas>
    			<button id="show_btn" style="display:none"  class="btn btn-primary" onclick="show_video()">显示</button>
   				 <button id="hidden_btn" class="btn btn-primary" onclick="hidden_video()">隐藏</button>
            	
	    <div class="mid">
			<div class="des"> 	
				<div class="desOut" onmouseover="dsc_view(this,'${video_description}')"onmouseout="dsc_hide(this)">课程简介</div>
		    </div>
		    
	    	<div class="wrapper">
		        <div class="pure-g">
		            <div class="pure-u-1">
		                <div class="player">
		                    <video  id="player" width="100%">
		                    
		                        <source src="http://software-moodle.oss-cn-qingdao.aliyuncs.com/moodle_vedio/${video_url}.mp4" type="video/mp4"></source>		                        
		                    </video>
		
		                    <div class="pure-g" id="controller">
		                        <div class="pure-u-1-12">
		                            <span id="play" class="icon icon-play"></span>
		                            <span id="stop" class="icon icon-stop"></span>
		                        </div>
		                        <div class="pure-u-13-24 overflow-h">
		                            <div id="progressBar" class="controlBar">
		                                <div id="innerBar" class="controlInner"></div>
		                            </div>
		                        </div>
		                        <div class="pure-u-1-4">
		                            <span id="timer">0:00</span>
		                            <span id="volume" class="icon icon-volume"></span>
		                            <div id="volume-control" class="controlBar">
		                                <div id="volume-inner" class="controlInner"></div>
		                            </div>
		                        </div>
		                        <div class="pure-u-1-8 overflow-h">
		                            <span id="expand" class="icon icon-expand"></span>   
		                        </div>
		                    </div>
	                	</div>
	            	</div>
	       		</div>
	        	<div class="pure-g">
	          		<div class="pure-u-1">
	            	<input type="file" id="file">
	            	<input id="temp_userid" type="hidden" name="stu" value="${login_userid}">
	            	<input id="temp_sectionid" type="hidden" value="${video_url}">
	            	</div>
	        	</div>
			</div>
		</div>

		<div class="right">
			<div class="rcmd">
			<font  class="rcmdTip" id ='rcmdTip'>猜你想看</font>
			
			</div>
			
		</div>
	
		
		<!-- <div class="right">
			<div class="rcmd">
			<font  class="rcmdTip" id ='comment'>评论</font>
			</div>
		</div> -->
		<div class="bottom">
		    <div class="rate">		
		    	<div class="tip">难度打分</div>       	
		        <div class="star">
		            	<input id="input-grade" value="2" type="number" class="rating" min=0 max=5 step=0.5 data-size="md" >
		        </div>
		            <button id="ibt_button" type="submit" class="btn btn-primary" onclick="star()">提交评价</button>
		            
        	</div>
        </div>
    </div>

<script type="text/javascript">
function star()
{
	document.getElementById("ibt_button").disabled="disabled";	
	//alert('3');
	 var post_url = '/moodlevideo/videojob/rating';
     
     var video_time = getNowVideoPageTime(openPageTime); // 获取页面打开时间
     var current_time = getNowFormatDate();
     var star_grade = document.getElementById("input-grade").value;
     //alert(star_grade);
     // 打分（评星）事件
     if(cookie_sectionid!=null && cookie_sectionid!=""){
		alert(cookie_userid);
         $.ajax({
             url: post_url,
             type: 'post',
             dataType: 'json',
             data: { userid: cookie_userid, sectionid: cookie_sectionid,
                  videotime: video_time, happentime: current_time, 
                  stargrade: star_grade },
             error:function(){
                 alert('ibt_button ajax post_request error!');
             },
             success:function(data){
                 //alert('success');
                 console.log(data);
                 //alert(data.Hello);
             }
         })
     }
}

</script>
   
	
	<script type="text/javascript">
        var aVideo=document.getElementById('video');
        var aCanvas=document.getElementById('canvas');  
        var ctx=aCanvas.getContext('2d');
        navigator.getUserMedia  = navigator.getUserMedia ||  
                          navigator.webkitGetUserMedia ||  
                          navigator.mozGetUserMedia ||  
                          navigator.msGetUserMedia|| window.getUserMedia;
        navigator.getUserMedia({video:true}, gotStream, noStream);  //Ã¥ÂÂÃ¦ÂÂ°1Ã¨ÂÂ·Ã¥ÂÂÃ§ÂÂ¨Ã¦ÂÂ·Ã¦ÂÂÃ¥Â¼ÂÃ¦ÂÂÃ©ÂÂÃ¯Â¼ÂÃ¥ÂÂÃ¦ÂÂ°Ã¤ÂºÂÃ¦ÂÂÃ¥ÂÂÃ¦ÂÂÃ¥Â¼ÂÃ¥ÂÂÃ¨Â°ÂÃ§ÂÂ¨Ã¯Â¼ÂÃ¥Â¹Â¶Ã¤Â¼Â Ã¤Â¸ÂÃ¤Â¸ÂªÃ¨Â§ÂÃ©Â¢ÂÃ¦ÂµÂÃ¥Â¯Â¹Ã¨Â±Â¡Ã¯Â¼ÂÃ¥ÂÂÃ¦ÂÂ°Ã¤Â¸ÂÃ¦ÂÂÃ¥Â¼ÂÃ¥Â¤Â±Ã¨Â´Â¥Ã¥ÂÂÃ¨Â°ÂÃ§ÂÂ¨Ã¯Â¼ÂÃ¤Â¼Â Ã©ÂÂÃ¨Â¯Â¯Ã¤Â¿Â¡Ã¦ÂÂ¯
        function gotStream(stream) {  
            video.src = URL.createObjectURL(stream);  
            video.onerror = function () {  
              stream.stop();  
            };  
            stream.onended = noStream;  
            video.onloadedmetadata = function () {  
              //alert('Ã¦ÂÂÃ¥ÂÂÃ¦ÂÂÃ¥Â¼ÂÃ¯Â¼Â');  
            };  
        }  
        function noStream(err) {  
            alert(err);  
      }  

      var cnt=0;
      setInterval("pictures()", 15000);

      function pictures() {
          ctx.drawImage(aVideo, 0, 0, 500, 500);
          var imgData = aCanvas.toDataURL("image/png");
          //alert(imgData);
          var user_tmp=document.getElementById('temp_userid');
          var user=user_tmp.value;
         // alert(user);
          var video_tmp=document.getElementById('temp_sectionid');
          var video=video_tmp.value;
          //var video=${video_url};
          var base64Data = imgData.split(",")[1];
          
          $.ajax({  
              type : "POST",  
              url : '${pageContext.request.contextPath}/videojob/uploadPic',  
              data : {"data1":imgData,"user":user,"video":video},  
              timeout : 60000,  
              success : function(data){
            	  if("1" != data) {
            		  alert("格式错误");
            	  }
              }  
          });
          
      }
</script>
    
 <script>
  function __log(e, data) {
    log.innerHTML += "\n" + e + " " + (data || '');
  }
  var audio_context;
  var input;
  var recorder;
  var flag_watching = 0;//用户是否在看视频
  var audio_duration_eachtime = 59000;//每次录音长度
  
  function startUserMedia(stream) {
    input = audio_context.createMediaStreamSource(stream);
    __log('Media stream created.');
    recorder = new Recorder(input);
    
    document.getElementById('play').onclick=startRecording;
    
    self.setInterval("clock()",5*60000);//多久录一次
    window.setTimeout("clock()",20000);
    __log('Recorder initialised.');
  }
  
  //定时执行
  function clock(){
	if(flag_watching == 0){return;}
	//alert("开始录音");
	recorder && recorder.record();
	window.setTimeout(function(){
	 // alert("停止录音");
	  recorder && recorder.stop();
	  saveFile();
	  recorder.clear();
		},audio_duration_eachtime);
  }
  function startRecording(button) {
	flag_watching = 1;
  }

  function saveFile() {
    recorder && recorder.exportWAV(function(blob) {
      //wav2mp3(blob, send(blob));
      send(blob);
      
    });
  }
  
  //发送音频
  function send(blob) {
    //  alert("正在发送");
      var xhr = new XMLHttpRequest(),
      fd = new FormData();
      fd.append( 'file', blob);
      
      var date = new Date();
      
     // fd.append( 'filename', date+".wav");
     // fd.append( 'userid', 1600022704);
     // fd.append( 'sectionid', "testsectionid");
     // fd.append( 'videotime_finish', "17:77");
     // fd.append( 'videotime_duration', audio_duration_eachtime/1000);   
     
      var user_tmp=document.getElementById('temp_userid');
      var user=user_tmp.value;
     // alert(user);
      var video_tmp=document.getElementById('temp_sectionid');
      var video=video_tmp.value;
    //  alert(video);
      fd.append( 'filename', user+"_"+video+"_"+getNowVideoTime()+".wav");
      fd.append( 'userid', user);
      fd.append( 'sectionid', video);
      fd.append( 'videotime_finish', getNowVideoTime());
      fd.append( 'videotime_duration', audio_duration_eachtime/1000);//second 
      
/*       xhr.onreadystatechange = function(){
       var b = xhr.responseText;  
	      if(xhr.readyState == 4 && xhr.status == 200){    
	          alert(b);
	      }
      } */
      
      xhr.open('POST', "http://101.201.68.238/audio/upload.php");
      xhr.send( fd );
     // alert("发送成功");
	  } 
  window.onload = function init() {
    try {
      // webkit shim
      window.AudioContext = window.AudioContext || window.webkitAudioContext;
      navigator.getUserMedia = navigator.getUserMedia || navigator.webkitGetUserMedia;
      window.URL = window.URL || window.webkitURL;
      
      audio_context = new AudioContext;
      __log('Audio context set up.');
      __log('navigator.getUserMedia ' + (navigator.getUserMedia ? 'available.' : 'not present!'));
    } catch (e) {
      alert('No web audio support in this browser!');
    }
    
    navigator.getUserMedia({audio: true}, startUserMedia, function(e) {
      __log('No live audio input: ' + e);
    });
  };
  
</script>
    
    
      <pre id="log" style="display:none;"></pre>
    
    </body>

</html>
