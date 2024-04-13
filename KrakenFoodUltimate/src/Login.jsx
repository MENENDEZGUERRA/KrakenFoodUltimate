import React, { useState } from 'react';

function Login() {
  const [nombreUsuario, setNombreUsuario] = useState('');
  const [contraseña, setContraseña] = useState('');
  const [error, setError] = useState('');

  const handleNombreUsuarioChange = (event) => {
    setNombreUsuario(event.target.value);
  };

  const handleContraseñaChange = (event) => {
    setContraseña(event.target.value);
  };

  const handleSubmit = async (event) => {
    event.preventDefault();

    try {
      // Make a POST request to check user credentials
      const response = await fetch('http://localhost:3001/api/login', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          nombre_usuario: nombreUsuario,
          contraseña: contraseña,
        }),
      });

      const data = await response.json();
      if (response.ok) {
        // Login successful
        console.log('Login successful:', data);
        setError('');
        // Redirect user to dashboard or desired page
      } else {
        // Login failed
        setError(data.error);
      }
    } catch (error) {
      console.error('Error logging in:', error);
      setError('Server error');
    }
  };

  return (
    <div>
      <h2>Login</h2>
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
        <button type="submit">Login</button>
        {error && <p>{error}</p>}
      </form>
    </div>
  );
}

export default Login;
