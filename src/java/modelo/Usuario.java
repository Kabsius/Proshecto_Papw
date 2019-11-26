/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo;
import java.sql.Connection;
import java.sql.SQLException;

import java.sql.*;

import controlador.BeanUsuario;
import java.io.IOException;
import java.io.InputStream;

import javax.servlet.http.Part;

/**
 *
 * @author Personal
 */
public class Usuario extends Conexion{
    
    public boolean agregarUsuario(BeanUsuario usuario, Part imagen) throws IOException{
  boolean agregado=false;
  Conexion con = new Conexion();
  Connection cnn;
  
  try {
  
   cnn = con.getConexion();
   PreparedStatement st = null;
       InputStream fileContent = null;

   if(con!=null){
    

    fileContent = imagen.getInputStream();
    
    st = cnn.prepareStatement("CALL Agre_usua(?,?,?,?,?,?,?,?,?)");
    st.setString(1,usuario.getNombre());
    st.setString(2,usuario.getApellidoP());
    st.setString(3,usuario.getApellidoM());
    st.setString(4,usuario.getCorreo());
    st.setInt(5,usuario.getTelefono());
    st.setInt(6,usuario.getCelular());
    st.setString(7,usuario.getNombreUsuario());
    st.setString(8,usuario.getPasswordUsuario());
    st.setBlob(9,fileContent);
   
   
    
   st.executeUpdate();
    agregado=true;
     st.close();
     
   }
   else{
       agregado=false;
   }
  
//   c.cerrarConexion();
  } catch (SQLException e) {
   
   e.printStackTrace();
  }
  return agregado;
 }
    
    public boolean loginUsuario(String nombre, String contrasenia){
        boolean entra = false;
       
        return entra;
    }
}
