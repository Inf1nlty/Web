package servlet;

import bean.User;
import dao.UserDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String remember = request.getParameter("remember");

        // 参数验证
        if (username == null || username.trim().isEmpty()) {
            request.setAttribute("errorMsg", "用户名不能为空");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }

        if (password == null || password.trim().isEmpty()) {
            request.setAttribute("errorMsg", "密码不能为空");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }

        // 登录验证
        User user = userDAO.login(username.trim(), password);

        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("currentUser", user);

            // 设置会话超时时间
            if ("on".equals(remember)) {
                session.setMaxInactiveInterval(7 * 24 * 60 * 60); // 7天
            } else {
                session.setMaxInactiveInterval(30 * 60); // 30分钟
            }

            // 跳转到首页
            response.sendRedirect(request.getContextPath() + "/index.jsp");
        } else {
            request.setAttribute("errorMsg", "用户名或密码错误");
            request.setAttribute("username", username);
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }
}