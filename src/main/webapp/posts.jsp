<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>所有帖子 - 校园论坛</title>
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

    .nav-menu a:hover,
    .nav-menu a.active {
      color: #667eea;
    }

    .btn-primary {
      background: #667eea;
      color: white;
      padding: 0.5rem 1rem;
      border-radius: 6px;
      border: none;
      text-decoration: none;
      transition: background 0.3s;
    }

    .btn-primary:hover {
      background: #5a6fd8;
    }

    /* 主要内容 */
    .main {
      padding: 2rem 0;
    }

    .page-header {
      text-align: center;
      margin-bottom: 3rem;
      color: white;
    }

    .page-header h1 {
      font-size: 2.5rem;
      margin-bottom: 0.5rem;
    }

    .page-header p {
      font-size: 1.1rem;
      opacity: 0.9;
    }

    /* 搜索和筛选 */
    .search-filter-section {
      background: rgba(255, 255, 255, 0.95);
      backdrop-filter: blur(10px);
      padding: 2rem;
      border-radius: 15px;
      margin-bottom: 2rem;
      box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
    }

    .search-form {
      margin-bottom: 1.5rem;
    }

    .search-group {
      display: flex;
      max-width: 500px;
      margin: 0 auto;
    }

    .search-input {
      flex: 1;
      padding: 1rem;
      border: 2px solid #e9ecef;
      border-right: none;
      border-radius: 10px 0 0 10px;
      font-size: 1rem;
      outline: none;
    }

    .search-input:focus {
      border-color: #667eea;
    }

    .search-btn {
      padding: 1rem 1.5rem;
      background: #667eea;
      color: white;
      border: 2px solid #667eea;
      border-radius: 0 10px 10px 0;
      cursor: pointer;
      transition: background 0.3s;
    }

    .search-btn:hover {
      background: #5a6fd8;
    }

    .filter-buttons {
      display: flex;
      justify-content: center;
      gap: 1rem;
      flex-wrap: wrap;
    }

    .filter-btn {
      padding: 0.75rem 1.5rem;
      background: transparent;
      color: #666;
      text-decoration: none;
      border: 2px solid #e9ecef;
      border-radius: 8px;
      transition: all 0.3s ease;
      display: flex;
      align-items: center;
      gap: 0.5rem;
    }

    .filter-btn:hover,
    .filter-btn.active {
      background: #667eea;
      color: white;
      border-color: #667eea;
    }

    /* 帖子容器 */
    .posts-container {
      background: rgba(255, 255, 255, 0.95);
      backdrop-filter: blur(10px);
      border-radius: 15px;
      padding: 2rem;
      box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
    }

    .posts-grid {
      display: grid;
      gap: 2rem;
    }

    .post-card {
      background: white;
      border-radius: 12px;
      padding: 1.5rem;
      box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
      transition: all 0.3s ease;
      border: 1px solid #f0f0f0;
    }

    .post-card:hover {
      transform: translateY(-5px);
      box-shadow: 0 15px 40px rgba(0, 0, 0, 0.15);
    }

    .post-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 1rem;
    }

    .post-category {
      background: linear-gradient(135deg, #667eea, #764ba2);
      color: white;
      padding: 0.25rem 0.75rem;
      border-radius: 15px;
      font-size: 0.8rem;
      display: flex;
      align-items: center;
      gap: 0.25rem;
    }

    .post-progress {
      display: flex;
      align-items: center;
      gap: 0.5rem;
      font-size: 0.8rem;
      color: #666;
    }

    .progress-bar {
      width: 60px;
      height: 4px;
      background: #e9ecef;
      border-radius: 2px;
      overflow: hidden;
    }

    .progress-fill {
      height: 100%;
      background: linear-gradient(90deg, #667eea, #764ba2);
      transition: width 0.3s ease;
    }

    .post-title {
      margin-bottom: 1rem;
    }

    .post-title a {
      color: #333;
      text-decoration: none;
      font-size: 1.2rem;
      font-weight: 600;
      line-height: 1.4;
    }

    .post-title a:hover {
      color: #667eea;
    }

    .post-content {
      color: #666;
      margin-bottom: 1rem;
      line-height: 1.6;
    }

    .post-footer {
      display: flex;
      justify-content: space-between;
      align-items: center;
      border-top: 1px solid #f0f0f0;
      padding-top: 1rem;
    }

    .post-author {
      display: flex;
      align-items: center;
      gap: 0.5rem;
      color: #666;
      font-size: 0.9rem;
    }

    .post-stats {
      display: flex;
      gap: 1rem;
      font-size: 0.9rem;
      color: #999;
    }

    .stat-item {
      display: flex;
      align-items: center;
      gap: 0.25rem;
    }

    /* 分页 */
    .pagination {
      display: flex;
      justify-content: center;
      gap: 0.5rem;
      margin-top: 2rem;
    }

    .page-btn {
      padding: 0.75rem 1rem;
      background: white;
      color: #667eea;
      text-decoration: none;
      border-radius: 8px;
      border: 2px solid #667eea;
      transition: all 0.3s ease;
    }

    .page-btn:hover,
    .page-btn.active {
      background: #667eea;
      color: white;
    }

    /* 空状态 */
    .empty-state {
      text-align: center;
      padding: 4rem 2rem;
      color: #666;
    }

    .empty-state i {
      font-size: 4rem;
      color: #ccc;
      margin-bottom: 1rem;
    }

    .empty-state h3 {
      margin-bottom: 1rem;
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

      .page-header h1 {
        font-size: 2rem;
      }

      .search-group {
        max-width: 100%;
      }

      .filter-buttons {
        justify-content: center;
      }

      .post-footer {
        flex-direction: column;
        gap: 1rem;
        align-items: flex-start;
      }

      .pagination {
        flex-wrap: wrap;
      }
    }
  </style>
</head>
<body>
<!-- 头部导航 -->
<jsp:include page="includes/headers.jsp" />

<!-- 主要内容 -->
<main class="main">
  <div class="container">
    <!-- 页面标题 -->
    <div class="page-header">
      <h1><i class="fas fa-list"></i> 所有帖子</h1>
      <p>探索校园里的精彩话题和讨论</p>
    </div>

    <!-- 搜索和筛选 -->
    <div class="search-filter-section">
      <form method="get" action="${pageContext.request.contextPath}/posts" class="search-form">
        <div class="search-group">
          <input type="text" name="keyword" value="${keyword}" placeholder="搜索帖子..." class="search-input">
          <button type="submit" class="search-btn">
            <i class="fas fa-search"></i>
          </button>
        </div>
      </form>

      <div class="filter-buttons">
        <a href="${pageContext.request.contextPath}/posts"
           class="filter-btn ${empty category ? 'active' : ''}">
          <i class="fas fa-th-large"></i> 全部
        </a>
        <a href="${pageContext.request.contextPath}/posts?category=1"
           class="filter-btn ${category == '1' ? 'active' : ''}">
          <i class="fas fa-graduation-cap"></i> 学习
        </a>
        <a href="${pageContext.request.contextPath}/posts?category=2"
           class="filter-btn ${category == '2' ? 'active' : ''}">
          <i class="fas fa-gamepad"></i> 娱乐
        </a>
        <a href="${pageContext.request.contextPath}/posts?category=3"
           class="filter-btn ${category == '3' ? 'active' : ''}">
          <i class="fas fa-briefcase"></i> 求职
        </a>
        <a href="${pageContext.request.contextPath}/posts?category=4"
           class="filter-btn ${category == '4' ? 'active' : ''}">
          <i class="fas fa-heart"></i> 生活
        </a>
      </div>
    </div>

    <!-- 帖子列表 -->
    <div class="posts-container">
      <c:choose>
        <c:when test="${not empty posts}">
          <div class="posts-grid">
            <c:forEach var="post" items="${posts}">
              <article class="post-card">
                <div class="post-header">
                  <div class="post-category">
                    <i class="fas fa-tag"></i>
                    <span>${post.categoryName}</span>
                  </div>
                  <div class="post-progress">
                    <span class="progress-text">${post.progressPercent}%</span>
                    <div class="progress-bar">
                      <div class="progress-fill" style="width: ${post.progressPercent}%"></div>
                    </div>
                  </div>
                </div>

                <h2 class="post-title">
                  <a href="${pageContext.request.contextPath}/post-detail?id=${post.id}">
                      ${post.title}
                  </a>
                </h2>

                <div class="post-content">
                    ${post.content.length() > 150 ? post.content.substring(0, 150) : post.content}
                  <c:if test="${post.content.length() > 150}">...</c:if>
                </div>

                <div class="post-footer">
                  <div class="post-author">
                    <i class="fas fa-user-circle"></i>
                    <span>${post.userNickname}</span>
                  </div>

                  <div class="post-stats">
                                        <span class="stat-item">
                                            <i class="fas fa-eye"></i>
                                            ${post.viewCount}
                                        </span>
                    <span class="stat-item">
                                            <i class="fas fa-heart"></i>
                                            ${post.likeCount}
                                        </span>
                    <span class="stat-item">
                                            <i class="fas fa-clock"></i>
                                            <fmt:formatDate value="${post.createTime}" pattern="MM-dd HH:mm"/>
                                        </span>
                  </div>
                </div>

                <c:if test="${not empty post.businessOrderNo}">
                  <div class="post-order">
                    <i class="fas fa-barcode"></i>
                    订单号: ${post.businessOrderNo}
                  </div>
                </c:if>
              </article>
            </c:forEach>
          </div>

          <!-- 分页 -->
          <c:if test="${totalPages > 1}">
            <div class="pagination">
              <c:if test="${currentPage > 1}">
                <a href="${pageContext.request.contextPath}/posts?page=${currentPage - 1}${not empty keyword ? '&keyword=' : ''}${keyword}${not empty category ? '&category=' : ''}${category}"
                   class="page-btn">
                  <i class="fas fa-chevron-left"></i> 上一页
                </a>
              </c:if>

              <c:forEach begin="1" end="${totalPages}" var="pageNum">
                <c:if test="${pageNum >= currentPage - 2 && pageNum <= currentPage + 2}">
                  <a href="${pageContext.request.contextPath}/posts?page=${pageNum}${not empty keyword ? '&keyword=' : ''}${keyword}${not empty category ? '&category=' : ''}${category}"
                     class="page-btn ${pageNum == currentPage ? 'active' : ''}">
                      ${pageNum}
                  </a>
                </c:if>
              </c:forEach>

              <c:if test="${currentPage < totalPages}">
                <a href="${pageContext.request.contextPath}/posts?page=${currentPage + 1}${not empty keyword ? '&keyword=' : ''}${keyword}${not empty category ? '&category=' : ''}${category}"
                   class="page-btn">
                  下一页 <i class="fas fa-chevron-right"></i>
                </a>
              </c:if>
            </div>
          </c:if>
        </c:when>
        <c:otherwise>
          <div class="empty-state">
            <i class="fas fa-comments"></i>
            <h3>暂无帖子</h3>
            <p>还没有符合条件的帖子，来发布第一个吧！</p>
            <c:if test="${not empty sessionScope.currentUser}">
              <a href="${pageContext.request.contextPath}/user/createPost" class="btn-primary">发布帖子</a>
            </c:if>
          </div>
        </c:otherwise>
      </c:choose>
    </div>
  </div>
</main>

<!-- 页脚 -->
<jsp:include page="includes/footer.jsp" />
</body>
</html>