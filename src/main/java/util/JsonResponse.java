package util;

import com.fasterxml.jackson.databind.ObjectMapper;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

/**
 * JSON响应工具类
 */
public class JsonResponse {
    private static final ObjectMapper mapper = new ObjectMapper();

    /**
     * 发送成功响应
     */
    public static void success(HttpServletResponse response, Object data) {
        Map<String, Object> result = new HashMap<>();
        result.put("success", true);
        result.put("message", "操作成功");
        result.put("data", data);

        sendJson(response, result);
    }

    /**
     * 发送成功响应（带自定义消息）
     */
    public static void success(HttpServletResponse response, String message, Object data) {
        Map<String, Object> result = new HashMap<>();
        result.put("success", true);
        result.put("message", message);
        result.put("data", data);

        sendJson(response, result);
    }

    /**
     * 发送错误响应
     */
    public static void error(HttpServletResponse response, String message) {
        Map<String, Object> result = new HashMap<>();
        result.put("success", false);
        result.put("message", message);
        result.put("data", null);

        sendJson(response, result);
    }

    /**
     * 发送JSON数据
     */
    private static void sendJson(HttpServletResponse response, Object data) {
        response.setContentType("application/json;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");

        try (PrintWriter out = response.getWriter()) {
            String json = mapper.writeValueAsString(data);
            out.print(json);
            out.flush();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}