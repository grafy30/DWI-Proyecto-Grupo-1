package BusinessEntify;
import javax.swing.ImageIcon;
public class PersonalBE {
    private int id_personal;
    private String nombre_personal;
    private String cargo_personal;
    private String correo_personal;
    private String telefono_personal;
    private ImageIcon imagen;
    private String descripcion;
    
    //Getters and Setters

    public PersonalBE() {
    }
    

    public int getId_personal() {
        return id_personal;
    }

    public void setId_personal(int id_personal) {
        this.id_personal = id_personal;
    }

    public String getNombre_personal() {
        return nombre_personal;
    }

    public void setNombre_personal(String nombre_personal) {
        this.nombre_personal = nombre_personal;
    }

    public String getCargo_personal() {
        return cargo_personal;
    }

    public void setCargo_personal(String cargo_personal) {
        this.cargo_personal = cargo_personal;
    }

    public String getCorreo_personal() {
        return correo_personal;
    }

    public void setCorreo_personal(String correo_personal) {
        this.correo_personal = correo_personal;
    }

    public String getTelefono_personal() {
        return telefono_personal;
    }

    public void setTelefono_personal(String telefono_personal) {
        this.telefono_personal = telefono_personal;
    }

    public ImageIcon getImagen() {
        return imagen;
    }

    public void setImagen(ImageIcon imagen) {
        this.imagen = imagen;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }
    
    
}
