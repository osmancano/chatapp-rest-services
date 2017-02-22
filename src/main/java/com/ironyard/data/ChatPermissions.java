package com.ironyard.data;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;

/**
 * Created by osmanidris on 2/13/17.
 */
@Entity
public class ChatPermissions {
    @Id
    private Long id;
    private String permissionName;
    private String key;

    public ChatPermissions(String key){
        this.key = key;
    }

    public ChatPermissions() {
    }

    @Override
    public String toString(){
        return key;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null ){
            return false;
        } else if (o instanceof String){
            return key.equals(o);
        } else if (o instanceof ChatPermissions) {

            ChatPermissions that = (ChatPermissions) o;

            return key.equals(that.key);
        } else {
            return false;
        }
    }

    @Override
    public int hashCode() {
        return key.hashCode();
    }

    public Long getId() {
        return id;
    }

    public void setId(Long ID) {
        this.id = ID;
    }

    public String getPermissionName() {
        return permissionName;
    }

    public void setPermissionName(String permissionName) {
        this.permissionName = permissionName;
    }

    public String getKey() {
        return key;
    }

    public void setKey(String key) {
        this.key = key;
    }
}
