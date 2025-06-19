<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>登录 - 校园论坛</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/auth.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
<div class="auth-container">
    <div class="auth-card">
        <div class="auth-header">
            <h1><i class="fas fa-graduation-cap"></i> 校园论坛</h1>
            <h2>用户登录</h2>
        </div>

        <!-- 错误提示 -->
        <c:if test="${not empty errorMsg}">
            <div class="alert alert-error">
                <i class="fas fa-exclamation-circle"></i>
                    ${errorMsg}
            </div>
        </c:if>

        <!-- 成功提示 -->
        <c:if test="${not empty successMsg}">
            <div class="alert alert-success">
                <i class="fas fa-check-circle"></i>
                    ${successMsg}
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/login" method="post" class="auth-form">
            <div class="form-group">
                <label for="username">
                    <i class="fas fa-user"></i>
                    用户名
                </label>
                <input type="text" id="username" name="username"
                       value="${username}"
                       placeholder="请输入用户名"
                       required maxlength="20">
            </div>

            <div class="form-group">
                <label for="password">
                    <i class="fas fa-lock"></i>
                    密码
                </label>
                <input type="password" id="password" name="password"
                       placeholder="请输入密码"
                       required minlength="6">
            </div>

            <div class="form-options">
                <label class="checkbox-label">
                    <input type="checkbox" name="remember">
                    <span class="checkmark"></span>
                    记住我
                </label>
                <a href="#" class="forgot-link">忘记密码？</a>
            </div>

            <button type="submit" class="btn btn-primary btn-full">
                <i class="fas fa-sign-in-alt"></i>
                登录
            </button>
        </form>

        <div class="auth-footer">
            <p>还没有账号？ <a href="${pageContext.request.contextPath}/register">立即注册</a></p>
            <p><a href="${pageContext.request.contextPath}/index.jsp">返回首页</a></p>
        </div>
    </div>
</div>

<script>
    // 表单验证
    document.querySelector('.auth-form').addEventListener('submit', function(e) {
        const username = document.getElementById('username').value.trim();
        const password = document.getElementById('password').value;

        if (!username) {
            alert('请输入用户名');
            e.preventDefault();
            return;
        }

        if (!password) {
            alert('请输入密码');
            e.preventDefault();
            return;
        }

        if (password.length < 6) {
            alert('密码长度不能少于6位');
            e.preventDefault();
            return;
        }
    });

    // 自动聚焦到用户名输入框
    document.getElementById('username').focus();
</script>
</body>
</html>