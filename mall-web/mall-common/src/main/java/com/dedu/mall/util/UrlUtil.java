package com.dedu.mall.util;

import org.apache.http.NameValuePair;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class UrlUtil {

    public static String post(String url, Map<String, String> data) throws Exception {
        // 创建Httpclient对象
        CloseableHttpClient httpclient = HttpClients.createDefault();
        // 创建http POST请求，访问开源中国
        HttpPost httpPost = new HttpPost(url);

        // 根据开源中国的请求需要，设置post请求参数
        List<NameValuePair> parameters = new ArrayList<NameValuePair>(0);
        data.entrySet().forEach(s -> {
            parameters.add(new BasicNameValuePair(s.getKey(), s.getValue()));
        });
        // 构造一个form表单式的实体
        UrlEncodedFormEntity formEntity = new UrlEncodedFormEntity(parameters);
        // 将请求实体设置到httpPost对象中
        httpPost.setEntity(formEntity);

        CloseableHttpResponse response = null;
        String content = "";
        try {
            // 执行请求
            response = httpclient.execute(httpPost);
            // 判断返回状态是否为200
            if (response.getStatusLine().getStatusCode() == 200) {
                // 解析响应体
                content = EntityUtils.toString(response.getEntity(), "UTF-8");
            }
        } finally {
            if (response != null) {
                response.close();
            }
            // 关闭浏览器
            httpclient.close();
        }
        return content;
    }
}
