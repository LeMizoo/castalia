# Créer le dossier si nécessaire
$folder = "src/components/auth"
if (-not (Test-Path $folder)) {
  New-Item -ItemType Directory -Path $folder -Force | Out-Null
  Write-Host "📁 Dossier créé : $folder"
}

# Contenu de Login.jsx
$loginContent = @"
import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { useAuth } from '../../hooks/useAuth';

function Login() {
  const [email, setEmail] = useState('');
  const [name, setName] = useState('');
  const { login } = useAuth();
  const navigate = useNavigate();

  const handleSubmit = (e) => {
    e.preventDefault();
    const userData = {
      name,
      email,
      isAdmin: email.includes('admin') // simple logique temporaire
    };
    login(userData);
    navigate('/');
  };

  return (
    <div className="auth-form">
      <h3>Connexion</h3>
      <form onSubmit={handleSubmit}>
        <input
          type="text"
          placeholder="Nom"
          value={name}
          onChange={(e) => setName(e.target.value)}
          required
        />
        <input
          type="email"
          placeholder="Email"
          value={email}
          onChange={(e) => setEmail(e.target.value)}
          required
        />
        <button type="submit">Se connecter</button>
      </form>
    </div>
  );
}

export default Login;
"@

# Contenu de Register.jsx
$registerContent = @"
import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { useAuth } from '../../hooks/useAuth';

function Register() {
  const [email, setEmail] = useState('');
  const [name, setName] = useState('');
  const { login } = useAuth();
  const navigate = useNavigate();

  const handleSubmit = (e) => {
    e.preventDefault();
    const userData = {
      name,
      email,
      isAdmin: false
    };
    login(userData);
    navigate('/');
  };

  return (
    <div className="auth-form">
      <h3>Inscription</h3>
      <form onSubmit={handleSubmit}>
        <input
          type="text"
          placeholder="Nom"
          value={name}
          onChange={(e) => setName(e.target.value)}
          required
        />
        <input
          type="email"
          placeholder="Email"
          value={email}
          onChange={(e) => setEmail(e.target.value)}
          required
        />
        <button type="submit">S'inscrire</button>
      </form>
    </div>
  );
}

export default Register;
"@

# Créer les fichiers
Set-Content -Path "$folder/Login.jsx" -Value $loginContent -Force
Write-Host "✅ Fichier créé : $folder/Login.jsx"

Set-Content -Path "$folder/Register.jsx" -Value $registerContent -Force
Write-Host "✅ Fichier créé : $folder/Register.jsx"