# Créer le dossier si nécessaire
$folder = "src/components/auth"
if (-not (Test-Path $folder)) {
  New-Item -ItemType Directory -Path $folder -Force | Out-Null
  Write-Host "📁 Dossier créé : $folder"
}

# Contenu du composant ProtectedRoute.jsx
$protectedRouteContent = @"
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

# Créer le fichier et y écrire le contenu
$filePath = "$folder/ProtectedRoute.jsx"
Set-Content -Path $filePath -Value $protectedRouteContent -Force
Write-Host "✅ Fichier créé : $filePath"