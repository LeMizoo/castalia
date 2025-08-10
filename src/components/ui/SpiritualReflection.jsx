// src/components/ui/SpiritualReflection.jsx
import React from 'react';

export default function SpiritualReflection({ texts }) {
  return (
    <div className="spiritual-reflection">
      <h3>Réflexions spirituelles</h3>
      <ul>
        {texts.map((text, i) => <li key={i}>{text}</li>)}
      </ul>
    </div>
  );
}