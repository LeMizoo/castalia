import React from 'react';
import { Link } from 'react-router-dom';

function NotFound() {
  return (
    <div className="page notfound">
      <h2>404 - Page introuvable</h2>
      <Link to="/">Retour à l’accueil</Link>
    </div>
  );
}

export default NotFound;