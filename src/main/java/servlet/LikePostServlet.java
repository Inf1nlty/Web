package servlet;

import bean.User;
import dao.LikeDAO;
import dao.PostDAO;
import util.JsonResponse;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/likePost")
public class LikePostServlet extends HttpServlet {

    private LikeDAO likeDAO = new LikeDAO();
    private PostDAO postDAO = new PostDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("currentUser");

        if (currentUser == null) {
            JsonResponse.error(response, "请先登录");
            return;
        }

        String postIdStr = request.getParameter("postId");

        if (postIdStr == null || postIdStr.trim().isEmpty()) {
            JsonResponse.error(response, "参数错误");
            return;
        }

        try {
            int postId = Integer.parseInt(postIdStr);

            // 检查是否已点赞
            boolean hasLiked = likeDAO.hasUserLikedPost(currentUser.getId(), postId);

            if (hasLiked) {
                // 取消点赞
                likeDAO.unlikePost(currentUser.getId(), postId);
            } else {
                // 点赞
                likeDAO.likePost(currentUser.getId(), postId);
            }

            // 获取最新点赞数
            int likeCount = likeDAO.getPostLikeCount(postId);

            // 获取帖子并计算新的进度
            bean.Post post = postDAO.getPostById(postId);

            Map<String, Object> result = new HashMap<>();
            result.put("likeCount", likeCount);
            result.put("hasLiked", !hasLiked);
            result.put("progressPercent", post != null ? post.getProgressPercent() : 0);

            JsonResponse.success(response, hasLiked ? "取消点赞成功" : "点赞成功", result);

        } catch (NumberFormatException e) {
            JsonResponse.error(response, "参数错误");
        }
    }
}