<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>关于我们 - 校园论坛</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
  <style>
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }

    body {
      font-family: 'Microsoft YaHei', 'SimSun', Arial, sans-serif;
      line-height: 1.6;
      color: #333;
      background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      min-height: 100vh;
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

    .nav-menu a:hover, .nav-menu a.active {
      color: #667eea;
    }

    .user-menu {
      display: flex;
      gap: 1rem;
      align-items: center;
    }

    .btn-primary {
      background: #667eea;
      color: white;
      padding: 0.75rem 1.5rem;
      border-radius: 8px;
      text-decoration: none;
      transition: background 0.3s;
    }

    .btn-primary:hover {
      background: #5a6fd8;
      color: white;
    }

    /* 主要内容 */
    .main {
      padding: 2rem 0;
    }

    .about-section {
      background: rgba(255, 255, 255, 0.95);
      border-radius: 20px;
      padding: 3rem;
      margin-bottom: 2rem;
      box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
    }

    .section-header {
      text-align: center;
      margin-bottom: 3rem;
    }

    .section-header h1 {
      font-size: 2.5rem;
      color: #333;
      margin-bottom: 1rem;
    }

    .section-header p {
      font-size: 1.2rem;
      color: #666;
    }

    .features-grid {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
      gap: 2rem;
      margin: 3rem 0;
    }

    .feature-card {
      background: #f8f9fa;
      padding: 2rem;
      border-radius: 15px;
      text-align: center;
      transition: transform 0.3s;
    }

    .feature-card:hover {
      transform: translateY(-5px);
    }

    .feature-icon {
      font-size: 3rem;
      color: #667eea;
      margin-bottom: 1rem;
    }

    .feature-card h3 {
      margin-bottom: 1rem;
      color: #333;
    }

    .feature-card p {
      color: #666;
    }

    .team-section {
      text-align: center;
      margin: 3rem 0;
    }

    .team-section h2 {
      margin-bottom: 2rem;
      color: #333;
    }

    .contact-info {
      background: #f8f9fa;
      padding: 2rem;
      border-radius: 15px;
      margin: 2rem 0;
    }

    .contact-info h3 {
      margin-bottom: 1rem;
      color: #333;
    }

    .contact-info p {
      margin-bottom: 0.5rem;
      color: #666;
    }

    /* 页脚 */
    .footer {
      background: rgba(0, 0, 0, 0.1);
      color: white;
      text-align: center;
      padding: 2rem 0;
      margin-top: 3rem;
    }

    @media (max-width: 768px) {
      .header .container {
        flex-direction: column;
        gap: 1rem;
      }

      .nav-menu {
        flex-wrap: wrap;
        justify-content: center;
      }

      .about-section {
        padding: 2rem 1rem;
      }

      .features-grid {
        grid-template-columns: 1fr;
      }
    }
  </style>
</head>
<body>
<!-- 头部导航 -->
<header class="header">
  <div class="container">
    <div class="nav-brand">
      <h1><i class="fas fa-graduation-cap"></i> 校园论坛</h1>
    </div>
    <nav class="nav-menu">
      <a href="${pageContext.request.contextPath}/index.jsp">首页</a>
      <a href="${pageContext.request.contextPath}/posts">帖子</a>
      <a href="${pageContext.request.contextPath}/about.jsp" class="active">关于</a>

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

<!-- 主要内容 -->
<main class="main">
  <div class="container">
    <section class="about-section">
      <div class="section-header">
        <h1><i class="fas fa-graduation-cap"></i> 关于校园论坛</h1>
        <p>连接校园，分享知识，共同成长</p>
      </div>

      <div class="content">
        <p>校园论坛是一个专为在校学生打造的学术交流和社交平台。我们致力于为学生提供一个开放、友好、积极向上的交流环境，让每一位同学都能在这里找到志同道合的朋友，分享学习心得，讨论学术问题，展示个人才华。</p>

        <div class="features-grid">
          <div class="feature-card">
            <div class="feature-icon">
              <i class="fas fa-book-open"></i>
            </div>
            <h3>学术交流</h3>
            <p>分享学习资源，讨论学术问题，互帮互助，共同进步</p>
          </div>

          <div class="feature-card">
            <div class="feature-icon">
              <i class="fas fa-users"></i>
            </div>
            <h3>社交互动</h3>
            <p>结识新朋友，分享生活点滴，建立有意义的社交关系</p>
          </div>

          <div class="feature-card">
            <div class="feature-icon">
              <i class="fas fa-lightbulb"></i>
            </div>
            <h3>创新思维</h3>
            <p>激发创新思维，分享创意想法，推动学术创新发展</p>
          </div>

          <div class="feature-card">
            <div class="feature-icon">
              <i class="fas fa-shield-alt"></i>
            </div>
            <h3>安全可靠</h3>
            <p>严格的内容审核机制，营造健康积极的网络环境</p>
          </div>
        </div>

        <div class="team-section">
          <h2><i class="fas fa-heart"></i> 我们的愿景</h2>
          <p>成为最受学生欢迎的校园交流平台，让知识传播更高效，让校园生活更丰富多彩。我们相信，通过技术的力量和社区的温暖，每一位同学都能在这里收获知识、友谊和成长。</p>
        </div>

        <div class="contact-info">
          <h3><i class="fas fa-envelope"></i> 联系我们</h3>
          <p><i class="fas fa-envelope"></i> 邮箱：contact@campus-forum.edu</p>
          <p><i class="fas fa-phone"></i> 电话：400-123-4567</p>
          <p><i class="fas fa-map-marker-alt"></i> 地址：校园信息中心 3楼</p>
          <p><i class="fas fa-clock"></i> 服务时间：周一至周五 9:00-18:00</p>
        </div>
      </div>
    </section>
  </div>
</main>

<!-- 页脚 -->
<footer class="footer">
  <div class="container">
    <p>&copy; 2025 校园论坛. All rights reserved. | 让知识传播，让友谊绽放</p>
  </div>
</footer>
</body>
</html>