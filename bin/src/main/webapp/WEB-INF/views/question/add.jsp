<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<!-- HEADER -->
<jsp:include page="../common/header.jsp"/>

<!-- MAIN CONTENT OF THE PAGE -->
<div class="container mt-4">

    <div class="row">
        <div class="col-8">
            <div class="card card-body">

                <h3 class="font-weight-bolder">${ pageTitle }</h3>

                <form:form action="${pageContext.request.contextPath }/questions/ask"
                           modelAttribute="question"
                           enctype="multipart/form-data">

                    <div class="form-group">
                        <label>Title</label>
                        <form:input path="title" class="form-control" required="required"/>
                    </div>

                    <div class="form-group">
                        <label>Description</label>
                        <form:textarea path="description" id="summernote" class="form-control" required="required"/>
                    </div>

                    <div class="form-group">
                        <label>Attachment</label> <br>
                        <input type="file" name="files" multiple/>
                    </div>

                    <div class="float-right">

                        <a href="/questions"
                           class="btn btn-secondary small font-weight-bold pl-4 pr-4 pt-1 pb-1">Cancel</a>

                        <input type="submit" name="submit" value="POST"
                               class="btn btn-warning small font-weight-bold  pl-4 pr-4 pt-1 pb-1 ml-2"
                               id="btnSubmit">
                    </div>
                </form:form>
            </div>
        </div>

        <div class="col-4 pr-0">

            <a href="/questions" class="btn btn-outline-light pl-4 pr-4 pt-1 pb-1 btn-block mb-4"><small
                    class="font-weight-bold">BACK TO
                QUESTIONS</small></a>

            <div class="card mb-3">
                <div class="card-body">

                    <h6 class="font-weight-bold border-bottom pb-2">Tips for asking question</h6>
                    <div class=" text-dark">
                        The community is here to help you with specific coding, algorithm, or language problems.
                        <br>
                        <br>
                        Avoid asking opinion-based questions.
                        <br>
                        <br>
                    </div>
                    <div class="accordion" id="accordionExample">
                        <div class="card">
                            <div class="card-header p-0" id="headingOne">
                                <h2 class="mb-0">
                                    <button class="btn btn-block font-weight-bold" type="button" data-toggle="collapse"
                                            data-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                                        Summarize the problem
                                    </button>
                                </h2>
                            </div>

                            <div id="collapseOne" class="collapse show" aria-labelledby="headingOne"
                                 data-parent="#accordionExample">
                                <div class="card-body text-dark">
                                    <ul>
                                        <li>Include details about your goal</li>

                                        <li>Describe expected and actual results</li>

                                        <li>Include any error messages</li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <div class="card">
                            <div class="card-header p-0" id="headingTwo">
                                <h2 class="mb-0">
                                    <button class="btn collapsed btn-block font-weight-bold" type="button"
                                            data-toggle="collapse"
                                            data-target="#collapseTwo" aria-expanded="false"
                                            aria-controls="collapseTwo">
                                        Describe What you've tried
                                    </button>
                                </h2>
                            </div>
                            <div id="collapseTwo" class="collapse" aria-labelledby="headingTwo"
                                 data-parent="#accordionExample">
                                <div class="card-body text-dark">
                                    Show what you?ve tried and tell us what you found (on this site or elsewhere) and
                                    why it didn?t meet your needs. You can get better answers when you provide research.
                                </div>
                            </div>
                        </div>
                        <div class="card">
                            <div class="card-header p-0" id="headingThree">
                                <h2 class="mb-0">
                                    <button class="btn collapsed btn-block font-weight-bold" type="button"
                                            data-toggle="collapse"
                                            data-target="#collapseThree" aria-expanded="false"
                                            aria-controls="collapseThree">
                                        Show some code
                                    </button>
                                </h2>
                            </div>
                            <div id="collapseThree" class="collapse" aria-labelledby="headingThree"
                                 data-parent="#accordionExample">
                                <div class="card-body text-dark">
                                    When appropriate, share the minimum amount of code others need to reproduce your
                                    problem (also called a minimum, reproducible example)
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>


            <jsp:include page="../common/sidebar-footer.jsp"/>

        </div>

    </div>
</div>

<!-- FOOTER -->
<jsp:include page="../common/footer.jsp"/>
<script>
    $(document).ready(function () {
        $('#summernote').summernote({
            tabsize: 2,
            height: 240,
            toolbar: [
                ['style', ['style']],
                ['font', ['bold', 'underline', 'clear']],
                ['color', ['color']],
                ['para', ['ul', 'ol', 'paragraph']],
                ['insert', ['link']],
                ['view', ['help']]
            ]
        });
        $('#summernote').summernote('code', '');
    });
</script>

