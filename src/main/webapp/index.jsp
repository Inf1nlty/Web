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
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
<!-- 头部导航 -->
<jsp:include page="includes/headers.jsp" />

<!-- 主要内容 -->
<main class="main">
    <div class="container">
        <!-- 成功消息显示 -->
        <c:if test="${not empty sessionScope.successMsg}">
            <div class="alert alert-success" style="margin-bottom: 2rem;">
                <i class="fas fa-check-circle"></i>
                    ${sessionScope.successMsg}
            </div>
            <c:remove var="successMsg" scope="session" />
        </c:if>

        <!-- 欢迎横幅 -->
        <section class="hero-section">
            <div class="hero-content">
                <h2>欢迎来到校园论坛</h2>
                <p>分享知识，交流想法，建设更好的校园社区</p>
                <c:if test="${empty sessionScope.currentUser}">
                    <a href="${pageContext.request.contextPath}/register" class="btn btn-hero">立即加入</a>
                </c:if>
                <c:if test="${not empty sessionScope.currentUser}">
                    <a href="${pageContext.request.contextPath}/user/createPost.jsp" class="btn btn-hero">发布帖子</a>
                </c:if>
            </div>
        </section>

        <!-- 统计信息 -->
        <section class="stats-section">
            <div class="stats-grid">
                <div class="stat-card">
                    <i class="fas fa-users"></i>
                    <h3>在线用户</h3>
                    <p class="stat-number">${applicationScope.onlineUserCount}</p>
                </div>
                <div class="stat-card">
                    <i class="fas fa-comments"></i>
                    <h3>今日帖子</h3>
                    <p class="stat-number" id="todayPosts">0</p>
                </div>
                <div class="stat-card">
                    <i class="fas fa-fire"></i>
                    <h3>热门话题</h3>
                    <p class="stat-number" id="hotTopics">5</p>
                </div>
                <div class="stat-card">
                    <i class="fas fa-clock"></i>
                    <h3>总浏览量</h3>
                    <p class="stat-number" id="totalViews">0</p>
                </div>
            </div>
        </section>

        <!-- 热门帖子预览 -->
        <section class="hot-posts-section">
            <h3><i class="fas fa-fire"></i> 热门帖子</h3>
            <div class="posts-preview" id="hotPostsList">
                <!-- 这里通过AJAX加载热门帖子 -->
                <div class="loading">正在加载...</div>
            </div>
            <div class="section-footer">
                <a href="${pageContext.request.contextPath}/posts" class="btn btn-outline">查看更多帖子</a>
            </div>
        </section>

        <!-- 最新动态 -->
        <section class="recent-activities">
            <h3><i class="fas fa-history"></i> 最新动态</h3>
            <div class="activity-list" id="recentActivities">
                <div class="loading">正在加载...</div>
            </div>
        </section>
    </div>
</main>

<!-- 页脚 -->
<jsp:include page="includes/footer.jsp" />

<script src="${pageContext.request.contextPath}/js/main.js"></script>
<script>
    // 页面加载完成后获取数据
    document.addEventListener('DOMContentLoaded', function() {
        loadHotPosts();
        loadRecentActivities();
        loadStatistics();
    });

    // 加载热门帖子
    function loadHotPosts() {
        fetch('${pageContext.request.contextPath}/api/hot-posts')
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    displayHotPosts(data.data);
                } else {
                    document.getElementById('hotPostsList').innerHTML = '<div class="no-data">暂无热门帖子</div>';
                }
            })
            .catch(error => {
                console.error('加载热门帖子失败:', error);
                document.getElementById('hotPostsList').innerHTML = '<div class="error">加载失败</div>';
            });
    }

    // 显示热门帖子
    function displayHotPosts(posts) {
        const container = document.getElementById('hotPostsList');
        if (!posts || posts.length === 0) {
            container.innerHTML = '<div class="no-data">暂无热门帖子</div>';
            return;
        }

        let html = '';
        posts.forEach(post => {
            html += `
                <div class="post-card">
                    <h4><a href="${pageContext.request.contextPath}/post-detail?id=\${post.id}">\${post.title}</a></h4>
                    <div class="post-meta">
                        <span><i class="fas fa-user"></i> \${post.userNickname}</span>
                        <span><i class="fas fa-folder"></i> \${post.categoryName}</span>
                        <span><i class="fas fa-eye"></i> \${post.viewCount}</span>
                        <span><i class="fas fa-heart"></i> \${post.likeCount}</span>
                        <span><i class="fas fa-clock"></i> \${formatTime(post.createTime)}</span>
                        <span style="color: #e17055;">\${post.hotLevel}</span>
                    </div>
                </div>
            `;
        });
        container.innerHTML = html;
    }

    // 加载统计数据
    function loadStatistics() {
        fetch('${pageContext.request.contextPath}/api/statistics')
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    document.getElementById('todayPosts').textContent = data.data.todayPosts || 0;
                    document.getElementById('totalViews').textContent = data.data.totalViews || 0;
                }
            })
            .catch(error => {
                console.error('加载统计数据失败:', error);
            });
    }

    // 加载最新动态
    function loadRecentActivities() {
        document.getElementById('recentActivities').innerHTML = `
            <div class="activity-item">
                <i class="fas fa-plus-circle" style="color: #28a745;"></i>
                <span>系统启动，欢迎大家使用校园论坛！</span>
                <small>刚刚</small>
            </div>
        `;
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