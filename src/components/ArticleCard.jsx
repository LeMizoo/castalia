import React from 'react';

export default function ArticleCard({ title, author, date, excerpt }) {
  return (
    <div className="article-card">
      <h3>{title}</h3>
      <p><em>{author}</em> – {date}</p>
      <p>{excerpt}</p>
    </div>
  );
}