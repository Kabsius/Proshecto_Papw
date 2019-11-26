/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controlador;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import modelo.Conexion;

/**
 *
 * @author tonny
 */

@MultipartConfig( fileSizeThreshold=1024*1024,
    maxFileSize=1024*1024*5, maxRequestSize=1024*1024*5*5)
public class NuevoProducto extends HttpServlet {

    Conexion con = new Conexion();
    Connection cnn;
    PreparedStatement ps;
    ResultSet rs;
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
        
        String nombre = request.getParameter("nombreP");
        String descripcion = request.getParameter("descP");
        double ofert = Double.parseDouble(request.getParameter("ofertaP"));
        double precio = Double.parseDouble(request.getParameter("precioP"));
        int unidades = Integer.parseInt(request.getParameter("unidadesP"));
        int categoria =Integer.parseInt(request.getParameter("categoriaP"));
         
        
       Part video = request.getPart("videoP");
       
       Part img1 = request.getPart("foto");
       Part img2 = request.getPart("foto2");
       Part img3 = request.getPart("foto3");
       
      String path = request.getServletContext().getRealPath("/");
        File fileSaveDir = new File(path + "/videosArticulo");
        if(!fileSaveDir.exists()){
            fileSaveDir.mkdir();
        }
        
         String contentType = video.getContentType();
         String videoName = "video" + System.currentTimeMillis() + ".mp4";
         String save = "videosArticulo/" + videoName;
         video.write(path+ "videosArticulo/" +  videoName);
         
         
               

         
         
        PreparedStatement pst = null;
        rs = null;
         try{
             
             InputStream imgUno = null;
            InputStream imgDos = null;
             InputStream imgTres = null;
            // InputStream videito = null;
             
             imgUno = img1.getInputStream();
             imgDos = img2.getInputStream();
             imgTres = img3.getInputStream();
            // videito = video.getInputStream();
             
           cnn = con.getConexion();
           String spAdd = "CALL agre_prod(?,?,?,?,?,?,?,?,?,?,?)";
           pst = cnn.prepareStatement(spAdd);
           pst.setInt(1,1);
           pst.setInt(2, categoria);
           pst.setString(3, nombre);
           pst.setInt(4, unidades);
           pst.setDouble(5, precio);
           pst.setDouble(6, ofert);
           pst.setString(7, save);
           pst.setBlob(8, imgUno);
           pst.setBlob(9, imgDos);
           pst.setBlob(10, imgTres);
           pst.setString(11, descripcion);
           
          
          pst.execute();
              
          
          try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<script>alert('Producto agregado! :D');</script>");
             response.sendRedirect("adm_usua.jsp");
             // request.getRequestDispatcher("adm_usua.jsp").forward(request, response);
          }
          
             
                         
          
          rs.close();
        
          
       }catch(Exception e){
           System.err.println("Error" + e);
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
