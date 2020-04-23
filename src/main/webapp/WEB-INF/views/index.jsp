<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!-- GLOBAL HEADER -->
<jsp:include page="common/header.jsp"/>

<!-- MAIN CONTENT OF THE PAGE -->
<div class="container  mt-4">

    <div class="row">

        <div class="col-8 pl-0">

            <div class="card mb-5 d-none">
                <div class="card-body">
                    <h3 class="mb-3">Q&A Discussions</h3>

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
                        <li class="nav-item">
                            <a class="nav-link active" href="#">Recent</a>
                        </li>
                    </ul>


                    <%-- question 1 --%>
                    <%--                    <div class="media border-bottom  pt-3 pb-3">--%>
                    <%--                        <div style="width: 60px">--%>
                    <%--                            <div class="row-4 small text-center">13<br>--%>
                    <%--                                <i class="fa fa-sm fa-thumbs-up text-secondary"></i>--%>
                    <%--                            </div>--%>
                    <%--                            <div class="row-4 small text-center mt-3">83<br>--%>
                    <%--                                <i class="fa fa-sm fa-comment text-secondary"></i>--%>
                    <%--                            </div>--%>
                    <%--                        </div>--%>
                    <%--                        <div class="media-body ml-2 pl-4 border-left ">--%>
                    <%--                            <div>--%>
                    <%--                                <a href="/p/3" class="text-dark font-weight-bold">Question Title</a>--%>
                    <%--                            </div>--%>
                    <%--                            <div class="">--%>
                    <%--                                <a href="/questions/tagged/java" class="badge badge-warning p-2 mt-2">java</a>--%>
                    <%--                            </div>--%>
                    <%--                            <div class="media text-right mt-3">--%>
                    <%--                                <div class="media-body">--%>
                    <%--                                    <a href="/${authUser.username}"--%>
                    <%--                                       class="text-dark small font-weight-bold">${authUser.username}</a>--%>
                    <%--                                    <h6 class="text-secondary small">2 views · 2 hours ago</h6>--%>
                    <%--                                </div>--%>
                    <%--                                <a href="/${authUser.username}" class="font-weight-bold text-dark ml-3">--%>
                    <%--                                    <img src="/images/${authUser.propic}"--%>
                    <%--                                         class="rounded-circle border border-light align-middle" width="40px"--%>
                    <%--                                         height="40px">--%>
                    <%--                                </a>--%>
                    <%--                            </div>--%>
                    <%--                        </div>--%>
                    <%--                    </div>--%>


                </div>
            </div>

            <h3 class="mb-3 text-white">Q&A Discussions <a href="/questions/ask"
                                                           class="btn btn-warning pl-4 pr-4 pt-1 pb-1 float-right">
                <small class="font-weight-bold">NEW QUESTION</small>
            </a>
            </h3>
            
            <ul class="nav nav-pills nav-justified mb-3 font-weight-bold" id="pills-tab" role="tablist">
                <li class="nav-item">
                    <a class="nav-link active" id="pills-home-tab" data-toggle="pill" href="#pills-home" role="tab"
                       aria-controls="pills-home" aria-selected="true">Recent</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link d-none" id="pills-profile-tab" data-toggle="pill" href="#pills-profile"
                       role="tab"
                       aria-controls="pills-profile" aria-selected="false">Most Voted</a>
                </li>
            </ul>

            <ul class="list-group list-group-flush">
                <div id="load_posts"></div>
            </ul>
            <div id="load_data_message"></div>

        </div>


        <jsp:include page="common/sidebar.jsp"/>

    </div>

</div>

<%--<div class="media border-bottom  pt-3 pb-3">--%>

<%--    <div style="width: 60px">--%>
<%--        <div class="row-4 small text-center">13<br>--%>
<%--            <i class="fa fa-sm fa-thumbs-up text-secondary"></i>--%>
<%--        </div>--%>
<%--        <div class="row-4 small text-center mt-3">83<br>--%>
<%--            <i class="fa fa-sm fa-comment text-secondary"></i>--%>
<%--        </div>--%>
<%--    </div>--%>

<%--    <div class="media-body ml-2 pl-4 border-left ">--%>
<%--        <div>--%>
<%--            <a href="/p/3" class="text-dark font-weight-bold">Question Title</a>--%>
<%--        </div>--%>
<%--        <div class="">--%>
<%--            <a href="/questions/tagged/java" class="badge badge-warning p-2 mt-2">java</a>--%>
<%--        </div>--%>

<%--        <div class="media text-right mt-3">--%>
<%--            <div class="media-body">--%>
<%--                <a href="/" class="text-dark small font-weight-bold"></a>--%>
<%--                <h6 class="text-secondary small">2 views · 2 hours ago</h6>--%>
<%--            </div>--%>
<%--            <a href="/" class="font-weight-bold text-dark ml-3">--%>
<%--                <img src="/images/" class="rounded-circle border border-light align-middle" width="40px" height="40px">--%>
<%--            </a>--%>
<%--        </div>--%>

<%--    </div>--%>
<%--</div>--%>

<script>

    var pageCounter = 0;
    haveMore = false;

    loadPosts(pageCounter);

    function loadPosts(page) {
        $.getJSON("/api/v1/questions/all?&page=" + page, function (data) {
            console.log(data);
            var post_data = '';
            $.each(data, function (key, value) {

                post_data += '<li class="list-group-item">';
                post_data += '<div class="media pt-3 pb-3">';
                post_data += '<div style="width: 60px">';
                post_data += '<div class="row-4 small text-center">' + value.likeCount + '<br>';
                post_data += '<i class="fa fa-sm fa-thumbs-up text-secondary"></i>';
                post_data += '</div>';
                post_data += '<div class="row-4 small text-center mt-3">' + value.answerCount + '<br>';
                post_data += '<i class="fa fa-sm fa-comment text-secondary"></i>';
                post_data += '</div>';
                post_data += '</div>';

                post_data += '<div class="media-body ml-2 pl-4 border-left ">';
                post_data += '<div>';
                post_data += '<a href="/questions/' + value.questionId + '" class="text-dark font-weight-bold">' + value.title + '</a>';
                post_data += '</div>';
                post_data += '<div class="">';

                $.each(value.tags, function (key, value) {
                    post_data += '<a href="/questions/tagged/' + value + '" class="badge badge-warning p-2 mt-2 mr-1">' + value + '</a>';
                })

                post_data += '</div>';

                post_data += '<div class="media text-right mt-3">';
                post_data += '<div class="media-body">';
                post_data += '<a href="' + value.username + '" class="text-dark small font-weight-bold">' + value.username + '</a>';
                post_data += '<h6 class="text-secondary small">' + value.viewCount + ' views · ' + value.created_at + '</h6>';
                post_data += '</div>';
                post_data += '<a href="' + value.username + '" class="font-weight-bold text-dark ml-3">';
                post_data += '<img src="/images/' + value.propic + '" class="rounded-circle border border-light align-middle" width="40px" height="40px">';
                post_data += '</a>';
                post_data += '</div>';

                post_data += '</div>';
                post_data += '</div>';
                post_data += '</li>';

            });

            $('#load_posts').append(post_data);

            if (data.length > 9) {
                haveMore = true;
            } else {
                haveMore = false;
            }
        });

        pageCounter = pageCounter + 1;
    }

    $(window).scroll(function () {
        if ($(window).scrollTop() + $(window).height() >= $(document).height()) {
            if (haveMore) {
                loadPosts(pageCounter);
            } else {
                $('#load_data_message').html('<div class="mt-3 muted small text-center">End of questions</div>');
            }
        }
    });

</script>


<!-- GLOBAL FOOTER -->
<jsp:include page="common/footer.jsp"/>