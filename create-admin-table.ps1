# Créer le dossier si nécessaire
$folder = "src/components/admin"
if (-not (Test-Path $folder)) {
  New-Item -ItemType Directory -Path $folder -Force | Out-Null
  Write-Host "📁 Dossier créé : $folder"
}

# Contenu du composant AdminTable.jsx
$adminTableContent = @"
import React, { useEffect, useState } from 'react';
import { collection, getDocs, doc, deleteDoc, updateDoc } from 'firebase/firestore';
import { db } from '../../lib/firebase';

function AdminTable() {
  const [users, setUsers] = useState([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const fetchUsers = async () => {
      try {
        const querySnapshot = await getDocs(collection(db, 'users'));
        const userList = querySnapshot.docs.map(doc => ({
          id: doc.id,
          ...doc.data()
        }));
        setUsers(userList);
      } catch (error) {
        console.error('Erreur lors du chargement des utilisateurs :', error);
      } finally {
        setLoading(false);
      }
    };

    fetchUsers();
  }, []);

  const handleDelete = async (id) => {
    try {
      await deleteDoc(doc(db, 'users', id));
      setUsers(users.filter(user => user.id !== id));
    } catch (error) {
      console.error('Erreur lors de la suppression :', error);
    }
  };

  const toggleAdmin = async (id, currentStatus) => {
    try {
      const userRef = doc(db, 'users', id);
      await updateDoc(userRef, { isAdmin: !currentStatus });
      setUsers(users.map(user =>
        user.id === id ? { ...user, isAdmin: !currentStatus } : user
      ));
    } catch (error) {
      console.error('Erreur lors de la mise à jour du rôle :', error);
    }
  };

  if (loading) return <p>Chargement des utilisateurs...</p>;

  return (
    <div className="admin-table">
      <h3>Gestion des membres</h3>
      <table>
        <thead>
          <tr>
            <th>Nom</th>
            <th>Email</th>
            <th>Admin</th>
            <th>Actions</th>
          </tr>
        </thead>
        <tbody>
          {users.map(user => (
            <tr key={user.id}>
              <td>{user.name || '—'}</td>
              <td>{user.email || '—'}</td>
              <td>{user.isAdmin ? '✅' : '❌'}</td>
              <td>
                <button onClick={() => toggleAdmin(user.id, user.isAdmin)}>
                  {user.isAdmin ? 'Révoquer' : 'Promouvoir'}
                </button>
                <button onClick={() => handleDelete(user.id)}>Supprimer</button>
              </td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
}

export default AdminTable;
"@

# Créer le fichier et y écrire le contenu
$filePath = "$folder/AdminTable.jsx"
Set-Content -Path $filePath -Value $adminTableContent -Force
Write-Host "✅ Fichier créé : $filePath"