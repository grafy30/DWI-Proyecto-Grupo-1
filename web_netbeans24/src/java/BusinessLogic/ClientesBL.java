package BusinessLogic;

import BusinessEntify.ClientesBE;
import DataAccessObject.ClientesDAO;
import java.util.ArrayList;

public class ClientesBL implements IBaseBL<ClientesBE> {

    @Override
    public boolean Create(ClientesBE input) {
        ClientesDAO cliente = new ClientesDAO();
        return cliente.Create(input);
    }

    @Override
    public ClientesBE Read(String input) {
        ClientesDAO cliente = new ClientesDAO();
        return cliente.Read(input);
    }

    @Override
    public ArrayList<ClientesBE> ReadAll() {
        ClientesDAO cliente = new ClientesDAO();
        return cliente.ReadAll();
    }

    @Override
    public boolean Update(ClientesBE input) {
        ClientesDAO cliente = new ClientesDAO();
        return cliente.Update(input);
    }

    @Override
    public boolean Delete(String input) {
    ClientesDAO cliente = new ClientesDAO();
        return cliente.Delete(input);
    }

}
