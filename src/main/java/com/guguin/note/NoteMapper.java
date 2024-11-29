package com.guguin.note;

import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface NoteMapper {


    List<NoteVo> getNoteList(String id, String type);

    List<NoteVo> getSendNoteList(String id, String type);

    NoteVo getNote(String note_num);

    int checkComReceiveId(String receive_id);

    int checkUserReceiveId(String receive_id);

    void insertNote(NoteVo note);

    int deleteNote(NoteVo note);

    void sendLicenseNote(NoteVo noteVo);

    void updateViewed(String note_num);
}
