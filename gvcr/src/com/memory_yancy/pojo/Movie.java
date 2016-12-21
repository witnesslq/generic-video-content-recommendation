package com.memory_yancy.pojo;


/**
 * Database fileds in Java
 * @author memory
 *
 */
public class Movie {
	private String commentTitleString;
	private String movieTitleString;
	private String movieURLString;
	private String movieRankString;
	private String 	movieShortCommentString;
	private String movieCommentURL;
	private String movieImageString;
	private Integer idInteger;
	
	public String getMovieCommentURL() {
		return movieCommentURL;
	}
	public void setMovieCommentURL(String movieCommentURL) {
		this.movieCommentURL = movieCommentURL;
	}
	public String getCommentTitleString() {
		return commentTitleString;
	}
	public void setCommentTitleString(String commentTitleString) {
		this.commentTitleString = commentTitleString;
	}
	public String getMovieTitleString() {
		return movieTitleString;
	}
	public void setMovieTitleString(String movieTitleString) {
		this.movieTitleString = movieTitleString;
	}
	public String getMovieURLString() {
		return movieURLString;
	}
	public void setMovieURLString(String movieURLString) {
		this.movieURLString = movieURLString;
	}
	public String getMovieRankString() {
		return movieRankString;
	}
	public void setMovieRankString(String movieRankString) {
		this.movieRankString = movieRankString;
	}
	public String getMovieShortCommentString() {
		return movieShortCommentString;
	}
	public void setMovieShortCommentString(String movieShortCommentString) {
		this.movieShortCommentString = movieShortCommentString;
	}
	public String getMovieImageString() {
		return movieImageString;
	}
	public void setMovieImageString(String movieImageString) {
		this.movieImageString = movieImageString;
	}
	public Integer getIdInteger() {
		return idInteger;
	}
	public void setIdInteger(Integer idInteger) {
		this.idInteger = idInteger;
	}
	
	
}
