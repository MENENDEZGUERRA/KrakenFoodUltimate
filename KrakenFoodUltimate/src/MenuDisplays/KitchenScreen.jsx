// KitchenScreen.jsx
import React, { useState, useEffect } from 'react';

function KitchenScreen() {
  const [plates, setPlates] = useState([]);

  useEffect(() => {
    fetch('http://localhost:3001/api/plates') // Assuming your backend server is running on localhost:3001
      .then(response => response.json())
      .then(data => {
        console.log(data); // Logging the fetched data to the console
        if (Array.isArray(data.plates)) {
          setPlates(data.plates); // Setting the fetched data to the state
        } else {
          console.error('Data fetched does not contain a valid array:', data);
        }
      })
      .catch(error => {
        console.error('Error fetching plates data:', error);
      });
  }, []);

  return (
    <div>
      <h2>Kitchen Screen</h2>
      <ul>
        {Array.isArray(plates) && plates.map(plate => (
          <li key={plate.plato_id}>
            <strong>Name:</strong> {plate.nombre}, <strong>Description:</strong> {plate.descripcion}, <strong>Price:</strong> {plate.precio}
          </li>
        ))}
      </ul>
    </div>
  );
}

export default KitchenScreen;
