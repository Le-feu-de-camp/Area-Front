import { useState, useEffect } from "react"
import { useGoogleLogin } from "@react-oauth/google";

import SettingsNavBar from "./SettingsNavBar"
import Container from "../Tools/Container"
import SwitchTheme from "../Tools/SwitchTheme"
import AXIOS from "../Tools/Client"

function APIPage() {
    SwitchTheme();

    var url = localStorage.getItem("platform") === "mobile" ? "file:///android_asset/www/index.html" : "http://" + window.location.href.split("/")[2]
    var token = "Bearer " + localStorage.getItem("token");
    var user_url = localStorage.getItem("url") + "/current_user";
    const [spotifyText, setSpotifyText] = useState("Login with Spotify");
    const [googleText, setGoogleText] = useState("Login with Google");

    useEffect(() => {
        AXIOS.get(user_url, { headers: { Authorization: token } })
            .then(function (res) {
                if (res.data.spotify_token !== null) {
                    setSpotifyText("Logout from Spotify");
                }
            })
    }, [spotifyText, token, user_url])


    function logoutSpotify() {
        var logout_url = localStorage.getItem("url") + `/users/delete_token`;

        AXIOS.post(logout_url, { headers: { Authorization: token } })
            .then((res) => { setSpotifyText("Login with Spotify") })
            .catch((err) => console.log(err))
    }

    const googleLogin = useGoogleLogin({
        onSuccess: tokenResponse => {
            var url_target = localStorage.getItem("url") + `/users/refresh_token`;
            const token = "Bearer " + localStorage.getItem("token");
            var access_token = {
                "refresh_token": {
                    "name": "google",
                    "code": tokenResponse.code,
                    "redirect_uri": localStorage.getItem("platform") === "mobile" ? "file:///android_asset/www/index.html" : "http://" + window.location.href.split("/")[2]
                }
            }
            setGoogleText("Logout from Google");
            AXIOS.post(url_target, access_token, { headers: { Authorization: token } })
                .catch((err) => Error(err))
        },
        flow: 'auth-code',
        scope: `https://www.googleapis.com/auth/gmail.modify`,
        onError: error => Error({ "res": error })
    })

    function googleLogout() {
        var logout_url = localStorage.getItem("url") + `/users/delete_token`;

        AXIOS.post(logout_url, { headers: { Authorization: token } })
            .then((res) => { setSpotifyText("Login with Google") })
            .catch((err) => Error(err))
    }

    return (
        <>
            <SettingsNavBar currentPage="API" />
            <div className="content large">
                <Container type="large" key="Spotify">
                    {
                        (spotifyText === "Login with Spotify") ? <a className="spotify" href={`https://accounts.spotify.com/authorize?client_id=${process.env.SPOTIFY_CLIENT_ID}&redirect_uri=${url}&response_type=code&scope=user-library-read,playlist-modify-public,playlist-modify-private,user-read-private,user-read-email`}>{spotifyText}</a>
                            : <button className="spotify spotify-button" onClick={() => { logoutSpotify() }}>{spotifyText}</button>
                    }
                </Container>

                <Container type="large" key="Google">
                    <button className="google-button" onClick={() => { (googleText === "Login with Google") ? googleLogin() : googleLogout() }}>{googleText}</button>
                </Container>
            </div>
        </>
    );
}

export default APIPage;