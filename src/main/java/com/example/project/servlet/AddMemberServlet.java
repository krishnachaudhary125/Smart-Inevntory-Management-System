package com.example.project.servlet;

import com.example.project.dao.MemberDAO;
import com.example.project.model.Member;
import com.example.project.util.DBConnection;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;

@WebServlet("/addMember")
public class AddMemberServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        try(Connection conn = DBConnection.getConnection()){

            MemberDAO dao = new MemberDAO(conn);

            Member m = new Member();

            m.setMemberName(req.getParameter("memberName"));
            m.setPhone(req.getParameter("phone"));

            dao.addMember(m);

            resp.sendRedirect(
                    req.getContextPath()+
                            "/index.jsp?link=dashboard&menu=members&success=added");

        }catch(Exception e){

            e.printStackTrace();

            resp.sendRedirect(
                    req.getContextPath()+
                            "/index.jsp?link=dashboard&menu=members&error=failed");
        }
    }
}