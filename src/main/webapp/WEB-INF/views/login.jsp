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
            <h3 class="font-weight-bolder">Log in</h3>
            <h6 class="pb-4 small">Don't have an account? <a href="/signup">Sign Up</a></h6>

            <c:if test="${error == 'true'}">
                <div class="alert alert-danger">Wrong username or
                    password
                </div>
            </c:if>
            <c:if test="${success == 'true'}">
                <div class="alert alert-success">Registration Successful! <br>Please Login</div>
            </c:if>
            <form action="${pageContext.request.contextPath }/login-processing"
                  method="POST">
                <div class="form-group">
                    <label for="username" class="small font-weight-bold">Username</label>
                    <input
                            type="text" class="form-control" id="username"
                            aria-describedby="emailHelp" placeholder="Username"
                            value=""
                            name="username">
                </div>
                <div class="form-group">
                    <label for="password" class="small font-weight-bold">Password</label>
                    <input
                            type="password" class="form-control" id="password"
                            placeholder="Password" name="password" value="">
                </div>
                <button type="submit"
                        class="btn btn-warning btn-block">Log in
                </button>
            </form>
        </c:if>
    </div>
</div>

<!-- FOOTER -->
<jsp:include page="common/footer.jsp"/>