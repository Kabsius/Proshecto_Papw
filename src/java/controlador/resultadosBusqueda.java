/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controlador;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import modelo.Conexion;
import modelo.Producto;

/**
 *
 * @author tonny
 */
public class resultadosBusqueda extends HttpServlet {
        PreparedStatement ps;
        ResultSet rs;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        int tipo = Integer.parseInt(request.getParameter("tipo"));
        
        Conexion con = new Conexion();
        Connection cnn;
        ArrayList<Producto> lista = new ArrayList<Producto>();
        String param = "CALL spBusquedaChida(?,?,?,?,?);";
        
       try{
           
            switch(tipo){
            case 1: //CATEGORIA POR ID
                {   
                    int cat = Integer.parseInt(request.getParameter("catId"));
                    cnn = con.getConexion();
                    ps = cnn.prepareStatement(param); 
                    ps.setInt(1, tipo);
                    ps.setInt(2, cat);
                    ps.setString(3, null);
                    ps.setString(4, null);
                     ps.setString(5, null);
                    rs = ps.executeQuery();
                     while(rs.next()){
                        Producto art = new Producto();
                        art.setIdProducto(rs.getInt("id_producto"));
                        art.setCategoria(rs.getString("categoria"));
                        art.setNombre(rs.getString("nombre_producto"));
                        art.setDescripcion(rs.getString("descripcion"));             
                        lista.add(art);
                        System.out.println(art);
                    }
                } 
                break;
            case 2: //GENERAL
                {
                    String filtro = request.getParameter("filtro");
                    if(!filtro.equals("") || filtro!=null){
                        cnn = con.getConexion();
                        ps = cnn.prepareStatement(param); 
                        ps.setInt(1, tipo);
                        ps.setInt(2, 0);
                        ps.setString(3, filtro);
                        ps.setString(4, null);
                         ps.setString(5, null);
                        rs = ps.executeQuery();
                         while(rs.next()){
                            Producto art = new Producto();
                            art.setIdProducto(rs.getInt("id_producto"));
                            art.setCategoria(rs.getString("categoria"));
                            art.setNombre(rs.getString("nombre_producto"));
                            art.setDescripcion(rs.getString("descripcion"));             
                            lista.add(art);
                            System.out.println(art);
                        }
                    }
                } 
                break;
            case 3: //POR FECHA
                {
                    String inicio = request.getParameter("inicio");
                    String fin = request.getParameter("fin");
                    if(!inicio.equals("") || inicio!=null || !fin.equals("") || fin!=null){
                        cnn = con.getConexion();
                        ps = cnn.prepareStatement(param); 
                        ps.setInt(1, tipo);
                        ps.setInt(2, 0);
                        ps.setString(3, null);
                        ps.setString(4, fin);
                         ps.setString(5, inicio);
                        rs = ps.executeQuery();
                         while(rs.next()){
                            Producto art = new Producto();
                            art.setIdProducto(rs.getInt("id_producto"));
                            art.setCategoria(rs.getString("categoria"));
                            art.setNombre(rs.getString("nombre_producto"));
                            art.setDescripcion(rs.getString("descripcion"));             
                            lista.add(art);
                            System.out.println(art);
                        }
                    }
                } 
                break;
            }
        
        
        request.setAttribute("resultados", lista);
        request.getRequestDispatcher("results.jsp").forward(request, response);
       }
       catch(Exception e){
           System.out.println(e);
       }
        
        
    }

  
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
