package com.email.email_assistant_sb.app;

import lombok.Data;

@Data
public class EmailRequest {
    private String emailContent;
    private String tone;
}