<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>注册 - 校园论坛</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/auth.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
<div class="auth-container">
    <div class="auth-card">
        <div class="auth-header">
            <h1><i class="fas fa-graduation-cap"></i> 校园论坛</h1>
            <h2>用户注册</h2>
        </div>

        <!-- 错误提示 -->
        <c:if test="${not empty errorMsg}">
            <div class="alert alert-error">
                <i class="fas fa-exclamation-circle"></i>
                    ${errorMsg}
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/register" method="post" class="auth-form">
            <div class="form-group">
                <label for="username">
                    <i class="fas fa-user"></i>
                    用户名
                </label>
                <input type="text" id="username" name="username"
                       value="${username}"
                       placeholder="3-20位字母数字下划线"
                       required maxlength="20" minlength="3">
            </div>

            <div class="form-group">
                <label for="email">
                    <i class="fas fa-envelope"></i>
                    邮箱
                </label>
                <input type="email" id="email" name="email"
                       value="${email}"
                       placeholder="请输入邮箱地址"
                       required maxlength="100">
            </div>

            <div class="form-group">
                <label for="nickname">
                    <i class="fas fa-id-card"></i>
                    昵称
                </label>
                <input type="text" id="nickname" name="nickname"
                       value="${nickname}"
                       placeholder="请输入昵称"
                       required maxlength="50">
            </div>

            <div class="form-group">
                <label for="password">
                    <i class="fas fa-lock"></i>
                    密码
                </label>
                <input type="password" id="password" name="password"
                       placeholder="至少6位密码"
                       required minlength="6">
            </div>

            <div class="form-group">
                <label for="confirmPassword">
                    <i class="fas fa-lock"></i>
                    确认密码
                </label>
                <input type="password" id="confirmPassword" name="confirmPassword"
                       placeholder="请再次输入密码"
                       required minlength="6">
            </div>

            <button type="submit" class="btn btn-primary btn-full">
                <i class="fas fa-user-plus"></i>
                注册
            </button>
        </form>

        <div class="auth-footer">
            <p>已有账号？ <a href="${pageContext.request.contextPath}/login">立即登录</a></p>
            <p><a href="${pageContext.request.contextPath}/index.jsp">返回首页</a></p>
        </div>
    </div>
</div>

<script>
    // 表单验证
    document.querySelector('.auth-form').addEventListener('submit', function(e) {
        const username = document.getElementById('username').value.trim();
        const email = document.getElementById('email').value.trim();
        const nickname = document.getElementById('nickname').value.trim();
        const password = document.getElementById('password').value;
        const confirmPassword = document.getElementById('confirmPassword').value;

        if (!username) {
            alert('请输入用户名');
            e.preventDefault();
            return;
        }

        if (username.length < 3 || username.length > 20) {
            alert('用户名长度必须在3-20个字符之间');
            e.preventDefault();
            return;
        }

        if (!/^[a-zA-Z0-9_]+$/.test(username)) {
            alert('用户名只能包含字母、数字和下划线');
            e.preventDefault();
            return;
        }

        if (!email) {
            alert('请输入邮箱');
            e.preventDefault();
            return;
        }

        if (!nickname) {
            alert('请输入昵称');
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

        if (password !== confirmPassword) {
            alert('两次输入的密码不一致');
            e.preventDefault();
            return;
        }
    });

    // 自动聚焦到用户名输入框
    document.getElementById('username').focus();

    // 密码确认实时验证
    document.getElementById('confirmPassword').addEventListener('input', function() {
        const password = document.getElementById('password').value;
        const confirmPassword = this.value;

        if (confirmPassword && password !== confirmPassword) {
            this.style.borderColor = '#dc3545';
        } else {
            this.style.borderColor = '#e9ecef';
        }
    });
</script>
</body>
</html>