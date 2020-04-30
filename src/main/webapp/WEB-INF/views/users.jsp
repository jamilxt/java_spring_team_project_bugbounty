<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- GLOBAL HEADER -->
<jsp:include page="common/header.jsp"/>
<!-- MAIN CONTENT OF THE PAGE -->
<body>
<div class="container mt-4 p-0">
    <h3 class="mb-3 text-white">Users</h3>
    <div class="row user-list">
        <c:forEach items="${users}" var="user">
            <div class="col-12 col-sm-6 col-md-4 col-lg-4 col-xl-4 offset-xl-0 user-item">
                <div class="user-container"><a class="user-avatar" href="${user.username}"><img class="rounded-circle"
                                                                                                src="images/${user.propic}"
                                                                                                width="48"
                                                                                                height="48"
                                                                                                alt="Profile of ${user.fullName}"/></a>
                    <p class="user-name pl-2 mb-2"><a href="${user.username}">${user.fullName}
                    </a><span>Users bio area</span><span><a href="/questions/tagged"
                                                            class="badge badge-warning p-2 mr-2 mb-2">Php</a><a
                            href="/questions/tagged" class="badge badge-warning p-2 mr-2 mb-2">Java</a><a
                            href="/questions/tagged" class="badge badge-warning p-2 mr-2 mb-2">Python</a></span></p>
                </div>
            </div>
        </c:forEach>
    </div>
</div>
</body>
<!-- GLOBAL FOOTER -->
<jsp:include page="common/footer.jsp"/>
