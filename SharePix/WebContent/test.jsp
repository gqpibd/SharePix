<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>

<meta charset="utf-8">

<title>Dropzone simple example</title>


<!--
  DO NOT SIMPLY COPY THOSE LINES. Download the JS and CSS files from the
  latest release (https://github.com/enyo/dropzone/releases/latest), and
  host them yourself!
-->
<script src="https://rawgit.com/enyo/dropzone/master/dist/dropzone.js"></script>
<link rel="stylesheet" href="https://rawgit.com/enyo/dropzone/master/dist/dropzone.css">
<script src="./js/dropzone.js"></script>


<form action="/images/pictures" method="post" enctype="multipart/form-data"  class="dropzone">

  <div class="fallback">
    <input name="file" type="file" multiple />
  </div>
</form>
