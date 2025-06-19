package servlet;

import bean.Post;
import bean.User;
import dao.PostDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/user/createPost")
public class PostServlet extends HttpServlet {

    private PostDAO postDAO = new PostDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("currentUser");

        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String title = request.getParameter("title");
        String content = request.getParameter("content");
        String categoryIdStr = request.getParameter("categoryId");

        // 参数验证
        if (title == null || title.trim().isEmpty()) {
            request.setAttribute("errorMsg", "标题不能为空");
            request.getRequestDispatcher("/user/createPost.jsp").forward(request, response);
            return;
        }

        if (content == null || content.trim().isEmpty()) {
            request.setAttribute("errorMsg", "内容不能为空");
            request.getRequestDispatcher("/user/createPost.jsp").forward(request, response);
            return;
        }

        try {
            int categoryId = Integer.parseInt(categoryIdStr);

            Post post = new Post(title.trim(), content.trim(), currentUser.getId(), categoryId);
            boolean success = postDAO.createPost(post);

            if (success) {
                response.sendRedirect(request.getContextPath() + "/index.jsp");
            } else {
                request.setAttribute("errorMsg", "发布失败，请重试");
                request.getRequestDispatcher("/user/createPost.jsp").forward(request, response);
            }

        } catch (NumberFormatException e) {
            request.setAttribute("errorMsg", "请选择分类");
            request.getRequestDispatcher("/user/createPost.jsp").forward(request, response);
        }
    }
}