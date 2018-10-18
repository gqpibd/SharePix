package utils;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;

public class Sorter {
	public static List<String> sortByValue(HashMap<String, Integer> map) {
	    List<String> sortedList = new ArrayList<>();
	    sortedList.addAll(map.keySet());
	    Collections.sort(sortedList,new Comparator<String>() {
	        public int compare(String o1,String o2) {
	            Integer v1 = map.get(o1);
	            Integer v2 = map.get(o2);     
	            return (v2).compareTo(v1);
	        }
	    });
	    //Collections.reverse(sortedList); // 주석시 오름차순
	    return sortedList;
	}
}
