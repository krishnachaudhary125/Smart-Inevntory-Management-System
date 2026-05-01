package com.example.project.util;

import java.util.List;

public class ExponentialSmoothing {

    public static double forecast(List<Integer> sales, double alpha){

        if(sales == null || sales.isEmpty())
            return 0;

        double forecast = sales.get(0);

        for(int i=1;i<sales.size();i++){

            forecast = alpha * sales.get(i)
                    + (1 - alpha) * forecast;
        }

        return forecast;
    }
}