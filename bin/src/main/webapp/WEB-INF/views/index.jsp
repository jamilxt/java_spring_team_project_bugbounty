<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!-- GLOBAL HEADER -->
<jsp:include page="common/header.jsp"/>


<div id="load_data"></div>
<div id="load_data_message"></div>

<!-- MAIN CONTENT OF THE PAGE -->
<div class="container  mt-4">


    <div class="row">

        <div class="col-8">

            <div class="card mb-5">
                <div class="card-body">
                    <h3 class="mb-3">Q&A Discussions</h3>

                    <div class="row mt-4 mb-4">

                        <div class="col-4">
                            <a href="${pageContext.request.contextPath}/questions/ask" class="btn btn-warning pl-4 pr-4 pt-1 pb-1">
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
                    <div class="row pt-3">
                        <div class="col-2  border-right">
                            <div class="col">
                                <div class="row-4 small text-center">13<br><i
                                        class="fa fa-sm fa-thumbs-up text-secondary"></i>
                                </div>
                                <div class="row-4 small text-center mt-3">83<br> <i
                                        class="fa fa-sm fa-comment text-secondary"></i>
                                </div>
                                <div class="row-4 small text-center mt-3">122<br> <i
                                        class="fa fa-sm fa-eye text-secondary"></i>
                                </div>
                            </div>
                        </div>
                        <div class="col-10">
                            <div>
                                <a href="/p/3" class="text-dark font-weight-bold">Changing a variables number part
                                    periodically after each use</a>
                            </div>
                            <div class="">
                                <a href="#" class="badge badge-warning p-2 mt-2">Java</a>
                                <a href="#" class="badge badge-warning p-2 mt-2">Python</a>
                                <a href="#" class="badge badge-warning p-2 mt-2">Spring</a>
                                <a href="#" class="badge badge-warning p-2 mt-2">C++</a>
                                <a href="#" class="badge badge-warning p-2 mt-2">C#</a>
                                <a href="#" class="badge badge-warning p-2 mt-2">COBOL</a>
                                <a href="#" class="badge badge-warning p-2 mt-2">GO</a>
                                <a href="#" class="badge badge-warning p-2 mt-2">OAuth</a>
                                <a href="#" class="badge badge-warning p-2 mt-2">Bug</a>
                            </div>
                            <div>
                                <a href="${pageContext.request.contextPath}/<sec:authentication property="principal.username" />"
                                   class="font-weight-bold text-dark float-right">
                                    <img src="${pageContext.request.contextPath}/images/${authUser.propic}"
                                         class="rounded-circle border border-light align-middle"
                                         width="35px" height="35px">
                                </a>
                                <div class="float-right text-right mr-3">
                                    <a href="${pageContext.request.contextPath}/<sec:authentication property="principal.username" />"
                                       class="text-warning small">
                                        admin
                                    </a>
                                    <h6 class="text-secondary small text-right">2 hours ago</h6>
                                </div>
                            </div>
                        </div>
                    </div>
                    <hr>


                </div>
            </div>
        </div>


        <jsp:include page="common/sidebar.jsp"/>

    </div>

</div>

<script>

    var pageCounter = 0;
    var username = "${user.username}";
    haveMore = false;

    loadPosts(username, pageCounter);

    function loadPosts(username, page) {
        $.getJSON("/api/v1/questions/all?&page=" + page, function (data) {
            console.log(data);
            var post_data = '';
            $.each(data, function (key, value) {

                // var multipleImages = value.images.length > 1;
                //
                // post_data += '<div class="col-4 mb-4"><div class="imgHoverContainer w-100 align-content-center" style="height: 300px">';
                // post_data += '<a href="/p/' + value.postId + '">';
                // post_data += '<img src="/images/' + value.images[0] + '" class="w-100 imgHoverImage h-100" height="300px">';
                // post_data += '<div class="imgHoverMiddle"><div class="imgHoverText">';
                // post_data += '<i class="fa fa-1x fa-heart nav-item"></i> ' + value.likeCount + ' <i class="fa fa-1x fa-answer nav-item ml-4"></i> ' + value.commentCount + '';
                // post_data += '</div></div></a>';
                //
                // if (multipleImages) {
                //     post_data += '<div class="multipleImage"><i class="fa fa-1x fa-clone nav-item text-white"></i></div>';
                // }
                //
                // post_data += '</div></div>';

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

</script>


<!-- GLOBAL FOOTER -->
<jsp:include page="common/footer.jsp"/>