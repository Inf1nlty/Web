package servlet;

import bean.User;
import dao.UserDAO;
import util.JsonResponse;
import com.google.gson.Gson;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/api/admin/users")
public class ApiAdminUsersServlet extends HttpServlet {

    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("currentUser");

        // 验证管理员权限
        if (currentUser == null || !"admin".equals(currentUser.getRole())) {
            JsonResponse.error(response, "权限不足");
            return;
        }

        try {
            List<User> users = userDAO.getAllUsers();

            // 脱敏处理：移除密码字段
            for (User user : users) {
                user.setPassword("***");
            }

            JsonResponse.success(response, "获取用户列表成功", users);

        } catch (Exception e) {
            e.printStackTrace();
            JsonResponse.error(response, "获取用户列表失败: " + e.getMessage());
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("currentUser");

        if (currentUser == null || !"admin".equals(currentUser.getRole())) {
            JsonResponse.error(response, "权限不足");
            return;
        }

        String action = request.getParameter("action");

        try {
            if ("updateStatus".equals(action)) {
                int userId = Integer.parseInt(request.getParameter("userId"));
                String status = request.getParameter("status");

                boolean success = userDAO.updateUserStatus(userId, status);
                if (success) {
                    JsonResponse.success(response, "用户状态更新成功");
                } else {
                    JsonResponse.error(response, "用户状态更新失败");
                }
            } else if ("updateRole".equals(action)) {
                int userId = Integer.parseInt(request.getParameter("userId"));
                String role = request.getParameter("role");

                boolean success = userDAO.updateUserRole(userId, role);
                if (success) {
                    JsonResponse.success(response, "用户角色更新成功");
                } else {
                    JsonResponse.error(response, "用户角色更新失败");
                }
            } else {
                JsonResponse.error(response, "未知操作");
            }

        } catch (Exception e) {
            e.printStackTrace();
            JsonResponse.error(response, "操作失败: " + e.getMessage());
        }
    }
}