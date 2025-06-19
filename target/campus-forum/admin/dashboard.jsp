<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>管理后台 - 校园论坛</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .admin-dashboard {
            display: grid;
            grid-template-columns: 250px 1fr;
            min-height: calc(100vh - 120px);
            gap: 20px;
        }

        .admin-sidebar {
            background: white;
            padding: 1.5rem;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            height: fit-content;
        }

        .admin-sidebar h3 {
            margin-bottom: 1rem;
            color: #333;
            border-bottom: 2px solid #667eea;
            padding-bottom: 0.5rem;
        }

        .admin-menu {
            list-style: none;
            padding: 0;
        }

        .admin-menu li {
            margin-bottom: 0.5rem;
        }

        .admin-menu a {
            display: block;
            padding: 10px 15px;
            color: #333;
            text-decoration: none;
            border-radius: 5px;
            transition: all 0.3s ease;
        }

        .admin-menu a:hover, .admin-menu a.active {
            background-color: #667eea;
            color: white;
        }

        .admin-content {
            background: white;
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }

        .stats-overview {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 2rem;
        }

        .stat-item {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            padding: 1.5rem;
            border-radius: 10px;
            text-align: center;
        }

        .stat-item h4 {
            margin-bottom: 0.5rem;
            font-size: 0.9rem;
            opacity: 0.9;
        }

        .stat-item .number {
            font-size: 2rem;
            font-weight: bold;
        }

        .hot-posts-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 1rem;
        }

        .hot-posts-table th,
        .hot-posts-table td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #e9ecef;
        }

        .hot-posts-table th {
            background-color: #f8f9fa;
            font-weight: 600;
        }

        .hot-level {
            display: inline-block;
            padding: 4px 8px;
            border-radius: 12px;
            font-size: 0.8rem;
            font-weight: bold;
        }

        .hot-level.super { background: #ff6b6b; color: white; }
        .hot-level.very { background: #ffa500; color: white; }
        .hot-level.normal { background: #4ecdc4; color: white; }
        .hot-level.low { background: #95a5a6; color: white; }
    </style>
</head>
<body>
<jsp:include page="../includes/headers.jsp" />

<main class="main">
    <div class="container">
        <div class="admin-dashboard">
            <!-- 左侧菜单 -->
            <div class="admin-sidebar">
                <h3><i class="fas fa-cog"></i> 管理菜单</h3>
                <ul class="admin-menu">
                    <li><a href="?tab=overview" class="active"><i class="fas fa-tachometer-alt"></i> 数据概览</a></li>
                    <li><a href="?tab=posts"><i class="fas fa-file-alt"></i> 帖子管理</a></li>
                    <li><a href="?tab=users"><i class="fas fa-users"></i> 用户管理</a></li>
                    <li><a href="?tab=statistics"><i class="fas fa-chart-bar"></i> 统计分析</a></li>
                    <li><a href="?tab=settings"><i class="fas fa-wrench"></i> 系统设置</a></li>
                </ul>
            </div>

            <!-- 右侧内容 -->
            <div class="admin-content">
                <h2><i class="fas fa-dashboard"></i> 管理后台</h2>

                <!-- 统计概览 -->
                <div class="stats-overview">
                    <div class="stat-item">
                        <h4>总用户数</h4>
                        <div class="number" id="totalUsers">-</div>
                    </div>
                    <div class="stat-item">
                        <h4>总帖子数</h4>
                        <div class="number" id="totalPosts">-</div>
                    </div>
                    <div class="stat-item">
                        <h4>今日新帖</h4>
                        <div class="number" id="todayPosts">-</div>
                    </div>
                    <div class="stat-item">
                        <h4>在线用户</h4>
                        <div class="number">${applicationScope.onlineUserCount}</div>
                    </div>
                </div>

                <!-- 热门帖子统计 -->
                <section>
                    <h3><i class="fas fa-fire"></i> 热度最高的帖子</h3>
                    <table class="hot-posts-table">
                        <thead>
                        <tr>
                            <th>排名</th>
                            <th>标题</th>
                            <th>作者</th>
                            <th>分类</th>
                            <th>热度</th>
                            <th>浏览量</th>
                            <th>点赞数</th>
                            <th>业务订单号</th>
                            <th>发布时间</th>
                        </tr>
                        </thead>
                        <tbody id="hotPostsList">
                        <tr>
                            <td colspan="9" style="text-align: center; padding: 2rem;">
                                <i class="fas fa-spinner fa-spin"></i> 正在加载数据...
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </section>
            </div>
        </div>
    </div>
</main>

<jsp:include page="../includes/footer.jsp" />

<script>
    // 加载管理员统计数据
    document.addEventListener('DOMContentLoaded', function() {
        loadAdminStatistics();
        loadHotPostsStatistics();
    });

    // 加载统计数据
    function loadAdminStatistics() {
        fetch('${pageContext.request.contextPath}/admin/statistics')
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    document.getElementById('totalUsers').textContent = data.data.totalUsers || 0;
                    document.getElementById('totalPosts').textContent = data.data.totalPosts || 0;
                    document.getElementById('todayPosts').textContent = data.data.todayPosts || 0;
                }
            })
            .catch(error => {
                console.error('加载统计数据失败:', error);
            });
    }

    // 加载热门帖子统计
    function loadHotPostsStatistics() {
        fetch('${pageContext.request.contextPath}/admin/hotPosts')
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    displayHotPosts(data.data);
                }
            })
            .catch(error => {
                console.error('加载热门帖子失败:', error);
                document.getElementById('hotPostsList').innerHTML =
                    '<tr><td colspan="9" style="text-align: center; color: #e74c3c;">加载失败</td></tr>';
            });
    }

    // 显示热门帖子
    function displayHotPosts(posts) {
        const tbody = document.getElementById('hotPostsList');

        if (!posts || posts.length === 0) {
            tbody.innerHTML = '<tr><td colspan="9" style="text-align: center;">暂无数据</td></tr>';
            return;
        }

        let html = '';
        posts.forEach((post, index) => {
            const rank = index + 1;
            const hotLevel = getHotLevelClass(post.hotScore);
            const formatTime = new Date(post.createTime).toLocaleString('zh-CN');

            html += `
                    <tr>
                        <td><strong>#\${rank}</strong></td>
                        <td><a href="${pageContext.request.contextPath}/post-detail?id=\${post.id}" target="_blank">\${post.title}</a></td>
                        <td>\${post.userNickname}</td>
                        <td>\${post.categoryName}</td>
                        <td><span class="hot-level \${hotLevel.class}">\${hotLevel.text}</span></td>
                        <td>\${post.viewCount}</td>
                        <td>\${post.likeCount}</td>
                        <td><code>\${post.businessOrderNo}</code></td>
                        <td>\${formatTime}</td>
                    </tr>
                `;
        });

        tbody.innerHTML = html;
    }

    // 获取热度等级样式
    function getHotLevelClass(score) {
        if (score > 100) return { class: 'super', text: '🔥🔥🔥 超热' };
        if (score > 50) return { class: 'very', text: '🔥🔥 很热' };
        if (score > 20) return { class: 'normal', text: '🔥 热门' };
        return { class: 'low', text: '📝 普通' };
    }

    // 菜单切换
    document.querySelectorAll('.admin-menu a').forEach(link => {
        link.addEventListener('click', function(e) {
            e.preventDefault();

            // 移除所有active类
            document.querySelectorAll('.admin-menu a').forEach(a => a.classList.remove('active'));

            // 添加active类到当前链接
            this.classList.add('active');

            // 这里可以添加页面切换逻辑
            const tab = new URL(this.href).searchParams.get('tab');
            console.log('切换到标签页:', tab);
        });
    });
</script>
</body>
</html>