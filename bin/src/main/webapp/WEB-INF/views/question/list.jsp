<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!-- HEADER -->
<jsp:include page="../common/header.jsp"/>

<!-- MAIN CONTENT OF THE PAGE -->
<div class="container mt-4">

    <div class="row">

        <div class="col-8">

            <div class="card mb-5">
                <div class="card-body">
                    <h3 class="mb-3">${pageTitle}</h3>

                    <div class="row mt-4 mb-4">

                        <div class="col-4">
                            <a href="/questions/ask" class="btn btn-warning pl-4 pr-4 pt-1 pb-1">
                                <small class="font-weight-bold">NEW QUESTION</small>
                            </a>
                        </div>
                        <div class="col-8">
                            <form class="form-inline my-2 my-lg-0 float-right">
                                <input class="form-control mr-sm-2" type="search" placeholder="Search"
                                       aria-label="Search">
                                <button class="btn btn-warning my-2 my-sm-0" type="submit">Search</button>
                            </form>
                        </div>

                    </div>

                    <ul class="nav nav-tabs small">
                        <li class="nav-item d-none">
                            <a class="nav-link" href="#">Trending</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link active" href="#">Recent</a>
                        </li>
                        <li class="nav-item d-none">
                            <a class="nav-link" href="#">Unanswered</a>
                        </li>
                        <li class="nav-item d-none">
                            <a class="nav-link" href="#">My Questions</a>
                        </li>
                        <li class="nav-item d-none">
                            <a class="nav-link" href="#">My Answers</a>
                        </li>
                    </ul>


                    <c:forEach items="${ questions.content }" var="question">
                        <%-- question 1 --%>
                        <div class="row pt-3">
                            <div class="col-2  border-right">
                                <div class="col">
                                    <div class="row-4 small text-center">${question.views}<br><i
                                            class="fa fa-sm fa-thumbs-up text-secondary"></i>
                                    </div>
                                    <div class="row-4 small text-center mt-3">${question.views}<br> <i
                                            class="fa fa-sm fa-comment text-secondary"></i>
                                    </div>
                                    <div class="row-4 small text-center mt-3 d-none">${question.views}<br> <i
                                            class="fa fa-sm fa-eye text-secondary"></i>
                                    </div>
                                </div>
                            </div>
                            <div class="col-10">
                                <div>
                                    <a href="/questions/${ question.questionId }"
                                       class="text-dark font-weight-bold">${question.title}</a>
                                </div>
                                <div class="d-none">
                                    <a href="#" class="badge badge-warning p-2 mt-2">Tag1</a>
                                    <a href="#" class="badge badge-warning p-2 mt-2">Tag2</a>
                                    <a href="#" class="badge badge-warning p-2 mt-2">Tag3</a>
                                    <a href="#" class="badge badge-warning p-2 mt-2">Tag4</a>

                                </div>
                                <div>
                                    <a href="/${ question.user.username }"
                                       class="font-weight-bold text-dark float-right">
                                        <img src="/images/${ question.user.propic }"
                                             class="rounded-circle border border-light align-middle"
                                             width="35px" height="35px">
                                    </a>
                                    <div class="float-right text-right mr-3">
                                        <a href="${question.user.username}"
                                           class="text-warning small">
                                                ${question.user.username}
                                        </a>
                                        <h6 class="text-secondary small text-right">${question.created_at}</h6>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <hr>
                    </c:forEach>

                    <h6 class="text-muted text-center mb-3">Total Pages: ${questions.totalPages}</h6>

                    <c:if test="${questions.totalElements > 0}">
                        <nav aria-label="Page navigation example">
                            <ul class="pagination justify-content-center">
                                <li class="page-item ${questions.first ? 'disabled' : ''}">
                                    <a class="page-link" href="?page=${questions.number - 1}" tabindex="-1">Previous</a>
                                </li>
                                <c:forEach begin="${0}" end="${questions.totalPages - 1}" var="p">
                                    <li class="page-item ${questions.number == p ? 'active' : ''}">
                                        <a class="page-link" href=" ?page=${p}">${p+1}</a>
                                    </li>
                                </c:forEach>
                                <li class="page-item ${questions.last ? 'disabled' : ''}">
                                    <a class="page-link"
                                       href="?page=${questions.number + 1}${!empty param.username ? '&username='.concat(param.username) : ''}">Next</a>
                                </li>
                            </ul>
                        </nav>
                    </c:if>
                </div>
            </div>
        </div>

        <jsp:include page="../common/sidebar.jsp"/>

    </div>

</div>

<!-- FOOTER -->
<jsp:include page="../common/footer.jsp"/>