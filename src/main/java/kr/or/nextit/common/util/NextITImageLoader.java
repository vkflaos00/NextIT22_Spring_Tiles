package kr.or.nextit.common.util;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;

import org.apache.commons.io.IOUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import kr.or.nextit.attach.service.IAttachService;
import kr.or.nextit.attach.vo.AttachVO;
import kr.or.nextit.exception.BizNotEffectedException;

//@Controller
@RestController
public class NextITImageLoader {

	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	private IAttachService attachService;
	
	/*@RequestMapping(value = "/image/{atchNo:^[0-9]+$}"
			, method = RequestMethod.GET)
	@ResponseBody
	public byte[] getImageByteArray(@PathVariable("atchNo") int atchNo) 
			throws BizNotEffectedException {
		
		AttachVO attach;
		FileInputStream fis = null;
		ByteArrayOutputStream baos = null;
		byte[] byteData = null;
		try {
			attach = attachService.getAttach(atchNo);
			String filePath = attach.getAtchPath();
			String fileName = attach.getAtchFileName();
		 
			baos = new ByteArrayOutputStream();
			fis = new FileInputStream(filePath + File.separator + fileName);
		
			byte[] readBytes = new byte[1024];
			while( fis.read(readBytes) != -1) {
				baos.write(readBytes);
			}
			byteData = baos.toByteArray();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally{
			try {fis.close();}catch(IOException e) {e.printStackTrace();}
			try {baos.close();}catch(IOException e) {e.printStackTrace();}
		}
		return byteData;
	}
	*/
	
	/*@RequestMapping(value = "/image/{atchNo:^[0-9]+$}"
			, method = RequestMethod.GET)
	@ResponseBody
	public byte[] getImageByteArray(@PathVariable("atchNo") int atchNo) 
			throws BizNotEffectedException {
		
		AttachVO attach;
		FileInputStream fis = null;
		//ByteArrayOutputStream baos = null;
		byte[] byteData = null;
		
		try {
			attach = attachService.getAttach(atchNo);
			String filePath = attach.getAtchPath();
			String fileName = attach.getAtchFileName();
		 
			//baos = new ByteArrayOutputStream();
			fis = new FileInputStream(filePath + File.separator + fileName);
		
			//byte[] readBytes = new byte[1024];
			//while( fis.read(readBytes) != -1) {
			//	baos.write(readBytes);
			//}
			//byteData = baos.toByteArray();
			
			byteData = IOUtils.toByteArray(fis);
			
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally{
			try {fis.close();}catch(IOException e) {e.printStackTrace();}
			//try {baos.close();}catch(IOException e) {e.printStackTrace();}
		}
		return byteData;
	}*/
	
	/*
	 이미지 파일은 바이너리(binary) 파일 범주에 들어갑니다
	 바이너리는 쉽게 말해서 0, 1로 구성된 데이터입니다.
	 그렇기 때문에 이미지파일을 주고 받을때 byte 배열 타입을 사용합니다.
	 그 다음 고려 대상은 @ResponseBody 와 ResponseEntity 두 가지 선택입니다.
	 @ResponseBody 와 ResponseEntity 는 응답 메시지 body에 데이터를 첨부한다는 점은 
	 동일합니다. 다만 ResponseEntity는 header와 status(상태코드)를 설정할 수 있습니다.
	 따라서 ResponseEntity를 사용할 경우 header에 해당 데이터 타입이 이미지 파일임을 명확히
	 명시하여 브라우저가 올바르게 처리할 수 있도록 합니다.
	 */
	/*@RequestMapping(value = "/image/{atchNo:^[0-9]+$}", method = RequestMethod.GET)
	//@ResponseBody
	public ResponseEntity<byte[]> getImageByteArray(@PathVariable("atchNo") int atchNo) 
			throws BizNotEffectedException {
		
		AttachVO attach;
		//FileInputStream fis = null;
		//byte[] byteData = null;
		
		ResponseEntity<byte[]> entity = null;
		
		try {
			attach = attachService.getAttach(atchNo);
			String filePath = attach.getAtchPath();
			String fileName = attach.getAtchFileName();
			String fileOriginalName = attach.getAtchOriginalName();
		 
			//fis = new FileInputStream(filePath + File.separator + fileName);
			//byteData = IOUtils.toByteArray(fis);

			fileOriginalName 
			 = fileOriginalName.substring(fileOriginalName.lastIndexOf(".")+1);
			
			MediaType mType = NextITMediaUtils.getMediaType(fileOriginalName);
			logger.info("mType : "+ mType.toString());
			
			
			HttpHeaders headers = new HttpHeaders();
			headers.add("Content-Type", mType.toString());
			
			File file = new File(filePath + File.separator + fileName);
			entity = new ResponseEntity<byte[]>(
						FileCopyUtils.copyToByteArray(file)
						, headers
						, HttpStatus.CREATED);
			
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<byte[]>(HttpStatus.BAD_REQUEST);
		//} finally{
			//try {fis.close();}catch(IOException e) {e.printStackTrace();}
		}
		//return byteData;
		return entity;
	}*/
	
	
	@RequestMapping(value = "/image/{atchNo:^[0-9]+$}", method = RequestMethod.GET)
	//@ResponseBody
	public byte[] getImageByteArray(@PathVariable("atchNo") int atchNo) 
			throws BizNotEffectedException {
		
		AttachVO attach;
		FileInputStream fis = null;
		byte[] byteData = null;
		
		try {
			attach = attachService.getAttach(atchNo);
			String filePath = attach.getAtchPath();
			String fileName = attach.getAtchFileName();
		 
			fis = new FileInputStream(filePath + File.separator + fileName);
			byteData = IOUtils.toByteArray(fis);
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally{
			try {fis.close();}catch(IOException e) {e.printStackTrace();}
		}
		return byteData;
	}
	
	
}
