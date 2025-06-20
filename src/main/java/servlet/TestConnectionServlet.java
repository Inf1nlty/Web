package servlet;

import util.DBUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;

@WebServlet("/test-connection")
public class TestConnectionServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        out.println("<!DOCTYPE html>");
        out.println("<html><head><title>数据库连接测试</title></head><body>");
        out.println("<h2>数据库连接测试</h2>");

        // 检查初始化状态
        out.println("<h3>1. 初始化状态检查</h3>");
        if (DBUtil.isInitialized()) {
            out.println("<p style='color: green;'>✅ DBUtil 初始化成功</p>");
        } else {
            out.println("<p style='color: red;'>❌ DBUtil 初始化失败</p>");
            out.println("<p>错误信息: " + DBUtil.getErrorMessage() + "</p>");
        }

        // 测试连接
        out.println("<h3>2. 连接测试</h3>");
        try (Connection conn = DBUtil.getConnection()) {
            if (conn != null && !conn.isClosed()) {
                out.println("<p style='color: green;'>✅ 数据库连接成功</p>");
                out.println("<p>连接信息: " + conn.toString() + "</p>");
            } else {
                out.println("<p style='color: red;'>❌ 连接为null或已关闭</p>");
            }
        } catch (Exception e) {
            out.println("<p style='color: red;'>❌ 连接失败: " + e.getMessage() + "</p>");
            e.printStackTrace();
        }

        // 连接池状态
        out.println("<h3>3. 连接池状态</h3>");
        out.println("<p>" + DBUtil.getPoolStatus() + "</p>");

        out.println("</body></html>");
    }
}