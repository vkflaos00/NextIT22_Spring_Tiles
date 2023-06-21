package kr.or.nextit.common.util;

import java.util.HashMap;
import java.util.Map;

import org.springframework.http.MediaType;

public class NextITMediaUtils {

	private static Map<String, MediaType> mediaMap;
	
	static {
		mediaMap = new HashMap<String, MediaType>();
		mediaMap.put("JPG", MediaType.IMAGE_JPEG);
		mediaMap.put("JPEG", MediaType.IMAGE_JPEG);
		mediaMap.put("GIF", MediaType.IMAGE_GIF);
		mediaMap.put("PNG", MediaType.IMAGE_PNG);
	}
	
	public static MediaType getMediaType(String type) {
		// TODO Auto-generated method stub
	
		//return null;
		return mediaMap.get(type.toUpperCase());
	}

}
