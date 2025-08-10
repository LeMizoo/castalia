import React from 'react';
import { useAuth } from '../hooks/useAuth';

function EspaceMembre() {
  const { user, logout } = useAuth();

  return (
    <div className="page membre">
      <h2>Espace membre</h2>
      <p>Bienvenue, {user?.username || 'utilisateur'} !</p>
      <button onClick={logout}>Se déconnecter</button>
    </div>
  );
}

export default EspaceMembre;