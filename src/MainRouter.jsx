import React from 'react';
import { Routes, Route } from 'react-router-dom';
import Home from './pages/Home';
import Media from './pages/Media';
import Articles from './pages/Articles';
import EspaceMembre from './components/user/EspaceMembre';
import DashboardAdmin from './pages/DashboardAdmin';
import Login from './components/auth/Login';
import Register from './components/auth/Register';
import NotFound from './pages/NotFound';
import ProtectedRoute from './components/auth/ProtectedRoute';

function MainRouter() {
  return (
    <Routes>
      <Route path="/" element={<Home />} />
      <Route path="/media" element={<Media />} />
      <Route path="/articles" element={<Articles />} />
      <Route path="/login" element={<Login />} />
      <Route path="/register" element={<Register />} />
      <Route path="/espace-membre" element={
        <ProtectedRoute>
          <EspaceMembre />
        </ProtectedRoute>
      } />
      <Route path="/admin" element={
        <ProtectedRoute adminOnly>
          <DashboardAdmin />
        </ProtectedRoute>
      } />
      <Route path="*" element={<NotFound />} />
    </Routes>
  );
}

export default MainRouter;