package utils;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;

import dto.PdsBean;

public class CollenctionUtil {
	public static List<String> sortByValue(HashMap<String, Integer> map) { // 내림차순
	    List<String> sortedList = new ArrayList<>();
	    sortedList.addAll(map.keySet());
	    Collections.sort(sortedList,new Comparator<String>() {
	        public int compare(String o1,String o2) {
	            Integer v1 = map.get(o1);
	            Integer v2 = map.get(o2);     
	            return (v2).compareTo(v1);
	        }
	    });
	    return sortedList;
	}
	
	public static List<String> sortByValueReverse(HashMap<String, Integer> map) { // 오름차순 정렬
	    List<String> sortedList = new ArrayList<>();
	    sortedList.addAll(map.keySet());
	    Collections.sort(sortedList,new Comparator<String>() {
	        public int compare(String o1,String o2) {
	            Integer v1 = map.get(o1);
	            Integer v2 = map.get(o2);     
	            return (v1).compareTo(v2);
	        }
	    });
	    return sortedList;
	}
	
	public static HashMap<String, Integer> getHashMap(List<PdsBean> list){
		HashMap<String, Integer> map = new HashMap<>();
		for(int i=0;i<list.size();i++) {
			for(int j=0;j<list.get(i).getTags().length;j++) {
				String key = list.get(i).getTags()[j];
				if(map.containsKey(key)) {
					int value = map.get(key);
					map.put(key, value+1);
				}else {
					map.put(key, 1);
				}
			}
		}	
		return map;
	}
}
