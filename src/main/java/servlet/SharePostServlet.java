package servlet;

import bean.Post;
import dao.PostDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/share/*")
public class SharePostServlet extends HttpServlet {

    private PostDAO postDAO = new PostDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String pathInfo = request.getPathInfo();

        if (pathInfo == null || pathInfo.length() <= 1) {
            response.sendRedirect(request.getContextPath() + "/index.jsp");
            return;
        }

        String shareCode = pathInfo.substring(1); // 去掉开头的 "/"

        // 根据分享码获取帖子
        Post post = postDAO.getPostByShareCode(shareCode);

        if (post != null) {
            // 增加浏览量
            postDAO.increaseViewCount(post.getId());
            post.setViewCount(post.getViewCount() + 1);

            request.setAttribute("post", post);
            request.setAttribute("isSharedPost", true);
            request.getRequestDispatcher("/post-detail.jsp").forward(request, response);
        } else {
            request.setAttribute("errorMsg", "分享链接无效或帖子不存在");
            request.getRequestDispatcher("/post-detail.jsp").forward(request, response);
        }
    }
}