package com.appBase.config;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Фильтр для проверки авторизации доступа к админ-панели
 */
@WebFilter(urlPatterns = "/admin/*")
public class AdminAuthFilter implements Filter {

    /**
     * Проверяет авторизацию для доступа к админ-страницам
     */
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);
        String uri = httpRequest.getRequestURI();

        // Пропускаем запросы не к админ-панели
        if (!uri.startsWith(httpRequest.getContextPath() + "/admin/")) {
            chain.doFilter(request, response);
            return;
        }

        // Пропускаем запросы к странице входа
        if (uri.endsWith("/admin/login")) {
            chain.doFilter(request, response);
            return;
        }

        // Проверка авторизации пользователя
        boolean isLoggedIn = session != null && session.getAttribute("authenticated") != null
                && (Boolean)session.getAttribute("authenticated");

        if (isLoggedIn) {
            chain.doFilter(request, response);
        } else {
            // Перенаправление на страницу входа
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/admin/login");
        }
    }

    /**
     * Инициализация фильтра
     */
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        System.out.println("AdminAuthFilter инициализирован");
    }

    /**
     * Уничтожение фильтра
     */
    @Override
    public void destroy() {
        System.out.println("AdminAuthFilter уничтожен");
    }
}