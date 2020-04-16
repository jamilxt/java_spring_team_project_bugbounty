<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../common/header.jsp"/>

<br><br><br>
<div class="container">
    <H1>Insert a new Tag <span><a class="btn btn-success"
                                  href="${pageContext.request.contextPath}/createTag">Add</a></span></H1>
    <div class="row">
        <c:forEach items="${tagResponse}" var="tag">
            <div class="card" style="width: 15rem;">
                <div class="card-body">
                    <h5 class="card-title btn btn-outline-info">${tag.tag}</h5>
                    <h6 class="card-subtitle mb-2 text-muted">${tag.totalUsed} questions</h6>
                    <p class="card-text">${tag.tagDescription}</p>
                    <a href="${pageContext.request.contextPath}/tag/delete?id=${tag.id}"
                       class="card-link btn btn-outline-danger">Delete</a>
                    <a href="${pageContext.request.contextPath}/tag/edit?id=${tag.id}"
                       class="card-link btn btn-outline-warning">Edit</a>
                </div>
            </div>
        </c:forEach>

    </div>
</div>
<br><br><br>
<jsp:include page="../common/footer.jsp"/>