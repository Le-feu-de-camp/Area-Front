import '../css/colors.css'
import '../css/style.css'

import Navbar from '../Tools/Navbar'
import Load from '../Tools/Load'
import Error from '../Tools/Error'
import CreateForm from './CreateForm'

import { useState, useEffect } from 'react'
import axios from 'axios'

function Create() {
    const [element, setElement] = useState(<Load/>)

    useEffect(() => {
        axios.get(localStorage.getItem('url') + '/about.json')
            .then(function (res) { setElement(<CreateForm json={res.data}/>) })
            .catch(function (err) { setElement(<Error msg="La requête vers le serveur a échouée." error={err} />) });
      }, []);

    return (
        <>
            <Navbar currentPage="Create" />
            <div className="content">
                {element}
            </div>
        </>
    );
}

export default Create