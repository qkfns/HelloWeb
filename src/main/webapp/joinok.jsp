<%@ page language="java" 
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" 
		uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" 
		uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sql" 
		uri="http://java.sun.com/jsp/jstl/sql" %>
<%-- JSP 명령어들을 html 태그형식으로 사용하기 --%>
<%-- 위해 JSP 태그라이브러리를 등록함 --%>

<fmt:requestEncoding value="utf-8" />
<%-- 한글처리를 위한 태그 --%>

<sql:setDataSource var="oracledb"
scope="application" 
url="jdbc:oracle:thin:@localhost:1521:XE"
driver="oracle.jdbc.OracleDriver"
user="bigdata" password="bigdata2020" />
<%-- 마리아디비 접속을 위해 접속정보 생성 --%>

<c:catch var="result">
	<sql:update 
		dataSource="${oracledb}" var="join">
		insert into member
		(mno, userid, passwd, name, email)
		values (mbseq.nextval,?,?,?,'abc123@xyz.com')
		<sql:param value="${param.uid}" />
		<sql:param value="${param.pwd}" />
		<sql:param value="${param.name}" />
	</sql:update>	
</c:catch>
<%-- 입력한 회원정보를 members 테이블에 저장 --%>
<%-- 처리 성공여부는 join이라는 변수에 저장 --%>

<c:choose>
	<c:when test='${join == 1}'>
		<script>
		alert('회원가입 성공!');
		location.href='login.jsp';
		</script>
	</c:when>
	
	<c:when test='${join != 1 || result != null }'>
		<script>
		alert('회원가입 실패! -- 이전페이지로 이동');
		//history.back();
		</script>
	</c:when>
</c:choose>

<c:out value="${result}" />
<%-- 예외 발생시 오류내용 출력 --%>

<%--
회원 테이블 생성 
create table members (
mno		int			auto_increment,
userid	varchar(18)	not null,
passwd	varchar(18)	not null,
name	varchar(10) not null,
joindate	timestamp 	
            default current_timestamp,
primary key (mno)
);
--%>


		
		
		
		