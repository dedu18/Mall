package com.dedu.mall;

import org.apache.commons.lang.StringUtils;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import java.io.UnsupportedEncodingException;
import java.nio.charset.Charset;

@RunWith(SpringRunner.class)
@SpringBootTest
public class MallCartApplicationTests {

    @Test
    public void contextLoads() {
    }

    public static void main(String[] args) {
        String input = "¸ÃÕË»§²»´æÔÚ";
        System.out.println("转换前得结果："+input);
        try {
            String output = new String(input.getBytes("iso-8859-1"),"gbk");
            System.out.println("转换后得结果："+output);
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
    }

    public static void smain(String[] args) {
        String source = "¸ÃÕË»§²»´æÔÚ";
        Charset gbkCharset = Charset.forName("gbk");
        Charset utf8Charset = Charset.forName("utf-8");
        Charset iso88591Charset = Charset.forName("iso-8859-1");

        Charset defaultCharset = Charset.defaultCharset();

        System.out.printf("defaultCharset:%s%n", defaultCharset);

        System.out.println(StringUtils.repeat("=",20));

        String str1 = new String(source.getBytes(gbkCharset), utf8Charset);
        System.out.printf("gbk=>utf-8：%s%n", str1);

        String str4 = new String(source.getBytes(utf8Charset), gbkCharset);
        System.out.printf("utf-8=>gbk：%s%n", str4);

        String str2 = new String(source.getBytes(iso88591Charset), utf8Charset);
        System.out.printf("iso8859-1=>utf-8：%s%n", str2);

        String str5 = new String(source.getBytes(utf8Charset), iso88591Charset);
        System.out.printf("utf-8=>iso8859-1：%s%n", str5);

        String str3 = new String(source.getBytes(gbkCharset), iso88591Charset);
        System.out.printf("gbk=>iso8859-1：%s%n", str3);

        String str6 = new String(source.getBytes(iso88591Charset), gbkCharset);
        System.out.printf("iso8859-1=>gbk：%s%n", str6);
    }

}
