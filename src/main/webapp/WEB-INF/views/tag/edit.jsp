<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<jsp:include page="../common/header.jsp"/>
<br><br><br>
<div class="container">
    <h1>Edit tag</h1>
    <form:form action="/tag/edit" modelAttribute="tagRequest">
        <fieldset class="form-group">
            <label>Tag Name</label>
            <form:input path="tag" class="form-control" type="text"/>
        </fieldset>

        <fieldset class="form-group">
            <label>Tag description</label>
            <form:textarea path="tagDescription" class="form-control"/>
        </fieldset>
        <form:input path="id" value = "${id}" hidden = "hidden"/>
        <input class="btn btn-success" type="submit" value="add">
    </form:form>
<jsp:include page="../common/footer.jsp"/>