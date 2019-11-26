/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controlador;
import java.io.File;
;
/**
 *
 * @author Personal
 */
public class BeanUsuario {

 private String nombre;
 private String apellidoP;
 private String apellidoM;
 private String correo;
 private int telefono;
 private int  celular;
 private String nombreUsuario;
 private String passwordUsuario;
 private File imagen_usuario;
 private int presupuesto;
 private int nivel;
 
 
 public String getNombre() {
  return nombre;
 }
 public void setNombre(String nombre) {
  this.nombre = nombre;
 }
 public String getApellidoP() {
  return apellidoP;
 }
  
 public void setApellidoP(String apellidoP) {
  this.apellidoP = apellidoP;
 }
 public String getApellidoM() {
  return apellidoM;
 }
 
 public void setApellidoM(String apellidoM) {
  this.apellidoM = apellidoM;
 }
 public String getCorreo() {
  return correo;
 }
 public void setCorreo(String correo) {
  this.correo = correo;
 }
 public int getTelefono() {
  return telefono;
 }
 public void setTelefono(int telefono) {
  this.telefono = telefono;
 }
 public int getCelular() {
  return celular;
 }
 public void setCelular(int celular) {
  this.celular = celular;
 }
 
  public String getNombreUsuario() {
  return nombreUsuario;
 }
 public void setNombreUsuario(String nombreUsuario) {
  this.nombreUsuario = nombreUsuario;
 }
  public String getPasswordUsuario() {
  return passwordUsuario;
 }
 public void setPasswordUsuario(String passwordUsuario) {
  this.passwordUsuario = passwordUsuario;
 }
  public File getImagen_usuario() {
  return imagen_usuario;
 }
 public void setImagen_usuario(File imagen_usuario) {
  this.imagen_usuario = imagen_usuario;
 }
 
  public int getPresupuesto() {
  return presupuesto;
 }
 public void setPresupuesto(int presupuesto) {
  this.presupuesto = presupuesto;
 }
 
  public int getNivel() {
  return nivel;
 }
  public void setNivel(int nivel) {
  this.nivel = nivel;
 }
  
 public BeanUsuario(String nombre, String apellidoP, String apellidoM,
   String correo, int telefono, int celular, String nombreUsuario,
   String passwordUsuario,int presupuesto,
   int nivel) {
 
  this.nombre = nombre;
  this.apellidoP = apellidoP;
  this.apellidoM = apellidoM;
  this.correo = correo;
  this.telefono = telefono;
  this.celular = celular;
  this.nombreUsuario = nombreUsuario;

  this.presupuesto = presupuesto;
  this.nivel = nivel;
  
 }
 
 public BeanUsuario(){
     
 }
}
