package com.example.project.util;

import java.security.MessageDigest;

public class PasswordHashing {
    public static String sha1(String input) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-1");
            byte[] result = md.digest(input.getBytes("UTF-8"));

            StringBuilder sb = new StringBuilder();
            for (byte b : result) {
                sb.append(String.format("%02x", b));
            }
            return sb.toString();

        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}
