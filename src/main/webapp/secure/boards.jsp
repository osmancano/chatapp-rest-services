<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<br/>
<style>
    .clickable
    {
        cursor: pointer;
    }

    .clickable .glyphicon
    {
        background: rgba(0, 0, 0, 0.15);
        display: inline-block;
        padding: 6px 12px;
        border-radius: 4px
    }

    .panel-heading span
    {
        margin-top: -23px;
        font-size: 15px;
        margin-right: -9px;
    }
    a.clickable { color: inherit; }
    a.clickable:hover { text-decoration:none; }
</style>
<script>
    $( document ).ready(function() {
        $("#btnNewBoard").click(function(event) {
            event.preventDefault();
            $("#ModalDiv").load("/secure/newBoard.jsp");
            $("#ModalDiv").modal("show");
        });
        $('.getMsgs').click(function (event) {
            event.preventDefault();
            $.ajax({ // create an AJAX call...
                type: 'GET', // GET or POST
                url: $(this).attr('href'), // the file to call
                success: function(response) { // on success..
                    $("#mainDiv").html(response);
                }
            });
            return false;
        })
    });

</script>
<c:if test="${success_user_operation_msg != null}">
    <div class="alert alert-success">
        <c:out value="${success_user_operation_msg}"/>
    </div>
</c:if>
<div class="row">
    <div class="col-sm-8">
        <h4>Message Board Settings:</h4>
        <c:if test="${permissions.contains('CREATE_BOARD')}">
        <div>
            <p>
                <a href="" id="btnNewBoard" class="btn btn-xs btn-info" id="btnAdd">New Message Board</a>
            </p>
        </div>
        </c:if>
            <c:if test="${bList == null}">
                <h4>No Boards to display</h4>
            </c:if>

            <c:forEach items="${bList}" var="aBoard">
                <div class="well well-sm">
                    <h5>
                        <c:out value="${aBoard.boardName}"/>
                        <a href="/secure/boards/messages?boardId=<c:out value="${aBoard.ID}"/>" class="pull-right getMsgs btn btn-sm btn-info">
                            <span>Open</span>
                        </a>
                    </h5>

                </div>
            </c:forEach>
    </div>
</div>