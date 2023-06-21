package kr.or.nextit.attach.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.nextit.attach.vo.AttachVO;

@Mapper
public interface IAttachMapper {

	void insertAttach(AttachVO attch);

	List<AttachVO> getAttachList(@Param("atchParentNo")String boNo
			, @Param("atchCategory")String string);

	AttachVO getAttach(int atchNo);

	int increaseDownHit(int atchNo);

	void deleteAttaches(Map<String, Object> map);

	Integer getAttachNo(Map<String, Object> map);

}
