package BusinessEntify;
import java.util.Date;

public class ContactosBE {
    private int id_contacto;
    private String nombre;
    private String correo;
    private String telefono;
    private String mensaje;
    private Date fecha_contacto;
    private String estado; 
    
    //Constructor
    public ContactosBE() {
    }
    
    //Getters and Setters

    public int getId_contacto() {
        return id_contacto;
    }

    public void setId_contacto(int id_contacto) {
        this.id_contacto = id_contacto;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getCorreo() {
        return correo;
    }

    public void setCorreo(String correo) {
        this.correo = correo;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    public String getMensaje() {
        return mensaje;
    }

    public void setMensaje(String mensaje) {
        this.mensaje = mensaje;
    }

    public Date getFecha_contacto() {
        return fecha_contacto;
    }

    public void setFecha_contacto(Date fecha_contacto) {
        this.fecha_contacto = fecha_contacto;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }        
}
