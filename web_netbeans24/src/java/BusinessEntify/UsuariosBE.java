/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package BusinessEntify;

/**
 *
 * @author DIEGO DAMIAN
 */


public class UsuariosBE {
    private int id;
    private String userName;
    private String passwd;
    private String userRol;
    private String userGenero;

    // Getters y setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getUserName() { return userName; }
    public void setUserName(String userName) { this.userName = userName; }

    public String getPasswd() { return passwd; }
    public void setPasswd(String passwd) { this.passwd = passwd; }

    public String getUserRol() { return userRol; }
    public void setUserRol(String userRol) { this.userRol = userRol; }

    public String getUserGenero() { return userGenero; }
    public void setUserGenero(String userGenero) { this.userGenero = userGenero; }
}

