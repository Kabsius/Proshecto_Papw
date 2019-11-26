/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package vista;
/**
 * 
 * @author Personal
 */


import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;

import modelo.Usuario;

import controlador.BeanUsuario;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.Part;


@MultipartConfig(maxFileSize= 18481581*8)


public class ServletRegistro extends HttpServlet {
 //private static final Int serialVersionUID = 1L;

    public ServletRegistro() {
    }

@Override

 protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
  String nombre=request.getParameter("nombre");
  String apellidoP=request.getParameter("apellidoP");
  String apellidoM=request.getParameter("apellidoM");
  String correo=request.getParameter("correo");
  int telefono = Integer.parseInt(request.getParameter("telefono"));
  int celular = Integer.parseInt(request.getParameter("celular"));
  String nombreUsuario=request.getParameter("nombreUsuario");
  String passwordUsuario=request.getParameter("passwordUsuario");

  Part imagen_usuario= request.getPart("imagen_usuario"); //Aqui recibe el inpute file
//String fileName= Paths.get(imagen_usuario.getSubmittedFileName()).getFileName().toString();
//String imagen_usuario=request.getParameter("imagen_usuario");
  int  presupuesto=48668;
  int nivel= 1;
  


  /*if(!nombre.equalsIgnoreCase("") && !apellidoP.equalsIgnoreCase("") && !apellidoM.equalsIgnoreCase("")&& !correo.equalsIgnoreCase("") && !telefono.equalsIgnoreCase("") && !celular.equalsIgnoreCase("") && !nombreUsuario.equalsIgnoreCase("")
  && !passwordUsuario.equalsIgnoreCase("") && !imagen_usuario.equalsIgnoreCase("") && !presupuesto.equalsIgnoreCase("") && !nivel.equalsIgnoreCase("")){
  */ 


    
  /*BeanUsuario busuario=   new BeanUsuario
        (nombre, apellidoP, apellidoM, correo, 
          telefono, celular, nombreUsuario, passwordUsuario, presupuesto, nivel);*/
  
  BeanUsuario busuario = new BeanUsuario();
  Usuario user = new Usuario();
  
  busuario.setNombre(nombre);
  busuario.setApellidoP(apellidoP);
  busuario.setApellidoM(apellidoM);
  busuario.setCorreo(correo);
  busuario.setTelefono(telefono);
  busuario.setCelular(celular);
  busuario.setNombreUsuario(nombreUsuario);
  busuario.setPasswordUsuario(passwordUsuario);
  busuario.setPresupuesto(presupuesto);
  busuario.setNivel(nivel);
  
    
   
   if(user.agregarUsuario(busuario, imagen_usuario)){
    request.getRequestDispatcher("ini_ses.jsp").forward(request, response);
   }else{
    PrintWriter out=response.getWriter();
    out.println("Si estas viendo este mensaje es por que algo salio mal, no se pudo completar tu solicitud.");
   }
  /*}
  else{
       PrintWriter out=response.getWriter();
    out.println("Si estas viendo este mensaje es por que algo salio mal, no se pudo completar tu solicitud.");
   
  }*/
 }
}
