<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- GLOBAL HEADER -->
<jsp:include page="../common/header.jsp"/>

<!-- MAIN CONTENT OF THE PAGE -->
<div class="container mt-4 p-0">
    <form class="form-inline my-2 my-lg-0 float-lg-right">
        <input
                class="form-control mr-sm-2"
                type="search"
                id="text_name"
                placeholder="Tag name"
                aria-label="Search"
        />
        <div class="form-group">
            <label for=""></label>
            <select class="form-control" id="sort">
                <option>Sort By Name</option>
                <option>Sort By Popularity</option>
                <option>Most Recent</option>
            </select>
        </div>
        <button class="btn btn-outline-success my-2 my-sm-0 ml-3" id="submit" type="submit">
            Search
        </button>
    </form>
    <h3 class="mb-3 text-white mb-5">Tags</h3>
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
    <div>
        <h6 class="text-center mb-3 text-white">Total Pages: ${totalPage}</h6>
        <c:if test="${totalElement > 0}">
            <nav aria-label="Page navigation example">
                <ul class="pagination justify-content-center">
                    <li class="page-item ${first ? 'disabled' : ''}">
                        <a class="page-link" href="?_search=${search}&_pageIndex=${number - 1}&_row=6&_sort=${sort}">Previous</a>
                    </li>
                    <c:forEach begin="${0}" end="${totalPage - 1}" var="p">
                        <li class="page-item ${number == p ? 'active' : ''}">
                            <a class="page-link" href="?_search=${search}&_pageIndex=${p}&_row=6&_sort=${sort}">${p+1}</a>
                        </li>
                    </c:forEach>
                    <li class="page-item ${last ? 'disabled' : ''}">
                        <a class="page-link"
                           href="?_search=${search}&_pageIndex=${number + 1}&_row=6&_sort=${sort}">Next</a>
                    </li>
                </ul>
            </nav>
        </c:if>
    </div>
</div>

<script type="text/javascript">
    $("#submit").click(function (e) {
        e.preventDefault();
        var search_text = $("#text_name").val();
        var sort = $('#sort').val();
        window.location = "${pageContext.request.contextPath}/tag/show-all?_search="+search_text+"&_pageIndex=0&_row=6&_sort="+sort+"";
    })
</script>

<!-- GLOBAL FOOTER -->
<jsp:include page="../common/footer.jsp"/>
