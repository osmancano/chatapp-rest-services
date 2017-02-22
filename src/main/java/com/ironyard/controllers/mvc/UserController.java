package com.ironyard.controllers.mvc;

import com.ironyard.data.ChatPermissions;
import com.ironyard.data.ChatUser;
import com.ironyard.repositories.ChatPermissionRepo;
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
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by osmanidris on 2/10/17.
 */
@Controller
public class UserController {
    @Autowired
    private ChatUserRepo chatUserRepo;
    @Autowired
    private ChatPermissionRepo chatPermissionRepo;
    @Value("${upload.location}")
    private String uploadLocation;

    @RequestMapping(path = "/open/authenticate", method = RequestMethod.POST)
    public String login(HttpSession session, Model data, @RequestParam(name = "username") String usr, @RequestParam String password){
        ChatUser found = chatUserRepo.findByUsernameAndPassword(usr, password);
        String destinationView = "home";
        if(found == null){
            // no user found, login must fail
            destinationView = "/open/login";
            data.addAttribute("message", true);
        }else{
            List<String> permissions= new ArrayList<>();
            for(int i =0 ;i < found.getUserPermissions().size();i++){
                permissions.add(found.getUserPermissions().get(i).getKey());
            }

            session.setAttribute ("user", found);
            session.setAttribute ("permissions", permissions);
            destinationView = "/secure/home";
        }
        return destinationView;
    }

    @RequestMapping(path = "/secure/users/create", method = RequestMethod.POST,consumes = MediaType.ALL_VALUE)
    public String createUser(Model dataToJsp, @RequestParam String username,
                             @RequestParam String password,
                             @RequestParam String displayName,
                             @RequestParam(required=false) List<String> permissions,
                             @RequestParam(required=false) MultipartFile userImage){
        // save to database
        String uploadedFileName = null;
        if(!userImage.isEmpty()){
            try {
                uploadedFileName = System.currentTimeMillis() + "_" + userImage.getOriginalFilename();
                // copy from input stream to computer disk
                Files.copy(userImage.getInputStream(), Paths.get(uploadLocation + uploadedFileName));
            }catch (Exception e){
                e.printStackTrace();
            }
        }
        ChatUser cUser = new ChatUser(username,password,displayName, uploadedFileName);
        List<ChatPermissions> userPermissions = new ArrayList<>();
        if(permissions.size()>0){
            for(int i = 0; i < permissions.size();i++){
                userPermissions.add(chatPermissionRepo.findByKey(permissions.get(i)));
            }
            cUser.setUserPermissions(userPermissions);
        }
        chatUserRepo.save(cUser);
        return "forward:/secure/users";
    }

    @RequestMapping(value = "/", method = RequestMethod.GET)
    public String index() {
        return "redirect:/secure/home";
    }

    @RequestMapping(path = "/secure/users")
    public String listUsers(Model xyz){
        String destination = "/secure/users";
        Iterable found = chatUserRepo.findAll();
        // put list into model
        xyz.addAttribute("uList", found);
        // go to jsp
        return destination;
    }

    @RequestMapping(path = "/secure/logout")
    public String login(HttpSession session){
        session.removeAttribute("user");
        session.invalidate();
        String destinationView = "/open/login";
        return destinationView;
    }

}
