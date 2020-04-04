<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!-- HEADER -->
<jsp:include page="../common/header.jsp"/>

<!-- MAIN CONTENT OF THE PAGE -->
<div class="container mt-4">

    <div class="row">

        <div class="col-8">
            <div class="card">
                <div class="card-body">

                    <div class="media">
                        <button class="btn btn-light" id="likeUnlike" style="width: 60px">
                            <span class="text-muted font-weight-bold small"
                                  id="totalLikeCounter">${totalLikes}</span><br>
                            <i class="fa fa-1x fa-caret-up ${isAlreadyLiked ? 'text-success' : 'text-muted'}"
                               id="isAlreadyLiked"></i>
                        </button>
                        <div class="media-body ml-3">
                            <div>
                                <h5 class="text-dark font-weight-bold">${singleQuestion.title}</h5>
                                <div class="text-dark">
                                    ${singleQuestion.description}
                                    <c:if test="${fn:length(singleQuestion.attachments) > 0}">
                                        <div class="small">
                                            <h6 class="text-muted small font-weight-bold mt-3">
                                                <i class="fa fa-paperclip text-muted"></i> Attachments
                                            </h6>

                                            <ol>
                                                <c:forEach items="${singleQuestion.attachments}" var="attachment">
                                                    <li><a href="/images/${attachment}">${attachment}</a></li>
                                                </c:forEach>
                                            </ol>

                                        </div>
                                    </c:if>
                                </div>
                            </div>
                            <div class="d-none">
                                <a href="#" class="badge badge-warning p-2 mt-2">Java</a>
                                <a href="#" class="badge badge-warning p-2 mt-2">Python</a>
                                <a href="#" class="badge badge-warning p-2 mt-2">Spring</a>
                                <a href="#" class="badge badge-warning p-2 mt-2">C++</a>
                                <a href="#" class="badge badge-warning p-2 mt-2">C#</a>
                            </div>
                            <div class="media text-right mt-3">
                                <div class="media-body">
                                    <a href="/${singleQuestion.user.username}"
                                       class="text-dark small font-weight-bold">${singleQuestion.user.username}</a>
                                    <h6 class="text-secondary small">${singleQuestion.views}
                                        view${singleQuestion.views > 0 ? 's' : ''}
                                        · ${postedAt}</h6>
                                </div>
                                <a href="/${singleQuestion.user.username}"
                                   class="font-weight-bold text-dark ml-3">
                                    <img src="/images/${singleQuestion.user.propic}"
                                         class="rounded-circle border border-light align-middle"
                                         width="40px" height="40px">
                                </a>
                            </div>
                        </div>
                    </div>

                </div>
            </div>

            <div class="text-center mt-3 mb-3">
                <button class="btn btn-outline-light pl-4 pr-4 pt-1 pb-1" data-toggle="collapse"
                        data-target="#collapseExample" aria-expanded="false" aria-controls="collapseExample"
                        id="collapseExampleBtn"><small class="font-weight-bold">POST NEW
                    ANSWER</small></button>
            </div>

            <div class="collapse" id="collapseExample">
                <div class="card">
                    <div class="card-body">
                        <h6 class="font-weight-bold text-dark mb-3 small">NEW ANSWER</h6>
                        <div class="media">
                            <img src="${pageContext.request.contextPath}/images/${authUser.propic}"
                                 class="rounded-circle border border-light align-middle mr-2"
                                 width="60px" height="60px">
                            <div class="media-body ml-2">
                                <h6 class="font-weight-bold text-dark">${authUser.username}</h6>
                                <textarea placeholder="Write your reply here" class="form-text form-control"
                                          id="answerText"></textarea>
                                <div class="float-right mt-3">
                                    <input type="submit" value="POST"
                                           class="btn btn-warning small font-weight-bold  pl-4 pr-4 pt-1 pb-1"
                                           id="postComment">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="media font-weight-bold text-white mt-3 mb-3 small align-middle">
                <div class="media-body mt-2">
                    <span id="totalCommentCounter" class="ml-4">${totalAnswers}</span>
                    ANSWER${totalAnswers > 0 ? 'S' : ''}

                </div>
                <div class="form-inline">
                    Sort By
                    <select class="custom-select ml-3" id="exampleFormControlSelect1">
                        <option>Date</option>
                    </select>
                </div>
            </div>


            <div class="${totalAnswers > 0 ? 'card' : ''}  mt-4 mb-4">

                <ul class="list-group list-group-flush">

                    <div id="load_answers"></div>

                </ul>
            </div>

            <c:if test="${totalAnswers > 10}">
                <div id="load_data_message" class="text-center">
                    <button class="btn btn-outline-light mt-3 d-none" id="loadMore">
                        <small>LOAD MORE</small>
                    </button>
                </div>
            </c:if>


        </div>

        <div class="col-4 pr-0">

            <a href="/questions" class="btn btn-outline-light pl-4 pr-4 pt-1 pb-1 btn-block mb-4"><small class="font-weight-bold">BACK TO
                QUESTIONS</small></a>

            <div class="card">
                <div class="card-body">

                    <h6 class="font-weight-bold border-bottom pb-2 small">
                        More Questions from <a href="/${singleQuestion.user.username}">${singleQuestion.user.username}</a>
                    </h6>

                    <c:forEach items="${relatedQuestions}" var="question">
                        <div class="media mb-2">
                            <i class="fa fa-sm fa-question-circle text-muted align-self-start"></i>
                            <div class="media-body ml-3 small">
                                <a href="/questions/${question.questionId}" class="text-dark">${question.title}</a>
                            </div>
                        </div>
                    </c:forEach>

                </div>
            </div>
        </div>

    </div>

</div>

<script>
    pageCounter = 0;
    questionId = ${singleQuestion.questionId};
    haveMore = false;
    loadComments(questionId, pageCounter);

    function loadComments(questionId, page) {
        $.getJSON("/api/v1/question/answers?questionId=" + questionId + "&page=" + page, function (data) {
            var answer_data = '';
            var dataR = data;
            // if (page === 0) {
            //     dataR = data.reverse;
            // }
            $.each(dataR, function (key, value) { // reverse array for last answer
                answer_data += '<li class="list-group-item" id="answerId' + value.answerId + '">';

                answer_data += '<div class="media mt-2">';
                answer_data += '<div style="width: 60px">';
                answer_data += '<button class="btn btn-light btn-block" disabled>';
                answer_data += '<span class="text-muted font-weight-bold small">0</span><br>';
                answer_data += '<i class="fa fa-1x fa-caret-up text-muted}"></i>';
                answer_data += '</button>';
                answer_data += '<button class="btn btn-light btn-block d-none" disabled>';
                answer_data += '<i class="fa fa-sm fa-check text-muted"></i>';
                answer_data += '</button>';
                answer_data += '</div>';

                answer_data += '<div class="media-body ml-3 text-dark">';
                answer_data += value.answerText;

                answer_data += '<div class="media text-right mt-5">';
                answer_data += '<div class="media-body">';
                answer_data += '<a href="/' + value.username + '" class="text-dark small font-weight-bold">' + value.username + '</a>';
                answer_data += '<h6 class="text-secondary small">' + value.created_at + '</h6>';
                answer_data += '</div>';
                answer_data += '<a href="/' + value.username + '" class="font-weight-bold text-dark ml-3">';
                answer_data += '<img src="/images/' + value.propic + '" class="rounded-circle border border-light align-middle" width="40px" height="40px">';
                answer_data += '</a>';
                answer_data += '</div>';

                answer_data += '</div>';

                answer_data += '</div>';
                answer_data += '</li>';
            });

            $('#load_answers').append(answer_data);
            if (data.length > 9) {
                haveMore = true;
            } else {
                haveMore = false;
            }
        });

        pageCounter = pageCounter + 1;
    }

    $('#loadMore').on('click', function () {
        if (haveMore) {
            loadComments(questionId, pageCounter);
            $('.answerDiv').fadeIn();
        } else {
            $('#load_data_message').html('');
        }
    });

    $(window).scroll(function () {
        if ($(window).scrollTop() + $(window).height() >= $(document).height()) {
            if (haveMore) {
                loadComments(questionId, pageCounter);
            } else {
                $('#load_data_message').html('End of the answers<br><br>');
            }
        }
    });

    // $(document).ready(function () {
    //     $('#newAnswer').hide();
    // });
    //
    // $('#showNewAnswer').click(function () {
    //     $("#newAnswer").toggle(400);
    // });


    // $('#answer_section').on('scroll', function () {
    //     let div = $(this).get(0);
    //     if (div.scrollTop + div.clientHeight >= div.scrollHeight) {
    //         if (haveMore) {
    //             loadComments(questionId, pageCounter);
    //         } else {
    //             $('#load_data_message').html('<div class="card-header small text-center">End of answers</div>');
    //         }
    //     }
    // });

    // gotoBottomOfCommentSection();

    function gotoBottomOfCommentSection() {
        var scroll = $('#answer_section');
        scroll.animate({scrollTop: scroll.height() + 600}, 1500);
    }

    $('#postComment').on('click', function () {
        addComment();
    });


    var cmntText = $('#answerText');

    // cmntText.summernote('code', '');

    function addComment() {
        $.post("/api/v1/question/answers/add", {
            questionId: ${singleQuestion.questionId},
            answerText: cmntText.val(),
        }, function (data, status) {
            // $('#postComment').prop('disabled', true);
            $('#answerText').summernote('code', '');
            $('#collapseExampleBtn').click();
            cmntText.val('');
            console.log(data + ' ' + status);
            var last_answer = '';

            last_answer += '<li class="list-group-item bg-light" id="answerId' + data.answerId + '">';

            last_answer += '<div class="media mt-2">';
            last_answer += '<div style="width: 60px">';
            last_answer += '<button class="btn btn-light btn-block" disabled>';
            last_answer += '<span class="text-muted font-weight-bold small">0</span><br>';
            last_answer += '<i class="fa fa-sm fa-chevron-up text-muted"></i>';
            last_answer += '</button>';
            last_answer += '<button class="btn btn-light btn-block d-none" disabled>';
            last_answer += '<i class="fa fa-sm fa-check text-muted"></i>';
            last_answer += '</button>';
            last_answer += '</div>';

            last_answer += '<div class="media-body ml-3 text-dark">';
            last_answer += data.answerText;

            last_answer += '<div class="media text-right mt-5">';
            last_answer += '<div class="media-body">';
            last_answer += '<a href="/' + data.username + '" class="text-dark small font-weight-bold">' + data.username + '</a>';
            last_answer += '<h6 class="text-secondary small">' + data.created_at + '</h6>';
            last_answer += '</div>';
            last_answer += '<a href="/' + data.username + '" class="font-weight-bold text-dark ml-3">';
            last_answer += '<img src="/images/' + data.propic + '" class="rounded-circle border border-light align-middle" width="40px" height="40px">';
            last_answer += '</a>';
            last_answer += '</div>';

            last_answer += '</div>';

            last_answer += '</div>';
            last_answer += '</li>';

            $('#load_answers').prepend(last_answer);
            $('#totalCommentCounter').html(data.totalAnswers);
            $('#totalLikeCounter').html(data.totalLikes);
            var cmntId = "#answerId" + data.answerId;
            $(cmntId).removeClass('bg-light', 3000).fadeIn();
            gotoBottomOfCommentSection();
        });
    }

    // cmntText.on('keyup', function () {
    //     var buttonDisabled = $(cmntText).val().trim() === '';
    //     $('#postComment').prop('disabled', buttonDisabled);
    // });


    // cmntText.on('keypress', function (e) {
    //     if (cmntText.val().trim().length > 0) {
    //         if (e.which === 13) {
    //             addComment();
    //         }
    //     }
    // });


    var caption = $('#captionText');
    var captionValue = caption.text();
    console.log(captionValue);
    var captionRegex = captionValue.replace(/#(\S*)/g, '<a href="/explore/tags/$1">#$1</a>');
    captionRegex = captionRegex.replace(/@(\S*)/g, '<a href="/$1">@$1</a>');
    caption.html(captionRegex);

    console.log(captionRegex);

    $('#likeUnlike').on('click', function () {
        addLike();
    });


    function addLike() {
        $.post("/api/v1/question/like", {
            questionId: ${singleQuestion.questionId},
        }, function (data, status) {
            $('#totalLikeCounter').html(data.totalLikes);
            if (data.isAlreadyLiked) {
                $('#isAlreadyLiked').toggleClass('text-muted text-success')
            } else {
                $('#isAlreadyLiked').toggleClass('text-success text-muted')
            }
        });
    }

</script>


<!-- FOOTER -->
<jsp:include page="../common/footer.jsp"/>

<script>
    $(document).ready(function () {
        $('#answerText').summernote({
            tabsize: 2,
            code: '',
            height: 180,
            toolbar: [
                ['style', ['style']],
                ['font', ['bold', 'underline', 'clear']],
                ['color', ['color']],
                ['para', ['ul', 'ol', 'paragraph']],
                ['insert', ['link']],
                ['view', ['help']]
            ]
        });
        $('#answerText').summernote('code', '');
    });
</script>