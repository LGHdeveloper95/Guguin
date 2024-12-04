package com.guguin.com.post.mapper;

import com.guguin.com.post.vo.PostVo;
import com.guguin.com.vo.ComVo;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface PostMapper {
    List<PostVo> getPostListByComid(String comid);

    int getCount();

    PostVo getPost(String recnum);

    void backupPost(PostVo post);

    List<PostVo> getBackupPostList(PostVo post);

    PostVo getBackupPost(String rec_backnum);

    void deleteBackup();

    int savePost(PostVo post);

    int updatePost(PostVo post);

    int deletePost(String recnum);

    List<PostVo> getPostList();
}
