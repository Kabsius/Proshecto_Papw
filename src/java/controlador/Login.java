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
import javax.servlet.http.HttpSession;
import modelo.Conexion;
import modelo.Sesion;

/**
 *
 * @author tonny
 */
public class Login extends HttpServlet {

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

        
        String usuario = request.getParameter("nombre");
        String passw = request.getParameter("password");
        
         Conexion con = new Conexion();
  Connection cnn;
  
  try {
    

    
     PreparedStatement st = null;
     ResultSet rs=null;
   cnn = con.getConexion();
Sesion actual = new Sesion();

   if(con!=null){

    st = cnn.prepareStatement("CALL ini_ses(?,?);");
    st.setString(1,usuario);
    st.setString(2,passw);

   
    
   rs = st.executeQuery();
   
   
   if(rs!=null)
   {
       
       while(rs.next()){
       actual.setIdUsuario(rs.getInt("id_Usuario"));
       actual.setNombreUs(rs.getString("nombre"));
       actual.setApellidoP(rs.getString("apellidoP"));
       actual.setApellidoP(rs.getString("apellidoM"));
       actual.setNombreUsuario(rs.getString("nombreUsuario"));
       actual.setCorreo(rs.getString("correo"));
   }
   
       System.out.println(actual.getNombreUsuario());
       
         HttpSession misession= request.getSession();
         misession.setAttribute("usuario", actual);
              
                //request.setAttribute("usuario", actual);
                //response.sendRedirect("index.jsp?activo=true");
                
         request.getRequestDispatcher("/Index").forward(request, response);
   }
   
     st.close();
     
     
   }
   else{
     
   }
  
//   c.cerrarConexion();
  } catch (SQLException e) {
   
   e.printStackTrace();
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
