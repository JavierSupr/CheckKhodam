const express = require('express');
const admin = require('firebase-admin');

// Inisialisasi Firebase Admin SDK menggunakan variabel lingkungan
const serviceAccount = JSON.parse(process.env.FIREBASE_SERVICE_ACCOUNT_KEY);

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount)
});

const db = admin.firestore();
const app = express();

// Middleware untuk parsing JSON
app.use(express.json());

app.get('/', (req, res) => {
  res.json({
    message: 'Welcome to the Chekodam Backend API',
    endpoints: [
      { method: 'GET', path: '/users/getinformation', description: 'Retrieve all user information from collection USR-001' },
      { method: 'POST', path: '/users/register', description: 'Register a new user with name, email, and password' },
      { method: 'POST', path: '/users/login', description: 'Login with email and password' },
      { method: 'GET', path: '/khodam/getrandom', description: 'Retrieve a random document from collection khod-000' },
      { method: 'POST', path: '/khodam/addImage', description: 'Add or update image URL for a document in collection khod-000' }
    ]
  });
});



// Endpoint untuk mengambil data dari koleksi 'USR-001' dengan URL baru
app.get('/users/getinformation', async (req, res) => {
  try {
    const snapshot = await db.collection('USR-001').get();
    const users = snapshot.docs.map(doc => ({ id: doc.id, ...doc.data() }));
    res.status(200).json(users);
  } catch (error) {
    console.error('Error fetching users:', error);
    res.status(500).json({ error: error.message });
  }
});

// Endpoint untuk mendaftarkan dokumen baru ke koleksi 'USR-001' dengan URL baru dan tambahan field 'password'
app.post('/users/register', async (req, res) => {
  try {
    const { name, email, password } = req.body;

    if (!name || !email || !password) {
      return res.status(400).json({ error: 'Name, email, and password are required' });
    }

    const newUserRef = await db.collection('USR-001').add({
      name: name,
      email: email,
      password: password
    });

    res.status(201).json({ id: newUserRef.id, name: name, email: email });
  } catch (error) {
    console.error('Error registering user:', error);
    res.status(500).json({ error: error.message });
  }
});

// Endpoint untuk mendapatkan dokumen acak dari koleksi 'khod-000' dengan URL baru
app.get('/khodam/getrandom', async (req, res) => {
  try {
    const snapshot = await db.collection('khod-000').get();

    if (snapshot.empty) {
      return res.status(404).json({ error: 'No documents found in collection khod-000' });
    }

    const randomIndex = Math.floor(Math.random() * snapshot.docs.length);
    const randomDoc = snapshot.docs[randomIndex];
    const data = { id: randomDoc.id, ...randomDoc.data() };

    res.status(200).json(data);
  } catch (error) {
    console.error('Error fetching random document:', error);
    res.status(500).json({ error: error.message });
  }
});

// Endpoint untuk login
app.post('/users/login', async (req, res) => {
  try {
    const { email, password } = req.body;

    if (!email || !password) {
      return res.status(400).json({ error: 'Email and password are required' });
    }

    const snapshot = await db.collection('USR-001')
      .where('email', '==', email)
      .where('password', '==', password)
      .get();

    if (snapshot.empty) {
      return res.status(404).json({ message: 'Informasi tidak ditemukan' });
    }

    const userDoc = snapshot.docs[0];
    const userData = { id: userDoc.id, ...userDoc.data() };

    res.status(200).json({
      message: 'Login berhasil',
      user: userData
    });
  } catch (error) {
    console.error('Error during login:', error);
    res.status(500).json({ error: error.message });
  }
});

// Endpoint untuk menambahkan atau memperbarui URL gambar di dokumen khod-000
app.post('/khodam/addImage', async (req, res) => {
  try {
    const { docId, imageUrl } = req.body;

    if (!docId || !imageUrl) {
      return res.status(400).json({ error: 'docId and imageUrl are required' });
    }

    await db.collection('khod-000').doc(docId).update({
      imageUrl: imageUrl
    });

    res.status(200).json({ message: 'Image URL added/updated successfully' });
  } catch (error) {
    console.error('Error adding image URL:', error);
    res.status(500).json({ error: error.message });
  }
});

// Ekspor `app` untuk digunakan oleh Vercel
module.exports = app;
