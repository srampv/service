/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package net.codejava.spring;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import java.io.DataInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author shashank
 */
@WebServlet(name ="seo",value = "/aboutus" )
public class SeoController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        
        PrintWriter out=resp.getWriter();
        out.println("Welcome to Ram Thoughts Ltd...!");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        InputStream is=req.getInputStream();
        DataInputStream dis=new DataInputStream(is);
        String DATA="";
        StringBuffer sb=new StringBuffer();
        while(DATA!=null){
            DATA=dis.readLine();
            System.out.println(DATA);
            if(DATA==null){
                break;
            }
            sb.append(DATA);
        }
        Gson gson= new GsonBuilder().create();
       User user= gson.fromJson(sb.toString(), User.class);
       
    }
    
    
    
}
