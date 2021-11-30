package application.persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import application.model.Livro;

public class LivroDao implements ILivroDao {

	private Connection c;

	public LivroDao() throws ClassNotFoundException, SQLException {
		GenericDao gDao = new GenericDao();
		c = gDao.getConnection();
	}

	@Override
	public void insereLivro(Livro l) throws SQLException {
		String sql = "INSERT INTO livro VALUES (?,?,?)";
		PreparedStatement ps = c.prepareStatement(sql);
		ps.setInt(1, l.getISBN());
		ps.setString(2, l.getTitulo());
		ps.setString(3, l.getAutor());

		ps.execute();
		ps.close();
	}

	@Override
	public void atualizarLivro(Livro l) throws SQLException {
		String sql = "UPDATE livro SET titulo = ?, autor = ? WHERE isbn = ?";
		PreparedStatement ps = c.prepareStatement(sql);
		ps.setString(1, l.getTitulo());
		ps.setString(2, l.getAutor());
		ps.setInt(3, l.getISBN());

		ps.execute();
		ps.close();
	}

	@Override
	public void excluirLivro(Livro l) throws SQLException {
		String sql = "DELETE livro WHERE isbn = ?";
		PreparedStatement ps = c.prepareStatement(sql);

		ps.setInt(1, l.getISBN());

		ps.execute();
		ps.close();

	}

	@Override
	public Livro buscaLivro(Livro l) throws SQLException {
		String sql = "SELECT isbn, titulo, autor FROM livro WHERE isbn = ?";

		PreparedStatement ps = c.prepareStatement(sql);
		ps.setInt(1, l.getISBN());

		int cont = 0;
		ResultSet rs = ps.executeQuery();

		if (rs.next()) {
			l.setTitulo(rs.getString("titulo"));
			l.setAutor(rs.getString("autor"));
			cont++;
		}

		if (cont == 0) {
			l = new Livro();
		}

		rs.close();
		ps.close();
		return l;
	}

	@Override
	public List<Livro> buscaLivros() throws SQLException {
		String sql = "SELECT isbn, titulo, autor FROM livro";

		PreparedStatement ps = c.prepareStatement(sql);
		
		ResultSet rs = ps.executeQuery();
		
		List<Livro> listaLivros = new ArrayList<Livro>();
		
		while (rs.next()) {
			Livro l = new Livro();
			l.setISBN(rs.getInt("isbn"));
			l.setTitulo(rs.getString("titulo"));
			l.setAutor(rs.getString("autor"));
			
			listaLivros.add(l);
			
		}
		
		rs.close();
		ps.close();
		
		return listaLivros;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

}
