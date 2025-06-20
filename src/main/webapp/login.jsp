<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>登录 - 校园论坛</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Microsoft YaHei', 'SimSun', Arial, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 2rem;
        }

        .auth-container {
            width: 100%;
            max-width: 400px;
        }

        .auth-card {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            padding: 3rem;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.2);
            animation: slideInUp 0.6s ease;
        }

        @keyframes slideInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .auth-header {
            text-align: center;
            margin-bottom: 2rem;
        }

        .auth-header h1 {
            color: #667eea;
            font-size: 1.8rem;
            margin-bottom: 0.5rem;
        }

        .auth-header h2 {
            color: #666;
            font-size: 1.2rem;
            font-weight: normal;
        }

        .alert {
            padding: 1rem;
            border-radius: 10px;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .alert-error {
            background: #ffe6e6;
            color: #d63031;
            border: 1px solid #fab1a0;
        }

        .alert-success {
            background: #e6ffe6;
            color: #00b894;
            border: 1px solid #81ecec;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-group label {
            display: block;
            margin-bottom: 0.5rem;
            color: #333;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .form-group input {
            width: 100%;
            padding: 1rem;
            border: 2px solid #e9ecef;
            border-radius: 10px;
            font-size: 1rem;
            transition: all 0.3s ease;
            background: rgba(255, 255, 255, 0.9);
        }

        .form-group input:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
            background: white;
        }

        .form-options {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
            font-size: 0.9rem;
        }

        .checkbox-label {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            cursor: pointer;
            color: #666;
        }

        .checkbox-label input[type="checkbox"] {
            width: auto;
            margin: 0;
        }

        .forgot-link {
            color: #667eea;
            text-decoration: none;
        }

        .forgot-link:hover {
            text-decoration: underline;
        }

        .btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
            padding: 1rem 2rem;
            border: none;
            border-radius: 10px;
            font-size: 1rem;
            font-weight: 600;
            text-decoration: none;
            cursor: pointer;
            transition: all 0.3s ease;
            width: 100%;
        }

        .btn-primary {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 30px rgba(102, 126, 234, 0.4);
        }

        .auth-footer {
            text-align: center;
            margin-top: 2rem;
            color: #666;
        }

        .auth-footer p {
            margin-bottom: 0.5rem;
        }

        .auth-footer a {
            color: #667eea;
            text-decoration: none;
            font-weight: 500;
        }

        .auth-footer a:hover {
            text-decoration: underline;
        }

        @media (max-width: 480px) {
            body {
                padding: 1rem;
            }

            .auth-card {
                padding: 2rem;
            }

            .form-options {
                flex-direction: column;
                gap: 1rem;
                align-items: flex-start;
            }
        }
    </style>
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
                    记住我
                </label>
                <a href="#" class="forgot-link">忘记密码？</a>
            </div>

            <button type="submit" class="btn btn-primary">
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