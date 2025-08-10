import React from "react";
import "../../styles/HeroSection.css"; // ✅ corrigé : fichier déplacé dans styles/

export default function HeroSection({ title, subtitle, background }) {
  return (
    <section
      className="hero-section"
      style={{ backgroundImage: `url(${background})` }}
    >
      <div className="hero-overlay">
        <h1>{title}</h1>
        <p>{subtitle}</p>
      </div>
    </section>
  );
}