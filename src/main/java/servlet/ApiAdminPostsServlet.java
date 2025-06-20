package servlet;

import bean.Post;
import bean.User;
import dao.PostDAO;
import util.JsonResponse;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/api/admin/posts")
public class ApiAdminPostsServlet extends HttpServlet {

    private PostDAO postDAO = new PostDAO();

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
            // 获取所有帖子（分页）
            int page = 1;
            int pageSize = 20;

            String pageParam = request.getParameter("page");
            if (pageParam != null) {
                page = Integer.parseInt(pageParam);
            }

            List<Post> posts = postDAO.getAllPosts((page - 1) * pageSize, pageSize);
            int totalCount = postDAO.getPostCount();

            java.util.Map<String, Object> result = new java.util.HashMap<>();
            result.put("posts", posts);
            result.put("totalCount", totalCount);
            result.put("currentPage", page);
            result.put("pageSize", pageSize);

            JsonResponse.success(response, "获取帖子列表成功", result);

        } catch (Exception e) {
            e.printStackTrace();
            JsonResponse.error(response, "获取帖子列表失败: " + e.getMessage());
        }
    }
}