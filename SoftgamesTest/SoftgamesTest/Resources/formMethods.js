function submitNames() {
    var message = {
        name: document.getElementById("fname").value,
        lname: document.getElementById("lname").value
    };
    window.webkit.messageHandlers.observer.postMessage(message);
}

function submitDates() {
    var message = {
        date: document.getElementById("birthday").value,
    };
    window.webkit.messageHandlers.observer.postMessage(message);
}

function notify() {
    var message = {
        notify: "",
    };
    window.webkit.messageHandlers.observer.postMessage(message);
}
