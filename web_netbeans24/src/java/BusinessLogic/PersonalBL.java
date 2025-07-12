package BusinessLogic;

import BusinessEntify.PersonalBE;
import DataAccessObject.PersonalDAO;
import java.util.ArrayList;

public class PersonalBL implements IBaseBL<PersonalBE>{
    
    private final PersonalDAO personal;

    public PersonalBL() {
        this.personal = new PersonalDAO();
    }        

    @Override
    public boolean Create(PersonalBE input) {
        return personal.Create(input);
    }

    @Override
    public PersonalBE Read(String input) {
        return personal.Read(input);
    }

    @Override
    public ArrayList<PersonalBE> ReadAll() {
        return personal.ReadAll();
    }

    @Override
    public boolean Update(PersonalBE input) {
        return personal.Update(input);
    }

    @Override
    public boolean Delete(String input) {
        return personal.Delete(input);
    }
}
