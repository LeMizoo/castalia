import React from 'react';
import { Link } from 'react-router-dom';

export default function NavBar() {
  return (
    <nav>
      <Link to="/">Accueil</Link>
      <Link to="/media">Médiathèque</Link>
      <Link to="/articles">Articles</Link>
      <Link to="/login">Connexion</Link>
    </nav>
  );
}