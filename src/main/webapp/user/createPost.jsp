<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>发布帖子 - 校园论坛</title>
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
      line-height: 1.6;
    }

    .container {
      max-width: 1200px;
      margin: 0 auto;
      padding: 0 20px;
    }

    /* 头部样式 */
    .header {
      background: rgba(255, 255, 255, 0.95);
      backdrop-filter: blur(10px);
      box-shadow: 0 2px 20px rgba(0, 0, 0, 0.1);
      position: sticky;
      top: 0;
      z-index: 100;
    }

    .header .container {
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding: 1rem 20px;
    }

    .nav-brand h1 {
      color: #667eea;
      font-size: 1.5rem;
      font-weight: bold;
    }

    .nav-menu {
      display: flex;
      gap: 2rem;
      align-items: center;
    }

    .nav-menu a {
      text-decoration: none;
      color: #333;
      font-weight: 500;
      transition: color 0.3s;
    }

    .nav-menu a:hover {
      color: #667eea;
    }

    .btn-primary {
      background: #667eea;
      color: white;
      padding: 0.75rem 1.5rem;
      border-radius: 8px;
      border: none;
      text-decoration: none;
      transition: background 0.3s;
      cursor: pointer;
      display: inline-flex;
      align-items: center;
      gap: 0.5rem;
    }

    .btn-primary:hover {
      background: #5a6fd8;
      color: white;
    }

    .btn-primary:disabled {
      background: #ccc;
      cursor: not-allowed;
    }

    /* 主要内容 */
    .main {
      padding: 2rem 0;
    }

    .post-form-container {
      max-width: 800px;
      margin: 0 auto;
      background: rgba(255, 255, 255, 0.95);
      backdrop-filter: blur(10px);
      padding: 3rem;
      border-radius: 20px;
      box-shadow: 0 20px 60px rgba(0, 0, 0, 0.15);
    }

    .form-header {
      text-align: center;
      margin-bottom: 2rem;
      color: #333;
    }

    .form-header h2 {
      font-size: 2rem;
      margin-bottom: 0.5rem;
      color: #667eea;
    }

    .form-header p {
      color: #666;
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

    /* 进度指示器 */
    .progress-container {
      margin-bottom: 2rem;
      padding: 1.5rem;
      background: #f8f9fa;
      border-radius: 12px;
      border: 2px solid #e9ecef;
    }

    .progress-header {
      display: flex;
      align-items: center;
      justify-content: space-between;
      margin-bottom: 1rem;
    }

    .progress-title {
      display: flex;
      align-items: center;
      gap: 0.5rem;
      font-weight: 600;
      color: #333;
    }

    .progress-percentage {
      font-weight: bold;
      color: #667eea;
    }

    .progress-bar {
      width: 100%;
      height: 8px;
      background-color: #e9ecef;
      border-radius: 4px;
      overflow: hidden;
    }

    .progress-fill {
      height: 100%;
      background: linear-gradient(90deg, #667eea, #764ba2);
      width: 0%;
      transition: width 0.3s ease;
    }

    .progress-text {
      margin-top: 0.5rem;
      font-size: 0.9rem;
      color: #666;
    }

    /* 表单样式 */
    .post-form .form-group {
      margin-bottom: 2rem;
    }

    .post-form label {
      display: block;
      margin-bottom: 0.75rem;
      font-weight: 600;
      color: #333;
      display: flex;
      align-items: center;
      gap: 0.5rem;
    }

    .post-form input,
    .post-form select,
    .post-form textarea {
      width: 100%;
      padding: 1rem;
      border: 2px solid #e9ecef;
      border-radius: 10px;
      font-size: 1rem;
      transition: all 0.3s ease;
      font-family: inherit;
      resize: vertical;
    }

    .post-form input:focus,
    .post-form select:focus,
    .post-form textarea:focus {
      outline: none;
      border-color: #667eea;
      box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
    }

    .post-form textarea {
      min-height: 200px;
    }

    .char-counter {
      text-align: right;
      font-size: 0.8rem;
      color: #999;
      margin-top: 0.25rem;
    }

    .char-counter.warning {
      color: #f39c12;
    }

    .char-counter.error {
      color: #e74c3c;
    }

    .form-actions {
      display: flex;
      gap: 1rem;
      justify-content: center;
      margin-top: 3rem;
    }

    .btn-outline {
      background: transparent;
      color: #666;
      border: 2px solid #e9ecef;
      padding: 0.75rem 1.5rem;
      border-radius: 8px;
      text-decoration: none;
      transition: all 0.3s ease;
      display: inline-flex;
      align-items: center;
      gap: 0.5rem;
    }

    .btn-outline:hover {
      background: #f8f9fa;
      border-color: #ccc;
      color: #333;
    }

    /* 页脚 */
    .footer {
      background: rgba(0, 0, 0, 0.1);
      color: white;
      text-align: center;
      padding: 2rem 0;
      margin-top: 3rem;
    }

    /* 响应式 */
    @media (max-width: 768px) {
      .header .container {
        flex-direction: column;
        gap: 1rem;
      }

      .nav-menu {
        flex-wrap: wrap;
        justify-content: center;
      }

      .post-form-container {
        padding: 2rem;
        margin: 1rem;
      }

      .form-actions {
        flex-direction: column;
      }

      .progress-header {
        flex-direction: column;
        gap: 0.5rem;
        align-items: flex-start;
      }
    }
  </style>
</head>
<body>
<!-- 包含头部导航 -->
<jsp:include page="/includes/headers.jsp" />

<main class="main">
  <div class="container">
    <div class="post-form-container">
      <div class="form-header">
        <h2><i class="fas fa-plus-circle"></i> 发布新帖</h2>
        <p>分享你的想法，与同学们交流</p>
      </div>

      <c:if test="${not empty errorMsg}">
        <div class="alert alert-error">
          <i class="fas fa-exclamation-circle"></i>
            ${errorMsg}
        </div>
      </c:if>

      <!-- 业务进度显示 -->
      <div class="progress-container">
        <div class="progress-header">
          <div class="progress-title">
            <i class="fas fa-tasks"></i>
            发帖进度
          </div>
          <div class="progress-percentage" id="progressText">0%</div>
        </div>
        <div class="progress-bar">
          <div class="progress-fill" id="postProgress"></div>
        </div>
        <div class="progress-text" id="progressMessage">请开始填写表单...</div>
      </div>

      <form action="${pageContext.request.contextPath}/user/createPost" method="post" class="post-form" id="postForm">
        <div class="form-group">
          <label for="categoryId">
            <i class="fas fa-folder"></i>
            帖子分类
          </label>
          <select id="categoryId" name="categoryId" required>
            <option value="">请选择分类</option>
            <option value="1">学习交流</option>
            <option value="2">休闲娱乐</option>
            <option value="3">求职招聘</option>
            <option value="4">校园生活</option>
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
          <div class="char-counter" id="titleCount">0/200</div>
        </div>

        <div class="form-group">
          <label for="content">
            <i class="fas fa-align-left"></i>
            帖子内容
          </label>
          <textarea id="content" name="content"
                    placeholder="请输入帖子内容（至少10个字符）"
                    required minlength="10" maxlength="5000"></textarea>
          <div class="char-counter" id="contentCount">0/5000</div>
        </div>

        <!-- 订单号预览 -->
        <div class="form-group">
          <label for="businessOrderNo">
            <i class="fas fa-barcode"></i>
            业务订单号 (自动生成)
          </label>
          <input type="text" id="orderPreview" name="businessOrderNo"
                 readonly
                 style="background-color: #f8f9fa; color: #666;">
        </div>

        <div class="form-actions">
          <button type="submit" class="btn-primary" id="submitBtn" disabled>
            <i class="fas fa-paper-plane"></i>
            发布帖子
          </button>
          <a href="${pageContext.request.contextPath}/index.jsp" class="btn-outline">
            <i class="fas fa-times"></i>
            取消
          </a>
        </div>
      </form>
    </div>
  </div>
</main>

<jsp:include page="/includes/footer.jsp" />

<script>
  // 表单验证和进度显示
  const form = document.getElementById('postForm');
  const titleInput = document.getElementById('title');
  const contentInput = document.getElementById('content');
  const categorySelect = document.getElementById('categoryId');
  const progressFill = document.getElementById('postProgress');
  const progressText = document.getElementById('progressText');
  const progressMessage = document.getElementById('progressMessage');
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
    progressText.textContent = progress + '%';

    if (progress === 0) message = '请开始填写表单...';
    else if (progress === 25) message = '已选择分类，继续填写标题...';
    else if (progress === 50) message = '标题已填写，继续填写内容...';
    else if (progress === 75) message = '内容已填写，可以发布了！';
    else if (progress === 100) message = '✅ 准备就绪，可以发布！';

    progressMessage.textContent = message;
    submitBtn.disabled = progress < 100;
  }

  // 字符计数和验证
  function updateCharCount(input, counter, max) {
    const length = input.value.length;
    counter.textContent = length + '/' + max;

    if (length > max * 0.9) {
      counter.className = 'char-counter error';
    } else if (length > max * 0.7) {
      counter.className = 'char-counter warning';
    } else {
      counter.className = 'char-counter';
    }
  }

  // 事件监听器
  titleInput.addEventListener('input', function() {
    updateCharCount(this, titleCount, 200);
    updateProgress();
  });

  contentInput.addEventListener('input', function() {
    updateCharCount(this, contentCount, 5000);
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
      alert('标题长度必须在2-200个字符之间');
      e.preventDefault();
      return;
    }

    if (content.length < 10 || content.length > 5000) {
      alert('内容长度必须在10-5000个字符之间');
      e.preventDefault();
      return;
    }
  });
</script>
</body>
</html>