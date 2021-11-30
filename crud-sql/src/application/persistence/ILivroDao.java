package application.persistence;

import java.sql.SQLException;
import java.util.List;

import application.model.Livro;

public interface ILivroDao {

	public void insereLivro (Livro l) throws SQLException;
	public void atualizarLivro (Livro l) throws SQLException;
	public void excluirLivro (Livro l) throws SQLException;
	public Livro buscaLivro (Livro l) throws SQLException;
	public List<Livro> buscaLivros () throws SQLException;
}
