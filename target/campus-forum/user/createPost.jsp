<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>发布帖子 - 校园论坛</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .post-form-container {
            max-width: 800px;
            margin: 2rem auto;
            background: white;
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }

        .post-form .form-group {
            margin-bottom: 1.5rem;
        }

        .post-form label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 600;
            color: #333;
        }

        .post-form input, .post-form select, .post-form textarea {
            width: 100%;
            padding: 12px;
            border: 2px solid #e9ecef;
            border-radius: 8px;
            font-size: 1rem;
            transition: border-color 0.3s ease;
            box-sizing: border-box;
        }

        .post-form input:focus, .post-form select:focus, .post-form textarea:focus {
            outline: none;
            border-color: #667eea;
        }

        .post-form textarea {
            resize: vertical;
            min-height: 200px;
        }

        .form-actions {
            display: flex;
            gap: 1rem;
            justify-content: center;
            margin-top: 2rem;
        }

        .progress-container {
            margin: 1rem 0;
        }

        .progress-bar {
            width: 100%;
            height: 6px;
            background-color: #e9ecef;
            border-radius: 3px;
            overflow: hidden;
        }

        .progress-fill {
            height: 100%;
            background: linear-gradient(90deg, #667eea, #764ba2);
            width: 0%;
            transition: width 0.3s ease;
        }
    </style>
</head>
<body>
<!-- 包含头部导航 -->
<jsp:include page="../includes/headers.jsp" />

<main class="main">
    <div class="container">
        <div class="post-form-container">
            <h2><i class="fas fa-plus-circle"></i> 发布新帖</h2>

            <c:if test="${not empty errorMsg}">
                <div class="alert alert-error">
                    <i class="fas fa-exclamation-circle"></i>
                        ${errorMsg}
                </div>
            </c:if>

            <!-- 业务进度显示 -->
            <div class="progress-container">
                <p><i class="fas fa-tasks"></i> 发帖进度</p>
                <div class="progress-bar">
                    <div class="progress-fill" id="postProgress"></div>
                </div>
                <small id="progressText">准备发布...</small>
            </div>

            <form action="${pageContext.request.contextPath}/user/createPost" method="post" class="post-form" id="postForm">
                <div class="form-group">
                    <label for="categoryId">
                        <i class="fas fa-folder"></i>
                        选择分类
                    </label>
                    <select id="categoryId" name="categoryId" required>
                        <option value="">请选择分类</option>
                        <option value="1">📚 学习交流</option>
                        <option value="2">🏠 生活服务</option>
                        <option value="3">👥 社团活动</option>
                        <option value="4">❓ 求助问答</option>
                        <option value="5">💬 闲聊水区</option>
                    </select>
                </div>

                <div class="form-group">
                    <label for="title">
                        <i class="fas fa-heading"></i>
                        帖子标题
                    </label>
                    <input type="text" id="title" name="title"
                           placeholder="请输入帖子标题（2-200字符）"
                           required maxlength="200" minlength="2">
                    <small>字符数: <span id="titleCount">0</span>/200</small>
                </div>

                <div class="form-group">
                    <label for="content">
                        <i class="fas fa-edit"></i>
                        帖子内容
                    </label>
                    <textarea id="content" name="content"
                              placeholder="请输入帖子内容（至少10字符）..."
                              required rows="10" minlength="10"></textarea>
                    <small>字符数: <span id="contentCount">0</span></small>
                </div>

                <!-- 业务订单号预览 -->
                <div class="form-group">
                    <label>
                        <i class="fas fa-receipt"></i>
                        业务订单号（自动生成）
                    </label>
                    <input type="text" id="orderPreview" readonly
                           style="background-color: #f8f9fa; color: #666;">
                </div>

                <div class="form-actions">
                    <button type="submit" class="btn btn-primary" id="submitBtn">
                        <i class="fas fa-paper-plane"></i>
                        发布帖子
                    </button>
                    <a href="${pageContext.request.contextPath}/index.jsp" class="btn btn-outline">
                        <i class="fas fa-times"></i>
                        取消
                    </a>
                </div>
            </form>
        </div>
    </div>
</main>

<jsp:include page="../includes/footer.jsp" />

<script>
    // 表单验证和进度显示
    const form = document.getElementById('postForm');
    const titleInput = document.getElementById('title');
    const contentInput = document.getElementById('content');
    const categorySelect = document.getElementById('categoryId');
    const progressFill = document.getElementById('postProgress');
    const progressText = document.getElementById('progressText');
    const titleCount = document.getElementById('titleCount');
    const contentCount = document.getElementById('contentCount');
    const orderPreview = document.getElementById('orderPreview');
    const submitBtn = document.getElementById('submitBtn');

    // 生成预览订单号
    function generateOrderPreview() {
        const timestamp = Date.now();
        const random = Math.floor(Math.random() * 10000).toString().padStart(4, '0');
        return 'POST' + timestamp + random;
    }

    // 更新进度
    function updateProgress() {
        let progress = 0;
        let message = '';

        // 检查各项完成情况
        if (categorySelect.value) progress += 25;
        if (titleInput.value.trim().length >= 2) progress += 25;
        if (contentInput.value.trim().length >= 10) progress += 25;
        if (progress === 75) progress += 25; // 全部完成

        progressFill.style.width = progress + '%';

        if (progress === 0) message = '请开始填写表单...';
        else if (progress === 25) message = '已选择分类，继续填写标题...';
        else if (progress === 50) message = '标题已填写，继续填写内容...';
        else if (progress === 75) message = '内容已填写，可以发布了！';
        else if (progress === 100) message = '✅ 准备就绪，可以发布！';

        progressText.textContent = message;
        submitBtn.disabled = progress < 100;
    }

    // 字符计数
    titleInput.addEventListener('input', function() {
        titleCount.textContent = this.value.length;
        updateProgress();
    });

    contentInput.addEventListener('input', function() {
        contentCount.textContent = this.value.length;
        updateProgress();
    });

    categorySelect.addEventListener('change', updateProgress);

    // 初始化
    orderPreview.value = generateOrderPreview();
    updateProgress();

    // 表单提交前再次验证
    form.addEventListener('submit', function(e) {
        const title = titleInput.value.trim();
        const content = contentInput.value.trim();
        const category = categorySelect.value;

        if (!category) {
            alert('请选择分类');
            e.preventDefault();
            return;
        }

        if (title.length < 2 || title.length > 200) {
            alert('标题长度必须在2-200字符之间');
            e.preventDefault();
            return;
        }

        if (content.length < 10) {
            alert('内容至少需要10个字符');
            e.preventDefault();
            return;
        }

        // 显示提交进度
        submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> 发布中...';
        submitBtn.disabled = true;
    });
</script>
</body>
</html>