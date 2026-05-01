package com.example.project.util;

import java.util.*;

public class Apriori {

    public static Map<String,String> findPairs(List<List<String>> transactions){

        Map<String,Integer> pairCount = new HashMap<>();

        for(List<String> t : transactions){

            for(int i=0;i<t.size();i++){

                for(int j=i+1;j<t.size();j++){

                    String key = t.get(i) + "-" + t.get(j);

                    pairCount.put(key,
                            pairCount.getOrDefault(key,0)+1);
                }
            }
        }

        Map<String,String> result = new HashMap<>();

        for(String pair : pairCount.keySet()){

            String[] p = pair.split("-");

            result.put(p[0],p[1]);
        }

        return result;
    }
}