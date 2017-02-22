package com.ironyard.controllers.mvc;

import com.ironyard.data.ChatBoard;
import com.ironyard.data.ChatMessage;
import com.ironyard.data.ChatUser;
import com.ironyard.repositories.ChatBoardRepo;
import com.ironyard.repositories.ChatMessageRepo;
import com.ironyard.repositories.ChatUserRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;
import java.nio.file.Files;
import java.nio.file.Paths;

/**
 * Created by osmanidris on 2/12/17.
 */
@Controller
public class MessageController {
    @Autowired
    private ChatMessageRepo chatMessageRepo;
    @Autowired
    private ChatBoardRepo chatBoardRepo;
    @Autowired
    private ChatUserRepo chatUserRepo;
    @Value("${upload.location}")
    private String uploadLocation;
    @RequestMapping(path = "/secure/messages/create", method = RequestMethod.POST,consumes = MediaType.ALL_VALUE)
    public String createMovie(HttpSession session, Model dataToJsp,
                              @RequestParam String messageText,
                              @RequestParam(required=false) MultipartFile imageFile,
                              @RequestParam Long boardId){
        String dest = "redirect:/secure/boards/messages?boardId="+boardId;
        String uploadedFileName = null;
        if(!imageFile.isEmpty()){
            try {
                uploadedFileName = System.currentTimeMillis() + "_" + imageFile.getOriginalFilename();
                // copy from input stream to computer disk
                Files.copy(imageFile.getInputStream(), Paths.get(uploadLocation + uploadedFileName));
            }catch (Exception e){
                e.printStackTrace();
            }
        }
        ChatBoard currBoard = chatBoardRepo.findOne(boardId);
        ChatUser user = (ChatUser) session.getAttribute("user");
        ChatMessage msg = new ChatMessage(messageText,uploadedFileName,user, currBoard);
        chatMessageRepo.save(msg);
        currBoard.getBoardMessages().add(msg);
        // save to database
        chatBoardRepo.save(currBoard);

        return dest;
    }
}
