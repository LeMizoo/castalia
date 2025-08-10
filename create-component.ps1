# Créer les dossiers nécessaires
$folders = @(
  "src/components/nav",
  "src/components/media",
  "src/components/auth",
  "src/hooks",
  "src/context"
)

foreach ($folder in $folders) {
  if (-not (Test-Path $folder)) {
    New-Item -ItemType Directory -Path $folder -Force | Out-Null
    Write-Host "📁 Dossier créé : $folder"
  }
}

# Dictionnaire des fichiers et leur contenu
$components = @{
  "components/nav/NavBar.jsx" = @"
import React from 'react';
import { Link } from 'react-router-dom';
import { useAuth } from '../../hooks/useAuth';

function NavBar() {
  const { user, logout } = useAuth();

  return (
    <nav className='navbar'>
      <Link to='/'>Accueil</Link>
      <Link to='/media'>Galerie</Link>
      {user ? (
        <>
          <Link to='/espace-membre'>Espace Membre</Link>
          {user.isAdmin && <Link to='/admin'>Admin</Link>}
          <button onClick={logout}>Déconnexion</button>
        </>
      ) : (
        <>
          <Link to='/login'>Connexion</Link>
          <Link to='/register'>Inscription</Link>
        </>
      )}
    </nav>
  );
}

export default NavBar;
"@

  "components/media/MediaUploader.jsx" = @"
import React, { useState } from 'react';
import { storage } from '../../lib/firebase';
import { ref, uploadBytesResumable, getDownloadURL } from 'firebase/storage';

function MediaUploader() {
  const [file, setFile] = useState(null);
  const [progress, setProgress] = useState(0);
  const [url, setUrl] = useState('');

  const handleUpload = () => {
    if (!file) return;

    const storageRef = ref(storage, `media/\${file.name}`);
    const uploadTask = uploadBytesResumable(storageRef, file);

    uploadTask.on('state_changed',
      (snapshot) => {
        const pct = (snapshot.bytesTransferred / snapshot.totalBytes) * 100;
        setProgress(Math.round(pct));
      },
      (error) => {
        console.error('Erreur d\'upload :', error);
      },
      () => {
        getDownloadURL(uploadTask.snapshot.ref).then((downloadURL) => {
          setUrl(downloadURL);
        });
      }
    );
  };

  return (
    <div className='media-uploader'>
      <h3>Uploader un média</h3>
      <input type='file' onChange={(e) => setFile(e.target.files[0])} />
      <button onClick={handleUpload}>Envoyer</button>
      {progress > 0 && <p>Progression : {progress}%</p>}
      {url && (
        <div>
          <p>Fichier disponible à :</p>
          <a href={url} target='_blank' rel='noopener noreferrer'>{url}</a>
        </div>
      )}
    </div>
  );
}

export default MediaUploader;
"@

  "components/auth/ProtectedRoute.jsx" = @"
import React from 'react';
import { Navigate } from 'react-router-dom';
import { useAuth } from '../../hooks/useAuth';

function ProtectedRoute({ children, adminOnly = false }) {
  const { user } = useAuth();

  if (!user) return <Navigate to='/login' />;
  if (adminOnly && !user.isAdmin) return <Navigate to='/' />;

  return children;
}

export default ProtectedRoute;
"@

  "hooks/useAuth.js" = @"
import { useContext } from 'react';
import { AuthContext } from '../context/AuthContext';

export function useAuth() {
  return useContext(AuthContext);
}
"@

  "context/AuthContext.jsx" = @"
import React, { createContext, useState, useEffect } from 'react';

export const AuthContext = createContext();

export function AuthProvider({ children }) {
  const [user, setUser] = useState(null);

  useEffect(() => {
    const storedUser = JSON.parse(localStorage.getItem('user'));
    if (storedUser) setUser(storedUser);
  }, []);

  const login = (userData) => {
    setUser(userData);
    localStorage.setItem('user', JSON.stringify(userData));
  };

  const logout = () => {
    setUser(null);
    localStorage.removeItem('user');
  };

  return (
    <AuthContext.Provider value={{ user, login, logout }}>
      {children}
    </AuthContext.Provider>
  );
}
"@
}

# Créer les fichiers et y écrire le contenu
foreach ($path in $components.Keys) {
  $fullPath = "src/$path"
  try {
    Set-Content -Path $fullPath -Value $components[$path] -Force
    Write-Host "✅ Fichier créé : $fullPath"
  } catch {
    Write-Host "❌ Erreur lors de la création de $fullPath : $_" -ForegroundColor Red
  }
}

Write-Host "`n🎉 Tous les composants ont été générés avec succès."