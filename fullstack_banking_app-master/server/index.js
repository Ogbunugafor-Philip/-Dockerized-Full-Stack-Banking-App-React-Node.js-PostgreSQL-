const express = require('express');
const cors = require('cors');
const authRoute = require('./routes/auth');
const profileRoute = require('./routes/profile');
require('dotenv').config();

const app = express();
const PORT = process.env.PORT || 5000;

app.use(express.json());
app.use(cors());

// 🔹 Simple GET route for testing
app.get("/test", (req, res) => {
  res.send("Backend is working!");
});

// 🔹 Auth and profile routes
app.use(authRoute);
app.use(profileRoute);

// 🔹 Catch-all for undefined routes
app.use("*", (req, res) => {
  res.json("Page not found.");
});

app.listen(PORT, () => {
  console.log(`server started on port ${PORT}`);
});
