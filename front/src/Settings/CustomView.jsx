export default function OpenBrowser(url) {

    var target = "_self"; // _system
    var ref = window.open(url, target, "fullscreen=no");

    ref.addEventListener("exit", exitCallback);

    function exitCallback() {
        ref.close();
        console.log("Browser is closed")
    }
}