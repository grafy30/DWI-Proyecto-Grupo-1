package BusinessLogic;

import BusinessEntify.UsuariosBE;
import DataAccessObject.UsuariosDAO;
import java.util.ArrayList;

public class UsuariosBL {

    private final UsuariosDAO dao;

    public UsuariosBL() {
        this.dao = new UsuariosDAO();
    }

    public UsuariosBE login(String nickname, String password) {
        return dao.login(nickname, password);
    }

    public boolean registrarUsuario(UsuariosBE nuevoUsuario) {
        return dao.Create(nuevoUsuario);
    }

    public boolean actualizarUsuario(UsuariosBE usuario) {
        return dao.Update(usuario);
    }

    public boolean eliminarUsuarioPorId(String id) {
        return dao.Delete(id);
    }

    public UsuariosBE obtenerUsuarioPorId(String id) {
        return dao.Read(id);
    }

    public ArrayList<UsuariosBE> obtenerTodosLosUsuarios() {
        return dao.ReadAll();
    }
}
    