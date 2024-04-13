// BarScreen.jsx
import React, { useState, useEffect } from 'react';

function BarScreen() {
  const [beverages, setBeverages] = useState([]);

  useEffect(() => {
    fetch('http://localhost:3001/api/beverages')
      .then(response => response.json())
      .then(data => {
        console.log(data); // Log the fetched data
        if (Array.isArray(data.beverages)) {
          setBeverages(data.beverages); // Access the 'beverages' array from the data object
        } else {
          console.error('Data fetched does not contain a valid array:', data);
        }
      })
      .catch(error => {
        console.error('Error fetching beverages data:', error);
      });
  }, []);

  console.log(beverages); // Log the state of beverages

  return (
    <div>
      <h2>Bar Screen</h2>
      <ul>
        {Array.isArray(beverages) && beverages.map(beverage => (
          <li key={beverage.bebida_id}>
            <strong>Name:</strong> {beverage.nombre}, <strong>Description:</strong> {beverage.descripcion}, <strong>Price:</strong> {parseFloat(beverage.precio).toFixed(2)}
          </li>
        ))}
      </ul>
    </div>
  );
}

export default BarScreen;
