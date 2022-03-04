package com.example.projetmediatek;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

public class InitListener implements ServletContextListener {

/* mettre dans le web.xml
<listener>
    <listener-class>InitListener</listener-class>
</listener>
*/

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        System.out.println("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA");
        try {
            Class.forName("com.example.projetmediatek.persistance.MediathequeData");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

}