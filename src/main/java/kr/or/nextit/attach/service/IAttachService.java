package kr.or.nextit.attach.service;

import kr.or.nextit.attach.vo.AttachVO;
import kr.or.nextit.exception.BizNotEffectedException;

public interface IAttachService {

	AttachVO getAttach(int atchNo) throws BizNotEffectedException;

	void increaseDownHit(int atchNo) throws BizNotEffectedException;

}
