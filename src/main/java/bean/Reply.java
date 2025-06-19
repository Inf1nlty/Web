package bean;

import java.sql.Timestamp;

public class Reply {
    private int id;
    private String content;
    private int userId;
    private String userNickname;
    private int postId;
    private int parentId; // 父回复ID（楼中楼）
    private String status;
    private int likeCount;
    private Timestamp createTime;

    // 构造方法
    public Reply() {}

    public Reply(String content, int userId, int postId) {
        this.content = content;
        this.userId = userId;
        this.postId = postId;
    }

    // Getter和Setter方法
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public String getUserNickname() { return userNickname; }
    public void setUserNickname(String userNickname) { this.userNickname = userNickname; }

    public int getPostId() { return postId; }
    public void setPostId(int postId) { this.postId = postId; }

    public int getParentId() { return parentId; }
    public void setParentId(int parentId) { this.parentId = parentId; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public int getLikeCount() { return likeCount; }
    public void setLikeCount(int likeCount) { this.likeCount = likeCount; }

    public Timestamp getCreateTime() { return createTime; }
    public void setCreateTime(Timestamp createTime) { this.createTime = createTime; }
}