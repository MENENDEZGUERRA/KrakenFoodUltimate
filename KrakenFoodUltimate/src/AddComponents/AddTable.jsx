import React, { useState } from 'react';

function AddTable() {
  const [areaId, setAreaId] = useState('');
  const [capacidad, setCapacidad] = useState('');
  const [estado, setEstado] = useState('');

  const handleSubmit = async (event) => {
    event.preventDefault();
    try {
      const response = await fetch('http://localhost:3001/api/tables', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({ area_id: areaId, capacidad, estado }),
      });
      const data = await response.json();
      console.log('Table added successfully:', data);
    } catch (error) {
      console.error('Error adding table:', error);
    }
  };

  return (
    <div>
      <h2>Add Table</h2>
      <form onSubmit={handleSubmit}>
        <label>
          Area ID:
          <input type="number" value={areaId} onChange={(e) => setAreaId(e.target.value)} />
        </label>
        <br />
        <label>
          Capacidad:
          <input type="number" value={capacidad} onChange={(e) => setCapacidad(e.target.value)} />
        </label>
        <br />
        <label>
          Estado:
          <input type="text" value={estado} onChange={(e) => setEstado(e.target.value)} />
        </label>
        <br />
        <button type="submit">Add Table</button>
      </form>
    </div>
  );
}

export default AddTable;
