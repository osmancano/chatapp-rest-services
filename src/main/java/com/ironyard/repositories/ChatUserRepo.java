package com.ironyard.repositories;

import com.ironyard.data.ChatUser;
import org.springframework.data.repository.CrudRepository;

/**
 * Created by osmanidris on 2/10/17.
 */
public interface ChatUserRepo extends CrudRepository<ChatUser, Long> {
    public ChatUser findByUsernameAndPassword(String username, String password);
}
