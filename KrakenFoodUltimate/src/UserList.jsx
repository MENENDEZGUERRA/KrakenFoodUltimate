import React, { useState, useEffect } from 'react';

function UserList() {
  const [users, setUsers] = useState([]);

  useEffect(() => {
    fetch('http://localhost:3001/api/data') // Assuming your backend server is running on localhost:3001
      .then(response => response.json())
      .then(data => {
        console.log(data); // Logging the fetched data to the console
        setUsers(data); // Setting the fetched data to the state
      })
      .catch(error => {
        console.error('Error fetching data:', error);
      });
  }, []);

  return (
    <div>
      <h2>User List</h2>
      <ul>
        {users.map(user => (
          <li key={user.usuario_id}>{user.nombre_usuario}</li>
        ))}
      </ul>
    </div>
  );
}

export default UserList;
