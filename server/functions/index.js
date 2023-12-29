/**
 * Import function triggers from their respective submodules:
 *
 * const {onCall} = require("firebase-functions/v2/https");
 * const {onDocumentWritten} = require("firebase-functions/v2/firestore");
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

const { onRequest } = require("firebase-functions/v2/https");
const logger = require("firebase-functions/logger");

const express = require("express");
const app = express();

app.get("/new", (req, res) => res.json({ content: "New Workout" }));

// Create and deploy your first functions
// https://firebase.google.com/docs/functions/get-started

exports.app = onRequest(app);
