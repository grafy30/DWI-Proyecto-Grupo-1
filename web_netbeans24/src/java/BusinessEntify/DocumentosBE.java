package BusinessEntify;
import java.time.LocalDateTime;
public class DocumentosBE {
    private int id_documento;
    private int id_proyecto;
    private String nombre_documento;
    private String tipo_documento;
    private String ruta_archivo;
    private LocalDateTime fecha_subida;
    private int subido_por;
    
    //Constructor
    public DocumentosBE() {
    }
    
    //Getters and Setters

    public int getId_documento() {
        return id_documento;
    }

    public void setId_documento(int id_documento) {
        this.id_documento = id_documento;
    }

    public int getId_proyecto() {
        return id_proyecto;
    }

    public void setId_proyecto(int id_proyecto) {
        this.id_proyecto = id_proyecto;
    }

    public String getNombre_documento() {
        return nombre_documento;
    }

    public void setNombre_documento(String nombre_documento) {
        this.nombre_documento = nombre_documento;
    }

    public String getTipo_documento() {
        return tipo_documento;
    }

    public void setTipo_documento(String tipo_documento) {
        this.tipo_documento = tipo_documento;
    }

    public String getRuta_archivo() {
        return ruta_archivo;
    }

    public void setRuta_archivo(String ruta_archivo) {
        this.ruta_archivo = ruta_archivo;
    }

    public LocalDateTime getFecha_subida() {
        return fecha_subida;
    }

    public void setFecha_subida(LocalDateTime fecha_subida) {
        this.fecha_subida = fecha_subida;
    }

    public int getSubido_por() {
        return subido_por;
    }

    public void setSubido_por(int subido_por) {
        this.subido_por = subido_por;
    }    
}
