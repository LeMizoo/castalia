import React, { useEffect, useState } from 'react';
import { collection, getDocs } from 'firebase/firestore';
import { db } from '../../lib/firebase';

function MediaGrid() {
  const [mediaList, setMediaList] = useState([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const fetchMedia = async () => {
      try {
        const querySnapshot = await getDocs(collection(db, 'media'));
        const items = querySnapshot.docs.map(doc => ({
          id: doc.id,
          ...doc.data()
        }));
        setMediaList(items);
      } catch (error) {
        console.error('Erreur lors du chargement des médias :', error);
      } finally {
        setLoading(false);
      }
    };

    fetchMedia();
  }, []);

  if (loading) return <p>Chargement des médias...</p>;

  return (
    <div className="media-grid">
      {mediaList.length === 0 ? (
        <p>Aucun média disponible.</p>
      ) : (
        <div className="grid">
          {mediaList.map(media => (
            <div key={media.id} className="media-item">
              <img src={media.url} alt={media.name || 'media'} />
              <p>{media.name}</p>
            </div>
          ))}
        </div>
      )}
    </div>
  );
}

export default MediaGrid;
