<%@ page import="com.ironyard.data.ChatPermissions" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<br/>
<style>
    .alert-message
    {
        margin: 20px 0;
        padding: 20px;
        border-left: 3px solid #eee;
    }
    .alert-message h4
    {
        margin-top: 0;
        margin-bottom: 5px;
    }
    .alert-message p:last-child
    {
        margin-bottom: 0;
    }
    .alert-message code
    {
        background-color: #fff;
        border-radius: 3px;
    }
    .alert-message-success
    {
        background-color: #F4FDF0;
        border-color: #3C763D;
    }
    .alert-message-success h4
    {
        color: #3C763D;
    }
    .alert-message-danger
    {
        background-color: #fdf7f7;
        border-color: #d9534f;
    }
    .alert-message-danger h4
    {
        color: #d9534f;
    }
    .alert-message-warning
    {
        background-color: #fcf8f2;
        border-color: #f0ad4e;
    }
    .alert-message-warning h4
    {
        color: #f0ad4e;
    }
    .alert-message-info
    {
        background-color: #f4f8fa;
        border-color: #5bc0de;
    }
    .alert-message-info h4
    {
        color: #5bc0de;
    }
    .alert-message-default
    {
        background-color: #EEE;
        border-color: #B4B4B4;
    }
    .alert-message-default h4
    {
        color: #000;
    }
    .alert-message-notice
    {
        background-color: #FCFCDD;
        border-color: #BDBD89;
    }
    .alert-message-notice h4
    {
        color: #444;
    }
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
        $('#newMsgForm').submit(function() { // catch the form's submit event
            event.preventDefault();
            var form = $('#newMsgForm')[0];
            var data = new FormData(form);
            $.ajax({ // create an AJAX call...
                enctype: 'multipart/form-data',
                type: $(this).attr('method'), // GET or POST
                data: data,
                processData: false,
                contentType: false,
                cache: false,
                timeout: 600000,
                url: $(this).attr('action'), // the file to call
                success: function(response) { // on success..
                    $('#mainDiv').html(response); // update the DIV
                }
            });
            return false; // cancel original event to prevent form submitting
        });

        $('Select').change(function() {
            var myForm = $(this).closest('form');
            $.get(myForm.attr('action'),myForm.serialize(),function (response) {
                $("#mainDiv").html(response);
            })
        });

        $('.getMsgs').click(function (event) {
            event.preventDefault();
            $.ajax({ // create an AJAX call...
                type: 'GET', // GET or POST
                url: $(this).attr('href'), // the file to call
                success: function(response) { // on success..
                    $('#mainDiv').html(response);
                }
            });
            return false;
        });
    });
</script>
<div class="panel panel-info">
    <div class="panel-heading">
        <h3 class="panel-title">
            <c:out value="${selectedBoard.boardName}"/> board
        </h3>
        <span class="pull-right">
       <i></i>
        </span>
    </div>
    <div class="panel-body">
        <c:forEach items="${bMessages.iterator()}" var="aMsg">
            <div class="col-sm-2 col-md-2">
                <c:if test="${aMsg.msgUser.userImageFile!=null}">
                    <img class="card-img-top" width="50" src="/ourCoolUploadedFiles/<c:out value="${aMsg.msgUser.userImageFile}"/>" alt="Card image cap">
                </c:if>
            </div>
            <div class="col-sm-10 col-md-10">
                <div class="alert-message alert-message-info">
                    <h4>
                        <strong>Posted by:</strong>
                        <c:out value="${aMsg.msgUser.username}"/>
                    </h4>
                    <p>
                        <c:out value="${aMsg.messageText}"/>
                        <c:if test="${aMsg.imageFileName!=null}">
                            <img class="card-img-top" width="50" src="/ourCoolUploadedFiles/<c:out value="${aMsg.imageFileName}"/>" alt="Card image cap">
                        </c:if>
                    </p>
                    <p>
                        <strong>Posted date:</strong>
                        <c:out value="${aMsg.postedDate}"/>
                    </p>
                </div>
            </div>
        </c:forEach>
        <div class="row">
            <div class="col-sm-3 col-xs-3" >
                <c:if test="${bMessages.hasPrevious()}">
                    <div class="pull-left">
                        <a class="getMsgs" href="/secure/boards/messages?boardId=<c:out value='${selectedBoard.ID}'/>&page=<c:out value="${bMessages.number - 1}"/>&size=<c:out value="${bMessages.size}"/>">
                            Previous Page
                        </a>
                    </div>
                </c:if>
            </div>

            <div class="col-sm-6 col-xs-6">
                Page <c:out value="${bMessages.number+1}"/> of <c:out value="${bMessages.totalPages}"/>, Total Records Found:<c:out value="${bMessages.totalElements}"/>
                <div>
                    <form class="form" id="myForm" method="get" action="/secure/boards/messages">
                        Results Per Page:
                        <select name="size">
                            <option value="2" <c:out value="${bMessages.size==2?'selected':''}"/> >
                                2
                            </option>
                            <option value="4" <c:out value="${bMessages.size==4?'selected':''}"/> >
                                4
                            </option>
                            <option value="8" <c:out value="${bMessages.size==8?'selected':''}"/> >
                                8
                            </option>
                        </select>
                        <input type="hidden" name="boardId"  value="<c:out default="0" value="${selectedBoard.ID}"/>" />
                        Sort By:
                        <select name="sortBy">
                            <option value="postedDate" <c:out value="${sortBy=='postedDate'?'selected':''}"/> >
                                Date
                            </option>
                            <option value="msgUserUsername" <c:out value="${sortBy=='msgUserUsername'?'selected':''}"/> >
                                Username
                            </option>
                        </select>
                    </form>
                </div>
            </div>


            <div class="col-sm-3 col-xs-3">

                <c:if test="${bMessages.hasNext()}">
                    <div class="pull-right">
                        <a class="getMsgs" href="/secure/boards/messages?boardId=<c:out value='${selectedBoard.ID}'/>&page=<c:out value='${bMessages.number + 1}'/>&size=<c:out value='${bMessages.size}'/> ">
                            Next Page
                        </a>
                    </div>
                </c:if>
            </div>

        </div>
    </div>
    <c:if test="${permissions.contains('POST_MESSAGE')}">
        <div class="col-sm-6">
            <form id="newMsgForm" class="form-horizontal" action="/secure/messages/create" method="post">
                <div class="form-group">
                    <label class="control-label" for="messageText">Message Text:</label>
                    <div>
                        <textArea id="messageText" name="messageText"></textArea>
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label" for="imageFile">Select Image:</label>
                    <div>
                        <input type="file" class="form-control file input-sm" id="imageFile" name="imageFile">
                    </div>
                </div>
                <input type="hidden" name="boardId"  value="<c:out default="0" value="${selectedBoard.ID}"/>" />
                <div class="form-group">
                    <div>
                        <button type="submit" class="btn btn-info">Post Message</button>
                    </div>
                </div>
            </form>
        </div>
    </c:if>
    </div>
</div>