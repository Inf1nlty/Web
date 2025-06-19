<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${post.title} - 校园论坛</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .post-detail-container {
            max-width: 900px;
            margin: 2rem auto;
            background: white;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }

        .post-header {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            padding: 2rem;
        }

        .post-title {
            font-size: 1.8rem;
            margin-bottom: 1rem;
            line-height: 1.4;
        }

        .post-meta {
            display: flex;
            flex-wrap: wrap;
            gap: 1rem;
            font-size: 0.9rem;
            opacity: 0.9;
        }

        .post-meta span {
            display: flex;
            align-items: center;
            gap: 5px;
        }

        .post-content {
            padding: 2rem;
        }

        .post-text {
            line-height: 1.8;
            font-size: 1.1rem;
            color: #333;
            margin-bottom: 2rem;
        }

        .post-actions {
            display: flex;
            gap: 1rem;
            padding: 1rem 2rem;
            background-color: #f8f9fa;
            border-top: 1px solid #e9ecef;
        }

        .action-btn {
            display: flex;
            align-items: center;
            gap: 5px;
            padding: 8px 16px;
            border: none;
            border-radius: 20px;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            font-size: 0.9rem;
        }

        .like-btn {
            background-color: #e74c3c;
            color: white;
        }

        .like-btn:hover {
            background-color: #c0392b;
        }

        .share-btn {
            background-color: #3498db;
            color: white;
        }

        .share-btn:hover {
            background-color: #2980b9;
        }

        .hot-indicator {
            display: inline-block;
            padding: 4px 12px;
            border-radius: 15px;
            font-size: 0.8rem;
            font-weight: bold;
            background: linear-gradient(45deg, #ff6b6b, #ffa500);
            color: white;
        }

        .progress-container {
            margin: 1rem 2rem;
        }

        .progress-label {
            display: flex;
            justify-content: space-between;
            margin-bottom: 0.5rem;
            font-size: 0.9rem;
            color: #666;
        }

        .progress-bar {
            width: 100%;
            height: 8px;
            background-color: #e9ecef;
            border-radius: 4px;
            overflow: hidden;
        }

        .progress-fill {
            height: 100%;
            background: linear-gradient(90deg, #667eea, #764ba2);
            transition: width 0.3s ease;
        }

        .business-info {
            background-color: #f8f9fa;
            padding: 1rem 2rem;
            border-top: 1px solid #e9ecef;
        }

        .business-info h4 {
            margin-bottom: 0.5rem;
            color: #333;
        }

        .order-code {
            font-family: 'Courier New', monospace;
            background-color: #e9ecef;
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 0.9rem;
        }

        .share-modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            z-index: 1000;
        }

        .share-modal-content {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background: white;
            padding: 2rem;
            border-radius: 10px;
            width: 90%;
            max-width: 500px;
        }

        .share-options {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(120px, 1fr));
            gap: 1rem;
            margin-top: 1rem;
        }

        .share-option {
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 1rem;
            border: 2px solid #e9ecef;
            border-radius: 8px;
            text-decoration: none;
            color: #333;
            transition: all 0.3s ease;
        }

        .share-option:hover {
            border-color: #667eea;
            background-color: #f8f9fa;
        }

        .share-option i {
            font-size: 2rem;
            margin-bottom: 0.5rem;
        }
    </style>
</head>
<body>
<jsp:include page="includes/headers.jsp" />

<main class="main">
    <div class="container">
        <c:choose>
            <c:when test="${not empty post}">
                <div class="post-detail-container">
                    <!-- 帖子头部 -->
                    <div class="post-header">
                        <h1 class="post-title">${post.title}</h1>
                        <div class="post-meta">
                            <span><i class="fas fa-user"></i> ${post.userNickname}</span>
                            <span><i class="fas fa-folder"></i> ${post.categoryName}</span>
                            <span><i class="fas fa-eye"></i> ${post.viewCount} 浏览</span>
                            <span><i class="fas fa-heart"></i> ${post.likeCount} 点赞</span>
                            <span><i class="fas fa-clock"></i> <fmt:formatDate value="${post.createTime}" pattern="yyyy-MM-dd HH:mm"/></span>
                            <span class="hot-indicator">${post.hotLevel}</span>
                        </div>
                    </div>

                    <!-- 热度进度条 -->
                    <div class="progress-container">
                        <div class="progress-label">
                            <span><i class="fas fa-fire"></i> 帖子热度</span>
                            <span>${post.progressPercent}%</span>
                        </div>
                        <div class="progress-bar">
                            <div class="progress-fill" style="width: ${post.progressPercent}%"></div>
                        </div>
                    </div>

                    <!-- 帖子内容 -->
                    <div class="post-content">
                        <div class="post-text">
                                ${post.content.replaceAll("\\n", "<br>")}
                        </div>
                    </div>

                    <!-- 操作按钮 -->
                    <div class="post-actions">
                        <button class="action-btn like-btn" onclick="likePost(${post.id})">
                            <i class="fas fa-heart"></i>
                            <span id="likeCount">${post.likeCount}</span>
                        </button>
                        <button class="action-btn share-btn" onclick="showShareModal()">
                            <i class="fas fa-share"></i>
                            分享
                        </button>
                    </div>

                    <!-- 业务信息 -->
                    <div class="business-info">
                        <h4><i class="fas fa-receipt"></i> 业务信息</h4>
                        <p><strong>订单号:</strong> <span class="order-code">${post.businessOrderNo}</span></p>
                        <p><strong>分享码:</strong> <span class="order-code">${post.shareCode}</span></p>
                        <p><strong>分享链接:</strong>
                            <span class="order-code">${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}/share/${post.shareCode}</span>
                        </p>
                    </div>
                </div>
            </c:when>
            <c:otherwise>
                <div class="post-detail-container" style="text-align: center; padding: 4rem;">
                    <h2>😔 帖子不存在</h2>
                    <p>抱歉，您访问的帖子不存在或已被删除。</p>
                    <a href="${pageContext.request.contextPath}/index.jsp" class="btn btn-primary">返回首页</a>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</main>

<!-- 分享模态框 -->
<div class="share-modal" id="shareModal">
    <div class="share-modal-content">
        <h3><i class="fas fa-share"></i> 分享帖子</h3>
        <div class="share-options">
            <a href="#" class="share-option" onclick="copyShareLink()">
                <i class="fas fa-link" style="color: #667eea;"></i>
                <span>复制链接</span>
            </a>
            <a href="#" class="share-option" onclick="shareToWeChat()">
                <i class="fab fa-weixin" style="color: #1aad19;"></i>
                <span>微信分享</span>
            </a>
            <a href="#" class="share-option" onclick="shareToQQ()">
                <i class="fab fa-qq" style="color: #12b7f5;"></i>
                <span>QQ分享</span>
            </a>
            <a href="#" class="share-option" onclick="shareToWeibo()">
                <i class="fab fa-weibo" style="color: #e6162d;"></i>
                <span>微博分享</span>
            </a>
        </div>
        <div style="text-align: center; margin-top: 1rem;">
            <button class="btn btn-outline" onclick="closeShareModal()">关闭</button>
        </div>
    </div>
</div>

<jsp:include page="includes/footer.jsp" />

<script>
    // 点赞功能
    function likePost(postId) {
        fetch('${pageContext.request.contextPath}/likePost', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: 'postId=' + postId
        })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    document.getElementById('likeCount').textContent = data.data.likeCount;
                    // 更新进度条
                    updateProgressBar(data.data.progressPercent);
                } else {
                    alert(data.message);
                }
            })
            .catch(error => {
                console.error('点赞失败:', error);
                alert('点赞失败，请重试');
            });
    }

    // 更新进度条
    function updateProgressBar(percent) {
        const progressFill = document.querySelector('.progress-fill');
        const progressLabel = document.querySelector('.progress-label span:last-child');

        progressFill.style.width = percent + '%';
        progressLabel.textContent = percent + '%';
    }

    // 显示分享模态框
    function showShareModal() {
        document.getElementById('shareModal').style.display = 'block';
    }

    // 关闭分享模态框
    function closeShareModal() {
        document.getElementById('shareModal').style.display = 'none';
    }

    // 复制分享链接
    function copyShareLink() {
        const shareLink = '${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}/share/${post.shareCode}';

        if (navigator.clipboard) {
            navigator.clipboard.writeText(shareLink).then(() => {
                alert('分享链接已复制到剪贴板！');
                closeShareModal();
            });
        } else {
            // 兼容旧浏览器
            const textArea = document.createElement('textarea');
            textArea.value = shareLink;
            document.body.appendChild(textArea);
            textArea.select();
            document.execCommand('copy');
            document.body.removeChild(textArea);
            alert('分享链接已复制到剪贴板！');
            closeShareModal();
        }
    }

    // 分享到微信（实际项目中需要集成微信SDK）
    function shareToWeChat() {
        alert('微信分享功能需要集成微信SDK');
    }

    // 分享到QQ
    function shareToQQ() {
        const title = encodeURIComponent('${post.title}');
        const url = encodeURIComponent('${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}/share/${post.shareCode}');
        const summary = encodeURIComponent('来自校园论坛的精彩帖子');

        window.open(`https://connect.qq.com/widget/shareqq/index.html?url=\${url}&title=\${title}&summary=\${summary}`);
        closeShareModal();
    }

    // 分享到微博
    function shareToWeibo() {
        const title = encodeURIComponent('${post.title}');
        const url = encodeURIComponent('${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}/share/${post.shareCode}');

        window.open(`https://service.weibo.com/share/share.php?url=\${url}&title=\${title}`);
        closeShareModal();
    }

    // 点击模态框外部关闭
    document.getElementById('shareModal').addEventListener('click', function(e) {
        if (e.target === this) {
            closeShareModal();
        }
    });
</script>
</body>
</html>