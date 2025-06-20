package servlet;

import bean.User;
import dao.CategoryDAO;
import util.JsonResponse;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/api/admin/categories")
public class ApiAdminCategoriesServlet extends HttpServlet {

    private CategoryDAO categoryDAO = new CategoryDAO();

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
            java.util.List<bean.Category> categories = categoryDAO.getAllCategories();
            JsonResponse.success(response, "获取分类列表成功", categories);

        } catch (Exception e) {
            e.printStackTrace();
            JsonResponse.error(response, "获取分类列表失败: " + e.getMessage());
        }
    }
}