package servlet;

import bean.User;
import dao.UserDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.regex.Pattern;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String email = request.getParameter("email");
        String nickname = request.getParameter("nickname");

        // 参数验证
        StringBuilder errorMsg = new StringBuilder();

        if (username == null || username.trim().isEmpty()) {
            errorMsg.append("用户名不能为空<br>");
        } else if (username.length() < 3 || username.length() > 20) {
            errorMsg.append("用户名长度必须在3-20个字符之间<br>");
        } else if (!Pattern.matches("^[a-zA-Z0-9_]+$", username)) {
            errorMsg.append("用户名只能包含字母、数字和下划线<br>");
        }

        if (password == null || password.trim().isEmpty()) {
            errorMsg.append("密码不能为空<br>");
        } else if (password.length() < 6) {
            errorMsg.append("密码长度不能少于6位<br>");
        }

        if (!password.equals(confirmPassword)) {
            errorMsg.append("两次输入的密码不一致<br>");
        }

        if (email == null || email.trim().isEmpty()) {
            errorMsg.append("邮箱不能为空<br>");
        } else if (!Pattern.matches("^[\\w.-]+@[\\w.-]+\\.[a-zA-Z]{2,}$", email)) {
            errorMsg.append("邮箱格式不正确<br>");
        }

        if (nickname == null || nickname.trim().isEmpty()) {
            errorMsg.append("昵称不能为空<br>");
        } else if (nickname.length() > 50) {
            errorMsg.append("昵称长度不能超过50个字符<br>");
        }

        // 检查用户名和邮箱是否已存在
        if (errorMsg.length() == 0) {
            if (userDAO.isUsernameExists(username.trim())) {
                errorMsg.append("用户名已存在<br>");
            }
            if (userDAO.isEmailExists(email.trim())) {
                errorMsg.append("邮箱已被注册<br>");
            }
        }

        // 如果有错误，返回注册页面
        if (errorMsg.length() > 0) {
            request.setAttribute("errorMsg", errorMsg.toString());
            request.setAttribute("username", username);
            request.setAttribute("email", email);
            request.setAttribute("nickname", nickname);
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        // 创建用户对象并注册
        User user = new User(username.trim(), password, email.trim(), nickname.trim());
        boolean success = userDAO.register(user);

        if (success) {
            request.setAttribute("successMsg", "注册成功！请登录");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        } else {
            request.setAttribute("errorMsg", "注册失败，请稍后重试");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
        }
    }
}