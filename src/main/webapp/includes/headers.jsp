<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 头部导航 -->
<header class="header">
    <div class="container">
        <div class="nav-brand">
            <h1><i class="fas fa-graduation-cap"></i> 校园论坛</h1>
        </div>
        <nav class="nav-menu">
            <a href="${pageContext.request.contextPath}/index.jsp">首页</a>
            <a href="${pageContext.request.contextPath}/posts">帖子</a>
            <a href="${pageContext.request.contextPath}/about.jsp">关于</a>

            <c:choose>
                <c:when test="${not empty sessionScope.currentUser}">
                    <div class="user-menu">
                        <span class="welcome">欢迎，${sessionScope.currentUser.nickname}</span>
                        <a href="${pageContext.request.contextPath}/user/profile.jsp">个人中心</a>
                        <a href="${pageContext.request.contextPath}/user/createPost.jsp">发布帖子</a>
                        <c:if test="${sessionScope.currentUser.role == 'admin'}">
                            <a href="${pageContext.request.contextPath}/admin/dashboard.jsp">管理后台</a>
                        </c:if>
                        <a href="${pageContext.request.contextPath}/logout">退出</a>
                    </div>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/login">登录</a>
                    <a href="${pageContext.request.contextPath}/register" class="btn-primary">注册</a>
                </c:otherwise>
            </c:choose>
        </nav>
    </div>
</header>