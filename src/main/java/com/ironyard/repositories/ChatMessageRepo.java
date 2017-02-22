package com.ironyard.repositories;

import com.ironyard.data.ChatBoard;
import com.ironyard.data.ChatMessage;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.PagingAndSortingRepository;

/**
 * Created by osmanidris on 2/10/17.
 */
public interface ChatMessageRepo extends PagingAndSortingRepository<ChatMessage,Long> {
    public Page<ChatMessage> findByMsgBoard(ChatBoard mBoard, Pageable pageable);
}
