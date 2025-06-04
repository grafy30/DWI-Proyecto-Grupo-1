package BusinessLogic;

import BusinessEntify.UsuariosBE;
import DataAccessObject.UsuariosDAO;
import java.util.ArrayList;

public class UsuariosBL implements IBaseBL<UsuariosBE>{

    private final UsuariosDAO user;
    
    public UsuariosBL() {
        this.user = new UsuariosDAO();
    }
    
    @Override
    public boolean Create(UsuariosBE input) {
        return user.Create(input);
    }

    @Override
    public UsuariosBE Read(String input) {
        return user.Read(input);
    }

    @Override
    public ArrayList<UsuariosBE> ReadAll() {
        return user.ReadAll();
    }

    @Override
    public boolean Update(UsuariosBE input) {
        return user.Update(input);
    }

    @Override
    public boolean Delete(String input) {
        return user.Delete(input);
    }    
            
    public UsuariosBE login(String nickname, String password) {
        return user.login(nickname, password);
    }
}
    