package util;

import com.alibaba.druid.pool.DruidDataSource;
import javax.sql.DataSource;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;

/**
 * 数据库工具类 - 使用Druid连接池
 * @author Inf1nlty
 * @date 2025-06-19
 */
public class DBUtil {
    private static DruidDataSource dataSource;
    private static boolean initialized = false;
    private static String errorMessage = "";

    static {
        try {
            System.out.println("=== 开始初始化Druid数据源 ===");

            // 加载数据库配置
            Properties props = new Properties();
            InputStream is = DBUtil.class.getClassLoader().getResourceAsStream("db.properties");
            if (is == null) {
                throw new RuntimeException("无法找到db.properties文件，请检查文件是否存在于 src/main/resources/ 目录下");
            }

            props.load(is);
            is.close();

            // 打印配置信息（隐藏密码）
            System.out.println("数据库配置:");
            System.out.println("  驱动: " + props.getProperty("db.driver"));
            System.out.println("  URL: " + props.getProperty("db.url"));
            System.out.println("  用户名: " + props.getProperty("db.username"));
            System.out.println("  密码: " + (props.getProperty("db.password") != null ? "已配置" : "未配置"));

            // 初始化Druid数据源
            dataSource = new DruidDataSource();
            dataSource.setDriverClassName(props.getProperty("db.driver"));
            dataSource.setUrl(props.getProperty("db.url"));
            dataSource.setUsername(props.getProperty("db.username"));
            dataSource.setPassword(props.getProperty("db.password"));

            // 连接池基本配置
            dataSource.setInitialSize(3);              // 初始连接数（降低）
            dataSource.setMinIdle(2);                  // 最小空闲连接数（降低）
            dataSource.setMaxActive(10);               // 最大连接数（降低）
            dataSource.setMaxWait(10000);              // 获取连接最大等待时间（降低）

            // 连接有效性检测
            dataSource.setTestOnBorrow(true);          // 申请连接时检测（改为true）
            dataSource.setTestOnReturn(false);         // 归还连接时检测
            dataSource.setTestWhileIdle(true);         // 空闲时检测
            dataSource.setValidationQuery("SELECT 1"); // 检测查询语句

            // 连接回收配置
            dataSource.setTimeBetweenEvictionRunsMillis(60000); // 检测间隔
            dataSource.setMinEvictableIdleTimeMillis(300000);   // 连接最小空闲时间

            // 连接泄露检测
            dataSource.setRemoveAbandoned(true);       // 开启连接泄露检测
            dataSource.setRemoveAbandonedTimeout(1800); // 连接泄露超时时间
            dataSource.setLogAbandoned(true);          // 记录连接泄露日志

            // 简化过滤器配置，移除log4j
            try {
                dataSource.setFilters("stat,wall");  // 只启用监控和防火墙
            } catch (Exception e) {
                System.out.println("警告: 无法设置Druid过滤器，将使用默认配置: " + e.getMessage());
                // 不设置过滤器，让Druid使用默认配置
            }

            // 测试连接
            System.out.println("=== 测试数据库连接 ===");
            try (Connection testConn = dataSource.getConnection()) {
                if (testConn != null && !testConn.isClosed()) {
                    System.out.println("数据库连接测试成功！");
                    initialized = true;
                } else {
                    throw new SQLException("获取到的连接为null或已关闭");
                }
            }

            System.out.println("=== Druid数据源初始化成功 ===");
            System.out.println("数据库URL: " + props.getProperty("db.url"));
            System.out.println("最大连接数: " + dataSource.getMaxActive());
            System.out.println("初始化时间: " + new java.util.Date());

        } catch (Exception e) {
            System.err.println("=== Druid数据源初始化失败 ===");
            System.err.println("错误详情: " + e.getMessage());
            e.printStackTrace();

            errorMessage = "数据库初始化失败: " + e.getMessage();
            initialized = false;

            // 不抛出RuntimeException，让程序继续运行
            System.err.println("数据库初始化失败，但程序将继续运行。请检查数据库配置。");
        }
    }

    /**
     * 获取数据库连接
     */
    public static Connection getConnection() throws SQLException {
        if (!initialized) {
            throw new SQLException("数据源未正确初始化: " + errorMessage);
        }

        if (dataSource == null) {
            throw new SQLException("数据源为null");
        }

        try {
            Connection conn = dataSource.getConnection();
            if (conn == null) {
                throw new SQLException("无法获取数据库连接");
            }
            return conn;
        } catch (SQLException e) {
            System.err.println("获取数据库连接失败: " + e.getMessage());
            throw e;
        }
    }

    /**
     * 关闭数据库连接
     */
    public static void close(Connection conn, PreparedStatement pstmt) {
        close(conn, pstmt, null);
    }

    /**
     * 关闭数据库连接
     */
    public static void close(Connection conn, PreparedStatement pstmt, ResultSet rs) {
        try {
            if (rs != null) {
                rs.close();
            }
        } catch (SQLException e) {
            System.err.println("关闭ResultSet失败: " + e.getMessage());
        }

        try {
            if (pstmt != null) {
                pstmt.close();
            }
        } catch (SQLException e) {
            System.err.println("关闭PreparedStatement失败: " + e.getMessage());
        }

        try {
            if (conn != null && !conn.isClosed()) {
                conn.close();
            }
        } catch (SQLException e) {
            System.err.println("关闭Connection失败: " + e.getMessage());
        }
    }

    /**
     * 获取数据源（用于监控）
     */
    public static DataSource getDataSource() {
        return dataSource;
    }

    /**
     * 获取连接池状态信息
     */
    public static String getPoolStatus() {
        if (!initialized || dataSource == null) {
            return "数据源未正确初始化: " + errorMessage;
        }

        try {
            return String.format("连接池状态 - 活跃连接:%d, 空闲连接:%d, 创建连接总数:%d",
                    dataSource.getActiveCount(),
                    dataSource.getPoolingCount(),
                    dataSource.getCreateCount());
        } catch (Exception e) {
            return "获取连接池状态失败: " + e.getMessage();
        }
    }

    /**
     * 测试数据库连接
     */
    public static boolean testConnection() {
        try (Connection conn = getConnection()) {
            return conn != null && !conn.isClosed();
        } catch (Exception e) {
            System.err.println("数据库连接测试失败: " + e.getMessage());
            return false;
        }
    }

    /**
     * 检查初始化状态
     */
    public static boolean isInitialized() {
        return initialized;
    }

    /**
     * 获取错误信息
     */
    public static String getErrorMessage() {
        return errorMessage;
    }
}