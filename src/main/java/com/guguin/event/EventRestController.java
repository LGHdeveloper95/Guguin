package com.guguin.event;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jdk.jfr.Event;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
public class EventRestController {
    @Autowired
    private EventMapper eventMapper;

    @GetMapping("/event/get/{id}")
    public ResponseEntity<List<EventVo>> getList(@PathVariable("id") String id){
        List<EventVo> eventList = eventMapper.getEventList(id);
        ResponseEntity<List<EventVo>> result = (eventList!=null)? ResponseEntity.status(HttpStatus.OK).body(eventList):
                ResponseEntity.status(HttpStatus.BAD_REQUEST).build();
        return result;
    }

    @GetMapping("/event/user/note/{id}")
    public ResponseEntity<String> getUserNoteCount(@PathVariable("id") String id){
        String count = eventMapper.getUserNoteCount(id);
        ResponseEntity<String> result = (count!=null)? ResponseEntity.status(HttpStatus.OK).body(count):
                ResponseEntity.status(HttpStatus.BAD_REQUEST).build();
        return result;
    }


    @GetMapping("/event/com/note/{id}")
    public ResponseEntity<String> getComNoteCount(@PathVariable("id") String id){
        String count = eventMapper.getComNoteCount(id);
        ResponseEntity<String> result = (count!=null)? ResponseEntity.status(HttpStatus.OK).body(count):
                ResponseEntity.status(HttpStatus.BAD_REQUEST).build();
        return result;
    }

    @PatchMapping("/event/viewed/{alnum}")
    public void updateViewed(@PathVariable("alnum") String alnum){
        eventMapper.updateViewed(alnum);
    }
    @DeleteMapping("/event/delete/{alnum}")
    public void deleteEvent(@PathVariable("alnum") String alnum){
        eventMapper.deleteEvent(alnum);
    }
}
