package bean;

import java.sql.Timestamp;
import java.util.UUID;

public class Post {
    private int id;
    private String title;
    private String content;
    private int userId;
    private String userNickname; // 关联用户昵称
    private int categoryId;
    private String categoryName; // 关联分类名称
    private int viewCount;
    private int likeCount;
    private int commentCount;
    private String status;
    private boolean isTop;
    private String shareCode; // 分享码
    private String businessOrderNo; // 业务订单号
    private Timestamp createTime;
    private Timestamp updateTime;

    // 构造方法
    public Post() {
        this.shareCode = generateShareCode();
        this.businessOrderNo = generateBusinessOrderNo();
    }

    public Post(String title, String content, int userId, int categoryId) {
        this();
        this.title = title;
        this.content = content;
        this.userId = userId;
        this.categoryId = categoryId;
    }

    // Getter和Setter方法
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public String getUserNickname() { return userNickname; }
    public void setUserNickname(String userNickname) { this.userNickname = userNickname; }

    public int getCategoryId() { return categoryId; }
    public void setCategoryId(int categoryId) { this.categoryId = categoryId; }

    public String getCategoryName() { return categoryName; }
    public void setCategoryName(String categoryName) { this.categoryName = categoryName; }

    public int getViewCount() { return viewCount; }
    public void setViewCount(int viewCount) { this.viewCount = viewCount; }

    public int getLikeCount() { return likeCount; }
    public void setLikeCount(int likeCount) { this.likeCount = likeCount; }

    public int getCommentCount() { return commentCount; }
    public void setCommentCount(int commentCount) { this.commentCount = commentCount; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public boolean isTop() { return isTop; }
    public void setTop(boolean top) { isTop = top; }

    public String getShareCode() { return shareCode; }
    public void setShareCode(String shareCode) { this.shareCode = shareCode; }

    public String getBusinessOrderNo() { return businessOrderNo; }
    public void setBusinessOrderNo(String businessOrderNo) { this.businessOrderNo = businessOrderNo; }

    public Timestamp getCreateTime() { return createTime; }
    public void setCreateTime(Timestamp createTime) { this.createTime = createTime; }

    public Timestamp getUpdateTime() { return updateTime; }
    public void setUpdateTime(Timestamp updateTime) { this.updateTime = updateTime; }

    // 计算热度方法
    public double getHotScore() {
        long timeDiff = System.currentTimeMillis() - createTime.getTime();
        double timeDecay = 1.0 / (1 + timeDiff / (24 * 60 * 60 * 1000.0)); // 时间衰减
        return (likeCount * 3 + commentCount * 2 + viewCount * 0.1) * timeDecay;
    }

    // 生成分享码
    private String generateShareCode() {
        return "SHARE" + System.currentTimeMillis() + (int)(Math.random() * 1000);
    }

    // 生成业务订单号
    private String generateBusinessOrderNo() {
        return "POST" + System.currentTimeMillis() + String.format("%04d", (int)(Math.random() * 10000));
    }

    // 获取热度等级
    public String getHotLevel() {
        double score = getHotScore();
        if (score > 100) return "🔥🔥🔥 超热";
        if (score > 50) return "🔥🔥 很热";
        if (score > 20) return "🔥 热门";
        return "📝 普通";
    }

    // 获取进度百分比（基于热度）
    public int getProgressPercent() {
        double score = getHotScore();
        int progress = (int) Math.min(100, score);
        return Math.max(5, progress); // 最小5%，最大100%
    }
}