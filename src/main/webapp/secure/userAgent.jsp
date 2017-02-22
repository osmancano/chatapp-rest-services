<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<br/>
<c:set var="browser" value="${header['User-Agent']}" scope="session"/>
<c:out value="${browser}"/>