package BusinessLogic;

import BusinessEntify.ClientesBE;
import DataAccessObject.ClientesDAO;
import java.util.ArrayList;

public class ClientesBL implements IBaseBL<ClientesBE> {

    private final ClientesDAO clienteDao;

    public ClientesBL() {
        this.clienteDao = new ClientesDAO();
    }

    @Override
    public boolean Create(ClientesBE input) {
        return clienteDao.Create(input);
    }

    @Override
    public ClientesBE Read(String input) {
        return clienteDao.Read(input);
    }

    @Override
    public ArrayList<ClientesBE> ReadAll() {
        return clienteDao.ReadAll();
    }

    @Override
    public boolean Update(ClientesBE input) {
        return clienteDao.Update(input);
    }

    @Override
    public boolean Delete(String input) {
        return clienteDao.Delete(input);
    }

    // --- Métodos extra para integración por usuario ---
    public ClientesBE findByUsuarioId(int idUsuario) {
        return clienteDao.findByUsuarioId(idUsuario);
    }
}
