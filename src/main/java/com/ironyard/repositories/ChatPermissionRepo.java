package com.ironyard.repositories;

import com.ironyard.data.ChatPermissions;
import org.springframework.data.repository.CrudRepository;

/**
 * Created by osmanidris on 2/13/17.
 */
public interface ChatPermissionRepo extends CrudRepository<ChatPermissions,Long>{
    public ChatPermissions findByKey(String permissionKey);
}
