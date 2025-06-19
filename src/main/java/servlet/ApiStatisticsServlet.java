package servlet;

import dao.PostDAO;
import dao.UserDAO;
import util.JsonResponse;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/api/statistics")
public class ApiStatisticsServlet extends HttpServlet {

    private UserDAO userDAO = new UserDAO();
    private PostDAO postDAO = new PostDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            Map<String, Object> statistics = new HashMap<>();

            // 获取统计数据
            statistics.put("totalUsers", userDAO.getUserCount());
            statistics.put("totalPosts", postDAO.getPostCount());
            statistics.put("todayPosts", postDAO.getTodayPostCount());
            statistics.put("totalViews", postDAO.getTotalViews());
            statistics.put("totalLikes", postDAO.getTotalLikes());

            JsonResponse.success(response, "获取统计数据成功", statistics);

        } catch (Exception e) {
            e.printStackTrace();
            JsonResponse.error(response, "获取统计数据失败");
        }
    }
}