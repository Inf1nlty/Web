<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>校园论坛 - 首页</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/home.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">
    <style>
        /* 确保基础样式 */
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
            display: inline-block;
        }

        .btn-primary:hover {
            background: #5a6fd8;
            color: white;
        }

        /* 主要内容区域 */
        .main {
            padding: 2rem 0;
        }

        /* 英雄区域 */
        .hero-section {
            text-align: center;
            padding: 4rem 0;
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            margin-bottom: 3rem;
            color: white;
        }

        .hero-title {
            font-size: 3rem;
            margin-bottom: 1rem;
        }

        .hero-subtitle {
            font-size: 1.2rem;
            margin-bottom: 2rem;
            opacity: 0.9;
        }

        .hero-actions {
            display: flex;
            gap: 1rem;
            justify-content: center;
            flex-wrap: wrap;
        }

        .btn-hero {
            padding: 1rem 2rem;
            border-radius: 10px;
            text-decoration: none;
            font-weight: bold;
            transition: all 0.3s;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
        }

        .btn-hero.primary {
            background: rgba(255, 255, 255, 0.2);
            color: white;
            border: 2px solid rgba(255, 255, 255, 0.3);
        }

        .btn-hero.secondary {
            background: transparent;
            color: white;
            border: 2px solid rgba(255, 255, 255, 0.5);
        }

        .btn-hero:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
        }

        /* 统计卡片 */
        .stats-section {
            margin-bottom: 3rem;
        }

        .section-header {
            text-align: center;
            margin-bottom: 2rem;
            color: white;
        }

        .section-header h2 {
            font-size: 2rem;
            margin-bottom: 0.5rem;
        }

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 2rem;
        }

        .stat-card {
            background: rgba(255, 255, 255, 0.95);
            padding: 2rem;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            display: flex;
            align-items: center;
            gap: 1rem;
            transition: transform 0.3s;
        }

        .stat-card:hover {
            transform: translateY(-5px);
        }

        .stat-icon {
            font-size: 2.5rem;
            color: #667eea;
        }

        .stat-content h3 {
            font-size: 1rem;
            color: #666;
            margin-bottom: 0.5rem;
        }

        .stat-number {
            font-size: 2rem;
            font-weight: bold;
            color: #333;
        }

        .stat-label {
            font-size: 0.8rem;
            color: #999;
        }

        /* 帖子区域 */
        .hot-posts-section {
            margin-bottom: 3rem;
        }

        .posts-container {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 15px;
            padding: 2rem;
            min-height: 200px;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .loading-spinner {
            text-align: center;
            color: #666;
        }

        .empty-state {
            text-align: center;
            color: #666;
        }

        .empty-state i {
            font-size: 3rem;
            color: #667eea;
            margin-bottom: 1rem;
            display: block;
        }

        .empty-state h3 {
            margin-bottom: 1rem;
            color: #333;
        }

        .empty-state p {
            margin-bottom: 1rem;
            color: #666;
        }

        .btn-outline-modern {
            background: transparent;
            color: white;
            border: 2px solid rgba(255, 255, 255, 0.5);
            padding: 0.75rem 1.5rem;
            border-radius: 8px;
            text-decoration: none;
            transition: all 0.3s;
            margin-top: 1rem;
            display: inline-block;
        }

        .btn-outline-modern:hover {
            background: rgba(255, 255, 255, 0.1);
            color: white;
        }

        /* 功能导航 */
        .features-section {
            margin-bottom: 3rem;
        }

        .features-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 2rem;
        }

        .feature-card {
            background: rgba(255, 255, 255, 0.95);
            padding: 2rem;
            border-radius: 15px;
            text-align: center;
            transition: transform 0.3s;
            position: relative;
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
            margin-bottom: 0.5rem;
            color: #333;
        }

        .feature-card p {
            color: #666;
            margin-bottom: 1rem;
        }

        .feature-link {
            color: #667eea;
            text-decoration: none;
        }

        /* 时间线 */
        .activities-section {
            margin-bottom: 3rem;
        }

        .timeline {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 15px;
            padding: 2rem;
        }

        .timeline-item {
            display: flex;
            gap: 1rem;
            align-items: flex-start;
        }

        .timeline-icon {
            background: #667eea;
            color: white;
            width: 40px;
            height: 40px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-shrink: 0;
        }

        .timeline-content h4 {
            margin-bottom: 0.5rem;
            color: #333;
        }

        .timeline-content p {
            color: #666;
            margin-bottom: 0.5rem;
        }

        .timeline-content time {
            color: #999;
            font-size: 0.9rem;
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

            .hero-title {
                font-size: 2rem;
            }

            .stats-grid {
                grid-template-columns: 1fr;
            }

            .features-grid {
                grid-template-columns: 1fr;
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
        <!-- 成功消息显示 -->
        <c:if test="${not empty sessionScope.successMsg}">
            <div class="alert alert-success">
                <i class="fas fa-check-circle"></i>
                <div class="alert-content">
                        ${sessionScope.successMsg}
                </div>
                <button class="alert-close" onclick="this.parentElement.style.display='none'">
                    <i class="fas fa-times"></i>
                </button>
            </div>
            <c:remove var="successMsg" scope="session" />
        </c:if>

        <!-- 英雄区域 -->
        <section class="hero-section modern">
            <div class="hero-content">
                <h1 class="hero-title">
                    <i class="fas fa-graduation-cap"></i>
                    欢迎来到校园论坛
                </h1>
                <p class="hero-subtitle">
                    在这里分享知识、交流想法、结识好友，共同建设更好的校园社区
                </p>
                <div class="hero-actions">
                    <c:choose>
                        <c:when test="${empty sessionScope.currentUser}">
                            <a href="${pageContext.request.contextPath}/register.jsp" class="btn-hero primary">
                                <i class="fas fa-rocket"></i> 立即加入
                            </a>
                            <a href="${pageContext.request.contextPath}/login.jsp" class="btn-hero secondary">
                                <i class="fas fa-sign-in-alt"></i> 用户登录
                            </a>
                        </c:when>
                        <c:otherwise>
                            <a href="${pageContext.request.contextPath}/user/createPost" class="btn-hero primary">
                                <i class="fas fa-edit"></i> 发布帖子
                            </a>
                            <a href="${pageContext.request.contextPath}/posts" class="btn-hero secondary">
                                <i class="fas fa-list"></i> 浏览帖子
                            </a>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </section>

        <!-- 统计信息卡片 -->
        <section class="stats-section modern">
            <div class="section-header">
                <h2><i class="fas fa-chart-line"></i> 论坛数据</h2>
                <p>实时统计信息</p>
            </div>
            <div class="stats-grid">
                <div class="stat-card">
                    <div class="stat-icon">
                        <i class="fas fa-users"></i>
                    </div>
                    <div class="stat-content">
                        <h3>在线用户</h3>
                        <div class="stat-number" data-target="${applicationScope.onlineUserCount}">0</div>
                        <p class="stat-label">正在浏览</p>
                    </div>
                </div>

                <div class="stat-card">
                    <div class="stat-icon">
                        <i class="fas fa-comments"></i>
                    </div>
                    <div class="stat-content">
                        <h3>今日帖子</h3>
                        <div class="stat-number" id="todayPosts" data-target="0">0</div>
                        <p class="stat-label">新发布</p>
                    </div>
                </div>

                <div class="stat-card">
                    <div class="stat-icon">
                        <i class="fas fa-fire"></i>
                    </div>
                    <div class="stat-content">
                        <h3>热门话题</h3>
                        <div class="stat-number" data-target="5">0</div>
                        <p class="stat-label">活跃讨论</p>
                    </div>
                </div>

                <div class="stat-card">
                    <div class="stat-icon">
                        <i class="fas fa-eye"></i>
                    </div>
                    <div class="stat-content">
                        <h3>总浏览量</h3>
                        <div class="stat-number" id="totalViews" data-target="0">0</div>
                        <p class="stat-label">页面访问</p>
                    </div>
                </div>
            </div>
        </section>

        <!-- 热门帖子 -->
        <section class="hot-posts-section modern">
            <div class="section-header">
                <h2><i class="fas fa-fire"></i> 热门帖子</h2>
                <p>最受欢迎的讨论话题</p>
            </div>
            <div class="posts-container" id="hotPostsList">
                <!-- 直接在 HTML 中写内容，避免 JavaScript 乱码 -->
                <div class="empty-state">
                    <i class="fas fa-comments"></i>
                    <h3>还没有热门帖子</h3>
                    <p>快来发布第一个帖子吧！</p>
                    <c:choose>
                        <c:when test="${not empty sessionScope.currentUser}">
                            <a href="${pageContext.request.contextPath}/user/createPost" class="btn-primary">发布帖子</a>
                        </c:when>
                        <c:otherwise>
                            <a href="${pageContext.request.contextPath}/login.jsp" class="btn-primary">登录后发布</a>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
            <div style="text-align: center; margin-top: 1rem;">
                <a href="${pageContext.request.contextPath}/posts" class="btn-outline-modern">
                    <i class="fas fa-arrow-right"></i> 查看更多帖子
                </a>
            </div>
        </section>

        <!-- 功能导航 -->
        <section class="features-section">
            <div class="section-header">
                <h2><i class="fas fa-compass"></i> 论坛导航</h2>
                <p>快速访问各个功能模块</p>
            </div>
            <div class="features-grid">
                <div class="feature-card">
                    <div class="feature-icon">
                        <i class="fas fa-graduation-cap"></i>
                    </div>
                    <h3>学习交流</h3>
                    <p>分享学习心得，互帮互助</p>
                    <a href="${pageContext.request.contextPath}/posts?category=1" class="feature-link">
                        <i class="fas fa-arrow-right"></i>
                    </a>
                </div>

                <div class="feature-card">
                    <div class="feature-icon">
                        <i class="fas fa-gamepad"></i>
                    </div>
                    <h3>休闲娱乐</h3>
                    <p>轻松话题，放松心情</p>
                    <a href="${pageContext.request.contextPath}/posts?category=2" class="feature-link">
                        <i class="fas fa-arrow-right"></i>
                    </a>
                </div>

                <div class="feature-card">
                    <div class="feature-icon">
                        <i class="fas fa-briefcase"></i>
                    </div>
                    <h3>求职招聘</h3>
                    <p>工作机会，职业发展</p>
                    <a href="${pageContext.request.contextPath}/posts?category=3" class="feature-link">
                        <i class="fas fa-arrow-right"></i>
                    </a>
                </div>

                <div class="feature-card">
                    <div class="feature-icon">
                        <i class="fas fa-heart"></i>
                    </div>
                    <h3>校园生活</h3>
                    <p>生活分享，情感交流</p>
                    <a href="${pageContext.request.contextPath}/posts?category=4" class="feature-link">
                        <i class="fas fa-arrow-right"></i>
                    </a>
                </div>
            </div>
        </section>

        <!-- 最新动态时间线 -->
        <section class="activities-section">
            <div class="section-header">
                <h2><i class="fas fa-clock"></i> 最新动态</h2>
                <p>论坛最新活动和更新</p>
            </div>
            <div class="timeline" id="recentActivities">
                <div class="timeline-item">
                    <div class="timeline-icon">
                        <i class="fas fa-rocket"></i>
                    </div>
                    <div class="timeline-content">
                        <h4>🎉 校园论坛正式上线</h4>
                        <p>欢迎大家使用全新的校园论坛系统，一起分享知识，交流想法！</p>
                        <time>刚刚</time>
                    </div>
                </div>
            </div>
        </section>
    </div>
</main>

<!-- 页脚 -->
<jsp:include page="includes/footer.jsp" />

<!-- 简化的 JavaScript，只做数字动画 -->
<script>
    document.addEventListener('DOMContentLoaded', function() {
        // 数字滚动动画
        const counters = document.querySelectorAll('.stat-number');
        counters.forEach(counter => {
            const target = parseInt(counter.getAttribute('data-target')) || 0;
            const increment = target / 50;
            let current = 0;

            const updateCounter = () => {
                if (current < target) {
                    current += increment;
                    counter.textContent = Math.ceil(current);
                    setTimeout(updateCounter, 40);
                } else {
                    counter.textContent = target;
                }
            };

            setTimeout(updateCounter, 1000);
        });
    });
</script>
</body>
</html>