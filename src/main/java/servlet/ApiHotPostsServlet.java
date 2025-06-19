package servlet;

import bean.Post;
import dao.PostDAO;
import util.JsonResponse;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/api/hot-posts")
public class ApiHotPostsServlet extends HttpServlet {

    private PostDAO postDAO = new PostDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // 获取热门帖子列表（前5名）
            List<Post> hotPosts = postDAO.getHotPosts(5);
            JsonResponse.success(response, "获取热门帖子成功", hotPosts);

        } catch (Exception e) {
            e.printStackTrace();
            JsonResponse.error(response, "获取热门帖子失败");
        }
    }
}