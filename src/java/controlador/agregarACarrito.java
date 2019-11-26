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
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import modelo.Conexion;

/**
 *
 * @author tonny
 */
public class agregarACarrito extends HttpServlet {

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
        int idUsuario = Integer.parseInt(request.getParameter("usuario"));
         int idProducto = Integer.parseInt(request.getParameter("producto"));
        int cantidad = Integer.parseInt( request.getParameter("cantidad"));
         
        Conexion con = new Conexion();
        java.sql.Connection cnn;
        PreparedStatement pst;
        ResultSet rs;
        
         pst = null;
        rs = null;
         try{
             
        
             
           cnn = con.getConexion();
           String spAdd = "CALL spAgregarCarrito(?,?,?);";
           pst = cnn.prepareStatement(spAdd);
           pst.setInt(1, idUsuario);
           pst.setInt(2, idProducto);
           pst.setInt(3, cantidad );
          
           
          
          pst.executeUpdate();
              
          
            
                         
          
          rs.close();
        
          
       }catch(Exception e){
           System.err.println("Error" + e);
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

}
