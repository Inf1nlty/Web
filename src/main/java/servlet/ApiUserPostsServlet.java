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

@WebServlet("/api/user-posts")
public class ApiUserPostsServlet extends HttpServlet {

    private PostDAO postDAO = new PostDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("currentUser");

        if (currentUser == null) {
            JsonResponse.error(response, "请先登录");
            return;
        }

        try {
            // 获取当前用户的帖子列表
            List<Post> userPosts = postDAO.getUserPosts(currentUser.getId());
            JsonResponse.success(response, "获取用户帖子成功", userPosts);

        } catch (Exception e) {
            e.printStackTrace();
            JsonResponse.error(response, "获取用户帖子失败");
        }
    }
}