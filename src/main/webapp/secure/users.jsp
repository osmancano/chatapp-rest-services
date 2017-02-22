<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<script>
    $( document ).ready(function() {
        $("#btnAdd").click(function(event) {
            event.preventDefault();
            $("#ModalDiv").load("/secure/newUser.html");
            $("#ModalDiv").modal("show");
        });
    });
</script>
<br/>
<c:if test="${success_user_operation_msg != null}">
    <div class="alert alert-success">
        <c:out value="${success_user_operation_msg}"/>
    </div>
</c:if>
<div class="row">
    <div class="col-sm-8">
        <h4>Users:</h4>
        <c:if test="${permissions.contains('CREATE_USER')}">
        <div>
            <p>
                Click <a href="" class="btn btn-xs btn-info" id="btnAdd">New User</a> to create new user
            </p>
        </div>
        </c:if>
        <table class="table">
            <thead>
            <tr>
                <td>User ID</td>
                <td>Username</td>
                <td>Display Name</td>
            </tr>
            <c:if test="${uList == null}">
                <tr>
                    <td colspan="4" style="text-align: center">No Users to display</td>
                </tr>
            </c:if>
            </thead>
            <tbody>
            <c:forEach items="${uList}" var="aUser">
                <tr>
                    <td><c:out value="${aUser.ID}"/></td>
                    <td><c:out value="${aUser.username}"/></td>
                    <td><c:out value="${aUser.displayName}"/></td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>