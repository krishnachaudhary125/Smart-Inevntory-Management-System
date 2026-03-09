package com.example.project.servlet;

import com.example.project.dao.MemberDAO;
import com.example.project.model.Member;
import com.example.project.util.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Connection;

@WebServlet("/searchMember")
public class MemberSearchServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String phone = req.getParameter("phone");

        resp.setContentType("application/json");

        try(Connection conn = DBConnection.getConnection()){

            MemberDAO dao = new MemberDAO(conn);

            Member member = dao.findByPhone(phone);

            if(member != null){

                resp.getWriter().write(
                        "{\"name\":\"" + member.getMemberName() +
                                "\",\"points\":" + member.getPoints() + "}"
                );

            }else{

                resp.getWriter().write("{}");

            }

        }catch(Exception e){
            e.printStackTrace();
        }

    }
}