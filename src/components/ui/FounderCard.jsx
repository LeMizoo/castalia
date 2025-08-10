// src/components/ui/FounderCard.jsx
import React from 'react';

export default function FounderCard({ name, role, description }) {
  return (
    <div className="founder-card">
      <h3>{name}</h3>
      <h4>{role}</h4>
      <p>{description}</p>
    </div>
  );
}