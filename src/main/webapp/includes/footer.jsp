<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!-- 页脚 -->
<footer class="footer">
    <div class="container">
        <p>&copy; 2025 校园论坛系统. All rights reserved.</p>
        <p>当前时间: <span id="currentTime"></span> | 在线用户: ${applicationScope.onlineUserCount}</p>
    </div>
</footer>

<script>
    // 实时时间显示
    function updateTime() {
        const now = new Date();
        document.getElementById('currentTime').textContent = now.toLocaleString('zh-CN');
    }
    setInterval(updateTime, 1000);
    updateTime();
</script>