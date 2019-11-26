/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author tonny
 */
public class cboCategorias extends Conexion{
    
     public ResultSet categorias () throws SQLException{
        ResultSet rs;
        String pList = "SELECT id_categoria, categoria FROM categoria ORDER BY id_categoria ASC";
       
           
        PreparedStatement pst = getConexion().prepareStatement(pList);
        return rs = pst.executeQuery();

    }
    
}
