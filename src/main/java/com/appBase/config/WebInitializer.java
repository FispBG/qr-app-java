package com.appBase.config;

import javax.servlet.MultipartConfigElement;
import javax.servlet.ServletRegistration;
import javax.servlet.Filter;
import org.springframework.web.servlet.support.AbstractAnnotationConfigDispatcherServletInitializer;
import org.springframework.web.filter.CharacterEncodingFilter;

/**
 * Инициализатор веб-приложения Spring
 */
public class WebInitializer extends AbstractAnnotationConfigDispatcherServletInitializer {

    /**
     * Корневая конфигурация приложения
     */
    @Override
    protected Class<?>[] getRootConfigClasses() {
        return null;
    }

    /**
     * Конфигурация сервлета диспетчера
     */
    @Override
    protected Class<?>[] getServletConfigClasses() {
        return new Class[] { WebConfig.class };
    }

    /**
     * Маппинг сервлета диспетчера
     */
    @Override
    protected String[] getServletMappings() {
        return new String[] { "/" };
    }

    /**
     * Настройка загрузки файлов
     */
    @Override
    protected void customizeRegistration(ServletRegistration.Dynamic registration) {
        // Определение директории для временных файлов
        String tempDir = System.getProperty("java.io.tmpdir");
        if (tempDir == null || tempDir.isEmpty()){
            tempDir = "/tmp";
            System.out.println("Системная временная папка не найдена, используется: " + tempDir);
        }

        // Настройка лимитов загрузки файлов
        long maxFileSize = 5 * 1024 * 1024;      // 5MB
        long maxRequestSize = 10 * 1024 * 1024;  // 10MB
        int fileSizeThreshold = 1024 * 1024;     // 1MB

        MultipartConfigElement multipartConfigElement =
                new MultipartConfigElement(tempDir, maxFileSize, maxRequestSize, fileSizeThreshold);

        registration.setMultipartConfig(multipartConfigElement);
    }

    /**
     * Настройка фильтров сервлета
     */
    @Override
    protected Filter[] getServletFilters() {
        // Настройка кодировки UTF-8
        CharacterEncodingFilter characterEncodingFilter = new CharacterEncodingFilter();
        characterEncodingFilter.setEncoding("UTF-8");
        characterEncodingFilter.setForceEncoding(true);
        return new Filter[] { characterEncodingFilter };
    }
}