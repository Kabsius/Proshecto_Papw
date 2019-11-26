/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controlador;

import com.google.gson.Gson;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
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
public class DetallePresupuestoAdmin extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
       int id = Integer.parseInt(request.getParameter("compra"));
        ResultSet prods = null;
        PreparedStatement pst =null;
        java.sql.Connection cnn = null;
        Conexion con = new Conexion();
        ArrayList<Map> listado = new ArrayList<>();
        Map <String, Object> presupuestos = new HashMap<String, Object>();
        Producto ppto;
        
         try{
            
            cnn = con.getConexion();
            
           String spAdd = "CALL spDetallePresupuestoAdmin(?);";
           pst = cnn.prepareStatement(spAdd);
           pst.setInt(1, id);
           prods = pst.executeQuery();
           if(prods != null){
               while(prods.next()){
                   ppto = new Producto();
                   presupuestos = new HashMap<String, Object>();
                   ppto.setIdProducto(prods.getInt("id_producto"));
                   ppto.setNombre(prods.getString("nombre_producto"));
                   ppto.setCantidad(prods.getInt("cantidad"));
                   ppto.setPrecio(prods.getDouble("precio"));
                   ppto.setTotal(prods.getDouble("total"));
                   presupuestos.put("producto", ppto);
                   
                   listado.add(presupuestos);
               }
               
                write(response, listado);
                        pst.close();
               
           }
         }
         catch(SQLException e){
             System.out.println(e);
         }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
    
    private void write(HttpServletResponse response,ArrayList<Map> map  )throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
            response.getWriter().write(new Gson().toJson(map));
    
        
    }

}
