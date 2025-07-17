package BusinessEntify;

/**
 * Entidad de negocio para los servicios y los pedidos de clientes.
 * Compatible con las tablas y procedimientos definidos en servicios_functions.sql.
 * Lista y registra servicios, así como pedidos de clientes para su atención.
 */
public class ServiciosBE {
    // Campos del catálogo de servicios
    private int id_servicio;
    private int id_categoria;
    private String nombre_servicio;
    private String descripcion;
    private double precio_base;
    private int duracion_estimada; // en días
    private String imagen; // Puede ser ruta, nombre de icono o Base64
    private String estado;

    // Campos para el pedido del cliente/usuario (servicios_cliente)
    private Integer id_servicio_cliente;
    private Integer id_cliente;
    private Integer id_personal_asignado;
    private Integer id_venta;
    private String fecha_contratacion;
    private String fecha_inicio;
    private String fecha_fin;
    private Double precio_final;
    private String detalles;
    private Integer calificacion;
    private String comentarios;

    // Constructor vacío
    public ServiciosBE() {}

    // Getters y Setters para todos los campos

    public int getId_servicio() {
        return id_servicio;
    }

    public void setId_servicio(int id_servicio) {
        this.id_servicio = id_servicio;
    }

    public int getId_categoria() {
        return id_categoria;
    }

    public void setId_categoria(int id_categoria) {
        this.id_categoria = id_categoria;
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

    public double getPrecio_base() {
        return precio_base;
    }

    public void setPrecio_base(double precio_base) {
        this.precio_base = precio_base;
    }

    public int getDuracion_estimada() {
        return duracion_estimada;
    }

    public void setDuracion_estimada(int duracion_estimada) {
        this.duracion_estimada = duracion_estimada;
    }

    public String getImagen() {
        return imagen;
    }

    public void setImagen(String imagen) {
        this.imagen = imagen;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    // Pedido del cliente
    public Integer getId_servicio_cliente() {
        return id_servicio_cliente;
    }

    public void setId_servicio_cliente(Integer id_servicio_cliente) {
        this.id_servicio_cliente = id_servicio_cliente;
    }

    public Integer getId_cliente() {
        return id_cliente;
    }

    public void setId_cliente(Integer id_cliente) {
        this.id_cliente = id_cliente;
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

    public String getFecha_contratacion() {
        return fecha_contratacion;
    }

    public void setFecha_contratacion(String fecha_contratacion) {
        this.fecha_contratacion = fecha_contratacion;
    }

    public String getFecha_inicio() {
        return fecha_inicio;
    }

    public void setFecha_inicio(String fecha_inicio) {
        this.fecha_inicio = fecha_inicio;
    }

    public String getFecha_fin() {
        return fecha_fin;
    }

    public void setFecha_fin(String fecha_fin) {
        this.fecha_fin = fecha_fin;
    }

    public Double getPrecio_final() {
        return precio_final;
    }

    public void setPrecio_final(Double precio_final) {
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
}