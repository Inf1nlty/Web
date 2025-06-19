package dao;

import util.DBUtil;

import java.sql.*;

public class LikeDAO {

    /**
     * 用户点赞帖子
     */
    public boolean likePost(int userId, int postId) {
        Connection conn = null;
        PreparedStatement pstmt1 = null;
        PreparedStatement pstmt2 = null;

        try {
            conn = DBUtil.getConnection();
            conn.setAutoCommit(false);

            // 1. 插入点赞记录
            String sql1 = "INSERT INTO likes (user_id, target_type, target_id) VALUES (?, 'post', ?)";
            pstmt1 = conn.prepareStatement(sql1);
            pstmt1.setInt(1, userId);
            pstmt1.setInt(2, postId);
            pstmt1.executeUpdate();

            // 2. 更新帖子点赞数
            String sql2 = "UPDATE posts SET like_count = like_count + 1 WHERE id = ?";
            pstmt2 = conn.prepareStatement(sql2);
            pstmt2.setInt(1, postId);
            pstmt2.executeUpdate();

            conn.commit();
            return true;

        } catch (SQLException e) {
            try {
                if (conn != null) conn.rollback();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
            return false;
        } finally {
            try {
                if (conn != null) conn.setAutoCommit(true);
            } catch (SQLException e) {
                e.printStackTrace();
            }
            DBUtil.close(conn, pstmt1);
            if (pstmt2 != null) {
                try {
                    pstmt2.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    /**
     * 用户取消点赞
     */
    public boolean unlikePost(int userId, int postId) {
        Connection conn = null;
        PreparedStatement pstmt1 = null;
        PreparedStatement pstmt2 = null;

        try {
            conn = DBUtil.getConnection();
            conn.setAutoCommit(false);

            // 1. 删除点赞记录
            String sql1 = "DELETE FROM likes WHERE user_id = ? AND target_type = 'post' AND target_id = ?";
            pstmt1 = conn.prepareStatement(sql1);
            pstmt1.setInt(1, userId);
            pstmt1.setInt(2, postId);
            pstmt1.executeUpdate();

            // 2. 更新帖子点赞数
            String sql2 = "UPDATE posts SET like_count = like_count - 1 WHERE id = ? AND like_count > 0";
            pstmt2 = conn.prepareStatement(sql2);
            pstmt2.setInt(1, postId);
            pstmt2.executeUpdate();

            conn.commit();
            return true;

        } catch (SQLException e) {
            try {
                if (conn != null) conn.rollback();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
            return false;
        } finally {
            try {
                if (conn != null) conn.setAutoCommit(true);
            } catch (SQLException e) {
                e.printStackTrace();
            }
            DBUtil.close(conn, pstmt1);
            if (pstmt2 != null) {
                try {
                    pstmt2.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    /**
     * 检查用户是否已点赞帖子
     */
    public boolean hasUserLikedPost(int userId, int postId) {
        String sql = "SELECT 1 FROM likes WHERE user_id = ? AND target_type = 'post' AND target_id = ?";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, userId);
            pstmt.setInt(2, postId);
            rs = pstmt.executeQuery();

            return rs.next();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            DBUtil.close(conn, pstmt, rs);
        }
    }

    /**
     * 获取帖子点赞数
     */
    public int getPostLikeCount(int postId) {
        String sql = "SELECT like_count FROM posts WHERE id = ?";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, postId);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                return rs.getInt("like_count");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, pstmt, rs);
        }
        return 0;
    }
}