<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>注册 - 校园论坛</title>
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
            max-width: 450px;
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

        .password-strength {
            margin-top: 0.5rem;
            font-size: 0.8rem;
        }

        .strength-bar {
            height: 4px;
            background: #e9ecef;
            border-radius: 2px;
            overflow: hidden;
            margin-top: 0.25rem;
        }

        .strength-fill {
            height: 100%;
            transition: all 0.3s ease;
            width: 0%;
        }

        .strength-weak { background: #e74c3c; }
        .strength-medium { background: #f39c12; }
        .strength-strong { background: #27ae60; }

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

        .btn-primary:disabled {
            background: #ccc;
            cursor: not-allowed;
            transform: none;
            box-shadow: none;
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

        .input-feedback {
            font-size: 0.8rem;
            margin-top: 0.25rem;
            display: none;
        }

        .input-feedback.show {
            display: block;
        }

        .input-feedback.error {
            color: #e74c3c;
        }

        .input-feedback.success {
            color: #27ae60;
        }

        @media (max-width: 480px) {
            body {
                padding: 1rem;
            }

            .auth-card {
                padding: 2rem;
            }
        }
    </style>
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
                <div class="input-feedback" id="usernameFeedback"></div>
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
                <div class="input-feedback" id="emailFeedback"></div>
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
                <div class="input-feedback" id="nicknameFeedback"></div>
            </div>

            <div class="form-group">
                <label for="password">
                    <i class="fas fa-lock"></i>
                    密码
                </label>
                <input type="password" id="password" name="password"
                       placeholder="至少6位密码"
                       required minlength="6">
                <div class="password-strength">
                    <span id="strengthText">密码强度</span>
                    <div class="strength-bar">
                        <div class="strength-fill" id="strengthBar"></div>
                    </div>
                </div>
            </div>

            <div class="form-group">
                <label for="confirmPassword">
                    <i class="fas fa-lock"></i>
                    确认密码
                </label>
                <input type="password" id="confirmPassword" name="confirmPassword"
                       placeholder="请再次输入密码"
                       required minlength="6">
                <div class="input-feedback" id="confirmFeedback"></div>
            </div>

            <button type="submit" class="btn btn-primary" id="submitBtn">
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
    // 表单验证和用户体验增强
    const form = document.querySelector('.auth-form');
    const username = document.getElementById('username');
    const email = document.getElementById('email');
    const nickname = document.getElementById('nickname');
    const password = document.getElementById('password');
    const confirmPassword = document.getElementById('confirmPassword');
    const submitBtn = document.getElementById('submitBtn');

    // 用户名验证
    username.addEventListener('input', function() {
        const value = this.value.trim();
        const feedback = document.getElementById('usernameFeedback');
        const pattern = /^[a-zA-Z0-9_]{3,20}$/;

        if (value.length < 3) {
            showFeedback(feedback, '用户名至少3个字符', 'error');
        } else if (!pattern.test(value)) {
            showFeedback(feedback, '只能包含字母、数字和下划线', 'error');
        } else {
            showFeedback(feedback, '用户名格式正确', 'success');
        }
        checkFormValidity();
    });

    // 邮箱验证
    email.addEventListener('input', function() {
        const value = this.value.trim();
        const feedback = document.getElementById('emailFeedback');
        const pattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

        if (value && !pattern.test(value)) {
            showFeedback(feedback, '邮箱格式不正确', 'error');
        } else if (value) {
            showFeedback(feedback, '邮箱格式正确', 'success');
        } else {
            hideFeedback(feedback);
        }
        checkFormValidity();
    });

    // 昵称验证
    nickname.addEventListener('input', function() {
        const value = this.value.trim();
        const feedback = document.getElementById('nicknameFeedback');

        if (value.length < 2) {
            showFeedback(feedback, '昵称至少2个字符', 'error');
        } else if (value.length > 50) {
            showFeedback(feedback, '昵称不能超过50个字符', 'error');
        } else {
            showFeedback(feedback, '昵称长度合适', 'success');
        }
        checkFormValidity();
    });

    // 密码强度检测
    password.addEventListener('input', function() {
        const value = this.value;
        const strengthBar = document.getElementById('strengthBar');
        const strengthText = document.getElementById('strengthText');

        let strength = 0;
        let strengthLabel = '';
        let strengthClass = '';

        if (value.length >= 6) strength += 1;
        if (value.length >= 8) strength += 1;
        if (/[a-z]/.test(value) && /[A-Z]/.test(value)) strength += 1;
        if (/\d/.test(value)) strength += 1;
        if (/[^a-zA-Z0-9]/.test(value)) strength += 1;

        switch (strength) {
            case 0:
            case 1:
                strengthLabel = '密码强度：弱';
                strengthClass = 'strength-weak';
                break;
            case 2:
            case 3:
                strengthLabel = '密码强度：中等';
                strengthClass = 'strength-medium';
                break;
            case 4:
            case 5:
                strengthLabel = '密码强度：强';
                strengthClass = 'strength-strong';
                break;
        }

        strengthText.textContent = strengthLabel;
        strengthBar.style.width = (strength * 20) + '%';
        strengthBar.className = 'strength-fill ' + strengthClass;

        checkPasswordMatch();
        checkFormValidity();
    });

    // 确认密码验证
    confirmPassword.addEventListener('input', checkPasswordMatch);

    function checkPasswordMatch() {
        const feedback = document.getElementById('confirmFeedback');
        const pass1 = password.value;
        const pass2 = confirmPassword.value;

        if (pass2 && pass1 !== pass2) {
            showFeedback(feedback, '两次密码输入不一致', 'error');
        } else if (pass2 && pass1 === pass2) {
            showFeedback(feedback, '密码匹配', 'success');
        } else {
            hideFeedback(feedback);
        }
        checkFormValidity();
    }

    function showFeedback(element, message, type) {
        element.textContent = message;
        element.className = 'input-feedback show ' + type;
    }

    function hideFeedback(element) {
        element.className = 'input-feedback';
    }

    function checkFormValidity() {
        const isValid = username.value.trim().length >= 3 &&
            email.value.trim() &&
            nickname.value.trim().length >= 2 &&
            password.value.length >= 6 &&
            password.value === confirmPassword.value;

        submitBtn.disabled = !isValid;
    }

    // 表单提交验证
    form.addEventListener('submit', function(e) {
        const usernameVal = username.value.trim();
        const emailVal = email.value.trim();
        const nicknameVal = nickname.value.trim();
        const passwordVal = password.value;
        const confirmPasswordVal = confirmPassword.value;

        if (usernameVal.length < 3 || usernameVal.length > 20) {
            alert('用户名长度必须在3-20个字符之间');
            e.preventDefault();
            return;
        }

        if (!/^[a-zA-Z0-9_]+$/.test(usernameVal)) {
            alert('用户名只能包含字母、数字和下划线');
            e.preventDefault();
            return;
        }

        if (!emailVal || !/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(emailVal)) {
            alert('请输入有效的邮箱地址');
            e.preventDefault();
            return;
        }

        if (nicknameVal.length < 2 || nicknameVal.length > 50) {
            alert('昵称长度必须在2-50个字符之间');
            e.preventDefault();
            return;
        }

        if (passwordVal.length < 6) {
            alert('密码长度不能少于6位');
            e.preventDefault();
            return;
        }

        if (passwordVal !== confirmPasswordVal) {
            alert('两次密码输入不一致');
            e.preventDefault();
            return;
        }
    });

    // 初始检查
    checkFormValidity();
</script>
</body>
</html>