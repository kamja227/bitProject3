<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<title>Bookery</title>
<%@ include file="../template/head.jspf" %>
<Script type="text/javascript">
var pagechoice;
var content;
var pages=${v_study.pages};
var startdate;
var enddate;
var plan_page;
var temp;
var mql = window.matchMedia("screen and (max-width: 800px)");
	mql.addListener(function(e) {
	    if(e.matches) {
		    $(".btn").before("<div class=\"temp\"><br/><div/>");
	    } else {
			$('.temp').remove();
	    }
	});
function get_date_str(date){
    var sYear = date.getFullYear();
    var sMonth = date.getMonth() + 1;
    var sDate = date.getDate();
    sMonth = sMonth > 9 ? sMonth : "0" + sMonth;
    sDate  = sDate > 9 ? sDate : "0" + sDate;
    return sYear +"-"+ sMonth +"-"+ sDate;
}//날짜 형변환
$(function() {
	if (mql.matches) {
		$(".btn").before("<div class=\"temp\"><br/><div/>");
	} else {
		$('.temp').remove();
	}//최초
  	$('.by-page').hide();
	$('.by-date').hide();
 	$('.page-result').hide();
	$('.date-result').hide();
	$('.page-choice').on('click',function(){
			$('.by-page').show();
			$('.by-date').hide();
		 	$('.date-result').hide();
	});//click
	$('.page-date').on('click',function(){
		$('.by-date').show();
		$('.by-page').hide();
		$('.page-result').hide();
	});//click
		
	$(".startdate").prop("min",  get_date_str(new Date()));
	$(".startdate1").prop("min",  get_date_str(new Date()));
	$(".startdate1").on("change", function() {
		$(".enddate").prop("min", $(".startdate1").val());
		var pos_enddate = new Date($(".startdate1").val());
		pos_enddate = pos_enddate.setDate(pos_enddate.getDate()+cntToc-1);
		pos_enddate = new Date(pos_enddate); // 선택할 수 있는 마칠 날짜
	     $(".enddate").prop("max", get_date_str(pos_enddate));
	});
	
	$('.page-btn').on('click',function(){
		startdate=$('.startdate').val();
		$('.start-date').val(startdate);
		plan_page=$('.page').val();
		$('.plan-page').val(plan_page);
		temp=Math.ceil(pages /plan_page); //숫자올림
		$('.study-day').val(temp);
		enddate=new Date(startdate);
		enddate=enddate.setDate(enddate.getDate()+temp-1);//끝나는 날짜 계산
		enddate=new Date(enddate);
		$('.end-date').val(get_date_str(enddate));
		if(startdate==""||plan_page==""){
			swal({
				  title: "내용이 비어있습니다",
				  text: "시작 날짜와 공부할 양이 제대로 입력되었는지 확인해 주세요",
				  icon: "error",
				  button: "확인",
			});			
		}else if(startdate<get_date_str(new Date())){
			swal({
				  title: "시작 날짜 입력 오류",
				  text: "시작 날짜는 오늘이나 오늘 이후의 날짜로 입력해 주세요",
				  icon: "error",
				  button: "확인",
				});
		}else if(plan_page>pages){
			swal({
				  title: "페이지 입력 오류",
				  text: "공부할 양은 총 페이지수보다 많을 수 없습니다",
				  icon: "error",
				  button: "확인",
				});
		}else{
			$('.page-result').show();
		} 
	});//page-btn click
	$('.enddate-btn').on('click',function(){
		temp=$('.startdate1').val();
		$('.start-date1').val(temp);
		startdate=new Date(temp);
		temp=$('.enddate').val();
		$('.end-date1').val(temp);
		enddate=new Date(temp);
		temp=Math.ceil((enddate.getTime()-startdate.getTime())/(1000*3600*24))+1;
		$('.study-day1').val(temp);
		plan_page=Math.ceil(pages/temp);
		$('.plan-page1').val(plan_page);
		if($('.startdate1').val()==""||$('.enddate').val()==""){
			swal({
				  title: "내용이 비어있습니다",
				  text: "시작 날짜와 마칠 날짜가 제대로 입력되었는지 확인해 주세요",
				  icon: "error",
				  button: "확인",
			});			
		}else if($('.startdate1').val()<get_date_str(new Date())){
			swal({
				  title: "시작 날짜 입력 오류",
				  text: "시작 날짜는 오늘이나 오늘 이후의 날짜로 입력해 주세요",
				  icon: "error",
				  button: "확인",
			});
		}else if($('.startdate1').val()>$('.enddate').val()){
			swal({
				  title: "날짜 입력 오류",
				  text: "마칠 날짜는 시작 날짜 이후여야 합니다",
				  icon: "error",
				  button: "확인",
			});
		}else{
		 	$('.date-result').show();
		}
	});//enddate-btn click
	
	$(".assert1").on("click",function(){
		swal({
			title: "목표설정이 완료되었습니다",
			text: "확인 버튼을 누르시면 오늘의 기록으로 이동합니다",
			icon: "success",
			button: "확인",
		}).then(function(value) {
			$(".assert1").closest("form").submit();
		});
	});//click
	
	$(".assert2").on("click",function(){
		swal({
			title: "목표설정이 완료되었습니다",
			text: "확인 버튼을 누르시면 오늘의 기록으로 이동합니다",
			icon: "success",
			button: "확인",
		}).then(function(value) {
			$(".assert2").closest("form").submit();
		});
	});//click
	
});//ready
</Script>
<style type="text/css">
	label{
	 width:20%;
	}
	input{
		width:150px;
		border: 1px solid #e4e4e4;
		margin:0.3em auto;
	}
	.jumbotron{
		background-color:white;
		width:70%;
		margin:0 auto;
		padding:10px;
		border:1px solid #e4e4e4;
	}
	.plan-page-title{
		text-align:center;
		margin-bottom:1em;
	}
	.title-image{
		width:1.5em;
	}
	.page-main{
		display:inline-flex;
		width:100%;
	}
	.book-image{
		width:14em;
		box-shadow: 12px 8px 24px rgba(0,0,0,.3), 4px 8px 8px rgba(0,0,0,.4), 0 0 2px rgba(0,0,0,.4);
		margin-bottom:5em;
	}
	.page-content{
		margin-left:3em;
	}
	.page-content h4{
		margin-top:0px;
	}
	.choice{
		cursor:pointer;
		line-height:40px;
		border: 1px solid #e4e4e4;
		padding:0.5em 1.5em;
		font-size:1.2em;
		border-radius:10px;
		margin:20px auto;
	}
	.choice:hover{
		color:#8ba989;
		border: 1px solid #8ba989;
	}
	.gray{
		color:#999999;
		font-size:0.9em;
	}
	.by{
		padding-left:10px;
	}
	.calc{
		margin-left:30px;
		background-color:#8ba989;
		color:white;
		line-height:15px;
	}
	.calc:hover{
		background-color:white;
		border:1px solid #8ba989;
		color:#8ba989;
	}
	.assert1,.assert2{
		color:black;
		background-color:white;
		line-height:15px;
		padding:0px 5px;
		margin-bottom:5px;
		font-size:1.2em;
	}
	.assert:hover,.assert2:hover{
		border:1px solid white;
		color: #49654d;
	} 
	.result{
		border-top:1px solid #e4e4e4;
		padding-top:1em;
		margin-top:1em;
	}
	.comment{
		vertical-align:middle;
		text-align:center;
		margin-top:10px;
	}
	.go-to-chap{
		width:100%;
		text-align:right;
		padding-bottom:1em;
	}
 	@media (max-width:800px) {
	 	label{
			width:30%;
		}
 		.jumbotron{width:90%; text-align:center;}
		.book-image{margin-bottom:2em;}
		.page-main{display:block;}
		.page-content{
			width:100%;
			margin:0 auto;
			font-size:1.3em;
		}
		.assert1,.assert2{
			font-size:1em;
		}
		.temp{
			margin:0px auto;
		}
	}
</style>
</head>
<body>
<%@ include file="../template/menu.jspf" %>
<%@ include file="../template/mylib-menu.jspf" %>
<!-- **********content start**********-->
<div class="row">
	<div class="jumbotron">
		<h3 class="plan-page-title">목표설정 by PAGE</h3>
		<div class="page-main">
			<div class="book-image-box">
				<img class="book-image" src="${v_study.coverurl }" alt="책 이미지">
			</div><!-- book-image-box -->
			<div class="page-content">
				<div class="book-info-detail">
					<h4><strong>${v_study.title}</strong></h4>
					<h5>본 책은 총 <strong class="color-green">${v_study.pages}</strong>페이지 입니다</h5>
				</div><!-- book-info-detail -->
				<div class="page-page">
					<div class="choice page-choice">
						 <span class="glyphicon glyphicon-duplicate" aria-hidden="true"></span> 하루에 공부할 양을 기준으로<br/>
						 <span class="gray">시작 날짜와 공부할 페이지 양을 입력하시면 끝나는 날짜가 계산됩니다</span>
					</div><!-- choice -->
					<div class="by-page by">
						<label for="startdate">시작 날짜</label><input type="date" name="startdate" class="startdate"/><br/>
						<label for="page">공부할 양</label><input type="number" name="page" class="page"/>
						<button class="btn btn-priamary page-btn calc">계산</button>
						<div class="page-result result">
							<form class="form" method="post" action="${pageContext.request.contextPath }/mylib/plan/page">
								<label for="startdate">시작 날짜</label><input type="date" name="startdate" class="start-date" readonly/><br/>
								<label for="enddate">끝나는 날짜</label><input type="date" name="enddate" class="end-date" readonly/><br/>
								<label for="studyday">총 공부일</label><input type="text" name="studyDay" class="study-day" readonly/><br/>
								<label for="planpage">공부할 양</label><input type="text" name="planPage" class="plan-page" readonly/><br/>
								<label for="memo">메모</label><input type="text" name="memo" class="memo"/>
								<input type="hidden" name="id" value="${v_study.study_id}" readonly/>
								<input type="hidden" name="book_bid" value="${v_study.book_bid}" readonly/>
								<input type="hidden" name="type" value="page" readonly/><br/>
								<div class="comment">
									<a class="btn assert1">해당 정보로 목표설정을 하시겠습니까?
										<span class="glyphicon glyphicon-ok"></span>
									</a>
								</div>
							</form>
						</div><!-- page-result -->
					</div><!-- by-page -->
				</div><!-- page-page -->
				<div class="page-date">
					<div class="choice page-choice">
						 <span class="glyphicon glyphicon-calendar" aria-hidden="true"></span> 공부를 마칠 날짜를 기준으로<br/>
						 <span class="gray">시작 날짜와 마칠 날짜를 입력하시면 하루에 공부해야 할 페이지이 계산됩니다</span>
					</div><!-- choice -->
					<div class="by-date by">
						<label for="startdate">시작 날짜</label><input type="date" name="startdate" class="startdate1"/><br/>
						<label for="enddate">마칠 날짜</label><input type="date" name="enddate" class="enddate"/>
						<button class="btn btn-priamary enddate-btn calc">계산</button>
						<div class="date-result result">
							<form class="form" method="post" action="${pageContext.request.contextPath }/mylib/plan/page">
								<label for="startdate">시작 날짜</label><input type="date" name="startdate" class="start-date1" readonly/><br/>
								<label for="enddate">끝나는 날짜</label><input type="date" name="enddate" class="end-date1" readonly/><br/>
								<label for="studyday">총 공부일</label><input type="text" name="studyDay" class="study-day1" readonly/><br/>
								<label for="planpage">공부할 양</label><input type="text" name="planPage" class="plan-page1" readonly/><br/>
								<label for="memo">메모</label><input type="text" name="memo" class="memo"/>
								<input type="hidden" name="id" value="${v_study.study_id}" readonly/>
								<input type="hidden" name="book_bid" value="${v_study.book_bid}" readonly/>
								<input type="hidden" name="type" value="page" readonly/><br/>
								<div class="comment">
									<a class="btn assert2">해당 정보로 목표설정을 하시겠습니까?
										<span class="glyphicon glyphicon-ok"></span>
									</a>
								</div>
							</form>
						</div><!-- date-result -->
					</div><!-- by-date -->
				</div><!-- page-date -->
			</div><!-- page content -->
		</div><!-- .page-main end -->
		<div class="go-to-chap">
			<a href="${pageContext.request.contextPath }/mylib/plan/chap/${v_study.study_id}"><em>챕터 목표설정 페이지로 이동</em></a>
		</div>
	</div><!-- jumbotron end -->
</div><!-- .row end -->
<!--**********content end**********-->
<%@ include file="../template/footer.jspf" %>
</body>
</html>