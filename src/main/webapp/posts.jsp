<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>所有帖子 - 校园论坛</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/posts.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
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
      </div>
    </div>

    <!-- 帖子列表 -->
    <div class="posts-container">
      <c:choose>
        <c:when test="${not empty posts}">
          <div class="posts-grid">
            <c:forEach var="post" items="${posts}">
              <article class="post-card modern">
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
          <div class="no-posts">
            <i class="fas fa-inbox"></i>
            <h3>暂无帖子</h3>
            <p>还没有人发布帖子，来成为第一个吧！</p>
            <c:if test="${not empty sessionScope.currentUser}">
              <a href="${pageContext.request.contextPath}/user/createPost" class="btn btn-primary">
                <i class="fas fa-plus"></i> 发布帖子
              </a>
            </c:if>
          </div>
        </c:otherwise>
      </c:choose>
    </div>
  </div>
</main>

<!-- 页脚 -->
<jsp:include page="includes/footer.jsp" />

<script src="${pageContext.request.contextPath}/js/main.js"></script>
</body>
</html>