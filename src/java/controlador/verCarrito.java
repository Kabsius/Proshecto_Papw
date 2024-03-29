/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controlador;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
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
public class verCarrito extends HttpServlet {

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
            out.println("<title>Servlet verCarrito</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet verCarrito at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
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
        
        int usuario = Integer.parseInt(request.getParameter("id"));
        
        ResultSet prods = null;
        PreparedStatement pst =null;
        java.sql.Connection cnn;
        Conexion con = new Conexion();
        ArrayList<Producto> listado = new ArrayList<>();
        
        Producto item;
        
        
         try{
            
            cnn = con.getConexion();
            
           String spAdd = "CALL spDetalleSolicitud(?);";
           pst = cnn.prepareStatement(spAdd);
           pst.setInt(1, usuario);
           prods = pst.executeQuery();
           if(prods != null){
               while(prods.next()){
                   item = new Producto();
                   item.setIdProducto(prods.getInt("id_producto"));
                   item.setNombre(prods.getString("nombre_producto"));
                   item.setCantidad(prods.getInt("cantidad"));
                   item.setIdPresupuesto(prods.getInt("id_carrito"));
                   
                   
                   listado.add(item);
               }
               
               prods.close();
               request.setAttribute("detalles",listado);
                  request.getRequestDispatcher("carrito.jsp?id=" + usuario).forward(request, response);
               
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

}
