<script>
    $('#newBoardForm').submit(function() { // catch the form's submit event
        $.ajax({ // create an AJAX call...
            data: $(this).serialize(), // get the form data
            type: $(this).attr('method'), // GET or POST
            url: $(this).attr('action'), // the file to call
            success: function(response) { // on success..
                $("#ModalDiv").modal("toggle");
                $('#mainDiv').html(response); // update the DIV
            }
        });
        return false; // cancel original event to prevent form submitting
    });
</script>
<div class="modal-dialog">

    <!-- Modal content-->
<div class="modal-content">
    <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal">&times;</button>
<h4 class="modal-title">Add New Board Form</h4>
</div>
<div class="modal-body">
    <form class="form-horizontal" id="newBoardForm" action="/secure/boards/create" method="post">
    <div class="form-group">
    <label class="control-label col-sm-4" for="boardName">Board Name:</label>
<div class="col-sm-8">
    <input type="text" class="form-control" id="boardName" name="boardName" placeholder="Enter Username"/>
    </div>
    </div>

    <div class="form-group">
    <label class="control-label col-sm-4" for="Discription">Board Description:</label>
<div class="col-sm-8">
    <input type="text" class="form-control" id="Discription" name="Description" placeholder="Enter Display Name"/>
    </div>
    </div>
        <input type="hidden" name="id"  value="<c:out default="0" value="${aBoard.id}"/>"
    <div class="form-group">
    <div class="col-sm-offset-4 col-sm-8">
    <button type="submit" class="btn btn-info">Add</button>
    </div>
    </div>
    </form>
    </div>
    <div class="modal-footer">
    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
    </div>
    </div>

    </div>