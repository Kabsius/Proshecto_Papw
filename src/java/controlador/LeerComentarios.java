/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controlador;

import java.io.IOException;
import java.io.PrintWriter;
import com.google.gson.Gson;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import modelo.Comentario;
import modelo.Conexion;

/**
 *
 * @author tonny
 */
public class LeerComentarios extends HttpServlet {

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
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        int id = Integer.parseInt(request.getParameter("producto"));
        
        ResultSet comments = null;
        PreparedStatement pst =null;
        Connection cnn = null;
        Conexion con = new Conexion();
        ArrayList<Map> comentarios = new ArrayList<>();
        Map <String, Object> mensajes = new HashMap<String, Object>();
        Comentario rd;
        try{
            
            cnn = con.getConexion();
            
           String spAdd = "CALL spVerComentarios(?);";
           pst = cnn.prepareStatement(spAdd);
           pst.setInt(1, id);
           
           comments = pst.executeQuery();
           
           if(comments!=null){
               while(comments.next()){
                    mensajes = new HashMap<String, Object>();
                    rd = new Comentario();
                    rd.setNickname(comments.getString("nombreUsuario"));
                     rd.setFecha(comments.getString("coment_date"));
                     rd.setComentario(comments.getString("comentario"));
                  
                    mensajes.put("Comentario",rd);
               
                   comentarios.add(mensajes);
                    
               }
               
                write(response, comentarios);
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
