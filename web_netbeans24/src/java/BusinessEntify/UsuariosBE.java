package BusinessEntify;
import java.util.Date;

public class UsuariosBE {
    private int id_usuario;
    private String usuario;
    private String rol;
    private String password;

    // Constructor
      
    public UsuariosBE() {
    }
    
    // Getters y setters

    public int getId_usuario() {
        return id_usuario;
    }

    public void setId_usuario(int id_usuario) {
        this.id_usuario = id_usuario;
    }

    public String getUsuario() {
        return usuario;
    }

    public void setUsuario(String usuario) {
        this.usuario = usuario;
    }

    public String getRol() {
        return rol;
    }

    public void setRol(String rol) {
        this.rol = rol;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }            
}

