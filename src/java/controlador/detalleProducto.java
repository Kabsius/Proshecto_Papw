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
import java.sql.SQLException;
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
public class detalleProducto extends HttpServlet {

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
        // processRequest(request, response);
        int id_producto = Integer.parseInt(request.getParameter("id"));
        
        ResultSet rs;
        PreparedStatement pst;
        Producto pdto;
         Conexion con = new Conexion();
        Connection cnn;
        
        try{
            
             pst = null;
             rs=null;
             cnn = con.getConexion();
             
             if(cnn != null){
                 
                    pst = cnn.prepareStatement("CALL spDetallesArticulo(?);");
                    pst.setInt(1,id_producto);
                    rs = pst.executeQuery();
                 
                    if(rs!=null)
                    {
                        pdto = new Producto();
                        while(rs.next()){
                            pdto.setNombre(rs.getString("nombre_producto"));
                            pdto.setDescripcion(rs.getString("descripcion"));
                            pdto.setPrecio(rs.getDouble("precio"));
                            pdto.setOferta(rs.getDouble("oferta"));
                            pdto.setValoracion(rs.getDouble("valoracion"));
                            pdto.setCantidad(rs.getInt("cantidad"));
                            pdto.setCategoria(rs.getString("categoria"));
                            pdto.setIdProducto(rs.getInt("id_producto"));
                            pdto.setRutaVideo(rs.getString("video"));
                            
                        }  
                        
                         rs.close();
                        request.setAttribute("producto", pdto);
                        //response.sendRedirect("index.jsp?activo=true");
                
                        request.getRequestDispatcher("art_det.jsp?id=" + id_producto).forward(request, response);
                       
                        
                    }
                    else{
                         rs.close();
                         response.sendRedirect("index.jsp");
                    }
             }
        }
        catch(SQLException e){
            e.printStackTrace();
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

}
