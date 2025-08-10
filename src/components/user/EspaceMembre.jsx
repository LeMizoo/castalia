import React from 'react';
import { useAuth } from '../../hooks/useAuth';

function EspaceMembre() {
  const { user } = useAuth();

  if (!user) return <p>Veuillez vous connecter pour accéder à votre espace.</p>;

  return (
    <div className="max-w-xl mx-auto mt-10 p-6 bg-white rounded-lg shadow-md">
      <h2 className="text-2xl font-bold mb-4">Espace Membre</h2>
      <p><strong>Nom :</strong> {user.name}</p>
      <p><strong>Email :</strong> {user.email}</p>
      <p><strong>Rôle :</strong> {user.isAdmin ? 'Administrateur' : 'Membre'}</p>
    </div>
  );
}

export default EspaceMembre;