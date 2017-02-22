<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Chat App</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <style>
        /* Remove the navbar's default margin-bottom and rounded borders */
        .navbar {
            background-color: #006699;
            margin-bottom: 0;
            border-radius: 0;
        }
        /* Set height of the grid so .sidenav can be 100% (adjust as needed) */
        .row.content {height: 450px}
        /* Set gray background color and 100% height */
        .sidenav {
            padding-top: 20px;
            height: 100%;
        }
        /* Set black background color, white text and some padding */
        footer {
            background-color: #006699;
            color: white;
            padding: 15px;
        }
        /* On small screens, set height to 'auto' for sidenav and grid */
        @media screen and (max-width: 767px) {
            .sidenav {
                height: auto;
                padding: 15px;
            }
            .row.content {height:auto;}
        }
    </style>
    <script>
        $( document ).ready(function() {
            $("#btnBoards").click(function(event) {
                event.preventDefault();
                $.get($(this).attr('href'), function(data, status){
                    $("#mainDiv").html(data);
                });
            });
            $("#btnUsers").click(function(event) {
                event.preventDefault();
                $.get($(this).attr('href'), function(data, status){
                    $("#mainDiv").html(data);
                });
            });
            $("#btnUserAgent").click(function(event) {
                event.preventDefault();
                $("#mainDiv").load('/secure/userAgent.jsp');
            });
        });
    </script>
</head>
<body>

<nav class="navbar navbar-inverse">
    <div class="container-fluid">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="#">Logo</a>
        </div>
        <div class="collapse navbar-collapse" id="myNavbar">
            <ul class="nav navbar-nav">
                <li><h4 style="color:white">Chatting System</h4></li>
            </ul>
            <ul class="nav navbar-nav navbar-right">
                <li><a>Welcome &nbsp;<span class="badge"><c:out value="${user.displayName}"/></span></a></li>
                <li><a href="/secure/logout"><span class="glyphicon glyphicon-log-out"></span>Logout</a></li>
            </ul>
        </div>
    </div>
</nav>
<div class="container-fluid text-left">
    <div class="row content">
        <div class="col-sm-2 sidenav">
            <h4>
                <a href="/secure/boards/" id="btnBoards" class="btn btn-sm btn-primary">
                    <span class="glyphicon glyphicon-plus-sign"></span> Messages Boards
                </a>
            </h4>
            <br>
            <h4>
                <a href="/secure/users/" id="btnUsers" class="btn btn-sm btn-primary">
                    <span class="glyphicon glyphicon-plus-sign"></span>Users Setting
                </a>
            </h4>
            <h4>
                <a href="/secure/users/" id="btnUserAgent" class="btn btn-sm btn-primary">
                    <span class="glyphicon glyphicon-plus-sign"></span>View User Agent
                </a>
            </h4>
            <hr>
            <c:if test="${user.userImageFile!=null}">
                <img class="card-img-top" width="100" src="/ourCoolUploadedFiles/<c:out value="${user.userImageFile}"/>" alt="Card image cap">
            </c:if>
            <h4>
                <c:out value="${user.displayName}"/>
            </h4>
        </div>
        <div class="col-sm-8 text-left" id="mainDiv">
        </div>
    </div>
    <!-- Modal -->
    <div class="modal fade" id="ModalDiv" role="dialog">

    </div>
</div>
<footer class="container-fluid text-center">
    <p>Welcome To Chatting Web App</p>
</footer>

</body>
</html>