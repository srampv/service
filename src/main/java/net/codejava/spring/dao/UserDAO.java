/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author shashank
 */
package net.codejava.spring.dao;
 
import java.util.List;
 
import net.codejava.spring.model.User;
 
public interface UserDAO {
    public List<User> list();
}