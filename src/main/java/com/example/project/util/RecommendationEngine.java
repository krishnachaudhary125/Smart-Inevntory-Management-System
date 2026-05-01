package com.example.project.util;

import java.util.*;

public class RecommendationEngine {

    public static Map<String,String> recommend(List<List<String>> transactions){

        Map<String,Integer> pairCount = new HashMap<>();
        Map<String,Integer> productCount = new HashMap<>();

        int totalTransactions = transactions.size();

        /* COUNT PRODUCTS AND PAIRS */

        for(List<String> transaction : transactions){

            Set<String> uniqueProducts = new HashSet<>(transaction);

            for(String product : uniqueProducts){
                productCount.put(product,
                        productCount.getOrDefault(product,0)+1);
            }

            List<String> list = new ArrayList<>(uniqueProducts);

            for(int i=0;i<list.size();i++){

                for(int j=i+1;j<list.size();j++){

                    String key = list.get(i)+"|"+list.get(j);

                    pairCount.put(key,
                            pairCount.getOrDefault(key,0)+1);
                }
            }
        }

        /* FIND BEST RECOMMENDATIONS */

        Map<String,String> recommendations = new HashMap<>();

        for(String pair : pairCount.keySet()){

            String[] products = pair.split("\\|");

            String A = products[0];
            String B = products[1];

            int pairSupport = pairCount.get(pair);

            double support =
                    pairSupport / (double) totalTransactions;

            double confidence =
                    pairSupport / (double) productCount.get(A);

            /* MINIMUM THRESHOLDS */

            if(support >= 0.2 && confidence >= 0.5){

                recommendations.put(A,B);
            }
        }

        return recommendations;
    }
}