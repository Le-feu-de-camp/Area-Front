import React, {useEffect} from 'react';

const receiveMessage = event => {
    const { data } = event;
    if (data.source === 'lma-login-redirect') {
        // get the URL params and redirect to our server to use Passport to auth/login
        const { payload } = data;
        const redirectUrl = `/auth/google/login${payload}`;
        window.location.pathname = redirectUrl;
    }
};

function WindowComponent() {
    useEffect(() => {
        const params = window.location.search;
        if (window.opener) {
            window.opener.postMessage(params);
            window.close();
        }
    });
    return (<p>Loading...</p>);
};

const openSignInWindow = (url, name) => {
    let previousUrl = null;
    let windowRef = null;
    const windowFeatures =
        'toolbar=no, menubar=no, width=600, height=700, top=100, left=100';

    window.removeEventListener('message', receiveMessage);
    if (windowRef === null || windowRef.closed) {
        windowRef = window.open(url, name, windowFeatures);
    } else if (previousUrl !== url) {
        windowRef = window.open(url, name, windowFeatures);
        windowRef.focus();
    } else {
        windowRef.focus();
    }
    window.addEventListener('message', event => receiveMessage(event), false);
    //    previousUrl = url;
};

export default function openPopup(url) {
    openSignInWindow(url, 'Google');
    return (<WindowComponent />);
}