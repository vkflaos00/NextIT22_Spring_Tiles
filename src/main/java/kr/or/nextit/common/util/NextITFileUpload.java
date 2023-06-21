package kr.or.nextit.common.util;

import java.io.File;
import java.io.IOException;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import kr.or.nextit.attach.vo.AttachVO;

@Component
public class NextITFileUpload {	

	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	public List<AttachVO> fileUpload(
				MultipartFile[] boFiles
				, String category
				, String path) throws IllegalStateException, IOException {
		// TODO Auto-generated method stub
		
		List<AttachVO> attachList = new ArrayList<AttachVO>();
		
		if(boFiles.length >0 ) {
			for(MultipartFile boFile : boFiles) {
				if(!boFile.isEmpty()) {
					AttachVO attach = getAttachInfoAndFileUpload(boFile ,category ,path );
					attachList.add(attach);	
				}
			}
		}
		return attachList;
	}
	
	@Value("#{util['file.upload.path']}")
	private String uploadPath;
	

	private AttachVO getAttachInfoAndFileUpload(MultipartFile boFile, String category, String path) throws IllegalStateException, IOException {
		// TODO Auto-generated method stub
		
		//리눅스
		//String filePath = "/home/ssam/upload/" + path;
		//윈도우 
		//String filePath = "C:/ssam/upload/"+ path;
		
		//uploadPath = null;
		
		String filePath = uploadPath + File.separator + path;
		String fileName = UUID.randomUUID().toString();
		
		logger.info("filePath + fileName : " + filePath + File.separator + fileName);
		
		File saveFile = new File(filePath + File.separator + fileName);
		if(!saveFile.getParentFile().exists()) {
			saveFile.getParentFile().mkdirs();//해당 폴더가 없으면 폴더 만들기
		}
		boFile.transferTo(saveFile);
		
		//파일 정보를 취득해서 AttachVO에 담기
		AttachVO attach = new AttachVO();
		attach.setAtchCategory(category);//FREE
		attach.setAtchFileName(fileName);//5b20326a-3e05-4718-a8af-dc694b38cfc7
		attach.setAtchOriginalName(boFile.getOriginalFilename());//nextit.txt
		attach.setAtchFileSize(boFile.getSize()); //1024
		attach.setAtchConvertSize(convertSize(boFile.getSize())); // 1MB
		attach.setAtchContentType(boFile.getContentType());// txt, jpg
		attach.setAtchPath(filePath);
		
		
		//return null;
		return attach ;
	}
	
	private DecimalFormat df = new DecimalFormat("#,###.0");
	
	private String convertSize(long size) {
		// TODO Auto-generated method stub
		
		if(size<1024) {
			return size + " Byte";
			
		}else if(size < (1024 * 1024) ) {
			return df.format(size /1024.0) + " KB";
			
		}else if(size < (1024 * 1024 * 1024) ) {
			return df.format(size /( 1024.0 * 1024.0 ) ) + " MB";
		}else {
			return df.format(size /( 1024.0 * 1024.0 * 1024.0 ) ) + " GB";
		}
		
		//return null;
	}

}
