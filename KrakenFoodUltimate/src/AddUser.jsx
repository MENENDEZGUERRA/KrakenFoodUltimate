import React, { useState } from 'react';

function AddUser() {
  const [nombreUsuario, setNombreUsuario] = useState('');
  const [contraseña, setContraseña] = useState('');

  const handleNombreUsuarioChange = (event) => {
    setNombreUsuario(event.target.value);
  };

  const handleContraseñaChange = (event) => {
    setContraseña(event.target.value);
  };

  const handleSubmit = async (event) => {
    event.preventDefault();

    // Check if both username and password are provided
    if (!nombreUsuario || !contraseña) {
      console.error('Username and password must be provided');
      return;
    }

    try {
      // Make a POST request to add the new user
      const response = await fetch('http://localhost:3001/api/addUser', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          nombre_usuario: nombreUsuario,
          contraseña: contraseña, // Ensure contraseña is passed correctly
        }),
      });

      // Parse response JSON
      const data = await response.json();
      console.log('User added successfully:', data);

      // Clear input fields after successful submission
      setNombreUsuario('');
      setContraseña('');
    } catch (error) {
      console.error('Error adding user:', error);
    }
  };

  return (
    <div>
      <h2>Add User</h2>
      <form onSubmit={handleSubmit}>
        <label>
          Username:
          <input type="text" value={nombreUsuario} onChange={handleNombreUsuarioChange} />
        </label>
        <br />
        <label>
          Password:
          <input type="password" value={contraseña} onChange={handleContraseñaChange} />
        </label>
        <br />
        <button type="submit">Add User</button>
      </form>
    </div>
  );
}

export default AddUser;
