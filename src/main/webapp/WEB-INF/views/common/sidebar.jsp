<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<div class="col-4 pr-0">
    <%--            <div class="position-fixed">--%>

    <div class="card mb-3">
        <div class="card-body">
            <div class="media">
                <a href="/${authUser.username}"
                   class="font-weight-bold text-dark float-left">
                    <img src="${pageContext.request.contextPath}/images/${authUser.propic}"
                         class="rounded-circle border border-light align-middle mr-2"
                         width="50px" height="50px">
                </a>
                <div class="media-body">
                    <a href="/${authUser.username}"
                       class="font-weight-bold">
                        ${authUser.username}
                    </a>
                    <h6 class="small">${authUser.xp} XP</h6>
                </div>
            </div>

            <%--                    <div class="">--%>
            <%--                        <a href="${pageContext.request.contextPath}/<sec:authentication property="principal.username" />"--%>
            <%--                           class="font-weight-bold text-dark float-left">--%>
            <%--                            <img src="${pageContext.request.contextPath}/images/${authUser.propic}"--%>
            <%--                                 class="rounded-circle border border-light align-middle mr-2"--%>
            <%--                                 width="50px" height="50px">--%>
            <%--                        </a>--%>
            <%--                        <a href="${pageContext.request.contextPath}/<sec:authentication property="principal.username" />"--%>
            <%--                           class="font-weight-bold">--%>
            <%--                            ${authUser.username}--%>
            <%--                        </a>--%>
            <%--                        <h6 class="small">0 XP</h6>--%>
            <%--                    </div>--%>
            <div class="mt-3">
                <a href="/accounts/edit" class="btn btn-warning btn-block pl-4 pr-4 pt-1 pb-1 mt-2"><small
                        class="font-weight-bold">EDIT PROFILE</small></a>
                <a href="/logout" class="btn btn-secondary btn-block pl-4 pr-4 pt-1 pb-1 mt-2"><small
                        class="font-weight-bold">SIGN OUT</small></a>
            </div>
        </div>
    </div>
    <div class="card mb-3">
        <div class="card-body">
            <h6 class="font-weight-bold border-bottom pb-2 mb-3">Search Questions</h6>

            <form class="form-group">
                <input class="form-control mr-sm-2" type="search" placeholder="Search"
                       aria-label="Search">
                <button class="btn btn-warning btn-block pl-4 pr-4 pt-1 pb-1 mt-3" type="submit">Search</button>
            </form>
        </div>
    </div>
    <div class="card mb-3 d-none">
        <div class="card-body">
            <h6 class="font-weight-bold border-bottom pb-2">Popular Tags</h6>

            <a href="#" class="badge badge-warning p-2 mt-2 small">Java <span
                    class="badge badge-dark">1000</span></a>
            <a href="#" class="badge badge-warning p-2 mt-2">Python <span
                    class="badge badge-dark">900</span></a>
            <a href="#" class="badge badge-warning p-2 mt-2">Spring <span
                    class="badge badge-dark">800</span></a>
            <a href="#" class="badge badge-warning p-2 mt-2">C++ <span class="badge badge-dark">700</span></a>
            <a href="#" class="badge badge-warning p-2 mt-2">C# <span class="badge badge-dark">600</span></a>
            <a href="#" class="badge badge-warning p-2 mt-2">COBOL <span class="badge badge-dark">500</span></a>
            <a href="#" class="badge badge-warning p-2 mt-2">GO <span class="badge badge-dark">400</span></a>
            <a href="#" class="badge badge-warning p-2 mt-2">OAuth <span class="badge badge-dark">300</span></a>
            <a href="#" class="badge badge-warning p-2 mt-2">Bug <span class="badge badge-dark">200</span></a>
            <a href="#" class="badge badge-warning p-2 mt-2">Solution <span class="badge badge-dark">100</span></a>
            <a href="#" class="badge badge-warning p-2 mt-2">Java <span class="badge badge-dark">1000</span></a>
            <a href="#" class="badge badge-warning p-2 mt-2">Python <span
                    class="badge badge-dark">900</span></a>
            <a href="#" class="badge badge-warning p-2 mt-2">Spring <span
                    class="badge badge-dark">800</span></a>
            <a href="#" class="badge badge-warning p-2 mt-2">C++ <span class="badge badge-dark">700</span></a>
            <a href="#" class="badge badge-warning p-2 mt-2">C# <span class="badge badge-dark">600</span></a>
            <a href="#" class="badge badge-warning p-2 mt-2">COBOL <span class="badge badge-dark">500</span></a>
            <a href="#" class="badge badge-warning p-2 mt-2">GO <span class="badge badge-dark">400</span></a>
            <a href="#" class="badge badge-warning p-2 mt-2">OAuth <span class="badge badge-dark">300</span></a>
            <a href="#" class="badge badge-warning p-2 mt-2">Bug <span class="badge badge-dark">200</span></a>
            <a href="#" class="badge badge-warning p-2 mt-2">Solution <span class="badge badge-dark">100</span></a>

            <a href="#" class="btn btn-block btn-secondary mt-3"><small class="font-weight-bold">SHOW
                ALL</small></a>


        </div>
    </div>

    <div class="card mb-3 d-none">
        <div class="card-body">
            <h6 class="font-weight-bold border-bottom pb-2">Announcements</h6>

            <div class="media">
                <i class="fa fa-sm fa-copy text-muted align-self-start mr-3"></i>
                <div class="media-body">
                    <a href="/a/1">Welcome to BugBean</a>
                </div>
            </div>

            <div class="media">
                <i class="fa fa-sm fa-copy text-muted align-self-start mr-3"></i>
                <div class="media-body">
                    <a href="/a/1">Terms & Conditions of BugBean</a>
                </div>
            </div>

            <div class="media">
                <i class="fa fa-sm fa-copy text-muted align-self-start mr-3"></i>
                <div class="media-body">
                    <a href="/a/1">Be Aware of Corona Virus</a>
                </div>
            </div>

            <div class="media">
                <i class="fa fa-sm fa-copy text-muted align-self-start mr-3"></i>
                <div class="media-body">
                    <a href="/a/1">How to create a question</a>
                </div>
            </div>

            <div class="media">
                <i class="fa fa-sm fa-copy text-muted align-self-start mr-3"></i>
                <div class="media-body">
                    <a href="/a/1">Tips for giving answers</a>
                </div>
            </div>

        </div>
    </div>

    <div class="card mb-3 d-none">
        <div class="card-body">
            <h6 class="font-weight-bold border-bottom pb-2">Leaderboard</h6>
            <div class="media mb-2">
                <a href="${pageContext.request.contextPath}/<sec:authentication property="principal.username" />"
                   class="font-weight-bold text-dark float-left">
                    <img src="${pageContext.request.contextPath}/images/${authUser.propic}"
                         class="rounded-circle border border-light align-middle mr-2"
                         width="50px" height="50px">
                </a>
                <div class="media-body">
                    <a href="${pageContext.request.contextPath}/<sec:authentication property="principal.username" />"
                       class="font-weight-bold">
                        ${authUser.username}
                    </a>
                    <h6 class="small">500 XP</h6>
                </div>
            </div>

            <div class="media mb-2">
                <a href="${pageContext.request.contextPath}/<sec:authentication property="principal.username" />"
                   class="font-weight-bold text-dark float-left">
                    <img src="${pageContext.request.contextPath}/images/${authUser.propic}"
                         class="rounded-circle border border-light align-middle mr-2"
                         width="50px" height="50px">
                </a>
                <div class="media-body">
                    <a href="${pageContext.request.contextPath}/<sec:authentication property="principal.username" />"
                       class="font-weight-bold">
                        shawon
                    </a>
                    <h6 class="small">400 XP</h6>
                </div>
            </div>

            <div class="media mb-2">
                <a href="${pageContext.request.contextPath}/<sec:authentication property="principal.username" />"
                   class="font-weight-bold text-dark float-left">
                    <img src="${pageContext.request.contextPath}/images/${authUser.propic}"
                         class="rounded-circle border border-light align-middle mr-2"
                         width="50px" height="50px">
                </a>
                <div class="media-body">
                    <a href="${pageContext.request.contextPath}/<sec:authentication property="principal.username" />"
                       class="font-weight-bold">
                        aiubur
                    </a>
                    <h6 class="small">300 XP</h6>
                </div>
            </div>

            <div class="media mb-2">
                <a href="${pageContext.request.contextPath}/<sec:authentication property="principal.username" />"
                   class="font-weight-bold text-dark float-left">
                    <img src="${pageContext.request.contextPath}/images/${authUser.propic}"
                         class="rounded-circle border border-light align-middle mr-2"
                         width="50px" height="50px">
                </a>
                <div class="media-body">
                    <a href="${pageContext.request.contextPath}/<sec:authentication property="principal.username" />"
                       class="font-weight-bold">
                        mainul35
                    </a>
                    <h6 class="small">200 XP</h6>
                </div>
            </div>

            <div class="media">
                <a href="${pageContext.request.contextPath}/<sec:authentication property="principal.username" />"
                   class="font-weight-bold text-dark float-left">
                    <img src="${pageContext.request.contextPath}/images/${authUser.propic}"
                         class="rounded-circle border border-light align-middle mr-2"
                         width="50px" height="50px">
                </a>
                <div class="media-body">
                    <a href="${pageContext.request.contextPath}/<sec:authentication property="principal.username" />"
                       class="font-weight-bold">
                        rashdid
                    </a>
                    <h6 class="small">100 XP</h6>
                </div>
            </div>

        </div>
    </div>

    <jsp:include page="sidebar-footer.jsp"/>

</div>