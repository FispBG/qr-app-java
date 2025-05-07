package com.appBase.config; // Убедитесь, что пакет правильный

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter(urlPatterns = "/admin/*")
public class AdminAuthFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        System.out.println("[AdminAuthFilter] Инициализирован.");
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);

        String requestURI = httpRequest.getRequestURI();
        String contextPath = httpRequest.getContextPath();


        if (requestURI.equals(contextPath + "/admin/login")) {
            chain.doFilter(request, response);
            return;
        }


        boolean isAdminLoggedIn = false;
        if (session != null) {
            String adminUsername = (String) session.getAttribute("adminUsername");
            String authenticatedUserType = (String) session.getAttribute("authenticatedUserType");

            if (adminUsername != null && "admin".equals(authenticatedUserType)) {
                isAdminLoggedIn = true;
            }
        } else {
        }


        if (isAdminLoggedIn) {
            chain.doFilter(request, response);
        } else {
            httpResponse.sendRedirect(contextPath + "/admin/login");
        }
    }

    @Override
    public void destroy() {
        System.out.println("[AdminAuthFilter] Уничтожен.");
    }
}