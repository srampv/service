/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package net.codejava.spring;

import java.io.IOException;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

/**
 *
 * @author shashank
 */
@WebServlet(name="tools",value = "/tools/url")
public class ToolsController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        RequestDispatcher rd=req.getRequestDispatcher("/WEB-INF/views/tools.jsp");
        rd.forward(req, resp);  
        
    }

    

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
      String url=req.getParameter("url");
      List<Url> list=new ArrayList<Url>();
        Document doc=Jsoup.parse(new URL(url), 30*1000);
        Elements els=doc.getElementsByTag("a");
        for(Element el:els){
            Url u=new Url();
            System.out.println(el.attr("href"));
            u.setUrl(el.attr("href"));
            list.add(u);
        }
        req.setAttribute("urls", list);
        RequestDispatcher rd=req.getRequestDispatcher("/WEB-INF/views/home.jsp");
        rd.forward(req, resp);
        
    }
    
    
}
