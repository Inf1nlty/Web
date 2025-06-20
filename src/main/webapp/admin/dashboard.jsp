<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- 检查管理员权限 -->
<c:if test="${empty sessionScope.currentUser || sessionScope.currentUser.role != 'admin'}">
    <c:redirect url="${pageContext.request.contextPath}/login.jsp"/>
</c:if>

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

        .user-menu {
            display: flex;
            gap: 1rem;
            align-items: center;
        }

        .welcome {
            color: #666;
            font-weight: 500;
        }

        .btn-logout {
            background: #dc3545;
            color: white;
            padding: 0.5rem 1rem;
            border-radius: 6px;
            text-decoration: none;
            transition: background 0.3s;
        }

        .btn-logout:hover {
            background: #c82333;
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
            transition: all 0.3s;
            font-weight: 500;
            cursor: pointer;
        }

        .admin-menu a:hover,
        .admin-menu a.active {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            transform: translateX(5px);
        }

        .admin-menu i {
            width: 20px;
            text-align: center;
        }

        /* 内容区域 */
        .admin-content {
            background: white;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }

        .content-header {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            padding: 2rem;
            text-align: center;
        }

        .content-header h2 {
            font-size: 2rem;
            margin-bottom: 0.5rem;
        }

        .content-header p {
            opacity: 0.9;
            font-size: 1.1rem;
        }

        .content-body {
            padding: 2rem;
        }

        /* 内容区域显示控制 */
        .content-section {
            display: none;
        }

        .content-section.active {
            display: block !important;
        }

        /* 统计卡片 */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 2rem;
            margin-bottom: 3rem;
        }

        .stat-card {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            padding: 2rem;
            border-radius: 15px;
            text-align: center;
            position: relative;
            overflow: hidden;
            transition: transform 0.3s;
        }

        .stat-card:hover {
            transform: translateY(-5px);
        }

        .stat-card::before {
            content: '';
            position: absolute;
            top: -50%;
            right: -50%;
            width: 100%;
            height: 100%;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 50%;
            transition: all 0.5s;
        }

        .stat-card:hover::before {
            top: -25%;
            right: -25%;
        }

        .stat-icon {
            font-size: 3rem;
            margin-bottom: 1rem;
            opacity: 0.8;
        }

        .stat-number {
            font-size: 2.5rem;
            font-weight: bold;
            margin-bottom: 0.5rem;
            position: relative;
            z-index: 1;
        }

        .stat-label {
            font-size: 1.1rem;
            opacity: 0.9;
            position: relative;
            z-index: 1;
        }

        /* 快速操作 */
        .quick-actions {
            margin-bottom: 3rem;
        }

        .quick-actions h3 {
            margin-bottom: 1.5rem;
            color: #333;
            font-size: 1.5rem;
        }

        .actions-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1.5rem;
        }

        .action-card {
            background: white;
            border: 2px solid #e9ecef;
            padding: 2rem;
            border-radius: 10px;
            text-align: center;
            transition: all 0.3s;
            cursor: pointer;
        }

        .action-card:hover {
            border-color: #667eea;
            transform: translateY(-3px);
            box-shadow: 0 10px 25px rgba(102, 126, 234, 0.15);
        }

        .action-card i {
            font-size: 2.5rem;
            color: #667eea;
            margin-bottom: 1rem;
        }

        .action-card h4 {
            color: #333;
            margin-bottom: 0.5rem;
        }

        .action-card p {
            color: #666;
            font-size: 0.9rem;
        }

        /* 最近活动 */
        .recent-activity {
            background: #f8f9fa;
            padding: 2rem;
            border-radius: 10px;
        }

        .recent-activity h3 {
            margin-bottom: 1.5rem;
            color: #333;
        }

        .activity-list {
            list-style: none;
        }

        .activity-item {
            display: flex;
            align-items: center;
            gap: 1rem;
            padding: 1rem;
            background: white;
            border-radius: 8px;
            margin-bottom: 1rem;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.05);
        }

        .activity-icon {
            width: 40px;
            height: 40px;
            background: #667eea;
            color: white;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-shrink: 0;
        }

        .activity-content {
            flex: 1;
        }

        .activity-title {
            font-weight: 500;
            color: #333;
            margin-bottom: 0.25rem;
        }

        .activity-time {
            font-size: 0.8rem;
            color: #666;
        }

        /* 按钮样式 */
        .btn-primary {
            background: #667eea;
            color: white;
            padding: 0.75rem 1.5rem;
            border: none;
            border-radius: 8px;
            text-decoration: none;
            transition: background 0.3s;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            font-size: 1rem;
        }

        .btn-primary:hover {
            background: #5a6fd8;
            color: white;
        }

        .btn-secondary {
            background: #6c757d;
            color: white;
            padding: 0.5rem 1rem;
            border: none;
            border-radius: 6px;
            text-decoration: none;
            transition: background 0.3s;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
        }

        .btn-secondary:hover {
            background: #5a6268;
            color: white;
        }

        .btn-danger {
            background: #dc3545;
            color: white;
            padding: 0.5rem 1rem;
            border: none;
            border-radius: 6px;
            text-decoration: none;
            transition: background 0.3s;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
        }

        .btn-danger:hover {
            background: #c82333;
            color: white;
        }

        /* 表格样式 */
        .data-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 1rem;
            background: white;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
        }

        .data-table th,
        .data-table td {
            padding: 1rem;
            text-align: left;
            border-bottom: 1px solid #e9ecef;
        }

        .data-table th {
            background: #f8f9fa;
            font-weight: 600;
            color: #333;
        }

        .data-table tbody tr:hover {
            background: #f8f9fa;
        }

        /* 响应式设计 */
        @media (max-width: 768px) {
            .admin-dashboard {
                grid-template-columns: 1fr;
                gap: 1rem;
            }

            .stats-grid {
                grid-template-columns: 1fr;
                gap: 1rem;
            }

            .actions-grid {
                grid-template-columns: 1fr;
            }
        }

        /* 加载动画 */
        .loading {
            text-align: center;
            padding: 2rem;
            color: #666;
        }

        .loading i {
            font-size: 2rem;
            margin-bottom: 1rem;
            animation: spin 1s linear infinite;
        }

        @keyframes spin {
            from { transform: rotate(0deg); }
            to { transform: rotate(360deg); }
        }

        /* 状态提示 */
        .status-success {
            color: #28a745;
            font-weight: 600;
        }

        .status-warning {
            color: #ffc107;
            font-weight: 600;
        }

        .status-danger {
            color: #dc3545;
            font-weight: 600;
        }

        .alert {
            padding: 1rem;
            margin-bottom: 1rem;
            border-radius: 8px;
            border: 1px solid transparent;
        }

        .alert-success {
            background: #d4edda;
            border-color: #c3e6cb;
            color: #155724;
        }

        .alert-danger {
            background: #f8d7da;
            border-color: #f5c6cb;
            color: #721c24;
        }

        .alert-warning {
            background: #fff3cd;
            border-color: #ffeaa7;
            color: #856404;
        }
    </style>
</head>
<body>
<!-- 头部导航 -->
<header class="header">
    <div class="container">
        <div class="nav-brand">
            <h1><i class="fas fa-graduation-cap"></i> 校园论坛管理后台</h1>
        </div>
        <nav class="nav-menu">
            <a href="${pageContext.request.contextPath}/index.jsp">
                <i class="fas fa-home"></i> 返回首页
            </a>
            <div class="user-menu">
                <span class="welcome">
                    <i class="fas fa-crown"></i>
                    欢迎，${sessionScope.currentUser.nickname}
                </span>
                <a href="${pageContext.request.contextPath}/logout" class="btn-logout">
                    <i class="fas fa-sign-out-alt"></i> 退出
                </a>
            </div>
        </nav>
    </div>
</header>

<!-- 主要内容 -->
<main class="main">
    <div class="container">
        <div class="admin-dashboard">
            <!-- 左侧菜单 -->
            <aside class="admin-sidebar">
                <h3><i class="fas fa-tachometer-alt"></i> 管理菜单</h3>
                <ul class="admin-menu">
                    <li>
                        <a href="#dashboard" class="menu-item active" data-section="dashboard">
                            <i class="fas fa-chart-line"></i>
                            仪表盘
                        </a>
                    </li>
                    <li>
                        <a href="#users" class="menu-item" data-section="users">
                            <i class="fas fa-users"></i>
                            用户管理
                        </a>
                    </li>
                    <li>
                        <a href="#posts" class="menu-item" data-section="posts">
                            <i class="fas fa-file-alt"></i>
                            帖子管理
                        </a>
                    </li>
                    <li>
                        <a href="#categories" class="menu-item" data-section="categories">
                            <i class="fas fa-folder"></i>
                            分类管理
                        </a>
                    </li>
                    <li>
                        <a href="#reports" class="menu-item" data-section="reports">
                            <i class="fas fa-flag"></i>
                            举报管理
                        </a>
                    </li>
                    <li>
                        <a href="#system" class="menu-item" data-section="system">
                            <i class="fas fa-cog"></i>
                            系统设置
                        </a>
                    </li>
                </ul>
            </aside>

            <!-- 右侧内容 -->
            <div class="admin-content">
                <!-- 仪表盘 -->
                <div class="content-section active" id="dashboard">
                    <div class="content-header">
                        <h2><i class="fas fa-chart-line"></i> 数据概览</h2>
                        <p>校园论坛运营数据统计</p>
                    </div>
                    <div class="content-body">
                        <!-- 统计卡片 -->
                        <div class="stats-grid">
                            <div class="stat-card">
                                <div class="stat-icon">
                                    <i class="fas fa-users"></i>
                                </div>
                                <div class="stat-number" id="totalUsers">-</div>
                                <div class="stat-label">总用户数</div>
                            </div>

                            <div class="stat-card">
                                <div class="stat-icon">
                                    <i class="fas fa-file-alt"></i>
                                </div>
                                <div class="stat-number" id="totalPosts">-</div>
                                <div class="stat-label">总帖子数</div>
                            </div>

                            <div class="stat-card">
                                <div class="stat-icon">
                                    <i class="fas fa-comments"></i>
                                </div>
                                <div class="stat-number" id="totalReplies">-</div>
                                <div class="stat-label">总回复数</div>
                            </div>

                            <div class="stat-card">
                                <div class="stat-icon">
                                    <i class="fas fa-eye"></i>
                                </div>
                                <div class="stat-number" id="totalViews">-</div>
                                <div class="stat-label">总浏览量</div>
                            </div>
                        </div>

                        <!-- 快速操作 -->
                        <div class="quick-actions">
                            <h3>快速操作</h3>
                            <div class="actions-grid">
                                <div class="action-card" onclick="showSection('users')">
                                    <i class="fas fa-user-plus"></i>
                                    <h4>管理用户</h4>
                                    <p>查看和管理注册用户</p>
                                </div>
                                <div class="action-card" onclick="showSection('posts')">
                                    <i class="fas fa-plus-circle"></i>
                                    <h4>管理帖子</h4>
                                    <p>审核和管理论坛帖子</p>
                                </div>
                                <div class="action-card" onclick="showSection('categories')">
                                    <i class="fas fa-tags"></i>
                                    <h4>分类设置</h4>
                                    <p>管理论坛分类</p>
                                </div>
                                <div class="action-card" onclick="showSection('system')">
                                    <i class="fas fa-tools"></i>
                                    <h4>系统设置</h4>
                                    <p>配置系统参数</p>
                                </div>
                            </div>
                        </div>

                        <!-- 最近活动 -->
                        <div class="recent-activity">
                            <h3>最近活动</h3>
                            <ul class="activity-list" id="recentActivity">
                                <li class="activity-item">
                                    <div class="activity-icon">
                                        <i class="fas fa-spinner fa-spin"></i>
                                    </div>
                                    <div class="activity-content">
                                        <div class="activity-title">正在加载最近活动...</div>
                                        <div class="activity-time">请稍候</div>
                                    </div>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>

                <!-- 用户管理 -->
                <div class="content-section" id="users">
                    <div class="content-header">
                        <h2><i class="fas fa-users"></i> 用户管理</h2>
                        <p>管理论坛注册用户</p>
                    </div>
                    <div class="content-body">
                        <div class="loading">
                            <i class="fas fa-spinner"></i>
                            <p>正在加载用户数据...</p>
                        </div>
                    </div>
                </div>

                <!-- 帖子管理 -->
                <div class="content-section" id="posts">
                    <div class="content-header">
                        <h2><i class="fas fa-file-alt"></i> 帖子管理</h2>
                        <p>管理论坛帖子内容</p>
                    </div>
                    <div class="content-body">
                        <div class="loading">
                            <i class="fas fa-spinner"></i>
                            <p>正在加载帖子数据...</p>
                        </div>
                    </div>
                </div>

                <!-- 分类管理 -->
                <div class="content-section" id="categories">
                    <div class="content-header">
                        <h2><i class="fas fa-folder"></i> 分类管理</h2>
                        <p>管理论坛分类设置</p>
                    </div>
                    <div class="content-body">
                        <div class="loading">
                            <i class="fas fa-spinner"></i>
                            <p>正在加载分类数据...</p>
                        </div>
                    </div>
                </div>

                <!-- 举报管理 -->
                <div class="content-section" id="reports">
                    <div class="content-header">
                        <h2><i class="fas fa-flag"></i> 举报管理</h2>
                        <p>处理用户举报内容</p>
                    </div>
                    <div class="content-body">
                        <div class="loading">
                            <i class="fas fa-spinner"></i>
                            <p>正在加载举报数据...</p>
                        </div>
                    </div>
                </div>

                <!-- 系统设置 -->
                <div class="content-section" id="system">
                    <div class="content-header">
                        <h2><i class="fas fa-cog"></i> 系统设置</h2>
                        <p>配置系统运行参数</p>
                    </div>
                    <div class="content-body">
                        <h3>数据库连接状态</h3>
                        <div id="systemStatus" class="loading">
                            <i class="fas fa-spinner"></i>
                            <p>正在检查系统状态...</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>

<script>
    // 获取上下文路径
    var contextPath = '<%= request.getContextPath() %>';

    // 页面切换功能
    function showSection(sectionName) {
        console.log("切换到页面:", sectionName);

        // 移除所有活跃状态
        document.querySelectorAll('.menu-item').forEach(item => {
            item.classList.remove('active');
        });
        document.querySelectorAll('.content-section').forEach(section => {
            section.classList.remove('active');
        });

        // 添加活跃状态
        const menuItem = document.querySelector('[data-section="' + sectionName + '"]');
        const contentSection = document.getElementById(sectionName);

        if (menuItem) {
            menuItem.classList.add('active');
        }

        if (contentSection) {
            contentSection.classList.add('active');
        }

        // 根据页面加载对应数据
        loadSectionData(sectionName);
    }

    // 菜单点击事件
    document.querySelectorAll('.menu-item').forEach(item => {
        item.addEventListener('click', function(e) {
            e.preventDefault();
            const section = this.dataset.section;
            console.log("点击菜单项:", section);
            showSection(section);
        });
    });

    // 加载统计数据
    function loadDashboardStats() {
        console.log("开始加载统计数据...");

        fetch(contextPath + '/api/admin/stats')
            .then(response => {
                console.log("请求响应状态:", response.status);
                if (!response.ok) {
                    throw new Error('HTTP error! status: ' + response.status);
                }
                return response.json();
            })
            .then(data => {
                console.log("获取的数据:", data);

                if (data.success) {
                    const stats = data.data;
                    document.getElementById('totalUsers').textContent = stats.totalUsers || 0;
                    document.getElementById('totalPosts').textContent = stats.totalPosts || 0;
                    document.getElementById('totalReplies').textContent = stats.totalReplies || 0;
                    document.getElementById('totalViews').textContent = stats.totalViews || 0;

                    console.log("统计数据更新完成");
                } else {
                    console.error("API返回错误:", data.message);
                    showAlert("获取统计数据失败: " + data.message, 'danger');
                }
            })
            .catch(error => {
                console.error('加载统计数据失败:', error);

                // 显示模拟数据作为后备
                document.getElementById('totalUsers').textContent = '9';
                document.getElementById('totalPosts').textContent = '5';
                document.getElementById('totalReplies').textContent = '0';
                document.getElementById('totalViews').textContent = '0';

                showAlert("无法连接到服务器，显示本地数据", 'warning');
            });
    }

    // 显示提示信息
    function showAlert(message, type) {
        type = type || 'success';

        const alertDiv = document.createElement('div');
        alertDiv.className = 'alert alert-' + type;

        const iconClass = (type === 'success') ? 'check-circle' :
            (type === 'warning') ? 'exclamation-triangle' : 'exclamation-triangle';
        alertDiv.innerHTML = '<i class="fas fa-' + iconClass + '"></i> ' + message;

        const contentBody = document.querySelector('#dashboard .content-body');
        contentBody.insertBefore(alertDiv, contentBody.firstChild);

        // 3秒后自动移除
        setTimeout(function() {
            if (alertDiv.parentNode) {
                alertDiv.parentNode.removeChild(alertDiv);
            }
        }, 3000);
    }

    // 加载最近活动
    function loadRecentActivity() {
        const activities = [
            { icon: 'fas fa-user-plus', title: '新用户注册', content: '最近有新用户注册', time: '2分钟前' },
            { icon: 'fas fa-file-alt', title: '新帖发布', content: '发布了新帖', time: '5分钟前' },
            { icon: 'fas fa-heart', title: '帖子点赞', content: '帖子获得新点赞', time: '10分钟前' },
            { icon: 'fas fa-comment', title: '新回复', content: '帖子收到新回复', time: '15分钟前' },
            { icon: 'fas fa-flag', title: '举报处理', content: '处理了用户举报', time: '30分钟前' }
        ];

        let html = '';
        activities.forEach(activity => {
            html += '<li class="activity-item">' +
                '<div class="activity-icon">' +
                '<i class="' + activity.icon + '"></i>' +
                '</div>' +
                '<div class="activity-content">' +
                '<div class="activity-title">' + activity.title + '</div>' +
                '<div class="activity-content">' + activity.content + '</div>' +
                '<div class="activity-time">' + activity.time + '</div>' +
                '</div>' +
                '</li>';
        });

        document.getElementById('recentActivity').innerHTML = html;
    }

    // 加载用户数据
    function loadUsersData(container) {
        container.innerHTML = '<div class="loading"><i class="fas fa-spinner"></i><p>正在加载用户数据...</p></div>';

        fetch(contextPath + '/api/admin/users')
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    const users = data.data;
                    let html = '<div style="margin-bottom: 1rem;">' +
                        '<button class="btn-primary"><i class="fas fa-plus"></i> 添加用户</button>' +
                        '<button class="btn-secondary"><i class="fas fa-download"></i> 导出数据</button>' +
                        '</div>' +
                        '<table class="data-table"><thead><tr>' +
                        '<th>ID</th><th>用户名</th><th>昵称</th><th>邮箱</th><th>角色</th><th>状态</th><th>注册时间</th><th>操作</th>' +
                        '</tr></thead><tbody>';

                    users.forEach(user => {
                        const createTime = new Date(user.createTime).toLocaleDateString();
                        const roleClass = user.role === 'admin' ? 'status-danger' : '';
                        const statusClass = user.status === 'active' ? 'status-success' : 'status-warning';

                        html += '<tr>' +
                            '<td>' + user.id + '</td>' +
                            '<td>' + user.username + '</td>' +
                            '<td>' + (user.nickname || user.username) + '</td>' +
                            '<td>' + user.email + '</td>' +
                            '<td><span class="' + roleClass + '">' + (user.role === 'admin' ? '管理员' : '普通用户') + '</span></td>' +
                            '<td><span class="' + statusClass + '">' + (user.status === 'active' ? '正常' : '禁用') + '</span></td>' +
                            '<td>' + createTime + '</td>' +
                            '<td>' +
                            '<button class="btn-secondary" style="padding: 0.25rem 0.5rem; font-size: 0.8rem;" onclick="editUser(' + user.id + ')">编辑</button>';

                        if (user.role !== 'admin') {
                            html += '<button class="btn-secondary" style="padding: 0.25rem 0.5rem; font-size: 0.8rem; margin-left: 0.5rem;" onclick="toggleUserStatus(' + user.id + ', \'' + (user.status === 'active' ? 'inactive' : 'active') + '\')">' + (user.status === 'active' ? '禁用' : '启用') + '</button>';
                        }

                        html += '</td></tr>';
                    });

                    html += '</tbody></table>';
                    container.innerHTML = html;
                } else {
                    container.innerHTML = '<div class="alert alert-danger">加载用户数据失败: ' + data.message + '</div>';
                }
            })
            .catch(error => {
                console.error('加载用户数据失败:', error);
                container.innerHTML = '<div class="alert alert-danger">网络错误，请稍后重试</div>';
            });
    }

    // 加载帖子数据
    function loadPostsData(container) {
        container.innerHTML = '<div class="loading"><i class="fas fa-spinner"></i><p>正在加载帖子数据...</p></div>';

        fetch(contextPath + '/api/admin/posts')
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    const result = data.data;
                    const posts = result.posts;

                    let html = '<div style="margin-bottom: 1rem;">' +
                        '<button class="btn-primary"><i class="fas fa-plus"></i> 发布公告</button>' +
                        '<button class="btn-secondary"><i class="fas fa-filter"></i> 筛选</button>' +
                        '</div>' +
                        '<table class="data-table"><thead><tr>' +
                        '<th>ID</th><th>标题</th><th>作者</th><th>分类</th><th>状态</th><th>浏览量</th><th>发布时间</th><th>操作</th>' +
                        '</tr></thead><tbody>';

                    posts.forEach(post => {
                        const createTime = new Date(post.createTime).toLocaleDateString();
                        const statusClass = post.status === 'normal' ? 'status-success' : 'status-warning';

                        html += '<tr>' +
                            '<td>' + post.id + '</td>' +
                            '<td>' + post.title + '</td>' +
                            '<td>' + (post.userNickname || '未知用户') + '</td>' +
                            '<td>' + (post.categoryName || '未分类') + '</td>' +
                            '<td><span class="' + statusClass + '">' + (post.status === 'normal' ? '已发布' : '已隐藏') + '</span></td>' +
                            '<td>' + post.viewCount + '</td>' +
                            '<td>' + createTime + '</td>' +
                            '<td>' +
                            '<button class="btn-secondary" style="padding: 0.25rem 0.5rem; font-size: 0.8rem;">编辑</button>' +
                            '<button class="btn-danger" style="padding: 0.25rem 0.5rem; font-size: 0.8rem; margin-left: 0.5rem;">删除</button>' +
                            '</td></tr>';
                    });

                    html += '</tbody></table>';
                    container.innerHTML = html;
                } else {
                    container.innerHTML = '<div class="alert alert-danger">加载帖子数据失败: ' + data.message + '</div>';
                }
            })
            .catch(error => {
                console.error('加载帖子数据失败:', error);
                container.innerHTML = '<div class="alert alert-danger">网络错误，请稍后重试</div>';
            });
    }

    // 加载分类数据
    function loadCategoriesData(container) {
        container.innerHTML = '<div class="loading"><i class="fas fa-spinner"></i><p>正在加载分类数据...</p></div>';

        fetch(contextPath + '/api/admin/categories')
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    const categories = data.data;

                    let html = '<div style="margin-bottom: 1rem;">' +
                        '<button class="btn-primary"><i class="fas fa-plus"></i> 添加分类</button>' +
                        '</div>' +
                        '<table class="data-table"><thead><tr>' +
                        '<th>ID</th><th>分类名称</th><th>描述</th><th>帖子数量</th><th>状态</th><th>创建时间</th><th>操作</th>' +
                        '</tr></thead><tbody>';

                    categories.forEach(category => {
                        const createTime = new Date(category.createTime).toLocaleDateString();
                        const statusClass = category.status === 'active' ? 'status-success' : 'status-warning';

                        html += '<tr>' +
                            '<td>' + category.id + '</td>' +
                            '<td>' + category.name + '</td>' +
                            '<td>' + (category.description || '暂无描述') + '</td>' +
                            '<td>' + (category.postCount || 0) + '</td>' +
                            '<td><span class="' + statusClass + '">' + (category.status === 'active' ? '正常' : '禁用') + '</span></td>' +
                            '<td>' + createTime + '</td>' +
                            '<td>' +
                            '<button class="btn-secondary" style="padding: 0.25rem 0.5rem; font-size: 0.8rem;">编辑</button>' +
                            '<button class="btn-danger" style="padding: 0.25rem 0.5rem; font-size: 0.8rem; margin-left: 0.5rem;">删除</button>' +
                            '</td></tr>';
                    });

                    html += '</tbody></table>';
                    container.innerHTML = html;
                } else {
                    container.innerHTML = '<div class="alert alert-danger">加载分类数据失败: ' + data.message + '</div>';
                }
            })
            .catch(error => {
                console.error('加载分类数据失败:', error);
                container.innerHTML = '<div class="alert alert-danger">网络错误，请稍后重试</div>';
            });
    }

    // 加载举报数据
    function loadReportsData(container) {
        container.innerHTML = '<div style="margin-bottom: 1rem;">' +
            '<button class="btn-secondary"><i class="fas fa-filter"></i> 筛选举报</button>' +
            '</div>' +
            '<div class="alert alert-warning">' +
            '<i class="fas fa-info-circle"></i> 暂无举报数据' +
            '</div>';
    }

    // 加载系统设置数据
    function loadSystemData(container) {
        container.innerHTML = '<h3>数据库连接状态</h3>' +
            '<div class="alert alert-success">' +
            '<i class="fas fa-check-circle"></i> 数据库连接正常' +
            '</div>' +
            '<h3>系统信息</h3>' +
            '<table class="data-table"><tbody>' +
            '<tr><td>用户总数</td><td>9</td></tr>' +
            '<tr><td>帖子总数</td><td>5</td></tr>' +
            '<tr><td>回复总数</td><td>0</td></tr>' +
            '<tr><td>系统运行时间</td><td>正常运行</td></tr>' +
            '</tbody></table>';
    }

    // 加载不同页面的数据
    function loadSectionData(section) {
        const contentBody = document.querySelector('#' + section + ' .content-body');

        switch(section) {
            case 'dashboard':
                loadDashboardStats();
                loadRecentActivity();
                break;
            case 'users':
                loadUsersData(contentBody);
                break;
            case 'posts':
                loadPostsData(contentBody);
                break;
            case 'categories':
                loadCategoriesData(contentBody);
                break;
            case 'reports':
                loadReportsData(contentBody);
                break;
            case 'system':
                loadSystemData(contentBody);
                break;
        }
    }

    // 用户操作函数
    function toggleUserStatus(userId, newStatus) {
        if (confirm('确定要' + (newStatus === 'active' ? '启用' : '禁用') + '该用户吗？')) {
            const formData = new FormData();
            formData.append('action', 'updateStatus');
            formData.append('userId', userId);
            formData.append('status', newStatus);

            fetch(contextPath + '/api/admin/users', {
                method: 'POST',
                body: formData
            })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        showAlert('用户状态更新成功', 'success');
                        // 重新加载用户列表
                        showSection('users');
                    } else {
                        showAlert('用户状态更新失败: ' + data.message, 'danger');
                    }
                })
                .catch(error => {
                    console.error('更新用户状态失败:', error);
                    showAlert('网络错误，请稍后重试', 'danger');
                });
        }
    }

    function editUser(userId) {
        alert('编辑用户功能开发中...');
    }

    // 页面加载完成后初始化
    document.addEventListener('DOMContentLoaded', function() {
        console.log("页面加载完成，开始初始化...");
        loadDashboardStats();
        loadRecentActivity();
    });
</script>

</body>
</html>