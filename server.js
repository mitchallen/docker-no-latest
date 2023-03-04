/**
 * Author: Mitch Allen 
 * https://scriptable.com
 * https://mitchallen.com
 */

const express = require('express');
const app = express();
const port = 3000;

app.get('/', (req, res) => {
  res.send('Server Demo!');
});

const server = app.listen(port, () => {
  console.log(`Server listening on port ${port}`);
});

process.on('SIGINT', () => {
  console.debug('\nSIGINT signal received: closing HTTP server')
  server.close(() => {
    console.debug('HTTP server closed')
  })
})

process.on('SIGTERM', () => {
  console.debug('\nSIGTERM signal received: closing HTTP server')
  server.close(() => {
    console.debug('HTTP server closed')
  })
})