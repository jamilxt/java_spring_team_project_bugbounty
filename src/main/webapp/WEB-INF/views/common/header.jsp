<%@ taglib prefix="sec"
           uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>${ pageTitle } - BugBounty</title>
    <link rel="icon" href="/images/favicon.png" type="image/png" sizes="16x16">
    <link rel="stylesheet"
          href="/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.css"/>
    <link rel="stylesheet"
          href="/css/main.css"/>

    <link rel="stylesheet"
          href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css"/>

    <script
            src="https://code.jquery.com/jquery-3.4.1.min.js"
            integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo="
            crossorigin="anonymous"></script>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.js"></script>

    <script
            src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
            integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo"
            crossorigin="anonymous"></script>
    <script src="/js/bootstrap.min.js"></script>

    <link href="https://cdn.jsdelivr.net/npm/summernote@0.8.16/dist/summernote-lite.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/summernote@0.8.16/dist/summernote-lite.min.js"></script>
</head>
<body class="backgroundDark">

<nav class="navbar navbar-expand navbar-light bg-dark shadow-sm sticky-top py-3">

    <div class="container">

        <sec:authorize access="isAnonymous()">

            <a class="navbar-brand pl-3 font-weight-bold text-warning mx-auto"
               href="${pageContext.request.contextPath }/"><i
                    class="fa fa-bug"></i>BOUNTY</a>

        </sec:authorize>

        <sec:authorize access="isAuthenticated()">

            <a class="navbar-brand font-weight-bold text-warning" href="${pageContext.request.contextPath }/"><i
                    class="fa fa-bug"></i>BOUNTY</a>

            <ul class="navbar-nav">
                <li class="nav-item mr-3">
                    <a href="/questions" class="btn btn-outline-secondary pl-2 pr-2 pt-1 pb-1 text-white">Questions</a>
                </li>
                <li class="nav-item mr-3">
                    <a href="${pageContext.request.contextPath}/tag/show-all" class="btn btn-outline-secondary pl-2 pr-2 pt-1 pb-1 text-white">Tags</a>
                </li>
                <li class="nav-item mr-3">
                    <a href="#" class="btn btn-outline-secondary pl-2 pr-2 pt-1 pb-1 text-white">Users</a>
                </li>
            </ul>

            <input type="text" id="search_data" placeholder="Search" autocomplete="off"
                   class="form-control w-25 d-none"/>

            <ul class="navbar-nav">
                <li class="nav-item">
                    <a href="${pageContext.request.contextPath}/<sec:authentication property="principal.username"/>"
                       class="btn pl-4 pr-4 pt-1 pb-1 text-white">
                        <i class="fa fa-1x fa-user-circle text-secondary"></i>
                    </a>
                </li>
                <li class="nav-item">
                    <a href="#"
                       class="btn pl-4 pr-4 pt-1 pb-1 text-white">
                        <i class="fa fa-1x fa-bell text-secondary"></i>
                            <%--                        <span class="badge badge-danger font-weight-bold">0</span>--%>
                    </a>
                </li>
                <li class="nav-item">
                    <div class="dropdown show">
                        <a class="btn pl-4 pr-4 pt-1 pb-1 dropdown-toggle text-warning" href="#" role="button"
                           id="dropdownMenuLink"
                           data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <i class="fa fa-1x fa-cog text-secondary"></i>
                        </a>

                        <div class="dropdown-menu bg-warning p-1" aria-labelledby="dropdownMenuLink">
                            <a class="dropdown-item" href="#">Settings</a>
                            <a class="dropdown-item" href="/logout">Logout</a>
                        </div>
                    </div>
                </li>
                <li class="nav-item">
                    <a href="#" class="btn btn-outline-secondary pl-2 pr-2 pt-1 pb-1 ml-2 mr-3" style="width: 80px">
                        <div class="media">
                            <i class="fa fa-diamond text-warning align-self-center"></i>
                            <div class="media-body text-right">
                                <span class="text-white">${authUser.xp}</span>
                            </div>
                        </div>
                    </a>
                </li>
                <li class="nav-item">
                    <a href="/questions/ask" class="btn btn-warning pl-4 pr-4 pt-1 pb-1" style="width: 80px">
                        <i class="fa fa-plus text-dark"></i>
                    </a>
                </li>
            </ul>

        </sec:authorize>

    </div>
</nav>

