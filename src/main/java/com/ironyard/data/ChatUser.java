package com.ironyard.data;

import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;
import org.springframework.web.multipart.MultipartFile;

import javax.persistence.*;
import java.util.List;

/**
 * Created by osmanidris on 2/10/17.
 */
@Entity
@JsonIdentityInfo(
        generator = ObjectIdGenerators.PropertyGenerator.class,
        property = "id")
public class ChatUser {
    @Id @GeneratedValue
    private Long id;
    private String username;
    private String password;
    private String displayName;
    @ManyToMany (fetch = FetchType.EAGER)
    private List<ChatPermissions> userPermissions;
    private String userImageFile;

    public ChatUser(){}

    public ChatUser(String username, String password, String displayName, String userImageFile){
        this.username = username;
        this.password = password;
        this.displayName = displayName;
        this.userImageFile = userImageFile;
    }

    public List<ChatPermissions> getUserPermissions() {
        return userPermissions;
    }

    public void setUserPermissions(List<ChatPermissions> userPermissions) {
        this.userPermissions = userPermissions;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long ID) {
        this.id = ID;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getDisplayName() {
        return displayName;
    }

    public void setDisplayName(String displayName) {
        this.displayName = displayName;
    }

    public String getUserImageFile() {
        return userImageFile;
    }

    public void setUserImageFile(String userImageFile) {
        this.userImageFile = userImageFile;
    }
}
