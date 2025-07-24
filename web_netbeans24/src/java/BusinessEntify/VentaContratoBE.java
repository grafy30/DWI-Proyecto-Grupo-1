package BusinessEntify;

import java.math.BigDecimal;
import java.sql.Date;
import java.util.List;

/**
 * Representa un contrato de venta con su información general y los servicios asociados.
 */
public class VentaContratoBE {

    private int id_venta;
    private String nombre;
    private String descripcion;
    private String ubicacion;
    private Date fecha_inicio;
    private Date fecha_fin;
    private String estado;
    private Integer cliente_id;
    private BigDecimal presupuesto;

    // Lista de servicios contratados (opcional)
    private List<ServiciosClienteBE> serviciosClienteBE;

    // Constructor vacío
    public VentaContratoBE() {}

    // Getters y Setters
    public int getId_venta() {
        return id_venta;
    }

    public void setId_venta(int id_venta) {
        this.id_venta = id_venta;
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

    public String getUbicacion() {
        return ubicacion;
    }

    public void setUbicacion(String ubicacion) {
        this.ubicacion = ubicacion;
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

    public Integer getCliente_id() {
        return cliente_id;
    }

    public void setCliente_id(Integer cliente_id) {
        this.cliente_id = cliente_id;
    }

    public BigDecimal getPresupuesto() {
        return presupuesto;
    }

    public void setPresupuesto(BigDecimal presupuesto) {
        this.presupuesto = presupuesto;
    }

    public List<ServiciosClienteBE> getServiciosClienteBE() {
        return serviciosClienteBE;
    }

    public void setServiciosClienteBE(List<ServiciosClienteBE> serviciosClienteBE) {
        this.serviciosClienteBE = serviciosClienteBE;
    }
}
