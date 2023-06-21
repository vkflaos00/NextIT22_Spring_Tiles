package kr.or.nextit.attach.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.nextit.attach.mapper.IAttachMapper;
import kr.or.nextit.attach.vo.AttachVO;
import kr.or.nextit.exception.BizNotEffectedException;

@Service
public class AttachServiceImpl implements IAttachService{

	@Autowired
	private IAttachMapper attachMapper;
	
	@Override
	public AttachVO getAttach(int atchNo) throws BizNotEffectedException {
		// TODO Auto-generated method stub
		
		AttachVO attach = attachMapper.getAttach(atchNo);
		if(attach == null) {
			throw new BizNotEffectedException();
		}
		
		return attach;
	}

	@Override
	public void increaseDownHit(int atchNo) throws BizNotEffectedException {
		// TODO Auto-generated method stub
	
		int cnt  = attachMapper.increaseDownHit(atchNo);
		if( cnt == 0) {
			throw new BizNotEffectedException();
		}
	}

}
