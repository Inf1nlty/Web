package filter;

import bean.User;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter({"/user/*", "/admin/*"})
public class LoginFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        System.out.println("登录验证过滤器初始化...");
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession();

        String requestURI = httpRequest.getRequestURI();
        String contextPath = httpRequest.getContextPath();

        // 获取相对路径
        String path = requestURI.substring(contextPath.length());

        User currentUser = (User) session.getAttribute("currentUser");

        if (currentUser == null) {
            // 未登录，跳转到登录页面
            httpResponse.sendRedirect(contextPath + "/login.jsp");
            return;
        }

        // 检查管理员权限
        if (path.startsWith("/admin/") && !"admin".equals(currentUser.getRole())) {
            httpResponse.sendRedirect(contextPath + "/index.jsp");
            return;
        }

        // 继续过滤链
        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
        System.out.println("登录验证过滤器销毁...");
    }
}