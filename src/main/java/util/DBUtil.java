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

    static {
        try {
            // 加载数据库配置
            Properties props = new Properties();
            InputStream is = DBUtil.class.getClassLoader().getResourceAsStream("db.properties");
            if (is == null) {
                throw new RuntimeException("无法找到db.properties文件");
            }
            props.load(is);

            // 初始化Druid数据源
            dataSource = new DruidDataSource();
            dataSource.setDriverClassName(props.getProperty("db.driver"));
            dataSource.setUrl(props.getProperty("db.url"));
            dataSource.setUsername(props.getProperty("db.username"));
            dataSource.setPassword(props.getProperty("db.password"));

            // 连接池基本配置
            dataSource.setInitialSize(5);              // 初始连接数
            dataSource.setMinIdle(5);                  // 最小空闲连接数
            dataSource.setMaxActive(20);               // 最大连接数
            dataSource.setMaxWait(60000);              // 获取连接最大等待时间

            // 连接有效性检测
            dataSource.setTestOnBorrow(false);         // 申请连接时检测
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

            // 监控统计
            dataSource.setFilters("stat,wall,log4j");  // 启用监控和防火墙

            System.out.println("=== Druid数据源初始化成功 ===");
            System.out.println("数据库URL: " + props.getProperty("db.url"));
            System.out.println("最大连接数: " + dataSource.getMaxActive());
            System.out.println("初始化时间: " + new java.util.Date());

        } catch (Exception e) {
            System.err.println("=== Druid数据源初始化失败 ===");
            e.printStackTrace();
            throw new RuntimeException("数据库初始化失败", e);
        }
    }

    /**
     * 获取数据库连接
     */
    public static Connection getConnection() throws SQLException {
        if (dataSource == null) {
            throw new SQLException("数据源未初始化");
        }
        return dataSource.getConnection();
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
        if (dataSource == null) {
            return "数据源未初始化";
        }

        return String.format("连接池状态 - 活跃连接:%d, 空闲连接:%d, 总连接数:%d",
                dataSource.getActiveCount(),
                dataSource.getPoolingCount(),
                dataSource.getCreateCount());
    }

    /**
     * 测试数据库连接
     */
    public static boolean testConnection() {
        try (Connection conn = getConnection()) {
            return conn != null && !conn.isClosed();
        } catch (SQLException e) {
            System.err.println("数据库连接测试失败: " + e.getMessage());
            return false;
        }
    }
}