package listener;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;
import java.util.concurrent.atomic.AtomicInteger;

@WebListener
public class SystemListener implements ServletContextListener, HttpSessionListener {

    private AtomicInteger onlineUserCount = new AtomicInteger(0);

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        System.out.println("=== 校园论坛系统启动 ===");
        System.out.println("系统初始化时间: " + new java.util.Date());

        // 初始化在线用户数
        sce.getServletContext().setAttribute("onlineUserCount", 0);

        System.out.println("系统初始化完成!");
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        System.out.println("=== 校园论坛系统关闭 ===");
        System.out.println("系统关闭时间: " + new java.util.Date());
    }

    @Override
    public void sessionCreated(HttpSessionEvent se) {
        int count = onlineUserCount.incrementAndGet();
        se.getSession().getServletContext().setAttribute("onlineUserCount", count);
        System.out.println("新用户会话创建，当前在线用户数: " + count);
    }

    @Override
    public void sessionDestroyed(HttpSessionEvent se) {
        int count = onlineUserCount.decrementAndGet();
        se.getSession().getServletContext().setAttribute("onlineUserCount", count);
        System.out.println("用户会话销毁，当前在线用户数: " + count);
    }
}