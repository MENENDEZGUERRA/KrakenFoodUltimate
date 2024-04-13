import { useState } from 'react'

import './App.css'
import UserList from './UserList'
import AddUser from './AddUser'
import Login from './Login'
import Logo from './Logo'

function App() {
  const [count, setCount] = useState(0)

  return (
    <>
    <Logo />
    <AddUser />
    <Login />
    <UserList />
    </>
  )
}

export default App
