// src/components/ui/SanctuaryMap.jsx
import React from 'react';

export default function SanctuaryMap({ locations }) {
  return (
    <div className="sanctuary-map">
      <h3>Lieux d’interprétation</h3>
      <ul>
        {locations.map((loc, i) => (
          <li key={i}>
            <strong>{loc.name}</strong> : {loc.description}
          </li>
        ))}
      </ul>
    </div>
  );
}