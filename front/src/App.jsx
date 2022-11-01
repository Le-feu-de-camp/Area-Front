import { HashRouter, Routes, Route } from "react-router-dom"

import Register from "./Authentification/Register"
import Login from "./Authentification/Login"
import LogoutUser from "./Authentification/LogOut"
import Home from "./Pages/Home"
import Create from "./Pages/Create"
import Edit from "./Pages/Edit"
import UserProfil from "./Settings/UserProfil"
import Appearance from "./Settings/Appearance"
import Identification from "./Settings/Identification"
import APIPage from "./Settings/KeyManagement"
import { GoogleOAuthProvider } from '@react-oauth/google';

function App() {
    return (
        <GoogleOAuthProvider clientId={"786358951542-6embdk4g0midg0odojrc55fq969jrs0a.apps.googleusercontent.com"}>
            <HashRouter>
                <Routes>
                    <Route path="/" element={<Login />} />
                    <Route path="/login" element={<Login />} />
                    <Route path="/register" element={<Register />} />
                    <Route path="/home" element={<Home />} />
                    <Route path="/logout" element={<LogoutUser />} />
                    <Route path='/create' element={<Create />} />
                    <Route path='/edit/:id' element={<Edit />} />
                    <Route path='/create' element={<Create />} />
                    <Route path='/profil' element={<UserProfil />} />
                    <Route path='/identification' element={<Identification />} />
                    <Route path='/appearance' element={<Appearance />} />
                    <Route path='/keys' element={<APIPage />} />
                </Routes>
            </HashRouter>
        </GoogleOAuthProvider>
    );
}

export default App;