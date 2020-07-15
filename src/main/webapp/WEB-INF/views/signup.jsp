<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!-- HEADER -->
<jsp:include page="common/header.jsp"/>

<%-- if user is not logged in, redirect--%>
<c:if test="${pageContext.request.userPrincipal.name != null}">
    <meta http-equiv="Refresh" content="0; url=/">
</c:if>

<!-- MAIN CONTENT OF THE PAGE -->
<div class="container mt-3" style="max-width: 450px">
    <div class="card card-body">
        <c:if test="${pageContext.request.userPrincipal.name == null}">
            <h3 class="font-weight-bolder">Sign up</h3>
            <h6 class="pb-4 small">Already have an account? <a href="${root}/login">Log in</a></h6>

            <c:if test="${error == 'true'}">
                <div class="alert alert-danger" role="alert" id="success-alert">Wrong username or
                    password
                </div>
            </c:if>

            <form:form action="${root}/signup-processing"
                       modelAttribute="user" method="post">

                <div class="form-group">
                    <label for="username" class="small font-weight-bold">Username <span id="Result"></span></label>
                    <form:input path="username" class="form-control" id="username" required="required"/>
                </div>

                <div class="form-group">
                    <label for="fullname" class="small font-weight-bold">Full Name</label>
                    <form:input path="fullName" class="form-control" required="required" id="fullname"/>
                </div>

                <div class="form-group">
                    <label for="email" class="small font-weight-bold">Email</label>
                    <form:input path="email" class="form-control" type="email" required="required"/>
                </div>

                <div class="form-group">
                    <label for="password" class="small font-weight-bold">Password</label>
                    <form:input path="password" class="form-control" type="password" id="password"
                                required="required"/>
                </div>

                <div class="form-group">
                    <label for="confirm_password" class="small font-weight-bold">Confirm Password</label>
                    <form:input path="" class="form-control" type="password" id="confirm_password"
                                required="required"/>
                </div>


                <input type="submit" name="submit" value="Sign up"
                       class="btn btn-warning btn-block" id="btnSubmit">

                <h6 class="text-muted text-center font-weight-bold mt-3 small">
                    By signing up, you agree to our <a href="/terms">Terms</a>, <a href="/data_policy">Data Policy</a>
                    and <a href="/cookie_policy">Cookies Policy</a>.
                </h6>

            </form:form>

        </c:if>

    </div>
</div>

<script>
    var password = document.getElementById("password")
        , confirm_password = document.getElementById("confirm_password");

    function validatePassword() {
        if (password.value !== confirm_password.value) {
            confirm_password.setCustomValidity("Password doesn't match");
        } else {
            confirm_password.setCustomValidity('');
        }
    }

    password.onchange = validatePassword;
    confirm_password.onkeyup = validatePassword;

</script>

<script type="text/javascript">
    $(document).ready(function () {
        $('#username').focusout(function () {

            if ($('#username').val().length > 0) {
                $.get("/users/is_available", {
                    username: $('#username').val()
                }, function (response) {
                    $('#Result').fadeOut();
                    setTimeout("finishAjax('Result', '" + escape(response) + "')", 400);
                });
            }

            return false;

        });
    });

    function finishAjax(id, response) {
        $('#Result').hide();
        if (response === "true") {
            $('#btnSubmit').prop('disabled', false);
            response = "<span class='badge badge-success'>" + "Available" + "</div>";
        } else {
            $('#btnSubmit').prop('disabled', true);
            response = "<span class='badge badge-danger'>" + "Unavailable" + "</div>";
        }
        $('#' + id).html(unescape(response));
        $('#' + id).fadeIn();

    }
</script>

<!-- FOOTER -->
<jsp:include page="common/footer.jsp"/>