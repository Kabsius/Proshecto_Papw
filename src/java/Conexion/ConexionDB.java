/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Conexion;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;



public class ConexionDB {
    
    private String USERNAME = "root"; // TU USUARIO DE MYSQL
    private String PASSWORD = "12345";  // TU CONTRASEÑA DE MYSQL
    private String HOST = "localhost";
    private String PORT = "3306";
    private String DATABASE = "papw"; // EL NOMBRE DE TU BASE DE DATOS
    private String CLASSNAME = "com.mysql.jdbc.Driver";
    private String URL = "jdbc:mysql://"+HOST+":"+PORT+"/"+DATABASE + "?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC";
    
    Connection conn;
    
    public ConexionDB() {
        
        try{
            Class.forName(CLASSNAME);
            conn = DriverManager.getConnection(URL, USERNAME, PASSWORD);
          
        }
        catch(ClassNotFoundException | SQLException e){
            System.err.println("Error" +  e);
        }
    }
    
    
    public Connection getConexion(){
        return conn;
    }
    
}
