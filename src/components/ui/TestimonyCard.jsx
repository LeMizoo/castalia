// src/components/ui/TestimonyCard.jsx
import React from 'react';

export default function TestimonyCard({ name, quote, description }) {
  return (
    <div className="testimony-card">
      <blockquote>“{quote}”</blockquote>
      <p><strong>{name}</strong> – {description}</p>
    </div>
  );
}