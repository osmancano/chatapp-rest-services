package com.ironyard.filters;

import com.ironyard.data.ChatUser;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Created by jasonskipper on 2/7/17.
 */
@WebFilter(filterName = "AuthFilter")
public class AuthFilter implements Filter {
    public void destroy() {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response,
                         FilterChain chain) throws IOException, ServletException {
        HttpServletRequest req = ((HttpServletRequest) request);
        HttpServletResponse resp = ((HttpServletResponse) response);
        // check session
        ChatUser usr = (ChatUser) req.getSession().getAttribute("user");
        boolean authorized = (usr != null);
        boolean tryingToLogin = req.getRequestURI().endsWith("login.jsp")||req.getRequestURI().endsWith("authenticate");
        if(authorized || tryingToLogin) {
            chain.doFilter(request, response);
        }else{
            resp.sendRedirect("/open/login.jsp");
        }
    }


    public void init(FilterConfig config) throws ServletException {

    }

}