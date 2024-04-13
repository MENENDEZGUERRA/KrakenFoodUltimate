import React, { useState } from 'react';
import './App.css';
import Logo from './Logo';
import StartScreen from './StartScreen';
import Login from './Login';
import ActionsPage from './ActionsPage';
import AddUser from './AddUser';

function App() {
  const [loggedIn, setLoggedIn] = useState(false);

  const handleLoginSuccess = () => {
    setLoggedIn(true);
  };

  return (
    <div className="App">
      {loggedIn ? (
        <>
          <ActionsPage />
          {/* Optionally include other components for the logged-in user */}
        </>
      ) : (
        <>
          <Logo />
          <AddUser />
          <Login onLoginSuccess={handleLoginSuccess} />
          {/* Optionally include other components for the non-logged-in user */}
        </>
      )}
    </div>
  );
}

export default App;
