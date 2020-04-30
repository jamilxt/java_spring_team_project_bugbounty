<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- GLOBAL HEADER -->
<jsp:include page="../common/header.jsp"/>

<!-- MAIN CONTENT OF THE PAGE -->
<div class="container mt-4 p-0">
    <h3 class="mb-3 text-white">Tags</h3>
    <div class="row">
        <c:forEach items="${tagResponse}" var="tag">
            <div class="col-4">
                <div class="card mb-4">
                    <div class="card-body">
                        <a href="/questions/tagged/${tag.tag}" class="badge badge-warning p-2">${tag.tag}</a>
                        <div class="small mt-2" style="height: 60px">
                                ${tag.tagDescription}
                        </div>
                        <div class="row small">
                            <div class="col">${tag.totalUsed} questions</div>
                            <div class="col"><span class="float-right">Created ${tag.created_at}</span></div>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>

    </div>
</div>

<!-- GLOBAL FOOTER -->
<jsp:include page="../common/footer.jsp"/>