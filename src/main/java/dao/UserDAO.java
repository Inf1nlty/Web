package dao;

import bean.User;
import util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * 用户数据访问对象
 * @author Inf1nlty
 * @date 2025-06-20
 */
public class UserDAO {

    /**
     * 用户注册（需要加密密码）
     */
    public boolean register(User user) {
        String sql = "INSERT INTO users (username, password, email, nickname, role, status, create_time) VALUES (?, ?, ?, ?, 'user', 'active', CURRENT_TIMESTAMP)";
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, user.getUsername());

            // 密码加密存储（暂时不加密，便于测试）
            pstmt.setString(2, user.getPassword());

            pstmt.setString(3, user.getEmail());
            pstmt.setString(4, user.getNickname());

            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("用户注册失败: " + e.getMessage());
            e.printStackTrace();
            return false;
        } finally {
            DBUtil.close(conn, pstmt);
        }
    }

    /**
     * 用户登录验证
     */
    public User login(String username, String password) {
        String sql = "SELECT * FROM users WHERE username = ? AND password = ? AND status = 'active'";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, username);
            pstmt.setString(2, password);

            rs = pstmt.executeQuery();
            if (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setUsername(rs.getString("username"));
                user.setPassword(rs.getString("password"));
                user.setEmail(rs.getString("email"));
                user.setNickname(rs.getString("nickname"));
                user.setAvatar(rs.getString("avatar"));
                user.setRole(rs.getString("role"));
                user.setStatus(rs.getString("status"));
                user.setCreateTime(rs.getTimestamp("create_time"));
                user.setLastLogin(rs.getTimestamp("last_login"));

                // 更新最后登录时间
                updateLastLogin(user.getId());
                return user;
            }
        } catch (SQLException e) {
            System.err.println("用户登录失败: " + e.getMessage());
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, pstmt, rs);
        }
        return null;
    }

    /**
     * 检查用户名是否存在
     */
    public boolean isUsernameExists(String username) {
        String sql = "SELECT id FROM users WHERE username = ?";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, username);
            rs = pstmt.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            System.err.println("检查用户名失败: " + e.getMessage());
            e.printStackTrace();
            return false;
        } finally {
            DBUtil.close(conn, pstmt, rs);
        }
    }

    /**
     * 检查邮箱是否存在
     */
    public boolean isEmailExists(String email) {
        String sql = "SELECT id FROM users WHERE email = ?";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, email);
            rs = pstmt.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            System.err.println("检查邮箱失败: " + e.getMessage());
            e.printStackTrace();
            return false;
        } finally {
            DBUtil.close(conn, pstmt, rs);
        }
    }

    /**
     * 更新最后登录时间
     */
    private void updateLastLogin(int userId) {
        String sql = "UPDATE users SET last_login = CURRENT_TIMESTAMP WHERE id = ?";
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, userId);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            System.err.println("更新最后登录时间失败: " + e.getMessage());
        } finally {
            DBUtil.close(conn, pstmt);
        }
    }

    /**
     * 根据ID获取用户信息
     */
    public User getUserById(int id) {
        String sql = "SELECT * FROM users WHERE id = ?";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setUsername(rs.getString("username"));
                user.setPassword(rs.getString("password"));
                user.setEmail(rs.getString("email"));
                user.setNickname(rs.getString("nickname"));
                user.setAvatar(rs.getString("avatar"));
                user.setRole(rs.getString("role"));
                user.setStatus(rs.getString("status"));
                user.setCreateTime(rs.getTimestamp("create_time"));
                user.setLastLogin(rs.getTimestamp("last_login"));
                return user;
            }
        } catch (SQLException e) {
            System.err.println("根据ID获取用户失败: " + e.getMessage());
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, pstmt, rs);
        }
        return null;
    }

    /**
     * 根据用户名获取用户信息
     */
    public User getUserByUsername(String username) {
        String sql = "SELECT * FROM users WHERE username = ?";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, username);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setUsername(rs.getString("username"));
                user.setPassword(rs.getString("password"));
                user.setEmail(rs.getString("email"));
                user.setNickname(rs.getString("nickname"));
                user.setAvatar(rs.getString("avatar"));
                user.setRole(rs.getString("role"));
                user.setStatus(rs.getString("status"));
                user.setCreateTime(rs.getTimestamp("create_time"));
                user.setLastLogin(rs.getTimestamp("last_login"));
                return user;
            }
        } catch (SQLException e) {
            System.err.println("根据用户名获取用户失败: " + e.getMessage());
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, pstmt, rs);
        }
        return null;
    }

    /**
     * 更新用户信息
     */
    public boolean updateUser(User user) {
        String sql = "UPDATE users SET nickname = ?, email = ?, avatar = ? WHERE id = ?";
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, user.getNickname());
            pstmt.setString(2, user.getEmail());
            pstmt.setString(3, user.getAvatar());
            pstmt.setInt(4, user.getId());

            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("更新用户信息失败: " + e.getMessage());
            e.printStackTrace();
            return false;
        } finally {
            DBUtil.close(conn, pstmt);
        }
    }

    /**
     * 修改密码
     */
    public boolean changePassword(int userId, String newPassword) {
        String sql = "UPDATE users SET password = ? WHERE id = ?";
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, newPassword);
            pstmt.setInt(2, userId);

            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("修改密码失败: " + e.getMessage());
            e.printStackTrace();
            return false;
        } finally {
            DBUtil.close(conn, pstmt);
        }
    }

    /**
     * 验证旧密码
     */
    public boolean verifyPassword(int userId, String password) {
        String sql = "SELECT id FROM users WHERE id = ? AND password = ?";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, userId);
            pstmt.setString(2, password);
            rs = pstmt.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            System.err.println("验证密码失败: " + e.getMessage());
            e.printStackTrace();
            return false;
        } finally {
            DBUtil.close(conn, pstmt, rs);
        }
    }

    /**
     * 获取所有用户列表（管理员功能）
     */
    public List<User> getAllUsers() {
        String sql = "SELECT * FROM users ORDER BY create_time DESC";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        List<User> users = new ArrayList<>();

        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setUsername(rs.getString("username"));
                user.setPassword(rs.getString("password"));
                user.setEmail(rs.getString("email"));
                user.setNickname(rs.getString("nickname"));
                user.setAvatar(rs.getString("avatar"));
                user.setRole(rs.getString("role"));
                user.setStatus(rs.getString("status"));
                user.setCreateTime(rs.getTimestamp("create_time"));
                user.setLastLogin(rs.getTimestamp("last_login"));
                users.add(user);
            }
        } catch (SQLException e) {
            System.err.println("获取所有用户失败: " + e.getMessage());
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, pstmt, rs);
        }
        return users;
    }

    /**
     * 分页获取用户列表
     */
    public List<User> getUsersByPage(int page, int pageSize) {
        String sql = "SELECT * FROM users ORDER BY create_time DESC LIMIT ?, ?";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        List<User> users = new ArrayList<>();

        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, (page - 1) * pageSize);
            pstmt.setInt(2, pageSize);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setUsername(rs.getString("username"));
                user.setPassword(rs.getString("password"));
                user.setEmail(rs.getString("email"));
                user.setNickname(rs.getString("nickname"));
                user.setAvatar(rs.getString("avatar"));
                user.setRole(rs.getString("role"));
                user.setStatus(rs.getString("status"));
                user.setCreateTime(rs.getTimestamp("create_time"));
                user.setLastLogin(rs.getTimestamp("last_login"));
                users.add(user);
            }
        } catch (SQLException e) {
            System.err.println("分页获取用户失败: " + e.getMessage());
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, pstmt, rs);
        }
        return users;
    }

    /**
     * 获取用户总数
     */
    public int getTotalUsersCount() {
        String sql = "SELECT COUNT(*) FROM users";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.err.println("获取用户总数失败: " + e.getMessage());
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, pstmt, rs);
        }
        return 0;
    }

    /**
     * 更新用户状态（启用/禁用）
     */
    public boolean updateUserStatus(int userId, String status) {
        String sql = "UPDATE users SET status = ? WHERE id = ?";
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, status);
            pstmt.setInt(2, userId);

            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("更新用户状态失败: " + e.getMessage());
            e.printStackTrace();
            return false;
        } finally {
            DBUtil.close(conn, pstmt);
        }
    }

    /**
     * 更新用户角色
     */
    public boolean updateUserRole(int userId, String role) {
        String sql = "UPDATE users SET role = ? WHERE id = ?";
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, role);
            pstmt.setInt(2, userId);

            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("更新用户角色失败: " + e.getMessage());
            e.printStackTrace();
            return false;
        } finally {
            DBUtil.close(conn, pstmt);
        }
    }

    /**
     * 删除用户（软删除，更改状态为deleted）
     */
    public boolean deleteUser(int userId) {
        return updateUserStatus(userId, "deleted");
    }

    /**
     * 搜索用户（按用户名或昵称）
     */
    public List<User> searchUsers(String keyword) {
        String sql = "SELECT * FROM users WHERE (username LIKE ? OR nickname LIKE ?) AND status != 'deleted' ORDER BY create_time DESC";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        List<User> users = new ArrayList<>();

        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            String searchPattern = "%" + keyword + "%";
            pstmt.setString(1, searchPattern);
            pstmt.setString(2, searchPattern);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setUsername(rs.getString("username"));
                user.setPassword(rs.getString("password"));
                user.setEmail(rs.getString("email"));
                user.setNickname(rs.getString("nickname"));
                user.setAvatar(rs.getString("avatar"));
                user.setRole(rs.getString("role"));
                user.setStatus(rs.getString("status"));
                user.setCreateTime(rs.getTimestamp("create_time"));
                user.setLastLogin(rs.getTimestamp("last_login"));
                users.add(user);
            }
        } catch (SQLException e) {
            System.err.println("搜索用户失败: " + e.getMessage());
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, pstmt, rs);
        }
        return users;
    }

    /**
     * 获取活跃用户数（最近30天登录过的用户）
     */
    public int getActiveUsersCount() {
        String sql = "SELECT COUNT(*) FROM users WHERE last_login >= DATE_SUB(NOW(), INTERVAL 30 DAY) AND status = 'active'";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.err.println("获取活跃用户数失败: " + e.getMessage());
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, pstmt, rs);
        }
        return 0;
    }

    /**
     * 获取新用户数（最近7天注册的用户）
     */
    public int getNewUsersCount() {
        String sql = "SELECT COUNT(*) FROM users WHERE create_time >= DATE_SUB(NOW(), INTERVAL 7 DAY)";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.err.println("获取新用户数失败: " + e.getMessage());
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, pstmt, rs);
        }
        return 0;
    }

    /**
     * 更新用户头像
     */
    public boolean updateUserAvatar(int userId, String avatarPath) {
        String sql = "UPDATE users SET avatar = ? WHERE id = ?";
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, avatarPath);
            pstmt.setInt(2, userId);

            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("更新用户头像失败: " + e.getMessage());
            e.printStackTrace();
            return false;
        } finally {
            DBUtil.close(conn, pstmt);
        }
    }

    /**
     * 检查用户是否为管理员
     */
    public boolean isAdmin(int userId) {
        String sql = "SELECT role FROM users WHERE id = ? AND status = 'active'";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, userId);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                return "admin".equals(rs.getString("role"));
            }
        } catch (SQLException e) {
            System.err.println("检查管理员权限失败: " + e.getMessage());
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, pstmt, rs);
        }
        return false;
    }

    /**
     * 批量更新用户状态
     */
    public boolean batchUpdateUserStatus(List<Integer> userIds, String status) {
        String sql = "UPDATE users SET status = ? WHERE id = ?";
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = DBUtil.getConnection();
            conn.setAutoCommit(false); // 开启事务

            pstmt = conn.prepareStatement(sql);
            for (Integer userId : userIds) {
                pstmt.setString(1, status);
                pstmt.setInt(2, userId);
                pstmt.addBatch();
            }

            int[] results = pstmt.executeBatch();
            conn.commit(); // 提交事务

            // 检查是否所有操作都成功
            for (int result : results) {
                if (result <= 0) {
                    return false;
                }
            }
            return true;

        } catch (SQLException e) {
            System.err.println("批量更新用户状态失败: " + e.getMessage());
            e.printStackTrace();
            try {
                if (conn != null) {
                    conn.rollback(); // 回滚事务
                }
            } catch (SQLException rollbackEx) {
                System.err.println("事务回滚失败: " + rollbackEx.getMessage());
            }
            return false;
        } finally {
            try {
                if (conn != null) {
                    conn.setAutoCommit(true); // 恢复自动提交
                }
            } catch (SQLException e) {
                System.err.println("恢复自动提交失败: " + e.getMessage());
            }
            DBUtil.close(conn, pstmt);
        }
    }
}