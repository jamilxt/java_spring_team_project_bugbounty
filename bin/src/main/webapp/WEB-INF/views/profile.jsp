<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!-- GLOBAL HEADER -->
<jsp:include page="common/header.jsp"/>
<style>
    .nav-pills .nav-link {
        border-radius: 0;
        color: #a0a0a0;
        padding-top: 15px;
        margin-left: 30px;
        margin-right: 30px;
        font-size: small;
    }

    .nav-pills .nav-link.active {
        color: black;
        border-top: 2px solid;
        background: none;
    }
</style>

<div class="backgroundWrap">
    <img src="/images/course_cover.jpg">
    <div class="gradient"></div>
</div>

<!-- MAIN CONTENT OF THE PAGE -->
<div class="container mt-5">

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

            <div class="tab-content py-3 px-3 px-sm-0" id="nav-tabContent">
                <div class="tab-pane fade show active" id="nav-home" role="tabpanel" aria-labelledby="nav-home-tab">


                    <%--            <div class="card card-body">--%>
                    <div class="row" id="load_posts">

                        <%-- POSTS --%>
                        <%--                <c:forEach items="${user.questions}" var="question">--%>
                        <%--                    <div class="col-4 mb-4">--%>
                        <%--                        <div class="imgHoverContainer w-100 h-100 ">--%>
                        <%--                            <a href="/p/${question.postId}">--%>
                        <%--                                <img src="/images/${question.images[0]}" class="w-100 h-100 imgHoverImage">--%>
                        <%--                                <div class="imgHoverMiddle">--%>
                        <%--                                        &lt;%&ndash;                                        ${fn:length(question.answers)}&ndash;%&gt;--%>
                        <%--                                    <div class="imgHoverText">--%>
                        <%--                                        <i class="fa fa-1x fa-heart nav-item"></i> 0--%>
                        <%--                                        <i class="fa fa-1x fa-answer nav-item ml-4"></i> 0--%>
                        <%--                                    </div>--%>
                        <%--                                </div>--%>
                        <%--                            </a>--%>
                        <%--                            <c:if test="${fn:length(question.images) > 1}">--%>
                        <%--                                <div class="multipleImage"><i class="fa fa-1x fa-clone nav-item text-white"></i></div>--%>
                        <%--                            </c:if>--%>
                        <%--                        </div>--%>
                        <%--                    </div>--%>
                        <%--                </c:forEach>--%>

                    </div>
                    <div id="load_data_message"></div>

                    <c:if test="${totalPosts == 0}">
                        <div class="text-center text-muted mt-5">
                            <i class="fa fa-4x fa-table nav-item"></i>
                            <h4>
                                Posts of
                                <c:choose>
                                    <c:when test="${user.username == authUser.username}">yours</c:when>
                                    <c:otherwise>${user.username}</c:otherwise>
                                </c:choose>
                            </h4>
                            <small>No Post Available</small>
                        </div>
                    </c:if>
                    <%--            </div>--%>
                </div>

            </div>

        </div>

        <div class="col-4 pr-0">

            <div class="d-flex text-white text-center  font-weight-bold">
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

                var multipleImages = value.attachments.length > 1;

                post_data += '<div class="col-4 mb-4"><div class="imgHoverContainer w-100 align-content-center" style="height: 300px">';
                post_data += '<a href="/questions/' + value.questionId + '">';
                post_data += '<img src="/images/' + value.attachments[0] + '" class="w-100 imgHoverImage h-100" height="300px">';
                post_data += '<div class="imgHoverMiddle"><div class="imgHoverText">';
                post_data += '<i class="fa fa-1x fa-heart nav-item"></i> ' + value.likeCount + ' <i class="fa fa-1x fa-answer nav-item ml-4"></i> ' + value.commentCount + '';
                post_data += '</div></div></a>';

                if (multipleImages) {
                    post_data += '<div class="multipleImage"><i class="fa fa-1x fa-clone nav-item text-white"></i></div>';
                }

                post_data += '</div></div>';

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