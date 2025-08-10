import React from 'react';
import articles from '../data/articles.json';
import ArticleCard from '../components/ArticleCard';

export default function Articles() {
  return (
    <div className="articles-page">
      <h2>📝 Articles & Témoignages</h2>
      {articles.map((a) => (
        <ArticleCard key={a.id} {...a} />
      ))}
    </div>
  );
}