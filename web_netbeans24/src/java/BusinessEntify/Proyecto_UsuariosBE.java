package BusinessEntify;
import java.time.LocalDateTime;
public class Proyecto_UsuariosBE {
    private int id_proyecto;
    private int id_usuario;
    private String rol_en_proyecto;
    private LocalDateTime fecha_asignacion;
    
    //Constructor

    public Proyecto_UsuariosBE() {
    }
    
    //Getters and Setters

    public int getId_proyecto() {
        return id_proyecto;
    }

    public void setId_proyecto(int id_proyecto) {
        this.id_proyecto = id_proyecto;
    }

    public int getId_usuario() {
        return id_usuario;
    }

    public void setId_usuario(int id_usuario) {
        this.id_usuario = id_usuario;
    }

    public String getRol_en_proyecto() {
        return rol_en_proyecto;
    }

    public void setRol_en_proyecto(String rol_en_proyecto) {
        this.rol_en_proyecto = rol_en_proyecto;
    }

    public LocalDateTime getFecha_asignacion() {
        return fecha_asignacion;
    }

    public void setFecha_asignacion(LocalDateTime fecha_asignacion) {
        this.fecha_asignacion = fecha_asignacion;
    }    
}
