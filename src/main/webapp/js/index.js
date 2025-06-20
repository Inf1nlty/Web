// 页面加载完成后执行
document.addEventListener('DOMContentLoaded', function() {
    initAnimations();
    loadHotPosts();
    loadStatistics();
    startCounterAnimation();
});

// 初始化动画
function initAnimations() {
    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.classList.add('animate__animated', 'animate__fadeInUp');
            }
        });
    });

    document.querySelectorAll('.stat-card, .feature-card').forEach(el => {
        observer.observe(el);
    });
}

// 数字滚动动画
function startCounterAnimation() {
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
}

// 加载热门帖子
function loadHotPosts() {
    // 暂时显示一个友好的消息，而不是网络错误
    showEmptyPosts();

    // 如果 API 存在，可以取消注释下面的代码
    /*
    fetch(window.contextPath + '/api/hot-posts')
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
            showEmptyPosts();
        });
    */
}

// 显示空状态
function showEmptyPosts() {
    const container = document.getElementById('hotPostsList');
    if (!container) return;

    const emptyState = document.createElement('div');
    emptyState.className = 'empty-state';
    emptyState.style.textAlign = 'center';
    emptyState.style.padding = '2rem';

    const createPostUrl = window.isLoggedIn ?
        window.contextPath + '/user/createPost' :
        window.contextPath + '/login.jsp';
    const buttonText = window.isLoggedIn ? '发布帖子' : '登录后发布';

    emptyState.innerHTML =
        '<i class="fas fa-comments" style="font-size: 3rem; color: #667eea; margin-bottom: 1rem;"></i>' +
        '<h3 style="margin-bottom: 1rem; color: #333;">还没有热门帖子</h3>' +
        '<p style="margin-bottom: 1rem; color: #666;">快来发布第一个帖子吧！</p>' +
        '<a href="' + createPostUrl + '" class="btn-primary">' + buttonText + '</a>';

    container.innerHTML = '';
    container.appendChild(emptyState);
}

// 加载统计数据
function loadStatistics() {
    // 暂时设置一些默认值
    const todayPostsEl = document.getElementById('todayPosts');
    const totalViewsEl = document.getElementById('totalViews');

    if (todayPostsEl) {
        todayPostsEl.setAttribute('data-target', '0');
    }
    if (totalViewsEl) {
        totalViewsEl.setAttribute('data-target', '0');
    }

    // 如果 API 存在，可以取消注释下面的代码
    /*
    fetch(window.contextPath + '/api/statistics')
        .then(response => response.json())
        .then(data => {
            if (data.success) {
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
    */
}