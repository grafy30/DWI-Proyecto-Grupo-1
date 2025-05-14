package BusinessEntify;
public class ServiciosBE {
    private int id_servicio;
    private String nombre_servicio;
    private String descripcion;
    private String duracion_estimada;
    private int costo_estimado;
    private String estado;
    
    // Constructor    
    public ServiciosBE() {
    }
    
    // Getters y setters

    public int getId_servicio() {
        return id_servicio;
    }

    public void setId_servicio(int id_servicio) {
        this.id_servicio = id_servicio;
    }

    public String getNombre_servicio() {
        return nombre_servicio;
    }

    public void setNombre_servicio(String nombre_servicio) {
        this.nombre_servicio = nombre_servicio;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public String getDuracion_estimada() {
        return duracion_estimada;
    }

    public void setDuracion_estimada(String duracion_estimada) {
        this.duracion_estimada = duracion_estimada;
    }

    public int getCosto_estimado() {
        return costo_estimado;
    }

    public void setCosto_estimado(int costo_estimado) {
        this.costo_estimado = costo_estimado;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }            
}
