package com.appBase.pojo;

import javax.persistence.*;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Entity
@Table(name = "appealsBase")
public class Appeal {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "uuid", unique = true, nullable = false)
    private String uuid = UUID.randomUUID().toString();

    @Column(name = "applicant_name", nullable = false)
    private String applicantName;

    @Column(name = "manager_name", nullable = false)
    private String managerName;

    @Column(name = "address", nullable = false)
    private String address;

    @Column(name = "topic", nullable = false)
    private String topic;

    @Column(name = "content", nullable = false, length = 2000)
    private String content;

    @Column(name = "resolution", length = 2000)
    private String resolution;

    @Column(name = "status", nullable = false)
    private String status = "Создано";

    @Column(name = "notes", length = 2000)
    private String notes;

    @Column(name = "printer")
    private Boolean printer;

    // Getters and Setters

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getUuid() {
        return uuid;
    }

    public void setUuid(String uuid) {
        this.uuid = uuid;
    }

    public String getApplicantName() {
        return applicantName;
    }

    public void setApplicantName(String applicantName) {
        this.applicantName = applicantName;
    }

    public String getManagerName() {
        return managerName;
    }

    public void setManagerName(String managerName) {
        this.managerName = managerName;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getTopic() {
        return topic;
    }

    public void setTopic(String topic) {
        this.topic = topic;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getResolution() {
        return resolution;
    }

    public void setResolution(String resolution) {
        this.resolution = resolution;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }

    public Boolean getPrinter() {
        return printer;
    }

    public void setPrinter(Boolean printer) {
        this.printer = printer;
    }

    @Override
    public String toString() {
        return "id:" + id +
                " uuid:" + uuid +
                " applicantName:" + applicantName +
                " managerName:" + managerName +
                " address:" + address +
                " topic:" + topic +
                " content:" + content +
                " resolution:" + resolution +
                " status:" + status +
                " notes:" + notes +
                " printer:" + printer;
    }

    public static Appeal fromString(String data) {
        Appeal appeal = new Appeal();

        Pattern pattern = Pattern.compile("(\\w+):(.*?)(?=\\s+\\w+:|$)", Pattern.DOTALL);
        Matcher matcher = pattern.matcher(data);

        Map<String, String> keyValuePairs = new HashMap<>();
        while (matcher.find()) {
            String key = matcher.group(1);
            String value = matcher.group(2).trim();
            System.out.println("Найдено поле: " + key + " = " + value);
            keyValuePairs.put(key, value);
        }

        System.out.println("Все найденные ключ-значения: " + keyValuePairs);

        if (keyValuePairs.containsKey("id")) {
            try {
                appeal.setId(Long.parseLong(keyValuePairs.get("id")));
            } catch (NumberFormatException e) {
                System.err.println("Ошибка парсинга ID: " + e.getMessage());
            }
        }

        appeal.setUuid(keyValuePairs.getOrDefault("uuid", UUID.randomUUID().toString()));
        appeal.setApplicantName(keyValuePairs.getOrDefault("applicantName", ""));
        appeal.setManagerName(keyValuePairs.getOrDefault("managerName", ""));
        appeal.setAddress(keyValuePairs.getOrDefault("address", ""));
        appeal.setTopic(keyValuePairs.getOrDefault("topic", ""));

        String content = keyValuePairs.getOrDefault("content", "");
        appeal.setContent(content);

        appeal.setResolution(keyValuePairs.getOrDefault("resolution", null));
        appeal.setStatus(keyValuePairs.getOrDefault("status", "Создано"));
        appeal.setNotes(keyValuePairs.getOrDefault("notes", null));

        String printer = keyValuePairs.getOrDefault("printer", "false");
        appeal.setPrinter(Boolean.parseBoolean(printer));

        return appeal;
    }
}