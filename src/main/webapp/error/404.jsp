<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>页面不存在 - 校园论坛</title>
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
            color: white;
        }

        .error-container {
            text-align: center;
            padding: 3rem;
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.2);
            max-width: 500px;
            width: 90%;
        }

        .error-code {
            font-size: 8rem;
            font-weight: bold;
            margin-bottom: 1rem;
            background: linear-gradient(45deg, #ff6b6b, #ffa500);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            animation: bounce 2s infinite;
        }

        @keyframes bounce {
            0%, 20%, 50%, 80%, 100% {
                transform: translateY(0);
            }
            40% {
                transform: translateY(-10px);
            }
            60% {
                transform: translateY(-5px);
            }
        }

        .error-title {
            font-size: 2rem;
            margin-bottom: 1rem;
            color: white;
        }

        .error-message {
            font-size: 1.1rem;
            margin-bottom: 2rem;
            opacity: 0.9;
            line-height: 1.6;
        }

        .error-actions {
            display: flex;
            gap: 1rem;
            justify-content: center;
            flex-wrap: wrap;
        }

        .btn {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            padding: 1rem 2rem;
            border-radius: 10px;
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .btn-primary {
            background: rgba(255, 255, 255, 0.2);
            color: white;
            border: 2px solid rgba(255, 255, 255, 0.3);
        }

        .btn-primary:hover {
            background: rgba(255, 255, 255, 0.3);
            transform: translateY(-2px);
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
        }

        .btn-secondary {
            background: transparent;
            color: white;
            border: 2px solid rgba(255, 255, 255, 0.5);
        }

        .btn-secondary:hover {
            background: rgba(255, 255, 255, 0.1);
            transform: translateY(-2px);
        }

        .error-icon {
            font-size: 4rem;
            margin-bottom: 1rem;
            opacity: 0.7;
        }

        @media (max-width: 480px) {
            .error-code {
                font-size: 6rem;
            }

            .error-title {
                font-size: 1.5rem;
            }

            .error-actions {
                flex-direction: column;
                align-items: center;
            }
        }
    </style>
</head>
<body>
<div class="error-container">
    <i class="fas fa-exclamation-triangle error-icon"></i>
    <div class="error-code">404</div>
    <h1 class="error-title">页面不存在</h1>
    <p class="error-message">
        抱歉，您访问的页面不存在或已被移动。<br>
        请检查URL是否正确，或返回首页继续浏览。
    </p>
    <div class="error-actions">
        <a href="${pageContext.request.contextPath}/index.jsp" class="btn btn-primary">
            <i class="fas fa-home"></i>
            返回首页
        </a>
        <a href="javascript:history.back()" class="btn btn-secondary">
            <i class="fas fa-arrow-left"></i>
            返回上页
        </a>
    </div>
</div>
</body>
</html>