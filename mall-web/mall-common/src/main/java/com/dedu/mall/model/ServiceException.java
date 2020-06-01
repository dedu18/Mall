package com.dedu.mall.model;

public class ServiceException extends RuntimeException {
    private String code;
    private Object data;

    public ServiceException() {
    }

    public ServiceException(String code) {
        this.code = code;
    }

    public ServiceException(String code, Object data) {
        super("");
        this.code = code;
        this.data = data;
    }

    public ServiceException(String code, String message) {
        super(message);
        this.code = code;
    }

    public ServiceException(String code, Object data, String message) {
        super(message);
        this.code = code;
        this.data = data;
    }

    public ServiceException(String code, Throwable cause) {
        super("", cause);
        this.code = code;
    }

    public ServiceException(String code, String message, Throwable cause) {
        super(message, cause.getCause());
        this.code = code;
    }

    public String getCode() {
        return this.code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public Object getData() {
        return this.data;
    }

    public void setData(Object data) {
        this.data = data;
    }
}
