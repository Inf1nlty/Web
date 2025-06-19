package servlet;

import bean.Post;
import dao.PostDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/post-detail")
public class PostDetailServlet extends HttpServlet {

    private PostDAO postDAO = new PostDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idStr = request.getParameter("id");

        if (idStr == null || idStr.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/index.jsp");
            return;
        }

        try {
            int postId = Integer.parseInt(idStr);

            // 获取帖子详情
            Post post = postDAO.getPostById(postId);

            if (post != null) {
                // 增加浏览量
                postDAO.increaseViewCount(postId);
                post.setViewCount(post.getViewCount() + 1);

                request.setAttribute("post", post);
                request.getRequestDispatcher("/post-detail.jsp").forward(request, response);
            } else {
                request.getRequestDispatcher("/post-detail.jsp").forward(request, response);
            }

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/index.jsp");
        }
    }
}