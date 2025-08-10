import React, { useContext } from 'react';
import { AuthContext } from '../../context/AuthContext';

function Profil() {
  const { user, logout } = useContext(AuthContext);

  return (
    <div className="max-w-md mx-auto mt-10 p-6 bg-white shadow rounded">
      <div className="flex flex-col items-center">
        <img
          src={user?.photoURL || '/default-avatar.png'}
          alt="Avatar"
          className="w-24 h-24 rounded-full mb-4"
        />
        <h2 className="text-xl font-semibold">{user?.username || 'Utilisateur'}</h2>
        <p className="text-gray-600">{user?.email}</p>
        <div className="mt-4">
          <p className="text-sm text-gray-500">Médias uploadés : {user?.mediaCount || 0}</p>
        </div>
        <button
          onClick={logout}
          className="mt-6 px-4 py-2 bg-red-500 text-white rounded hover:bg-red-600"
        >
          Se déconnecter
        </button>
      </div>
    </div>
  );
}

export default Profil;