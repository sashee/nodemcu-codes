client = new Paho.MQTT.Client(location.hostname, 9001, "clientId" + new Date().getTime());

var bal = false;
var jobb = false;

const balOn = () => {
	if (bal === false) {
		message = new Paho.MQTT.Message("1");
		message.destinationName = "/bal";
		client.send(message);
		bal = true;
	}
};
const balOff = () => {
	if (bal === true) {
		message = new Paho.MQTT.Message("0");
		message.destinationName = "/bal";
		client.send(message);
		bal = false;
	}
};
const jobbOn = () => {
	if (jobb === false) {
		message = new Paho.MQTT.Message("1");
		message.destinationName = "/jobb";
		client.send(message);
		jobb = true
	}
};
const jobbOff = () => {
	if (jobb === true) {
		message = new Paho.MQTT.Message("0");
		message.destinationName = "/jobb";
		client.send(message);
		jobb = false;
	}
};
function onConnect() {
	// Once a connection has been made, make a subscription and send a message.
	console.log("onConnect");
}

client.connect({onSuccess:onConnect});


document.addEventListener("keydown", (event) => {
	if (event.keyCode === 38) {
		jobbOn();
		balOn();
	}else if (event.keyCode === 37) {
		jobbOn();
	}else if (event.keyCode === 39) {
		balOn();
	}
});
document.addEventListener("keyup", (event) => {
	if (event.keyCode === 38) {
		jobbOff();
		balOff();
	}else if (event.keyCode === 37) {
		jobbOff();
	}else if (event.keyCode === 39) {
		balOff();
	}
});
