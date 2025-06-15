package BusinessLogic;

import BusinessEntify.UsuariosBE;
import DataAccessObject.UsuariosDAO;
import java.util.ArrayList;

public class UsuariosBL implements IBaseBL<UsuariosBE> {

    private final UsuariosDAO userDao;

    public UsuariosBL() {
        this.userDao = new UsuariosDAO();
    }

    @Override
    public boolean Create(UsuariosBE input) {
        return userDao.Create(input);
    }

    @Override
    public UsuariosBE Read(String input) {
        return userDao.Read(input);
    }

    @Override
    public ArrayList<UsuariosBE> ReadAll() {
        return userDao.ReadAll();
    }

    @Override
    public boolean Update(UsuariosBE input) {
        return userDao.Update(input);
    }

    @Override
    public boolean Delete(String input) {
        return userDao.Delete(input);
    }

    // --- Métodos extra para autenticación y Google ---
    public UsuariosBE login(String emailOrNickname, String password) {
        return userDao.login(emailOrNickname, password);
    }

    public UsuariosBE findByEmail(String email) {
        return userDao.findByEmail(email);
    }

    public UsuariosBE findByGoogleId(String googleId) {
        return userDao.findByGoogleId(googleId);
    }

    // Registro de usuario por Google
    public boolean createGoogle(UsuariosBE input) {
        return userDao.createGoogle(input);
    }
}
