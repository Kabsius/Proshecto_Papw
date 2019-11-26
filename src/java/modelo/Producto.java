/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo;

/**
 *
 * @author tonny
 */
public class Producto {
    
    private int idProducto;
    private int idCategoria;
    private int cantidad;
    private String nombre;
    private String descripcion;
    private double precio;
    private double oferta;
    private double valoracion;
    private String categoria;
    private String rutaVideo;
    private String fecha;
    private double total;
    private int idPresupuesto;

    public int getIdPresupuesto() {
        return idPresupuesto;
    }

    public void setIdPresupuesto(int idPresupuesto) {
        this.idPresupuesto = idPresupuesto;
    }

    public double getTotal() {
        return total;
    }

    public void setTotal(double total) {
        this.total = total;
    }
    

    public Producto() {
    }

    public String getFecha() {
        return fecha;
    }

    public void setFecha(String fecha) {
        this.fecha = fecha;
    }

    
    public Producto(int idProducto, int idCategoria, int cantidad, String nombre, String descripcion, double precio, double oferta, double valoracion) {
        this.idProducto = idProducto;
        this.idCategoria = idCategoria;
        this.cantidad = cantidad;
        this.nombre = nombre;
        this.descripcion = descripcion;
        this.precio = precio;
        this.oferta = oferta;
        this.valoracion = valoracion;
    }

    public String getRutaVideo() {
        return rutaVideo;
    }

    public void setRutaVideo(String rutaVideo) {
        this.rutaVideo = rutaVideo;
    }
    
    

    public int getIdProducto() {
        return idProducto;
    }

    public void setIdProducto(int idProducto) {
        this.idProducto = idProducto;
    }

    public int getIdCategoria() {
        return idCategoria;
    }

    public void setIdCategoria(int idCategoria) {
        this.idCategoria = idCategoria;
    }

    public int getCantidad() {
        return cantidad;
    }

    public void setCantidad(int cantidad) {
        this.cantidad = cantidad;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public double getPrecio() {
        return precio;
    }

    public void setPrecio(double precio) {
        this.precio = precio;
    }

    public double getOferta() {
        return oferta;
    }

    public void setOferta(double oferta) {
        this.oferta = oferta;
    }

    public double getValoracion() {
        return valoracion;
    }

    public void setValoracion(double valoracion) {
        this.valoracion = valoracion;
    }

    public String getCategoria() {
        return categoria;
    }

    public void setCategoria(String categoria) {
        this.categoria = categoria;
    }
    

    
}
