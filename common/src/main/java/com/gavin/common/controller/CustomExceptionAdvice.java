package com.gavin.common.controller;

import com.gavin.common.dto.common.CustomResponse;
import com.gavin.common.exception.CustomException;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.servlet.mvc.method.annotation.ResponseEntityExceptionHandler;

@RestControllerAdvice("com.gavin.business.controller")
@Slf4j
public class CustomExceptionAdvice extends ResponseEntityExceptionHandler {

    @ExceptionHandler(CustomException.class)
    public ResponseEntity<CustomResponse> handleException(Exception e) {
        log.info(String.format("handling exception: %s, %s.", e.getClass().getSimpleName(), e.getMessage()));

        HttpHeaders headers = new HttpHeaders();
        headers.set("Cache-Control", "no-store");
        headers.set("Pragma", "no-cache");

        CustomResponse body = new CustomResponse();

        ResponseEntity<CustomResponse> response;
        HttpStatus httpStatus;
        if (e instanceof CustomException) {
            CustomException ce = (CustomException) e;
            body.setCode(ce.getErrorCode());
            body.setMessage(ce.getMessage());
            httpStatus = HttpStatus.valueOf(ce.getHttpCode());
        } else {
            body.setCode("server_error");
            body.setMessage(e.getMessage());
            httpStatus = HttpStatus.INTERNAL_SERVER_ERROR;
        }

        response = new ResponseEntity<>(body, headers, httpStatus);
        return response;
    }

}
