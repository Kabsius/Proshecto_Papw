/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.http.HttpServletResponse;


public class Imagen {
    Conexion con = new Conexion();
    Connection cnn;
    PreparedStatement ps;
    ResultSet rs;

    public Imagen() {
    }
    
    
    
    public void verImagen(int id, int tipo, int numero, HttpServletResponse response){
        String query = "CALL spGetImage(?,?,?);";
        InputStream is = null;
        OutputStream os = null;
        BufferedInputStream bis = null;
        BufferedOutputStream bos = null;
        response.setContentType("image/*");

        try{
                    String columna = "imagen_usuario";
        if(tipo > 1){
            columna = "imagen_usuario";
        }
        else{
            switch(numero){
                case 1: columna = "imagen"; break;
                case 2: columna = "imagen2"; break;
                case 3: columna = "imagen3"; break;
            }
        }
            os = response.getOutputStream();
            cnn = con.getConexion();
            ps = cnn.prepareStatement(query); 
            ps.setInt(1, id);
            ps.setInt(2, tipo);
            ps.setInt(3, numero);
            rs = ps.executeQuery();
            if(rs.next()){
                is = rs.getBinaryStream(columna);
            }
            bis = new BufferedInputStream(is);
            bos = new BufferedOutputStream (os);
            int i = 0;
            while((i = bis.read())!= -1){
                bos.write(i);
            }
            
        }catch(Exception e){

        }
    }



 public void verVideo(int id, HttpServletResponse response){
        String query = "CALL spGetVideo(?);";
        InputStream is = null;
        OutputStream os = null;
        BufferedInputStream bis = null;
        BufferedOutputStream bos = null;
        response.setContentType("video/mp4");

        try{
                   
            os = response.getOutputStream();
            cnn = con.getConexion();
            ps = cnn.prepareStatement(query); 
            ps.setInt(1, id);
            rs = ps.executeQuery();
            if(rs.next()){
                is = rs.getBinaryStream("video");
            }
            bis = new BufferedInputStream(is);
            bos = new BufferedOutputStream (os);
            int i = 0;
            while((i = bis.read())!= -1){
                bos.write(i);
            }
            
        }catch(Exception e){

        }
    }
}
