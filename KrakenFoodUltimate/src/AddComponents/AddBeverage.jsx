import React, { useState } from 'react';

function AddBeverage() {
  const [nombre, setNombre] = useState('');
  const [descripcion, setDescripcion] = useState('');
  const [precio, setPrecio] = useState('');

  const handleSubmit = async (event) => {
    event.preventDefault();
    try {
      const response = await fetch('http://localhost:3001/api/beverages', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({ nombre, descripcion, precio }),
      });
      const data = await response.json();
      console.log('Beverage added successfully:', data);
    } catch (error) {
      console.error('Error adding beverage:', error);
    }
  };

  return (
    <div>
      <h2>Add Beverage</h2>
      <form onSubmit={handleSubmit}>
        <label>
          Nombre:
          <input type="text" value={nombre} onChange={(e) => setNombre(e.target.value)} />
        </label>
        <br />
        <label>
          Descripción:
          <input type="text" value={descripcion} onChange={(e) => setDescripcion(e.target.value)} />
        </label>
        <br />
        <label>
          Precio:
          <input type="number" value={precio} onChange={(e) => setPrecio(e.target.value)} />
        </label>
        <br />
        <button type="submit">Add Beverage</button>
      </form>
    </div>
  );
}

export default AddBeverage;
