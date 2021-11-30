package application.controller;

import java.sql.SQLException;
import java.util.List;

import application.model.Livro;
import application.persistence.LivroDao;
import javafx.scene.control.TextArea;
import javafx.scene.control.TextField;

public class LivroController implements ILivroController {
	
	private TextField tfIsbnLivro;
	private TextField tfTituloLivro;
	private TextField tfAutorLivro;
	private TextArea taListaLivros;
	
	public LivroController(TextField tfIsbnLivro, TextField tfTituloLivro, TextField tfAutorLivro,
			TextArea tfListaLivros) {
		this.tfIsbnLivro = tfIsbnLivro;
		this.tfTituloLivro = tfTituloLivro;
		this.tfAutorLivro = tfAutorLivro;
		this.taListaLivros = tfListaLivros;
	}

	@Override
	public void inserirLivro(Livro l) throws ClassNotFoundException, SQLException {
		LivroDao lDao = new LivroDao();
		lDao.insereLivro(l);
		limpaCamposLivro();
		buscarLivros();
	}

	@Override
	public void atualizarLivro(Livro l) throws ClassNotFoundException, SQLException {
		LivroDao lDao = new LivroDao();
		lDao.atualizarLivro(l);
		limpaCamposLivro();
		buscarLivros();
	}

	@Override
	public void excluirLivro(Livro l) throws ClassNotFoundException, SQLException {
		LivroDao lDao = new LivroDao();
		lDao.excluirLivro(l);
		limpaCamposLivro();
		buscarLivros();		
	}

	@Override
	public void buscarLivro(Livro l) throws ClassNotFoundException, SQLException {
		limpaCamposLivro();
				
		LivroDao lDao = new LivroDao();
		l = lDao.buscaLivro(l);
		
		tfIsbnLivro.setText(String.valueOf(l.getISBN()));
		tfTituloLivro.setText(l.getTitulo());
		tfAutorLivro.setText(l.getAutor());
	}

	@Override
	public void buscarLivros() throws ClassNotFoundException, SQLException {
		limpaCamposLivro();
		taListaLivros.setText("");
		
		LivroDao lDao = new LivroDao();
		List<Livro> listaLivros = lDao.buscaLivros();
		
		StringBuffer buffer = new StringBuffer("ISBN\t\t\t\tTitulo\t\t\t\tAutor\n");
		for (Livro l : listaLivros) {
			buffer.append(l.getISBN()+"\t\t\t\t\t"+l.getTitulo()+"\t\t\t\t\t"+l.getAutor()+"\n");
		}
		
		taListaLivros.setText(buffer.toString());
	}
	
	private void limpaCamposLivro() {
		tfIsbnLivro.setText("");
		tfTituloLivro.setText("");
		tfAutorLivro.setText("");
	}

}
