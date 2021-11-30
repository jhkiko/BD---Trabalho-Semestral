package application.model;

public class Livro {
	
	private int ISBN;
	private String titulo;
	private String autor;
	public int getISBN() {
		return ISBN;
	}
	public void setISBN(int iSBN) {
		ISBN = iSBN;
	}
	public String getTitulo() {
		return titulo;
	}
	public void setTitulo(String titulo) {
		this.titulo = titulo;
	}
	public String getAutor() {
		return autor;
	}
	public void setAutor(String autor) {
		this.autor = autor;
	}
	@Override
	public String toString() {
		return "Livro [ISBN=" + ISBN + ", titulo=" + titulo + ", autor=" + autor + "]";
	}
	
	
	

}
