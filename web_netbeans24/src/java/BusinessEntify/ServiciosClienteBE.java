package BusinessEntify;

import java.math.BigDecimal;
import java.sql.Date;
import java.sql.Timestamp;

public class ServiciosClienteBE {

    private int id_servicio_cliente;
    private int id_cliente;
    private int id_servicio;
    private Integer id_personal_asignado;  // Personal opcional
    private Integer id_venta;              // Se llena al contratar
    private Timestamp fecha_contratacion;  // Fecha y hora exactas
    private Date fecha_inicio;             // Inicio del servicio
    private Date fecha_fin;                // Fin estimado o real
    private String estado;                 // Cotización, Contratado, etc.
    private BigDecimal precio_final;       // Precio acordado
    private String detalles;               // Descripción o condiciones adicionales
    private Integer calificacion;          // Puede ser null si no hay calificación
    private String comentarios;            // Comentarios del cliente

    // Constructor vacío
    public ServiciosClienteBE() {}

    // Getters y Setters
    public int getId_servicio_cliente() {
        return id_servicio_cliente;
    }

    public void setId_servicio_cliente(int id_servicio_cliente) {
        this.id_servicio_cliente = id_servicio_cliente;
    }

    public int getId_cliente() {
        return id_cliente;
    }

    public void setId_cliente(int id_cliente) {
        this.id_cliente = id_cliente;
    }

    public int getId_servicio() {
        return id_servicio;
    }

    public void setId_servicio(int id_servicio) {
        this.id_servicio = id_servicio;
    }

    public Integer getId_personal_asignado() {
        return id_personal_asignado;
    }

    public void setId_personal_asignado(Integer id_personal_asignado) {
        this.id_personal_asignado = id_personal_asignado;
    }

    public Integer getId_venta() {
        return id_venta;
    }

    public void setId_venta(Integer id_venta) {
        this.id_venta = id_venta;
    }

    public Timestamp getFecha_contratacion() {
        return fecha_contratacion;
    }

    public void setFecha_contratacion(Timestamp fecha_contratacion) {
        this.fecha_contratacion = fecha_contratacion;
    }

    public Date getFecha_inicio() {
        return fecha_inicio;
    }

    public void setFecha_inicio(Date fecha_inicio) {
        this.fecha_inicio = fecha_inicio;
    }

    public Date getFecha_fin() {
        return fecha_fin;
    }

    public void setFecha_fin(Date fecha_fin) {
        this.fecha_fin = fecha_fin;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public BigDecimal getPrecio_final() {
        return precio_final;
    }

    public void setPrecio_final(BigDecimal precio_final) {
        this.precio_final = precio_final;
    }

    public String getDetalles() {
        return detalles;
    }

    public void setDetalles(String detalles) {
        this.detalles = detalles;
    }

    public Integer getCalificacion() {
        return calificacion;
    }

    public void setCalificacion(Integer calificacion) {
        this.calificacion = calificacion;
    }

    public String getComentarios() {
        return comentarios;
    }

    public void setComentarios(String comentarios) {
        this.comentarios = comentarios;
    }

    public void setCantidad(Integer value) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
}
