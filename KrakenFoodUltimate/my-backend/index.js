const cors = require('cors');
const express = require('express');
const bcrypt = require('bcrypt');
const pool = require('./db');

const app = express();
app.use(cors());
app.use(express.json());

// GET endpoint to fetch users data
app.get('/api/data', async (req, res) => {
  try {
    const data = await pool.query('SELECT * FROM usuarios');
    res.json(data.rows);
  } catch (err) {
    console.error(err.message);
    res.status(500).json({ error: 'Server error' });
  }
});

// POST endpoint to add a new user
app.post('/api/addUser', async (req, res) => {
    const { nombre_usuario, contraseña } = req.body;
  
    try {
      // Ensure contraseña is not null or undefined and is a string
      if (!contraseña || typeof contraseña !== 'string') {
        return res.status(400).json({ error: 'Password must be provided as a string' });
      }
  
      // Define the number of salt rounds
      const saltRounds = 10;
  
      // Hash the password
      const hashedPassword = await bcrypt.hash(contraseña, saltRounds);
  
      // Insert the user into the database with the hashed password
      const newUser = await pool.query(
        'INSERT INTO usuarios (nombre_usuario, contraseña_hash) VALUES ($1, $2) RETURNING *',
        [nombre_usuario, hashedPassword]
      );
  
      res.json(newUser.rows[0]);
    } catch (err) {
      console.error('Error adding user:', err.message);
      res.status(500).json({ error: 'Server error', message: err.message }); // Send the error message in the response
    }
});

// POST endpoint to check user credentials and login
app.post('/api/login', async (req, res) => {
    const { nombre_usuario, contraseña } = req.body;
  
    try {
      // Retrieve user from database by username
      const user = await pool.query('SELECT * FROM usuarios WHERE nombre_usuario = $1', [nombre_usuario]);
  
      // If user not found, return error
      if (user.rows.length === 0) {
        return res.status(401).json({ error: 'Username or password incorrect' });
      }
  
      // Compare hashed password from database with provided password
      const hashedPassword = user.rows[0].contraseña_hash;
      const passwordMatch = await bcrypt.compare(contraseña, hashedPassword);
  
      // If passwords match, login successful
      if (passwordMatch) {
        res.json({ message: 'Login successful' });
      } else {
        res.status(401).json({ error: 'Username or password incorrect' });
      }
    } catch (error) {
      console.error('Error logging in:', error);
      res.status(500).json({ error: 'Server error' });
    }
});
  
  
// Route to add an area
app.post('/api/areas', async (req, res) => {
    try {
      const { nombre, tipo, capacidad_maxima } = req.body;
      const newArea = await pool.query(
        'INSERT INTO Area (nombre, tipo, capacidad_maxima) VALUES ($1, $2, $3) RETURNING *',
        [nombre, tipo, capacidad_maxima]
      );
      res.json(newArea.rows[0]);
    } catch (err) {
      console.error(err.message);
      res.status(500).json({ error: 'Server error' });
    }
  });
  
  // Route to add a plate
  app.post('/api/plates', async (req, res) => {
    try {
      const { nombre, descripcion, precio } = req.body;
      const newPlate = await pool.query(
        'INSERT INTO Plato (nombre, descripcion, precio) VALUES ($1, $2, $3) RETURNING *',
        [nombre, descripcion, precio]
      );
      res.json(newPlate.rows[0]);
    } catch (err) {
      console.error(err.message);
      res.status(500).json({ error: 'Server error' });
    }
  });
  
  // Route to add a beverage
  app.post('/api/beverages', async (req, res) => {
    try {
      const { nombre, descripcion, precio } = req.body;
      const newBeverage = await pool.query(
        'INSERT INTO Bebida (nombre, descripcion, precio) VALUES ($1, $2, $3) RETURNING *',
        [nombre, descripcion, precio]
      );
      res.json(newBeverage.rows[0]);
    } catch (err) {
      console.error(err.message);
      res.status(500).json({ error: 'Server error' });
    }
  });

// Route to fetch all plates
app.get('/api/plates', async (req, res) => {
    try {
      const plates = await pool.query('SELECT * FROM Plato');
      res.json({ plates: plates.rows }); // Wrap the plates data in an object for consistency
    } catch (err) {
      console.error('Error fetching plates:', err);
      res.status(500).json({ error: 'Failed to fetch plates' }); // Provide a more specific error message
    }
  });
  
  // Route to fetch all beverages
  app.get('/api/beverages', async (req, res) => {
    try {
      const beverages = await pool.query('SELECT * FROM Bebida');
      res.json({ beverages: beverages.rows }); // Wrap the beverages data in an object for consistency
    } catch (err) {
      console.error('Error fetching beverages:', err);
      res.status(500).json({ error: 'Failed to fetch beverages' }); // Provide a more specific error message
    }
  });
  


  

const PORT = process.env.PORT || 3001;
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
