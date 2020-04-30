<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!-- GLOBAL HEADER -->
<jsp:include page="common/header.jsp"/>

<div class="backgroundWrap">
    <img src="/images/course_cover.jpg">
    <div class="gradient"></div>
</div>

<!-- MAIN CONTENT OF THE PAGE -->
<div class="container mt-5 pl-0">

    <div class="media pt-5 pb-5">

        <img src="${pageContext.request.contextPath}/images/${user.propic}" width="100px" height="100px" alt=""
             class="rounded-circle border border-secondary" style="border-width: 4px!important;">

        <div class="media-body ml-5 text-white">
            <small>@${user.username}</small>
            <h5 class="mt-1">${user.fullName}</h5>
            <div class="d-flex mt-3">

                <c:choose>
                    <c:when test="${user.username == authUser.username}">

                        <a href="${pageContext.request.contextPath}/accounts/edit"
                           class="btn btn-sm font-weight-bold pl-3 pr-3 btn-outline-light">
                            <small class="font-weight-bold">Edit Profile</small>
                        </a>

                    </c:when>
                    <c:otherwise>

                        <button class="btn btn-sm font-weight-bold pl-3 pr-3 ${isAlreadyFollowing ? 'btn-outline-light' : 'btn-warning' }"
                                id="followUnfollow">
                            <span id="followStatus">${isAlreadyFollowing ? 'Following' : 'Follow'}</span>
                        </button>

                    </c:otherwise>
                </c:choose>

            </div>
        </div>

    </div>

    <div class="row">

        <div class="col-8">

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

<%--            <ul class="list-group list-group-flush d-none">--%>
<%--                <li class="list-group-item">--%>
<%--                    <div class="media pt-3 pb-3">--%>
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
<%--                                    <a href="/" class="text-dark small font-weight-bold"></a>--%>
<%--                                    <h6 class="text-secondary small">2 views · 2 hours ago</h6>--%>
<%--                                </div>--%>
<%--                                <a href="/" class="font-weight-bold text-dark ml-3">--%>
<%--                                    <img src="/images/" class="rounded-circle border border-light align-middle"--%>
<%--                                         width="40px" height="40px">--%>
<%--                                </a>--%>
<%--                            </div>--%>
<%--                        </div>--%>
<%--                    </div>--%>
<%--                </li>--%>
<%--            </ul>--%>

            <ul class="list-group list-group-flush">
                <div id="load_posts"></div>
            </ul>
            <div id="load_data_message"></div>

            <c:if test="${totalPosts == 0}">
                <div class="text-center text-muted mt-5">
                    <i class="fa fa-4x fa-table nav-item"></i>
                    <h4>
                        Questions of
                        <c:choose>
                            <c:when test="${user.username == authUser.username}">yours</c:when>
                            <c:otherwise>${user.username}</c:otherwise>
                        </c:choose>
                    </h4>
                    <small>No Question Available</small>
                </div>
            </c:if>
            <%--            </div>--%>
        </div>

        <div class="col-4 pr-0">

            <div class="d-flex text-white font-weight-bold">
                <div class="pr-5">
                    <h5 class="font-weight-bold">${totalPosts}</h5>
                    <small class="text-white-50 font-weight-bold">Question${totalPosts > 1 ? 's' : ''}</small>
                </div>

                <div class="pr-5">
                    <h5 id="totalFollowers" class=" font-weight-bold">${totalFollowers}</h5>
                    <small class="text-white-50 font-weight-bold">Follower${totalFollowers > 1 ? 's' : ''}</small>
                </div>
                <div class="pr-5">
                    <h5 class="font-weight-bold">${totalFollowing}</h5>
                    <small class="text-white-50 font-weight-bold">Following</small>
                </div>
            </div>

            <h6 class="mt-lg-5 font-weight-bold text-white">About ${user.fullName}:</h6>

            <div class="media mb-3">
                <i class="fa fa-sm fa-user"></i>
                <div class="media-body ml-3 text-white-50 small">
                    ${user.bio} Android Developer
                </div>
            </div>

            <div class="media mb-3">
                <i class="fa fa-sm fa-globe"></i>
                <div class="media-body ml-3 text-white-50 small">
                    ${user.website} <a href="https://jamilxt.com">jamilxt.com</a>
                </div>
            </div>

            <div class="media mb-3">
                <i class="fa fa-sm fa-map-marker"></i>
                <div class="media-body ml-3 text-white-50 small">
                    Chittagong, Bangladesh
                </div>
            </div>

            <div class="media mb-3">
                <i class="fa fa-sm fa-hashtag"></i>
                <div class="media-body ml-3 text-white-50">
                    <small>Tags:</small> <br>
                    <a href="#" class="badge badge-warning p-2 mt-2 small">Java</a>
                    <a href="#" class="badge badge-warning p-2 mt-2 small">Python </a>
                    <a href="#" class="badge badge-warning p-2 mt-2 small">Spring</a>
                    <a href="#" class="badge badge-warning p-2 mt-2 small">PHP</a>
                    <a href="#" class="badge badge-warning p-2 mt-2 small">Javascript</a>
                    <a href="#" class="badge badge-warning p-2 mt-2 small">Laravel</a>
                </div>
            </div>

        </div>
    </div>
</div>

<script>

    var pageCounter = 0;
    var username = "${user.username}";
    haveMore = false;

    loadPosts(username, pageCounter);

    function loadPosts(username, page) {
        $.getJSON("/api/v1/questions?username=" + username + "&page=" + page, function (data) {
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
                loadPosts(username, pageCounter);
            } else {
                $('#load_data_message').html('<div class="muted small text-center">End of questions</div>');
            }
        }
    });

    $('#followUnfollow').on('click', function () {
        followUnfollow();
    });


    function followUnfollow() {
        $.post("/api/v1/user/follow", {
            username: username,
        }, function (data, status) {
            // $('#totalLikeCounter').html(data.totalLikes);
            console.log(data);
            var followBtn = $('#followUnfollow');
            // var followSts = $('#followStatus');
            if (data.isAlreadyFollowing) {
                followBtn.toggleClass('btn-warning btn-outline-light');
            } else {
                followBtn.toggleClass('btn-outline-light btn-warning');
            }
            $('#followStatus').html(data.followingOrNot);
            $('#totalFollowers').html(data.totalFollowers);
        });
    }

</script>

<!-- GLOBAL FOOTER -->
<jsp:include page="common/footer.jsp"/>