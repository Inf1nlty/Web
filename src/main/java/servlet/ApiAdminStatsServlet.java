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
public class ApiAdminStatsServlet extends HttpServlet {

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
            Map<String, Object> statistics = new HashMap<>();

            // 获取统计数据
            statistics.put("totalUsers", userDAO.getUserCount());
            statistics.put("totalPosts", postDAO.getPostCount());
            statistics.put("totalReplies", replyDAO.getReplyCount());
            statistics.put("totalViews", postDAO.getTotalViews());
            statistics.put("todayPosts", postDAO.getTodayPostCount());
            statistics.put("totalLikes", postDAO.getTotalLikes());

            // 添加调试日志
            System.out.println("管理员统计数据:");
            System.out.println("总用户数: " + statistics.get("totalUsers"));
            System.out.println("总帖子数: " + statistics.get("totalPosts"));
            System.out.println("总回复数: " + statistics.get("totalReplies"));
            System.out.println("总浏览量: " + statistics.get("totalViews"));

            JsonResponse.success(response, "获取统计数据成功", statistics);

        } catch (Exception e) {
            e.printStackTrace();
            JsonResponse.error(response, "获取统计数据失败: " + e.getMessage());
        }
    }
}