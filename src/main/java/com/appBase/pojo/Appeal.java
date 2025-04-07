package com.appBase.pojo;

import javax.persistence.*;
import java.util.UUID;

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
        Appeal petition = new Appeal();
        String[] parts = data.split(" ");

        for (String part : parts) {
            String[] keyValue = part.split(":", 2);
            if (keyValue.length != 2) continue;

            String key = keyValue[0].trim();
            String value = keyValue[1].trim();

            switch (key) {
                case "id":
                    petition.setId(Long.parseLong(value));
                    break;
                case "uuid":
                    petition.setUuid(value);
                    break;
                case "applicantName":
                    petition.setApplicantName(value);
                    break;
                case "managerName":
                    petition.setManagerName(value);
                    break;
                case "address":
                    petition.setAddress(value);
                    break;
                case "topic":
                    petition.setTopic(value);
                    break;
                case "content":
                    petition.setContent(value);
                    break;
                case "resolution":
                    petition.setResolution(value);
                    break;
                case "status":
                    petition.setStatus(value);
                    break;
                case "notes":
                    petition.setNotes(value);
                    break;
                case "printer":
                    petition.setPrinter(Boolean.parseBoolean(value));
                    break;
            }
        }

        return petition;
    }
}