<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<jsp:include page="../common/header.jsp"/>
    <br><br><br>
    <div class="container">
        <h1>Add a new tag</h1>
        <form:form action="/createTag" modelAttribute="tagRequest">
        <fieldset class="form-group">
            <label>Tag Name</label>
            <form:input path="tag" class="form-control" type="text"/>
        </fieldset>

        <fieldset class="form-group">
            <label>Tag description</label>
            <form:textarea path="tagDescription" class="form-control"/>
        </fieldset>
        <input class="btn btn-success" type="submit" value="add">
        </form:form>
    </div>
<jsp:include page="../common/footer.jsp"/>