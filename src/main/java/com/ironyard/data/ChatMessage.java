package com.ironyard.data;

import com.fasterxml.jackson.annotation.JsonIdentityReference;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import javax.persistence.*;
import java.util.Date;

/**
 * Created by osmanidris on 2/10/17.
 */
@Entity
public class ChatMessage {
    @Id @GeneratedValue
    private Long id;
    private String messageText;
    private Date postedDate;
    @ManyToOne
    @JsonIdentityReference(alwaysAsId=true)
    private ChatUser msgUser;
    private String imageFileName;
    @ManyToOne
    @JsonIdentityReference(alwaysAsId=true)
    private ChatBoard msgBoard;

    public ChatMessage(){}

    public ChatMessage(String messageText, String imageFileName,ChatUser msgUser, ChatBoard msgBoard) {
        this.messageText = messageText;
        this.imageFileName = imageFileName;
        this.msgUser = msgUser;
        this.msgBoard = msgBoard;
        this.postedDate = new Date();
    }

    public String getMessageText() {
        return messageText;
    }

    public void setMessageText(String messageText) {
        this.messageText = messageText;
    }

    public ChatUser getMsgUser() {
        return msgUser;
    }

    public void setMsgUser(ChatUser msgUser) {
        this.msgUser = msgUser;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getImageFileName() {
        return imageFileName;
    }

    public void setImageFileName(String imageFileName) {
        this.imageFileName = imageFileName;
    }

    public Date getPostedDate() {
        return postedDate;
    }

    public void setPostedDate(Date postedDate) {
        this.postedDate = postedDate;
    }

    public ChatBoard getMsgBoard() {
        return msgBoard;
    }

    public void setMsgBoard(ChatBoard msgBoard) {
        this.msgBoard = msgBoard;
    }
}
