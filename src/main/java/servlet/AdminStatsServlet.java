package servlet;

import bean.User;
import dao.PostDAO;
import dao.UserDAO;
import dao.ReplyDAO;
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

@WebServlet("/api/admin/stats")
public class AdminStatsServlet extends HttpServlet {

    private UserDAO userDAO = new UserDAO();
    private PostDAO postDAO = new PostDAO();
    private ReplyDAO replyDAO = new ReplyDAO();

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
            // 获取统计数据
            int totalUsers = userDAO.getTotalUserCount();
            int totalPosts = postDAO.getTotalPostCount();
            int totalReplies = replyDAO.getTotalReplyCount();
            int totalViews = postDAO.getTotalViewCount();

            Map<String, Object> stats = new HashMap<>();
            stats.put("totalUsers", totalUsers);
            stats.put("totalPosts", totalPosts);
            stats.put("totalReplies", totalReplies);
            stats.put("totalViews", totalViews);

            JsonResponse.success(response, "获取统计数据成功", stats);

        } catch (Exception e) {
            e.printStackTrace();
            JsonResponse.error(response, "获取统计数据失败：" + e.getMessage());
        }
    }
}