package com.appBase.config;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter(urlPatterns = "/admin/*")
public class AdminAuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);
        String uri = httpRequest.getRequestURI();

        if (!uri.startsWith(httpRequest.getContextPath() + "/admin/")) {
            chain.doFilter(request, response);
            return;
        }

        if (uri.endsWith("/admin/login")) {
            chain.doFilter(request, response);
            return;
        }

        boolean isLoggedIn = session != null && session.getAttribute("authenticated") != null
                && (Boolean)session.getAttribute("authenticated");

        if (isLoggedIn) {
            chain.doFilter(request, response);
        } else {
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/admin/login");
        }
    }

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        System.out.println("AdminAuthFilter инициализирован");
    }

    @Override
    public void destroy() {
        System.out.println("AdminAuthFilter уничтожен");
    }
}