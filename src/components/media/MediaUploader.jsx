import React, { useState } from 'react';
import { storage } from '../../lib/firebase';
import { ref, uploadBytesResumable, getDownloadURL } from 'firebase/storage';

function MediaUploader() {
  const [file, setFile] = useState(null);
  const [progress, setProgress] = useState(0);
  const [url, setUrl] = useState('');
  const [error, setError] = useState(null);

  const handleUpload = () => {
    if (!file) return;

    const storageRef = ref(storage, `media/${file.name}`);
    const uploadTask = uploadBytesResumable(storageRef, file);

    uploadTask.on(
      'state_changed',
      (snapshot) => {
        const pct = (snapshot.bytesTransferred / snapshot.totalBytes) * 100;
        setProgress(Math.round(pct));
      },
      (err) => {
        console.error("Erreur d'upload :", err);
        setError(err.message);
      },
      () => {
        getDownloadURL(uploadTask.snapshot.ref).then((downloadURL) => {
          setUrl(downloadURL);
        });
      }
    );
  };

  return (
    <div className="media-uploader">
      <h3>Uploader un média</h3>
      <input type="file" onChange={(e) => setFile(e.target.files[0])} />
      <button onClick={handleUpload} disabled={!file}>Envoyer</button>

      {progress > 0 && <p>Progression : {progress}%</p>}
      {error && <p style={{ color: 'red' }}>❌ Erreur : {error}</p>}
      {url && (
        <div>
          <p>Fichier disponible :</p>
          <a href={url} target="_blank" rel="noopener noreferrer">{url}</a>
        </div>
      )}
    </div>
  );
}

export default MediaUploader;