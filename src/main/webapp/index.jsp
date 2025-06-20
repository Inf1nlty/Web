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
</head>
<body>
<!-- 头部导航 -->
<jsp:include page="includes/headers.jsp" />

<!-- 主要内容 -->
<main class="main">
    <div class="container">
        <!-- 成功消息显示 -->
        <c:if test="${not empty sessionScope.successMsg}">
            <div class="alert alert-success animate__animated animate__slideInDown">
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
            <div class="hero-background">
                <div class="floating-shapes">
                    <div class="shape shape-1"></div>
                    <div class="shape shape-2"></div>
                    <div class="shape shape-3"></div>
                    <div class="shape shape-4"></div>
                </div>
            </div>
            <div class="hero-content">
                <h1 class="hero-title animate__animated animate__fadeInUp">
                    <i class="fas fa-graduation-cap"></i>
                    欢迎来到校园论坛
                </h1>
                <p class="hero-subtitle animate__animated animate__fadeInUp animate__delay-1s">
                    在这里分享知识、交流想法、结识好友，共同建设更好的校园社区
                </p>
                <div class="hero-actions animate__animated animate__fadeInUp animate__delay-2s">
                    <c:choose>
                        <c:when test="${empty sessionScope.currentUser}">
                            <a href="${pageContext.request.contextPath}/register.jsp" class="btn btn-hero primary">
                                <i class="fas fa-rocket"></i> 立即加入
                            </a>
                            <a href="${pageContext.request.contextPath}/login.jsp" class="btn btn-hero secondary">
                                <i class="fas fa-sign-in-alt"></i> 用户登录
                            </a>
                        </c:when>
                        <c:otherwise>
                            <a href="${pageContext.request.contextPath}/user/createPost" class="btn btn-hero primary">
                                <i class="fas fa-edit"></i> 发布帖子
                            </a>
                            <a href="${pageContext.request.contextPath}/posts" class="btn btn-hero secondary">
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
                <div class="stat-card animate__animated animate__fadeInLeft">
                    <div class="stat-icon">
                        <i class="fas fa-users"></i>
                    </div>
                    <div class="stat-content">
                        <h3>在线用户</h3>
                        <div class="stat-number" data-target="${applicationScope.onlineUserCount}">0</div>
                        <p class="stat-label">正在浏览</p>
                    </div>
                    <div class="stat-trend up">
                        <i class="fas fa-arrow-up"></i>
                    </div>
                </div>

                <div class="stat-card animate__animated animate__fadeInUp animate__delay-1s">
                    <div class="stat-icon">
                        <i class="fas fa-comments"></i>
                    </div>
                    <div class="stat-content">
                        <h3>今日帖子</h3>
                        <div class="stat-number" id="todayPosts" data-target="0">0</div>
                        <p class="stat-label">新发布</p>
                    </div>
                    <div class="stat-trend up">
                        <i class="fas fa-arrow-up"></i>
                    </div>
                </div>

                <div class="stat-card animate__animated animate__fadeInUp animate__delay-2s">
                    <div class="stat-icon">
                        <i class="fas fa-fire"></i>
                    </div>
                    <div class="stat-content">
                        <h3>热门话题</h3>
                        <div class="stat-number" data-target="5">0</div>
                        <p class="stat-label">活跃讨论</p>
                    </div>
                    <div class="stat-trend up">
                        <i class="fas fa-arrow-up"></i>
                    </div>
                </div>

                <div class="stat-card animate__animated animate__fadeInRight animate__delay-3s">
                    <div class="stat-icon">
                        <i class="fas fa-eye"></i>
                    </div>
                    <div class="stat-content">
                        <h3>总浏览量</h3>
                        <div class="stat-number" id="totalViews" data-target="0">0</div>
                        <p class="stat-label">页面访问</p>
                    </div>
                    <div class="stat-trend up">
                        <i class="fas fa-arrow-up"></i>
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
                <div class="loading-spinner">
                    <div class="spinner"></div>
                    <p>正在加载精彩内容...</p>
                </div>
            </div>
            <div class="section-footer">
                <a href="${pageContext.request.contextPath}/posts" class="btn btn-outline-modern">
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

<!-- JavaScript -->
<script src="${pageContext.request.contextPath}/js/main.js"></script>
<script>
    // 页面加载完成后执行
    document.addEventListener('DOMContentLoaded', function() {
        initAnimations();
        loadHotPosts();
        loadStatistics();
        startCounterAnimation();
    });

    // 初始化动画
    function initAnimations() {
        // 滚动时触发动画
        const observer = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    entry.target.classList.add('animate__animated', 'animate__fadeInUp');
                }
            });
        });

        // 观察所有卡片元素
        document.querySelectorAll('.stat-card, .feature-card').forEach(el => {
            observer.observe(el);
        });
    }

    // 数字滚动动画
    function startCounterAnimation() {
        const counters = document.querySelectorAll('.stat-number');
        counters.forEach(counter => {
            const target = parseInt(counter.getAttribute('data-target'));
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
    }

    // 加载热门帖子
    function loadHotPosts() {
        fetch('${pageContext.request.contextPath}/api/hot-posts')
            .then(response => response.json())
            .then(data => {
                if (data.success && data.data && data.data.length > 0) {
                    displayHotPosts(data.data);
                } else {
                    showEmptyPosts();
                }
            })
            .catch(error => {
                console.error('加载热门帖子失败:', error);
                showErrorPosts();
            });
    }

    // 显示热门帖子
    function displayHotPosts(posts) {
        const container = document.getElementById('hotPostsList');
        let html = '<div class="posts-grid">';

        posts.forEach((post, index) => {
            html += `
                <article class="post-card-modern animate__animated animate__fadeInUp" style="animation-delay: ${index * 0.1}s">
                    <div class="post-header">
                        <span class="post-category">${post.categoryName || '默认'}</span>
                        <div class="post-progress">
                            <span class="progress-value">${post.progressPercent || 0}%</span>
                            <div class="progress-bar">
                                <div class="progress-fill" style="width: ${post.progressPercent || 0}%"></div>
                            </div>
                        </div>
                    </div>
                    <h3 class="post-title">
                        <a href="${pageContext.request.contextPath}/post-detail?id=${post.id}">
                            ${post.title}
                        </a>
                    </h3>
                    <div class="post-excerpt">
                        ${post.content.substring(0, 100)}${post.content.length > 100 ? '...' : ''}
                    </div>
                    <div class="post-footer">
                        <div class="post-author">
                            <i class="fas fa-user-circle"></i>
                            <span>${post.userNickname}</span>
                        </div>
                        <div class="post-stats">
                            <span><i class="fas fa-eye"></i> ${post.viewCount}</span>
                            <span><i class="fas fa-heart"></i> ${post.likeCount}</span>
                            <span><i class="fas fa-clock"></i> ${formatTime(post.createTime)}</span>
                        </div>
                    </div>
                </article>
            `;
        });

        html += '</div>';
        container.innerHTML = html;
    }

    // 显示空状态
    function showEmptyPosts() {
        const isLoggedIn = ${not empty sessionScope.currentUser};
        const createPostLink = isLoggedIn ?
            '<a href="${pageContext.request.contextPath}/user/createPost" class="btn btn-primary">发布帖子</a>' :
            '<a href="${pageContext.request.contextPath}/login.jsp" class="btn btn-primary">登录后发布</a>';

        document.getElementById('hotPostsList').innerHTML = `
        <div class="empty-state">
            <i class="fas fa-comments"></i>
            <h3>还没有热门帖子</h3>
            <p>快来发布第一个帖子吧！</p>
            ${createPostLink}
        </div>
    `;
    }

    // 显示错误状态
    function showErrorPosts() {
        document.getElementById('hotPostsList').innerHTML = `
            <div class="error-state">
                <i class="fas fa-exclamation-triangle"></i>
                <h3>加载失败</h3>
                <p>网络连接有问题，请稍后再试</p>
                <button onclick="loadHotPosts()" class="btn btn-outline-modern">重新加载</button>
            </div>
        `;
    }

    // 加载统计数据
    function loadStatistics() {
        fetch('${pageContext.request.contextPath}/api/statistics')
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    const todayPostsEl = document.getElementById('todayPosts');
                    const totalViewsEl = document.getElementById('totalViews');

                    if (todayPostsEl) {
                        todayPostsEl.setAttribute('data-target', data.data.todayPosts || 0);
                    }
                    if (totalViewsEl) {
                        totalViewsEl.setAttribute('data-target', data.data.totalViews || 0);
                    }
                }
            })
            .catch(error => {
                console.error('加载统计数据失败:', error);
            });
    }

    // 格式化时间
    function formatTime(timestamp) {
        const date = new Date(timestamp);
        const now = new Date();
        const diff = now - date;

        if (diff < 60000) return '刚刚';
        if (diff < 3600000) return Math.floor(diff / 60000) + '分钟前';
        if (diff < 86400000) return Math.floor(diff / 3600000) + '小时前';
        return Math.floor(diff / 86400000) + '天前';
    }
</script>
</body>
</html>