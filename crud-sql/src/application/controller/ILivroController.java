package application.controller;

import java.sql.SQLException;

import application.model.Livro;

public interface ILivroController {
	
	public void inserirLivro(Livro l) throws ClassNotFoundException, SQLException;
	public void atualizarLivro(Livro l) throws ClassNotFoundException, SQLException;
	public void excluirLivro(Livro l) throws ClassNotFoundException, SQLException;
	public void buscarLivro(Livro l) throws ClassNotFoundException, SQLException;
	public void buscarLivros() throws ClassNotFoundException, SQLException;
	

}
