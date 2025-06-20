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

@WebServlet("/user/changePassword")
public class ChangePasswordServlet extends HttpServlet {

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
            String currentPassword = request.getParameter("currentPassword");
            String newPassword = request.getParameter("newPassword");
            String confirmPassword = request.getParameter("confirmPassword");

            // 验证输入
            if (currentPassword == null || currentPassword.trim().isEmpty()) {
                request.setAttribute("errorMsg", "请输入当前密码");
                request.getRequestDispatcher("/user/profile.jsp").forward(request, response);
                return;
            }

            if (newPassword == null || newPassword.length() < 6) {
                request.setAttribute("errorMsg", "新密码至少需要6位");
                request.getRequestDispatcher("/user/profile.jsp").forward(request, response);
                return;
            }

            if (!newPassword.equals(confirmPassword)) {
                request.setAttribute("errorMsg", "两次输入的新密码不一致");
                request.getRequestDispatcher("/user/profile.jsp").forward(request, response);
                return;
            }

            // 验证当前密码
            if (!userDAO.verifyPassword(currentUser.getId(), currentPassword)) {
                request.setAttribute("errorMsg", "当前密码错误");
                request.getRequestDispatcher("/user/profile.jsp").forward(request, response);
                return;
            }

            // 更新密码
            if (userDAO.changePassword(currentUser.getId(), newPassword)) {
                request.setAttribute("successMsg", "密码修改成功");
            } else {
                request.setAttribute("errorMsg", "密码修改失败，请重试");
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMsg", "系统错误：" + e.getMessage());
        }

        request.getRequestDispatcher("/user/profile.jsp").forward(request, response);
    }
}