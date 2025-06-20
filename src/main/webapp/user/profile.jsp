<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- 检查登录状态 -->
<c:if test="${empty sessionScope.currentUser}">
  <c:redirect url="${pageContext.request.contextPath}/login.jsp"/>
</c:if>

<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>个人中心 - 校园论坛</title>
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

    .user-menu {
      display: flex;
      gap: 1rem;
      align-items: center;
    }

    .user-menu .welcome {
      color: #666;
      font-weight: 500;
    }

    .btn-primary {
      background: #667eea;
      color: white;
      padding: 0.5rem 1rem;
      border-radius: 6px;
      text-decoration: none;
      transition: background 0.3s;
      display: inline-flex;
      align-items: center;
      gap: 0.5rem;
    }

    .btn-primary:hover {
      background: #5a6fd8;
    }

    /* 主要内容 */
    .main {
      padding: 2rem 0;
    }

    .profile-container {
      display: grid;
      grid-template-columns: 300px 1fr;
      gap: 2rem;
    }

    /* 用户信息卡片 */
    .user-card {
      background: rgba(255, 255, 255, 0.95);
      backdrop-filter: blur(10px);
      padding: 2rem;
      border-radius: 20px;
      box-shadow: 0 20px 60px rgba(0, 0, 0, 0.15);
      height: fit-content;
      text-align: center;
    }

    .avatar-container {
      position: relative;
      display: inline-block;
      margin-bottom: 1.5rem;
    }

    .avatar {
      width: 120px;
      height: 120px;
      border-radius: 50%;
      border: 4px solid #667eea;
      object-fit: cover;
      background: #f8f9fa;
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 3rem;
      color: #667eea;
    }

    .user-info h3 {
      color: #333;
      margin-bottom: 0.5rem;
      font-size: 1.5rem;
    }

    .user-info .username {
      color: #666;
      font-size: 0.9rem;
      margin-bottom: 1rem;
    }

    .user-stats {
      display: grid;
      grid-template-columns: 1fr 1fr;
      gap: 1rem;
      margin-top: 1.5rem;
    }

    .stat-item {
      text-align: center;
      padding: 1rem;
      background: #f8f9fa;
      border-radius: 10px;
    }

    .stat-number {
      font-size: 1.5rem;
      font-weight: bold;
      color: #667eea;
      display: block;
    }

    .stat-label {
      font-size: 0.8rem;
      color: #666;
      margin-top: 0.25rem;
    }

    .role-badge {
      display: inline-block;
      padding: 0.25rem 0.75rem;
      border-radius: 20px;
      font-size: 0.8rem;
      font-weight: bold;
      margin-top: 0.5rem;
    }

    .role-admin {
      background: #ff6b6b;
      color: white;
    }

    .role-user {
      background: #51cf66;
      color: white;
    }

    /* 内容区域 */
    .content-area {
      background: rgba(255, 255, 255, 0.95);
      backdrop-filter: blur(10px);
      border-radius: 20px;
      box-shadow: 0 20px 60px rgba(0, 0, 0, 0.15);
      overflow: hidden;
    }

    .tab-nav {
      display: flex;
      background: #f8f9fa;
      border-bottom: 1px solid #e9ecef;
    }

    .tab-btn {
      flex: 1;
      padding: 1rem 2rem;
      background: none;
      border: none;
      cursor: pointer;
      font-size: 1rem;
      color: #666;
      transition: all 0.3s;
      position: relative;
    }

    .tab-btn.active {
      color: #667eea;
      background: white;
    }

    .tab-btn.active::after {
      content: '';
      position: absolute;
      bottom: 0;
      left: 0;
      right: 0;
      height: 3px;
      background: #667eea;
    }

    .tab-content {
      padding: 2rem;
      min-height: 400px;
    }

    .tab-pane {
      display: none;
    }

    .tab-pane.active {
      display: block;
    }

    /* 表单样式 */
    .form-group {
      margin-bottom: 1.5rem;
    }

    .form-group label {
      display: block;
      margin-bottom: 0.5rem;
      color: #333;
      font-weight: 500;
    }

    .form-group input,
    .form-group textarea,
    .form-group select {
      width: 100%;
      padding: 0.75rem;
      border: 2px solid #e9ecef;
      border-radius: 8px;
      font-size: 1rem;
      transition: border-color 0.3s;
    }

    .form-group input:focus,
    .form-group textarea:focus,
    .form-group select:focus {
      outline: none;
      border-color: #667eea;
    }

    .btn-update {
      background: #667eea;
      color: white;
      padding: 0.75rem 2rem;
      border: none;
      border-radius: 8px;
      cursor: pointer;
      font-size: 1rem;
      transition: background 0.3s;
    }

    .btn-update:hover {
      background: #5a6fd8;
    }

    /* 帖子列表样式 */
    .post-item {
      padding: 1.5rem;
      border-bottom: 1px solid #e9ecef;
      transition: background 0.3s;
    }

    .post-item:hover {
      background: #f8f9fa;
    }

    .post-item:last-child {
      border-bottom: none;
    }

    .post-title {
      font-size: 1.1rem;
      font-weight: bold;
      color: #333;
      margin-bottom: 0.5rem;
    }

    .post-title a {
      text-decoration: none;
      color: inherit;
    }

    .post-title a:hover {
      color: #667eea;
    }

    .post-meta {
      display: flex;
      gap: 1rem;
      font-size: 0.9rem;
      color: #666;
      margin-bottom: 0.5rem;
    }

    .post-stats {
      display: flex;
      gap: 1rem;
      font-size: 0.8rem;
      color: #999;
    }

    .alert {
      padding: 1rem;
      border-radius: 8px;
      margin-bottom: 1rem;
      border-left: 4px solid;
    }

    .alert-success {
      background: #d4edda;
      border-color: #28a745;
      color: #155724;
    }

    .alert-error {
      background: #f8d7da;
      border-color: #dc3545;
      color: #721c24;
    }

    .empty-state {
      text-align: center;
      padding: 3rem;
      color: #666;
    }

    .empty-state i {
      font-size: 3rem;
      margin-bottom: 1rem;
      color: #ccc;
    }

    /* 响应式设计 */
    @media (max-width: 768px) {
      .profile-container {
        grid-template-columns: 1fr;
        gap: 1rem;
      }

      .user-stats {
        grid-template-columns: 1fr 1fr 1fr;
      }

      .tab-nav {
        flex-direction: column;
      }
    }
  </style>
</head>
<body>
<!-- 包含头部导航 -->
<jsp:include page="../includes/headers.jsp" />

<main class="main">
  <div class="container">
    <div class="profile-container">
      <!-- 用户信息卡片 -->
      <div class="user-card">
        <div class="avatar-container">
          <c:choose>
            <c:when test="${not empty sessionScope.currentUser.avatar}">
              <img src="${pageContext.request.contextPath}${sessionScope.currentUser.avatar}"
                   alt="头像" class="avatar">
            </c:when>
            <c:otherwise>
              <div class="avatar">
                <i class="fas fa-user"></i>
              </div>
            </c:otherwise>
          </c:choose>
        </div>

        <div class="user-info">
          <h3>${sessionScope.currentUser.nickname}</h3>
          <p class="username">@${sessionScope.currentUser.username}</p>

          <span class="role-badge ${sessionScope.currentUser.role == 'admin' ? 'role-admin' : 'role-user'}">
                        <c:choose>
                          <c:when test="${sessionScope.currentUser.role == 'admin'}">
                            <i class="fas fa-crown"></i> 管理员
                          </c:when>
                          <c:otherwise>
                            <i class="fas fa-user"></i> 普通用户
                          </c:otherwise>
                        </c:choose>
                    </span>

          <div class="user-stats">
            <div class="stat-item">
              <span class="stat-number" id="postCount">0</span>
              <div class="stat-label">我的帖子</div>
            </div>
            <div class="stat-item">
              <span class="stat-number" id="likeCount">0</span>
              <div class="stat-label">获赞数</div>
            </div>
          </div>

          <p style="margin-top: 1rem; font-size: 0.8rem; color: #999;">
            注册时间: <fmt:formatDate value="${sessionScope.currentUser.createTime}" pattern="yyyy-MM-dd"/>
          </p>
        </div>
      </div>

      <!-- 内容区域 -->
      <div class="content-area">
        <div class="tab-nav">
          <button class="tab-btn active" data-tab="posts">
            <i class="fas fa-file-alt"></i> 我的帖子
          </button>
          <button class="tab-btn" data-tab="profile">
            <i class="fas fa-edit"></i> 编辑资料
          </button>
          <button class="tab-btn" data-tab="security">
            <i class="fas fa-shield-alt"></i> 账户安全
          </button>
        </div>

        <div class="tab-content">
          <!-- 我的帖子 -->
          <div class="tab-pane active" id="posts">
            <div id="postsContainer">
              <div class="empty-state">
                <i class="fas fa-spinner fa-spin"></i>
                <p>正在加载帖子...</p>
              </div>
            </div>
          </div>

          <!-- 编辑资料 -->
          <div class="tab-pane" id="profile">
            <h3 style="margin-bottom: 1.5rem;">编辑个人资料</h3>

            <c:if test="${not empty successMsg}">
              <div class="alert alert-success">
                <i class="fas fa-check-circle"></i>
                  ${successMsg}
              </div>
            </c:if>

            <c:if test="${not empty errorMsg}">
              <div class="alert alert-error">
                <i class="fas fa-exclamation-circle"></i>
                  ${errorMsg}
              </div>
            </c:if>

            <form action="${pageContext.request.contextPath}/user/updateProfile" method="post">
              <div class="form-group">
                <label for="username">用户名</label>
                <input type="text" id="username" name="username"
                       value="${sessionScope.currentUser.username}" readonly>
                <small style="color: #666;">用户名不可修改</small>
              </div>

              <div class="form-group">
                <label for="nickname">昵称</label>
                <input type="text" id="nickname" name="nickname"
                       value="${sessionScope.currentUser.nickname}"
                       required maxlength="50">
              </div>

              <div class="form-group">
                <label for="email">邮箱</label>
                <input type="email" id="email" name="email"
                       value="${sessionScope.currentUser.email}"
                       required maxlength="100">
              </div>

              <button type="submit" class="btn-update">
                <i class="fas fa-save"></i> 保存修改
              </button>
            </form>
          </div>

          <!-- 账户安全 -->
          <div class="tab-pane" id="security">
            <h3 style="margin-bottom: 1.5rem;">修改密码</h3>

            <form action="${pageContext.request.contextPath}/user/changePassword" method="post">
              <div class="form-group">
                <label for="currentPassword">当前密码</label>
                <input type="password" id="currentPassword" name="currentPassword"
                       required minlength="6">
              </div>

              <div class="form-group">
                <label for="newPassword">新密码</label>
                <input type="password" id="newPassword" name="newPassword"
                       required minlength="6">
              </div>

              <div class="form-group">
                <label for="confirmPassword">确认新密码</label>
                <input type="password" id="confirmPassword" name="confirmPassword"
                       required minlength="6">
              </div>

              <button type="submit" class="btn-update">
                <i class="fas fa-key"></i> 修改密码
              </button>
            </form>
          </div>
        </div>
      </div>
    </div>
  </div>
</main>

<!-- 页脚 -->
<jsp:include page="../includes/footer.jsp" />

<script>
  // 标签页切换
  document.querySelectorAll('.tab-btn').forEach(btn => {
    btn.addEventListener('click', function() {
      const tabName = this.dataset.tab;

      // 移除所有活跃状态
      document.querySelectorAll('.tab-btn').forEach(b => b.classList.remove('active'));
      document.querySelectorAll('.tab-pane').forEach(p => p.classList.remove('active'));

      // 添加活跃状态
      this.classList.add('active');
      document.getElementById(tabName).classList.add('active');
    });
  });

  // 加载用户帖子
  function loadUserPosts() {
    fetch('${pageContext.request.contextPath}/api/user-posts')
            .then(response => response.json())
            .then(data => {
              const container = document.getElementById('postsContainer');

              if (data.success && data.data && data.data.length > 0) {
                let html = '';
                data.data.forEach(post => {
                  html += `
                            <div class="post-item">
                                <div class="post-title">
                                    <a href="${pageContext.request.contextPath}/post-detail?id=\${post.id}">
                                        \${post.title}
                                    </a>
                                </div>
                                <div class="post-meta">
                                    <span><i class="fas fa-folder"></i> \${post.categoryName || '未分类'}</span>
                                    <span><i class="fas fa-clock"></i> \${new Date(post.createTime).toLocaleDateString()}</span>
                                </div>
                                <div class="post-stats">
                                    <span><i class="fas fa-eye"></i> \${post.viewCount || 0} 浏览</span>
                                    <span><i class="fas fa-heart"></i> \${post.likeCount || 0} 点赞</span>
                                    <span><i class="fas fa-comment"></i> \${post.replyCount || 0} 回复</span>
                                </div>
                            </div>
                        `;
                });
                container.innerHTML = html;

                // 更新统计数据
                document.getElementById('postCount').textContent = data.data.length;
                document.getElementById('likeCount').textContent =
                        data.data.reduce((sum, post) => sum + (post.likeCount || 0), 0);
              } else {
                container.innerHTML = `
                        <div class="empty-state">
                            <i class="fas fa-file-alt"></i>
                            <p>还没有发布任何帖子</p>
                            <a href="${pageContext.request.contextPath}/user/createPost.jsp" class="btn-primary" style="margin-top: 1rem;">
                                <i class="fas fa-plus"></i> 发布第一个帖子
                            </a>
                        </div>
                    `;
              }
            })
            .catch(error => {
              console.error('加载帖子失败:', error);
              document.getElementById('postsContainer').innerHTML = `
                    <div class="empty-state">
                        <i class="fas fa-exclamation-triangle"></i>
                        <p>加载失败，请刷新重试</p>
                    </div>
                `;
            });
  }

  // 页面加载完成后执行
  document.addEventListener('DOMContentLoaded', function() {
    loadUserPosts();
  });

  // 密码确认验证
  document.getElementById('confirmPassword')?.addEventListener('input', function() {
    const newPassword = document.getElementById('newPassword').value;
    const confirmPassword = this.value;

    if (newPassword !== confirmPassword) {
      this.setCustomValidity('密码不一致');
    } else {
      this.setCustomValidity('');
    }
  });
</script>
</body>
</html>