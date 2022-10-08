import { BrowserRouter, Routes, Route } from 'react-router-dom'

import Register from './Authentification/Register.jsx'
import Login from './Authentification/Login.jsx'
import Home from './Pages/Home'
import Create from './Pages/Create'

import './css/app.css';

function App() {
  return (
    <>
      <BrowserRouter>
          <Routes>
            <Route path='/' element={<Login/>} />
            <Route path='/login' element={<Login/>} />
            <Route path='/register' element={<Register/>} />
            <Route path='/home' element={<Home/>} />
            <Route path='/create' element={<Create/>} />
        </Routes>
      </BrowserRouter>
    </>
  );
}

export default App;