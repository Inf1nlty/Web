package dao;

import bean.Post;
import util.DBUtil;

import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class PostDAO {

    /**
     * 发布新帖子（包含业务订单号和分享码）
     */
    public boolean createPost(Post post) {
        String sql = "INSERT INTO posts (title, content, user_id, category_id, share_code, business_order_no) VALUES (?, ?, ?, ?, ?, ?)";
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            pstmt.setString(1, post.getTitle());
            pstmt.setString(2, post.getContent());
            pstmt.setInt(3, post.getUserId());
            pstmt.setInt(4, post.getCategoryId());
            pstmt.setString(5, post.getShareCode());
            pstmt.setString(6, post.getBusinessOrderNo());

            int result = pstmt.executeUpdate();
            if (result > 0) {
                // 获取生成的ID
                ResultSet rs = pstmt.getGeneratedKeys();
                if (rs.next()) {
                    post.setId(rs.getInt(1));
                }
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, pstmt);
        }
        return false;
    }

    /**
     * 获取热门帖子列表（按热度排序）
     */
    public List<Post> getHotPosts(int limit) {
        List<Post> posts = new ArrayList<>();
        String sql = "SELECT p.*, u.nickname as userNickname, c.name as categoryName " +
                "FROM posts p " +
                "JOIN users u ON p.user_id = u.id " +
                "JOIN categories c ON p.category_id = c.id " +
                "WHERE p.status = 'normal' " +
                "ORDER BY (p.like_count * 3 + p.reply_count * 2 + p.view_count * 0.1) DESC " +
                "LIMIT ?";

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, limit);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                Post post = mapResultSetToPost(rs);
                posts.add(post);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, pstmt, rs);
        }
        return posts;
    }

    /**
     * 搜索帖子
     */
    public List<Post> searchPosts(String keyword, int offset, int limit) {
        List<Post> posts = new ArrayList<>();
        String sql = "SELECT p.*, u.nickname as userNickname, c.name as categoryName " +
                "FROM posts p " +
                "JOIN users u ON p.user_id = u.id " +
                "JOIN categories c ON p.category_id = c.id " +
                "WHERE p.status = 'normal' AND (p.title LIKE ? OR p.content LIKE ?) " +
                "ORDER BY p.is_top DESC, p.create_time DESC " +
                "LIMIT ? OFFSET ?";

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            String searchPattern = "%" + keyword + "%";
            pstmt.setString(1, searchPattern);
            pstmt.setString(2, searchPattern);
            pstmt.setInt(3, limit);
            pstmt.setInt(4, offset);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                Post post = mapResultSetToPost(rs);
                posts.add(post);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, pstmt, rs);
        }
        return posts;
    }

    /**
     * 获取搜索结果数量
     */
    public int getSearchPostCount(String keyword) {
        String sql = "SELECT COUNT(*) FROM posts WHERE status = 'normal' AND (title LIKE ? OR content LIKE ?)";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            String searchPattern = "%" + keyword + "%";
            pstmt.setString(1, searchPattern);
            pstmt.setString(2, searchPattern);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, pstmt, rs);
        }
        return 0;
    }

    /**
     * 按分类获取帖子
     */
    public List<Post> getPostsByCategory(int categoryId, int offset, int limit) {
        List<Post> posts = new ArrayList<>();
        String sql = "SELECT p.*, u.nickname as userNickname, c.name as categoryName " +
                "FROM posts p " +
                "JOIN users u ON p.user_id = u.id " +
                "JOIN categories c ON p.category_id = c.id " +
                "WHERE p.status = 'normal' AND p.category_id = ? " +
                "ORDER BY p.is_top DESC, p.create_time DESC " +
                "LIMIT ? OFFSET ?";

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, categoryId);
            pstmt.setInt(2, limit);
            pstmt.setInt(3, offset);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                Post post = mapResultSetToPost(rs);
                posts.add(post);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, pstmt, rs);
        }
        return posts;
    }

    /**
     * 获取分类帖子数量
     */
    public int getPostCountByCategory(int categoryId) {
        String sql = "SELECT COUNT(*) FROM posts WHERE status = 'normal' AND category_id = ?";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, categoryId);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, pstmt, rs);
        }
        return 0;
    }

    /**
     * 获取帖子总数
     */
    public int getPostCount() {
        String sql = "SELECT COUNT(*) FROM posts WHERE status = 'normal'";
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
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, pstmt, rs);
        }
        return 0;
    }

    /**
     * 获取帖子总数（别名方法，兼容PostListServlet）
     */
    public int getTotalPostCount() {
        return getPostCount();
    }

    /**
     * 获取今日帖子数
     */
    public int getTodayPostCount() {
        String sql = "SELECT COUNT(*) FROM posts WHERE DATE(create_time) = CURDATE() AND status = 'normal'";
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
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, pstmt, rs);
        }
        return 0;
    }

    /**
     * 获取总浏览量
     */
    public int getTotalViews() {
        String sql = "SELECT SUM(view_count) FROM posts WHERE status = 'normal'";
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
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, pstmt, rs);
        }
        return 0;
    }

    /**
     * 获取总点赞数
     */
    public int getTotalLikes() {
        String sql = "SELECT SUM(like_count) FROM posts WHERE status = 'normal'";
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
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, pstmt, rs);
        }
        return 0;
    }

    /**
     * 根据分享码获取帖子
     */
    public Post getPostByShareCode(String shareCode) {
        String sql = "SELECT p.*, u.nickname as userNickname, c.name as categoryName " +
                "FROM posts p " +
                "JOIN users u ON p.user_id = u.id " +
                "JOIN categories c ON p.category_id = c.id " +
                "WHERE p.share_code = ? AND p.status = 'normal'";

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, shareCode);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                return mapResultSetToPost(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, pstmt, rs);
        }
        return null;
    }

    /**
     * 增加帖子浏览量
     */
    public void increaseViewCount(int postId) {
        String sql = "UPDATE posts SET view_count = view_count + 1 WHERE id = ?";
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, postId);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, pstmt);
        }
    }

    /**
     * 获取帖子详情
     */
    public Post getPostById(int id) {
        String sql = "SELECT p.*, u.nickname as userNickname, c.name as categoryName " +
                "FROM posts p " +
                "JOIN users u ON p.user_id = u.id " +
                "JOIN categories c ON p.category_id = c.id " +
                "WHERE p.id = ?";

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                return mapResultSetToPost(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, pstmt, rs);
        }
        return null;
    }

    /**
     * 获取所有帖子（分页）
     */
    public List<Post> getAllPosts(int offset, int limit) {
        List<Post> posts = new ArrayList<>();
        String sql = "SELECT p.*, u.nickname as userNickname, c.name as categoryName " +
                "FROM posts p " +
                "JOIN users u ON p.user_id = u.id " +
                "JOIN categories c ON p.category_id = c.id " +
                "WHERE p.status = 'normal' " +
                "ORDER BY p.is_top DESC, p.create_time DESC " +
                "LIMIT ? OFFSET ?";

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, limit);
            pstmt.setInt(2, offset);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                Post post = mapResultSetToPost(rs);
                posts.add(post);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, pstmt, rs);
        }
        return posts;
    }

    /**
     * 映射ResultSet到Post对象
     */
    private Post mapResultSetToPost(ResultSet rs) throws SQLException {
        Post post = new Post();
        post.setId(rs.getInt("id"));
        post.setTitle(rs.getString("title"));
        post.setContent(rs.getString("content"));
        post.setUserId(rs.getInt("user_id"));
        post.setUserNickname(rs.getString("userNickname"));
        post.setCategoryId(rs.getInt("category_id"));
        post.setCategoryName(rs.getString("categoryName"));
        post.setViewCount(rs.getInt("view_count"));
        post.setLikeCount(rs.getInt("like_count"));
        post.setCommentCount(rs.getInt("reply_count"));
        post.setStatus(rs.getString("status"));
        post.setTop(rs.getBoolean("is_top"));
        post.setShareCode(rs.getString("share_code"));
        post.setBusinessOrderNo(rs.getString("business_order_no"));
        post.setCreateTime(rs.getTimestamp("create_time"));
        post.setUpdateTime(rs.getTimestamp("update_time"));
        return post;
    }

    /**
     * 获取热度最高的帖子（管理员统计用）
     */
    public List<Post> getTopHotPosts(int limit) {
        return getHotPosts(limit);
    }

    /**
     * 获取指定用户的帖子列表
     */
    public List<Post> getUserPosts(int userId) {
        List<Post> posts = new ArrayList<>();
        String sql = "SELECT p.*, u.nickname as userNickname, c.name as categoryName " +
                "FROM posts p " +
                "JOIN users u ON p.user_id = u.id " +
                "JOIN categories c ON p.category_id = c.id " +
                "WHERE p.user_id = ? AND p.status = 'normal' " +
                "ORDER BY p.create_time DESC";

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, userId);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                Post post = mapResultSetToPost(rs);
                posts.add(post);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, pstmt, rs);
        }
        return posts;
    }

    /**
     * 获取用户帖子总数
     */
    public int getUserPostCount(int userId) {
        String sql = "SELECT COUNT(*) FROM posts WHERE user_id = ? AND status = 'normal'";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, userId);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, pstmt, rs);
        }
        return 0;
    }

    public int getTotalViewCount() {
        String sql = "SELECT SUM(view_count) FROM posts";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

}