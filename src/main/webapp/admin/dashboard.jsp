<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>管理后台 - 校园论坛</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Microsoft YaHei', 'SimSun', Arial, sans-serif;
            background: #f5f6fa;
            line-height: 1.6;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
        }

        /* 头部样式 */
        .header {
            background: white;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
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

        /* 主要内容 */
        .main {
            padding: 2rem 0;
        }

        .admin-dashboard {
            display: grid;
            grid-template-columns: 280px 1fr;
            gap: 2rem;
            min-height: calc(100vh - 120px);
        }

        /* 侧边栏 */
        .admin-sidebar {
            background: white;
            padding: 2rem;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            height: fit-content;
        }

        .admin-sidebar h3 {
            margin-bottom: 1.5rem;
            color: #333;
            font-size: 1.2rem;
            padding-bottom: 0.5rem;
            border-bottom: 3px solid #667eea;
        }

        .admin-menu {
            list-style: none;
            padding: 0;
        }

        .admin-menu li {
            margin-bottom: 0.5rem;
        }

        .admin-menu a {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            padding: 1rem 1.25rem;
            color: #666;
            text-decoration: none;
            border-radius: 10px;
            transition: all 0.3s ease;
            font-weight: 500;
        }

        .admin-menu a:hover,
        .admin-menu a.active {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            transform: translateX(5px);
        }

        .admin-menu i {
            font-size: 1.1rem;
        }

        /* 主内容区域 */
        .admin-content {
            background: white;
            padding: 2.5rem;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
        }

        .content-header {
            margin-bottom: 2rem;
            padding-bottom: 1rem;
            border-bottom: 2px solid #f0f0f0;
        }

        .content-header h2 {
            color: #333;
            font-size: 2rem;
            margin-bottom: 0.5rem;
        }

        .content-header p {
            color: #666;
            font-size: 1.1rem;
        }

        /* 统计概览 */
        .stats-overview {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 1.5rem;
            margin-bottom: 3rem;
        }

        .stat-item {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            padding: 2rem;
            border-radius: 15px;
            text-align: center;
            box-shadow: 0 10px 30px rgba(102, 126, 234, 0.3);
            transition: transform 0.3s ease;
        }

        .stat-item:hover {
            transform: translateY(-5px);
        }

        .stat-item i {
            font-size: 3rem;
            margin-bottom: 1rem;
            opacity: 0.9;
        }

        .stat-item h4 {
            margin-bottom: 0.5rem;
            font-size: 1rem;
            opacity: 0.9;
            font-weight: normal;
        }

        .stat-item .number {
            font-size: 2.5rem;
            font-weight: bold;
            margin-bottom: 0.5rem;
        }

        .stat-item .trend {
            font-size: 0.9rem;
            opacity: 0.8;
        }

        /* 热门帖子表格 */
        .section-title {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            margin-bottom: 1.5rem;
            color: #333;
            font-size: 1.5rem;
            font-weight: 600;
        }

        .table-container {
            background: #f8f9fa;
            border-radius: 12px;
            padding: 1.5rem;
            overflow-x: auto;
        }

        .hot-posts-table {
            width: 100%;
            border-collapse: collapse;
            background: white;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
        }

        .hot-posts-table th {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            padding: 1rem;
            text-align: left;
            font-weight: 600;
            font-size: 0.9rem;
        }

        .hot-posts-table td {
            padding: 1rem;
            border-bottom: 1px solid #f0f0f0;
            vertical-align: middle;
        }

        .hot-posts-table tr:hover {
            background-color: #f8f9fa;
        }

        .hot-posts-table tr:last-child td {
            border-bottom: none;
        }

        .hot-level {
            padding: 0.25rem 0.75rem;
            border-radius: 15px;
            font-size: 0.8rem;
            font-weight: bold;
            display: inline-block;
        }

        .hot-level.super {
            background: #e74c3c;
            color: white;
        }

        .hot-level.very {
            background: #f39c12;
            color: white;
        }

        .hot-level.normal {
            background: #3498db;
            color: white;
        }

        .hot-level.low {
            background: #95a5a6;
            color: white;
        }

        .post-link {
            color: #667eea;
            text-decoration: none;
            font-weight: 500;
        }

        .post-link:hover {
            text-decoration: underline;
        }

        .order-code {
            font-family: 'Courier New', monospace;
            background: #f8f9fa;
            padding: 0.25rem 0.5rem;
            border-radius: 4px;
            font-size: 0.8rem;
            color: #666;
        }

        /* 加载状态 */
        .loading-spinner {
            text-align: center;
            padding: 3rem;
            color: #666;
        }

        .spinner {
            display: inline-block;
            width: 40px;
            height: 40px;
            border: 3px solid #f3f3f3;
            border-top: 3px solid #667eea;
            border-radius: 50%;
            animation: spin 1s linear infinite;
            margin-bottom: 1rem;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        /* 响应式 */
        @media (max-width: 1024px) {
            .admin-dashboard {
                grid-template-columns: 1fr;
            }

            .admin-sidebar {
                order: 1;
            }

            .admin-content {
                order: 0;
            }

            .stats-overview {
                grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            }
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

            .admin-content {
                padding: 1.5rem;
            }

            .stats-overview {
                grid-template-columns: 1fr;
            }

            .table-container {
                padding: 1rem;
            }

            .hot-posts-table {
                font-size: 0.8rem;
            }

            .hot-posts-table th,
            .hot-posts-table td {
                padding: 0.5rem;
            }
        }
    </style>
</head>
<body>
<!-- 包含头部导航 -->
<jsp:include page="../includes/headers.jsp" />

<main class="main">
    <div class="container">
        <div class="admin-dashboard">
            <!-- 侧边栏 -->
            <div class="admin-sidebar">
                <h3><i class="fas fa-cogs"></i> 管理菜单</h3>
                <ul class="admin-menu">
                    <li><a href="#dashboard" class="active" onclick="showSection('dashboard')">
                        <i class="fas fa-tachometer-alt"></i> 仪表盘
                    </a></li>
                    <li><a href="#posts" onclick="showSection('posts')">
                        <i class="fas fa-comments"></i> 帖子管理
                    </a></li>
                    <li><a href="#users" onclick="showSection('users')">
                        <i class="fas fa-users"></i> 用户管理
                    </a></li>
                    <li><a href="#categories" onclick="showSection('categories')">
                        <i class="fas fa-folder"></i> 分类管理
                    </a></li>
                    <li><a href="#reports" onclick="showSection('reports')">
                        <i class="fas fa-chart-bar"></i> 数据报表
                    </a></li>
                    <li><a href="#settings" onclick="showSection('settings')">
                        <i class="fas fa-cog"></i> 系统设置
                    </a></li>
                </ul>
            </div>

            <!-- 主内容区域 -->
            <div class="admin-content">
                <!-- 仪表盘内容 -->
                <div id="dashboard-content" class="content-section">
                    <div class="content-header">
                        <h2><i class="fas fa-tachometer-alt"></i> 管理仪表盘</h2>
                        <p>校园论坛系统总览</p>
                    </div>

                    <!-- 统计概览 -->
                    <div class="stats-overview">
                        <div class="stat-item">
                            <i class="fas fa-users"></i>
                            <h4>总用户数</h4>
                            <div class="number" id="totalUsers">0</div>
                            <div class="trend">📈 持续增长</div>
                        </div>
                        <div class="stat-item">
                            <i class="fas fa-comments"></i>
                            <h4>总帖子数</h4>
                            <div class="number" id="totalPosts">0</div>
                            <div class="trend">💬 活跃讨论</div>
                        </div>
                        <div class="stat-item">
                            <i class="fas fa-calendar-day"></i>
                            <h4>今日新帖</h4>
                            <div class="number" id="todayPosts">0</div>
                            <div class="trend">🆕 新增内容</div>
                        </div>
                        <div class="stat-item">
                            <i class="fas fa-eye"></i>
                            <h4>总浏览量</h4>
                            <div class="number" id="totalViews">0</div>
                            <div class="trend">👀 用户参与</div>
                        </div>
                    </div>

                    <!-- 热门帖子排行榜 -->
                    <h3 class="section-title">
                        <i class="fas fa-fire"></i>
                        热门帖子排行榜
                    </h3>
                    <div class="table-container">
                        <table class="hot-posts-table">
                            <thead>
                            <tr>
                                <th>排名</th>
                                <th>帖子标题</th>
                                <th>作者</th>
                                <th>分类</th>
                                <th>热度等级</th>
                                <th>浏览量</th>
                                <th>点赞数</th>
                                <th>订单号</th>
                                <th>发布时间</th>
                            </tr>
                            </thead>
                            <tbody id="hotPostsList">
                            <tr>
                                <td colspan="9">
                                    <div class="loading-spinner">
                                        <div class="spinner"></div>
                                        <p>正在加载数据...</p>
                                    </div>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>

                <!-- 其他内容区域 -->
                <div id="posts-content" class="content-section" style="display: none;">
                    <div class="content-header">
                        <h2><i class="fas fa-comments"></i> 帖子管理</h2>
                        <p>管理所有用户发布的帖子</p>
                    </div>
                    <p>帖子管理功能开发中...</p>
                </div>

                <div id="users-content" class="content-section" style="display: none;">
                    <div class="content-header">
                        <h2><i class="fas fa-users"></i> 用户管理</h2>
                        <p>管理注册用户和权限</p>
                    </div>
                    <p>用户管理功能开发中...</p>
                </div>

                <div id="categories-content" class="content-section" style="display: none;">
                    <div class="content-header">
                        <h2><i class="fas fa-folder"></i> 分类管理</h2>
                        <p>管理帖子分类和标签</p>
                    </div>
                    <p>分类管理功能开发中...</p>
                </div>

                <div id="reports-content" class="content-section" style="display: none;">
                    <div class="content-header">
                        <h2><i class="fas fa-chart-bar"></i> 数据报表</h2>
                        <p>查看系统统计和分析报告</p>
                    </div>
                    <p>数据报表功能开发中...</p>
                </div>

                <div id="settings-content" class="content-section" style="display: none;">
                    <div class="content-header">
                        <h2><i class="fas fa-cog"></i> 系统设置</h2>
                        <p>配置系统参数和选项</p>
                    </div>
                    <p>系统设置功能开发中...</p>
                </div>
            </div>
        </div>
    </div>
</main>

<jsp:include page="../includes/footer.jsp" />

<script>
    // 菜单切换功能
    function showSection(section) {
        // 隐藏所有内容区域
        document.querySelectorAll('.content-section').forEach(el => {
            el.style.display = 'none';
        });

        // 移除所有菜单项的active类
        document.querySelectorAll('.admin-menu a').forEach(el => {
            el.classList.remove('active');
        });

        // 显示选中的内容区域
        document.getElementById(section + '-content').style.display = 'block';

        // 为选中的菜单项添加active类
        event.target.classList.add('active');
    }

    // 加载管理员统计数据
    function loadAdminStatistics() {
        // 模拟数据，实际项目中应该从API获取
        setTimeout(() => {
            document.getElementById('totalUsers').textContent = '156';
            document.getElementById('totalPosts').textContent = '89';
            document.getElementById('todayPosts').textContent = '12';
            document.getElementById('totalViews').textContent = '2,847';
        }, 1000);

        // 如果有实际API，使用下面的代码
        /*
        fetch('${pageContext.request.contextPath}/admin/statistics')
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    document.getElementById('totalUsers').textContent = data.data.totalUsers || 0;
                    document.getElementById('totalPosts').textContent = data.data.totalPosts || 0;
                    document.getElementById('todayPosts').textContent = data.data.todayPosts || 0;
                    document.getElementById('totalViews').textContent = data.data.totalViews || 0;
                }
            })
            .catch(error => {
                console.error('加载统计数据失败:', error);
            });
        */
    }

    // 加载热门帖子统计
    function loadHotPostsStatistics() {
        // 模拟数据
        setTimeout(() => {
            const mockPosts = [
                {
                    id: 1,
                    title: "Java学习心得分享",
                    userNickname: "技术达人",
                    categoryName: "学习交流",
                    hotScore: 120,
                    viewCount: 856,
                    likeCount: 45,
                    businessOrderNo: "POST1705123456789",
                    createTime: new Date()
                },
                {
                    id: 2,
                    title: "校园生活趣事",
                    userNickname: "快乐学生",
                    categoryName: "校园生活",
                    hotScore: 85,
                    viewCount: 623,
                    likeCount: 32,
                    businessOrderNo: "POST1705123456790",
                    createTime: new Date()
                }
            ];
            displayHotPosts(mockPosts);
        }, 1500);

        // 如果有实际API，使用下面的代码
        /*
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
        */
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
                    <td><strong>#${rank}</strong></td>
                    <td><a href="${'${pageContext.request.contextPath}'}/post-detail?id=${post.id}"
                          target="_blank" class="post-link">${post.title}</a></td>
                    <td>${post.userNickname}</td>
                    <td>${post.categoryName}</td>
                    <td><span class="hot-level ${hotLevel.class}">${hotLevel.text}</span></td>
                    <td>${post.viewCount}</td>
                    <td>${post.likeCount}</td>
                    <td><span class="order-code">${post.businessOrderNo}</span></td>
                    <td>${formatTime}</td>
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

    // 页面加载完成后执行
    document.addEventListener('DOMContentLoaded', function() {
        loadAdminStatistics();
        loadHotPostsStatistics();
    });
</script>
</body>
</html>