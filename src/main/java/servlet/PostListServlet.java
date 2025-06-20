package servlet;

import bean.Post;
import dao.PostDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/posts")
public class PostListServlet extends HttpServlet {

    private PostDAO postDAO = new PostDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // 获取分页参数
            int page = 1;
            int pageSize = 10;

            String pageStr = request.getParameter("page");
            if (pageStr != null && !pageStr.trim().isEmpty()) {
                try {
                    page = Integer.parseInt(pageStr);
                    if (page < 1) page = 1;
                } catch (NumberFormatException e) {
                    page = 1;
                }
            }

            // 获取搜索关键词
            String keyword = request.getParameter("keyword");
            String category = request.getParameter("category");

            // 获取帖子列表
            List<Post> posts;
            int totalPosts;

            if (keyword != null && !keyword.trim().isEmpty()) {
                // 搜索帖子
                posts = postDAO.searchPosts(keyword.trim(), (page - 1) * pageSize, pageSize);
                totalPosts = postDAO.getSearchPostCount(keyword.trim());
            } else if (category != null && !category.trim().isEmpty()) {
                // 按分类筛选
                try {
                    int categoryId = Integer.parseInt(category);
                    posts = postDAO.getPostsByCategory(categoryId, (page - 1) * pageSize, pageSize);
                    totalPosts = postDAO.getPostCountByCategory(categoryId);
                } catch (NumberFormatException e) {
                    posts = postDAO.getAllPosts((page - 1) * pageSize, pageSize);
                    totalPosts = postDAO.getTotalPostCount();
                }
            } else {
                // 获取所有帖子
                posts = postDAO.getAllPosts((page - 1) * pageSize, pageSize);
                totalPosts = postDAO.getTotalPostCount();
            }

            // 计算分页信息
            int totalPages = (int) Math.ceil((double) totalPosts / pageSize);

            // 设置请求属性
            request.setAttribute("posts", posts);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("totalPosts", totalPosts);
            request.setAttribute("keyword", keyword);
            request.setAttribute("category", category);

            // 转发到JSP页面
            request.getRequestDispatcher("/posts.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "获取帖子列表失败");
        }
    }
}