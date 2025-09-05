const express = require("express");
const app = express();
const port = 3000;

app.get("/", (req, res) => {
  res.json({ message: "Hello from Node.js backend running on Docker Swarm!" });
});

app.listen(port, () => {
  console.log(`Backend service listening on port ${port}`);
});
