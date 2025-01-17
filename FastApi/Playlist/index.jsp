<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Music Player Design </title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    
    <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
    
</head>
<body>

  <%

  String title  = null;
  String artist = null;

  title   = request.getParameter("title") == null ? "": request.getParameter("title");
  artist  = request.getParameter("artist") == null ? "": request.getParameter("artist");

  %>

<style>
 :root {
  --primary-clr: rgba(228, 228, 229, 1);
  --secondary-clr: rgba(163, 162, 164, 0.9);
}

* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
  font-family: "Nunito", sans-serif;
}

body {
  display: flex;
  align-items: center;
  justify-content: center;
  min-height: 100vh;
  width: 100%;
  background: linear-gradient(90deg, rgba(73,67,115,1) 0%, rgba(98,60,99,1) 45%, rgba(85,128,122,1) 95%);
  background-repeat: no-repeat;
  backdrop-filter: blur(8px);
  -webkit-backdrop-filter: blur(8px);
}

.container {
  display: flex;
  justify-content: center;
  align-items: center;
  width: 100%;
  color: var(--primary-clr);
}

.music-player {
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  background: rgba(4, 68, 105, 1);
  color: var(--primary-clr);
  width: 380px;
  padding: 25px 35px;
  border-radius: 20px;
}

.music-player h1 {
  font-size: 1.5rem;
  font-weight: 600;
}

.music-player p {
  font-size: 1rem;
  font-weight: 400;
  opacity: 0.6;
}

#progress {
  -webkit-appearance: none;
  width: 100%;
  height: 7px;
  background: var(--secondary-clr);
  border-radius: 4px;
  cursor: pointer;
  margin: 32px 0;
}

#progress::-webkit-slider-thumb {
  -webkit-appearance: none;
  background: var(--secondary-clr);
  width: 16px;
  aspect-ratio: 1/1;
  border-radius: 50%;
  border: 4px solid var(--primary-clr);
  box-shadow: 0 6px 10px rgba(5, 36, 28, 0.3);
}

.controls {
  display: flex;
  justify-content: center;
  align-items: center;
}

.controls button {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 50px;
  aspect-ratio: 1/1;
  margin: 20px;
  background: rgba(163, 162, 164, 0.3);
  color: var(--primary-clr);
  border-radius: 50%;
  border: 1px solid rgba(255, 255, 255, 0.3);
  box-shadow: 0 10px 20px rgba(5, 36, 28, 0.3);
  cursor: pointer;
}

.controls button:is(:hover, :focus-visible) {
  transform: scale(0.96);
}

.controls button:nth-child(2) {
  transform: scale(1.3);
}

.controls button:nth-child(2):is(:hover, :focus-visible) {
  transform: scale(1.25);
}

</style>

<div class="container">
    <div class="music-player">
    <h1><%=title %></h1>
    <p><%=artist %></p>
    
    <audio controls id="song">
        <source src=<% out.println("/static/" + title + ".mp3");%> type="audio/mpeg">
    </audio>
    <input type="range" value="0" id="progress">

    <div class="controls">
        <div ><i class="fa-solid fa-backward"></i></div>
        <div onclick="playPause()"><i class="fa-solid fa-play" id="ctrlIcon"></i></div>
        <div><i class="fa-solid fa-forward"></i></div>

    </div>
    </div>
</div>

<script>

let progress = document.getElementById('progress');
let song = document.getElementById('song');
let ctrlIcon = document.getElementById('ctrlIcon');

song.onloadeddata = function(){
    progress.max = song.duration;
    progress.value = song.currentTime;
}

function playPause(){
    if(ctrlIcon.classList.contains('fa-pause')){
        song.pause();
        ctrlIcon.classList.remove('fa-pause');
        ctrlIcon.classList.add('fa-play');
    }
    else{
        song.play();
        ctrlIcon.classList.add('fa-pause');
        ctrlIcon.classList.remove('fa-play');
    }
}

if (song.play()){
    setInterval(() => {
        progress.value = song.currentTime;
    }, 500);
}

progress.onchange = function(){
    song.play();
    song.currentTime = progress.value;
    ctrlIcon.classList.add('fa-pause');
    ctrlIcon.classList.remove('fa-play');
}


</script>

</body>
</html>