const express = require('express');
const uuid = require('uuid');

const app = express();
const port = 3000;

const makeUUID = () => {
	const id = uuid.v4();
	return () => id;
}

app.get('/', (req,res) => {
	res.send(id);
});

app.listen(port, () => {});

module.exports = {
	makeUUID
}