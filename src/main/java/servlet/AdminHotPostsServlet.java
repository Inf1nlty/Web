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

@WebServlet("/admin/hotPosts")
public class AdminHotPostsServlet extends HttpServlet {

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
            // 获取热门帖子列表（前10名）
            List<Post> hotPosts = postDAO.getTopHotPosts(10);
            JsonResponse.success(response, "获取热门帖子成功", hotPosts);

        } catch (Exception e) {
            e.printStackTrace();
            JsonResponse.error(response, "获取热门帖子失败");
        }
    }
}