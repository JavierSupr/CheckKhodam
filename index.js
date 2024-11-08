const express = require('express');
const admin = require('firebase-admin');
const serviceAccount = require('./serviceAccountKey.json');

// Inisialisasi Firebase Admin SDK
admin.initializeApp({
  credential: admin.credential.cert(serviceAccount)
});

const db = admin.firestore();
const app = express();
const port = 3000;

// Middleware untuk parsing JSON
app.use(express.json());

// Endpoint untuk mengambil data dari koleksi 'USR-001'
app.get('/users', async (req, res) => {
  try {
    const snapshot = await db.collection('USR-001').get();
    const users = snapshot.docs.map(doc => ({ id: doc.id, ...doc.data() }));
    res.status(200).json(users);
  } catch (error) {
    console.error('Error fetching users:', error);
    res.status(500).json({ error: error.message });
  }
});

// Endpoint untuk menambahkan dokumen baru ke koleksi 'USR-001'
app.post('/users', async (req, res) => {
  try {
    const { name, email } = req.body;

    // Validasi untuk memastikan 'name' dan 'email' ada dalam permintaan
    if (!name || !email) {
      return res.status(400).json({ error: 'Name and email are required' });
    }

    // Menambahkan dokumen baru ke Firestore dengan ID yang dihasilkan secara otomatis
    const newUserRef = await db.collection('USR-001').add({
      name: name,
      email: email
    });

    // Mengirimkan respons yang berisi ID dokumen yang baru dibuat
    res.status(201).json({ id: newUserRef.id, name: name, email: email });
  } catch (error) {
    console.error('Error adding user:', error);
    res.status(500).json({ error: error.message });
  }
});

// Endpoint untuk mendapatkan dokumen acak dari koleksi 'khod-000'
app.get('/random-khodam', async (req, res) => {
    try {
      const snapshot = await db.collection('khod-000').get();
  
      if (snapshot.empty) {
        return res.status(404).json({ error: 'No documents found in collection khod-000' });
      }
  
      // Mengambil dokumen secara acak
      const randomIndex = Math.floor(Math.random() * snapshot.docs.length);
      const randomDoc = snapshot.docs[randomIndex];
      const data = { id: randomDoc.id, ...randomDoc.data() };
  
      res.status(200).json(data);
    } catch (error) {
      console.error('Error fetching random document:', error);
      res.status(500).json({ error: error.message });
    }
  });

// Jalankan server
app.listen(port, () => {
  console.log(`Server berjalan di http://localhost:${port}`);
});
