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
public class CreatePostServlet extends HttpServlet {

    private PostDAO postDAO = new PostDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/user/createPost.jsp").forward(request, response);
    }

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
        StringBuilder errorMsg = new StringBuilder();

        if (title == null || title.trim().isEmpty()) {
            errorMsg.append("标题不能为空<br>");
        } else if (title.trim().length() < 2 || title.trim().length() > 200) {
            errorMsg.append("标题长度必须在2-200字符之间<br>");
        }

        if (content == null || content.trim().isEmpty()) {
            errorMsg.append("内容不能为空<br>");
        } else if (content.trim().length() < 10) {
            errorMsg.append("内容至少需要10个字符<br>");
        }

        if (categoryIdStr == null || categoryIdStr.trim().isEmpty()) {
            errorMsg.append("请选择分类<br>");
        }

        if (errorMsg.length() > 0) {
            request.setAttribute("errorMsg", errorMsg.toString());
            request.getRequestDispatcher("/user/createPost.jsp").forward(request, response);
            return;
        }

        try {
            int categoryId = Integer.parseInt(categoryIdStr);

            // 创建帖子对象
            Post post = new Post(title.trim(), content.trim(), currentUser.getId(), categoryId);

            // 保存到数据库
            boolean success = postDAO.createPost(post);

            if (success) {
                // 发布成功，跳转到首页
                session.setAttribute("successMsg", "🎉 帖子发布成功！");
                response.sendRedirect(request.getContextPath() + "/index.jsp");
            } else {
                request.setAttribute("errorMsg", "发布失败，请稍后重试");
                request.getRequestDispatcher("/user/createPost.jsp").forward(request, response);
            }

        } catch (NumberFormatException e) {
            request.setAttribute("errorMsg", "分类选择无效");
            request.getRequestDispatcher("/user/createPost.jsp").forward(request, response);
        }
    }
}