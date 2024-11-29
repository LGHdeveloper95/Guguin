package com.guguin.note;

import com.guguin.com.mapper.ComMapper;
import com.guguin.user.mapper.UserMypageMapper;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Collections;
import java.util.List;

@RestController
@RequestMapping("/note")
public class NoteRestController {

    @Autowired
    private NoteMapper noteMapper;
    @Autowired
    private ComMapper comMapper;
    @Autowired
    private UserMypageMapper userMypageMapper;

    @GetMapping("/getList/{type}")
    public ResponseEntity<List<NoteVo>> getList(@PathVariable("type")String type,HttpServletRequest request){
        HttpSession session = request.getSession();
        String id = (String) ((session.getAttribute("userid") != null) ? session.getAttribute("userid")
                    : session.getAttribute("comid"));
        List<NoteVo> noteList = noteMapper.getNoteList(id, type);
        ResponseEntity<List<NoteVo>> result = (noteList != null) ? ResponseEntity.status(HttpStatus.OK).body(noteList)
                : ResponseEntity.status(HttpStatus.BAD_REQUEST).body(Collections.emptyList());
        return result;
    }

    @GetMapping("/getSendList/{type}")
    public ResponseEntity<List<NoteVo>> getSendList(@PathVariable("type")String type,HttpServletRequest request){
        HttpSession session = request.getSession();
        String id = (String) ((session.getAttribute("userid") != null) ? session.getAttribute("userid")
                : session.getAttribute("comid"));
        List<NoteVo> noteList = noteMapper.getSendNoteList(id, type);
        ResponseEntity<List<NoteVo>> result = (noteList != null) ? ResponseEntity.status(HttpStatus.OK).body(noteList)
                : ResponseEntity.status(HttpStatus.BAD_REQUEST).body(Collections.emptyList());
        return result;
    }

    @PostMapping("/write")
    public String write(@RequestBody NoteVo note){
        int check=0;
        if(note.getReceive_id()=="COM"){
            check = noteMapper.checkComReceiveId(note.getReceive_id());
        }else{
            check = noteMapper.checkUserReceiveId(note.getReceive_id());
        }

        if(check>0){
            noteMapper.insertNote(note);
            return "OK";
        }else return  "ERROR";
    }

    @DeleteMapping("/delete")
    public String delete(@RequestBody NoteVo note){
        int check = noteMapper.deleteNote(note);
        if(check>0){
            return "OK";
        } else return "ERROR";
    }
}
