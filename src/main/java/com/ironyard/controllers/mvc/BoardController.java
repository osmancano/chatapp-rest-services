package com.ironyard.controllers.mvc;

import com.ironyard.data.ChatBoard;
import com.ironyard.data.ChatMessage;
import com.ironyard.repositories.ChatBoardRepo;
import com.ironyard.repositories.ChatMessageRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

/**
 * Created by osmanidris on 2/12/17.
 */
@Controller
public class BoardController {
    @Autowired
    private ChatBoardRepo chatBoardRepo;
    @Autowired
    private ChatMessageRepo chatMessageRepo;

    @RequestMapping(value = "/secure/boards")
    public String boardsList(Model data) {
        Iterable found = chatBoardRepo.findAll();
        // put list into model
        data.addAttribute("bList", found);
        return "/secure/boards";
    }

    @RequestMapping(value = "/secure/boards/create", method = RequestMethod.POST,
            consumes = MediaType.APPLICATION_FORM_URLENCODED_VALUE)
    public String createNewBoard(ChatBoard newBoard) {
        chatBoardRepo.save(newBoard);
        return "forward:/secure/boards";
    }

    @RequestMapping(value = "/secure/boards/messages", method = RequestMethod.GET)
    public String boardMessages(Model data, @RequestParam Long boardId,
                                @RequestParam(value = "page", required = false) Integer page,
                                @RequestParam(value = "size", required = false) Integer size,
                                @RequestParam(value = "sortBy", required = false) String sortBy) {
        if(page == null){
            page = 0;
        }
        if(size == null){
            size = 2;
        }
        if(sortBy == null){
            sortBy = "postedDate";
        }
        ChatBoard found = chatBoardRepo.findOne(boardId);
        Sort s = new Sort(Sort.Direction.DESC, sortBy);
        PageRequest pr = new PageRequest(page, size, s);
        Page<ChatMessage> boardMessages = chatMessageRepo.findByMsgBoard(found, pr);
        // put list into model
        data.addAttribute("selectedBoard", found);
        data.addAttribute("bMessages", boardMessages);
        data.addAttribute("sortBy", sortBy);
        return "/secure/currentBoard";
    }

}

