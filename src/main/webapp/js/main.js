/**
 * 校园论坛主要JavaScript文件
 */

// 全局变量
let isLoading = false;

// DOM加载完成后执行
document.addEventListener('DOMContentLoaded', function() {
    console.log('校园论坛系统加载完成');

    // 初始化各种功能
    initializeNavigation();
    initializeAlerts();
    initializeModals();
    initializeFormValidation();
    initializeTimeUpdates();
});

/**
 * 初始化导航功能
 */
function initializeNavigation() {
    // 高亮当前页面导航
    const currentPath = window.location.pathname;
    const navLinks = document.querySelectorAll('.nav-menu a');

    navLinks.forEach(link => {
        if (link.getAttribute('href') === currentPath) {
            link.classList.add('active');
        } else {
            link.classList.remove('active');
        }
    });

    // 移动端菜单切换
    const mobileMenuBtn = document.getElementById('mobileMenuBtn');
    const navMenu = document.querySelector('.nav-menu');

    if (mobileMenuBtn && navMenu) {
        mobileMenuBtn.addEventListener('click', function() {
            navMenu.classList.toggle('mobile-active');
        });
    }
}

/**
 * 初始化警告提示
 */
function initializeAlerts() {
    // 自动隐藏警告信息
    const alerts = document.querySelectorAll('.alert');
    alerts.forEach(alert => {
        // 5秒后自动隐藏
        setTimeout(() => {
            fadeOut(alert);
        }, 5000);

        // 添加关闭按钮
        const closeBtn = document.createElement('button');
        closeBtn.innerHTML = '&times;';
        closeBtn.className = 'alert-close';
        closeBtn.style.cssText = `
            position: absolute;
            right: 10px;
            top: 50%;
            transform: translateY(-50%);
            background: none;
            border: none;
            font-size: 1.5rem;
            cursor: pointer;
            color: inherit;
            opacity: 0.7;
        `;

        closeBtn.addEventListener('click', () => {
            fadeOut(alert);
        });

        alert.style.position = 'relative';
        alert.appendChild(closeBtn);
    });
}

/**
 * 淡出效果
 */
function fadeOut(element) {
    element.style.transition = 'opacity 0.5s ease';
    element.style.opacity = '0';
    setTimeout(() => {
        element.remove();
    }, 500);
}

/**
 * 初始化模态框
 */
function initializeModals() {
    // 通用模态框关闭功能
    document.addEventListener('click', function(e) {
        if (e.target.classList.contains('modal') || e.target.classList.contains('modal-close')) {
            const modal = e.target.closest('.modal') || e.target;
            closeModal(modal);
        }
    });

    // ESC键关闭模态框
    document.addEventListener('keydown', function(e) {
        if (e.key === 'Escape') {
            const openModals = document.querySelectorAll('.modal[style*="block"]');
            openModals.forEach(modal => closeModal(modal));
        }
    });
}

/**
 * 关闭模态框
 */
function closeModal(modal) {
    if (modal) {
        modal.style.display = 'none';
    }
}

/**
 * 打开模态框
 */
function openModal(modalId) {
    const modal = document.getElementById(modalId);
    if (modal) {
        modal.style.display = 'block';
    }
}

/**
 * 初始化表单验证
 */
function initializeFormValidation() {
    const forms = document.querySelectorAll('form[data-validate="true"]');

    forms.forEach(form => {
        form.addEventListener('submit', function(e) {
            if (!validateForm(form)) {
                e.preventDefault();
            }
        });

        // 实时验证
        const inputs = form.querySelectorAll('input, textarea, select');
        inputs.forEach(input => {
            input.addEventListener('blur', () => validateField(input));
            input.addEventListener('input', () => clearFieldError(input));
        });
    });
}

/**
 * 验证表单
 */
function validateForm(form) {
    let isValid = true;
    const inputs = form.querySelectorAll('input[required], textarea[required], select[required]');

    inputs.forEach(input => {
        if (!validateField(input)) {
            isValid = false;
        }
    });

    return isValid;
}

/**
 * 验证单个字段
 */
function validateField(field) {
    const value = field.value.trim();
    const type = field.type;
    const required = field.hasAttribute('required');
    let isValid = true;
    let message = '';

    // 必填验证
    if (required && !value) {
        isValid = false;
        message = '此字段不能为空';
    }

    // 类型验证
    if (value && type === 'email') {
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (!emailRegex.test(value)) {
            isValid = false;
            message = '请输入有效的邮箱地址';
        }
    }

    // 长度验证
    if (value) {
        const minLength = field.getAttribute('minlength');
        const maxLength = field.getAttribute('maxlength');

        if (minLength && value.length < parseInt(minLength)) {
            isValid = false;
            message = `至少需要${minLength}个字符`;
        }

        if (maxLength && value.length > parseInt(maxLength)) {
            isValid = false;
            message = `不能超过${maxLength}个字符`;
        }
    }

    // 显示错误信息
    if (!isValid) {
        showFieldError(field, message);
    } else {
        clearFieldError(field);
    }

    return isValid;
}

/**
 * 显示字段错误
 */
function showFieldError(field, message) {
    clearFieldError(field);

    field.style.borderColor = '#e74c3c';

    const errorDiv = document.createElement('div');
    errorDiv.className = 'field-error';
    errorDiv.textContent = message;
    errorDiv.style.cssText = `
        color: #e74c3c;
        font-size: 0.8rem;
        margin-top: 0.25rem;
    `;

    field.parentNode.appendChild(errorDiv);
}

/**
 * 清除字段错误
 */
function clearFieldError(field) {
    field.style.borderColor = '';

    const existingError = field.parentNode.querySelector('.field-error');
    if (existingError) {
        existingError.remove();
    }
}

/**
 * 初始化时间更新
 */
function initializeTimeUpdates() {
    // 更新所有相对时间
    updateRelativeTimes();

    // 每分钟更新一次
    setInterval(updateRelativeTimes, 60000);
}

/**
 * 更新相对时间显示
 */
function updateRelativeTimes() {
    const timeElements = document.querySelectorAll('[data-time]');

    timeElements.forEach(element => {
        const timestamp = parseInt(element.getAttribute('data-time'));
        element.textContent = formatRelativeTime(timestamp);
    });
}

/**
 * 格式化相对时间
 */
function formatRelativeTime(timestamp) {
    const now = Date.now();
    const diff = now - timestamp;

    if (diff < 60000) return '刚刚';
    if (diff < 3600000) return Math.floor(diff / 60000) + '分钟前';
    if (diff < 86400000) return Math.floor(diff / 3600000) + '小时前';
    if (diff < 2592000000) return Math.floor(diff / 86400000) + '天前';

    return new Date(timestamp).toLocaleDateString('zh-CN');
}

/**
 * 发送AJAX请求
 */
function sendRequest(url, options = {}) {
    if (isLoading) {
        console.warn('请求正在进行中，请稍后重试');
        return Promise.reject(new Error('请求正在进行中'));
    }

    isLoading = true;

    const defaultOptions = {
        method: 'GET',
        headers: {
            'Content-Type': 'application/json',
        },
    };

    const finalOptions = { ...defaultOptions, ...options };

    return fetch(url, finalOptions)
        .then(response => {
            if (!response.ok) {
                throw new Error(`HTTP error! status: ${response.status}`);
            }
            return response.json();
        })
        .finally(() => {
            isLoading = false;
        });
}

/**
 * 显示加载状态
 */
function showLoading(element, text = '加载中...') {
    if (element) {
        element.innerHTML = `<div class="loading"><i class="fas fa-spinner fa-spin"></i> ${text}</div>`;
    }
}

/**
 * 显示错误信息
 */
function showError(element, message = '加载失败') {
    if (element) {
        element.innerHTML = `<div class="error"><i class="fas fa-exclamation-circle"></i> ${message}</div>`;
    }
}

/**
 * 显示成功信息
 */
function showSuccess(message) {
    const alert = document.createElement('div');
    alert.className = 'alert alert-success';
    alert.style.cssText = `
        position: fixed;
        top: 20px;
        right: 20px;
        z-index: 9999;
        min-width: 300px;
        animation: slideInRight 0.5s ease;
    `;
    alert.innerHTML = `
        <i class="fas fa-check-circle"></i>
        ${message}
    `;

    document.body.appendChild(alert);

    // 3秒后自动移除
    setTimeout(() => {
        fadeOut(alert);
    }, 3000);
}

/**
 * 显示错误信息
 */
function showErrorMessage(message) {
    const alert = document.createElement('div');
    alert.className = 'alert alert-error';
    alert.style.cssText = `
        position: fixed;
        top: 20px;
        right: 20px;
        z-index: 9999;
        min-width: 300px;
        animation: slideInRight 0.5s ease;
    `;
    alert.innerHTML = `
        <i class="fas fa-exclamation-circle"></i>
        ${message}
    `;

    document.body.appendChild(alert);

    // 5秒后自动移除
    setTimeout(() => {
        fadeOut(alert);
    }, 5000);
}

/**
 * 复制文本到剪贴板
 */
function copyToClipboard(text) {
    if (navigator.clipboard) {
        return navigator.clipboard.writeText(text).then(() => {
            showSuccess('复制成功！');
        }).catch(() => {
            fallbackCopy(text);
        });
    } else {
        fallbackCopy(text);
    }
}

/**
 * 兼容旧浏览器的复制方法
 */
function fallbackCopy(text) {
    const textArea = document.createElement('textarea');
    textArea.value = text;
    textArea.style.position = 'fixed';
    textArea.style.left = '-999999px';
    textArea.style.top = '-999999px';

    document.body.appendChild(textArea);
    textArea.focus();
    textArea.select();

    try {
        document.execCommand('copy');
        showSuccess('复制成功！');
    } catch (err) {
        showErrorMessage('复制失败，请手动复制');
    }

    document.body.removeChild(textArea);
}

/**
 * 防抖函数
 */
function debounce(func, wait) {
    let timeout;
    return function executedFunction(...args) {
        const later = () => {
            clearTimeout(timeout);
            func(...args);
        };
        clearTimeout(timeout);
        timeout = setTimeout(later, wait);
    };
}

/**
 * 节流函数
 */
function throttle(func, limit) {
    let inThrottle;
    return function() {
        const args = arguments;
        const context = this;
        if (!inThrottle) {
            func.apply(context, args);
            inThrottle = true;
            setTimeout(() => inThrottle = false, limit);
        }
    };
}

/**
 * 格式化数字（添加千分位分隔符）
 */
function formatNumber(num) {
    return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
}

/**
 * 截断文本
 */
function truncateText(text, maxLength) {
    if (text.length <= maxLength) {
        return text;
    }
    return text.slice(0, maxLength) + '...';
}

// 添加CSS动画
const style = document.createElement('style');
style.textContent = `
    @keyframes slideInRight {
        from {
            opacity: 0;
            transform: translateX(100%);
        }
        to {
            opacity: 1;
            transform: translateX(0);
        }
    }
    
    @keyframes slideInLeft {
        from {
            opacity: 0;
            transform: translateX(-100%);
        }
        to {
            opacity: 1;
            transform: translateX(0);
        }
    }
    
    @keyframes fadeIn {
        from {
            opacity: 0;
        }
        to {
            opacity: 1;
        }
    }
    
    .alert-close:hover {
        opacity: 1 !important;
    }
    
    .loading {
        text-align: center;
        padding: 2rem;
        color: #666;
    }
    
    .error {
        text-align: center;
        padding: 2rem;
        color: #e74c3c;
    }
    
    .field-error {
        animation: fadeIn 0.3s ease;
    }
`;

document.head.appendChild(style);

// 导出常用函数供全局使用
window.ForumUtils = {
    sendRequest,
    showLoading,
    showError,
    showSuccess,
    showErrorMessage,
    copyToClipboard,
    formatRelativeTime,
    formatNumber,
    truncateText,
    debounce,
    throttle,
    openModal,
    closeModal
};

console.log('校园论坛工具库加载完成');