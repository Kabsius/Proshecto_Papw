/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controlador;

import com.google.gson.Gson;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
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
import modelo.Presupuesto;
import modelo.Producto;

/**
 *
 * @author tonny
 */
public class getPresupuestos extends HttpServlet {

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
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet getPresupuestos</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet getPresupuestos at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

      @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
       ResultSet prods = null;
        PreparedStatement pst =null;
        Connection cnn = null;
        Conexion con = new Conexion();
        ArrayList<Map> listado = new ArrayList<>();
        Map <String, Object> presupuestos = new HashMap<String, Object>();
        Presupuesto ppto;
        
         try{
            
            cnn = con.getConexion();
            
           String spAdd = "CALL spPrespuestos();";
           pst = cnn.prepareStatement(spAdd);
           prods = pst.executeQuery();
           if(prods != null){
               while(prods.next()){
                   ppto = new Presupuesto();
                   presupuestos = new HashMap<String, Object>();
                   ppto.setId(prods.getInt("id_carrito"));
                   ppto.setUsuario(prods.getString("nombreUsuario"));
                   ppto.setIdUsuario(prods.getInt("id_Usuario"));
                   ppto.setUsuario(prods.getString("estado"));
                   ppto.setFecha(prods.getString("fecha"));
                   presupuestos.put("presupuesto", ppto);
                   
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
        int id = Integer.parseInt(request.getParameter("user"));
        ResultSet prods = null;
        PreparedStatement pst =null;
        Connection cnn = null;
        Conexion con = new Conexion();
        ArrayList<Map> listado = new ArrayList<>();
        Map <String, Object> presupuestos = new HashMap<String, Object>();
        Presupuesto ppto;
        
         try{
            
            cnn = con.getConexion();
            
           String spAdd = "CALL spPrespuestos(?);";
           pst = cnn.prepareStatement(spAdd);
           pst.setInt(1, id);
           prods = pst.executeQuery();
           if(prods != null){
               while(prods.next()){
                   ppto = new Presupuesto();
                   presupuestos = new HashMap<String, Object>();
                   ppto.setId(prods.getInt("id_carrito"));
                   ppto.setUsuario(prods.getString("nombreUsuario"));
                   ppto.setIdUsuario(prods.getInt("id_Usuario"));
                   ppto.setEstado(prods.getString("estado"));
                   ppto.setFecha(prods.getString("fecha"));
                   presupuestos.put("presupuesto", ppto);
                   
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
