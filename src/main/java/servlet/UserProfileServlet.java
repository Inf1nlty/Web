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

@WebServlet("/user/updateProfile")
public class UserProfileServlet extends HttpServlet {

    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("currentUser");

        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        try {
            String nickname = request.getParameter("nickname");
            String email = request.getParameter("email");

            // 验证输入
            if (nickname == null || nickname.trim().isEmpty()) {
                request.setAttribute("errorMsg", "昵称不能为空");
                request.getRequestDispatcher("/user/profile.jsp").forward(request, response);
                return;
            }

            if (email == null || email.trim().isEmpty()) {
                request.setAttribute("errorMsg", "邮箱不能为空");
                request.getRequestDispatcher("/user/profile.jsp").forward(request, response);
                return;
            }

            // 检查邮箱是否被其他用户使用
            if (!email.equals(currentUser.getEmail()) && userDAO.isEmailExists(email)) {
                request.setAttribute("errorMsg", "该邮箱已被其他用户使用");
                request.getRequestDispatcher("/user/profile.jsp").forward(request, response);
                return;
            }

            // 更新用户信息
            currentUser.setNickname(nickname.trim());
            currentUser.setEmail(email.trim());

            if (userDAO.updateUser(currentUser)) {
                session.setAttribute("currentUser", currentUser);
                request.setAttribute("successMsg", "个人资料更新成功");
            } else {
                request.setAttribute("errorMsg", "更新失败，请重试");
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMsg", "系统错误：" + e.getMessage());
        }

        request.getRequestDispatcher("/user/profile.jsp").forward(request, response);
    }
}