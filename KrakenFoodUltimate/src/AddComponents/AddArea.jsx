import React, { useState } from 'react';

function AddArea() {
  const [nombre, setNombre] = useState('');
  const [tipo, setTipo] = useState('');
  const [capacidadMaxima, setCapacidadMaxima] = useState('');

  const handleSubmit = async (event) => {
    event.preventDefault();
    try {
      const response = await fetch('http://localhost:3001/api/areas', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({ nombre, tipo, capacidad_maxima: capacidadMaxima }),
      });
      const data = await response.json();
      console.log('Area added successfully:', data);
    } catch (error) {
      console.error('Error adding area:', error);
    }
  };

  return (
    <div>
      <h2>Add Area</h2>
      <form onSubmit={handleSubmit}>
        <label>
          Nombre:
          <input type="text" value={nombre} onChange={(e) => setNombre(e.target.value)} />
        </label>
        <br />
        <label>
          Tipo:
          <input type="text" value={tipo} onChange={(e) => setTipo(e.target.value)} />
        </label>
        <br />
        <label>
          Capacidad Máxima:
          <input type="number" value={capacidadMaxima} onChange={(e) => setCapacidadMaxima(e.target.value)} />
        </label>
        <br />
        <button type="submit">Add Area</button>
      </form>
    </div>
  );
}

export default AddArea;
