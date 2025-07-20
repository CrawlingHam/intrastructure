const path = require("path");
const fs = require("fs");

function loadEnv() {
    console.log("🔍 Loading environment variables");
    const envPath = path.join(__dirname, "..", "..", ".env");

    if (fs.existsSync(envPath)) {
        const envContent = fs.readFileSync(envPath, "utf8");

        envContent.split("\n").forEach((line) => {
            const [key, ...valueParts] = line.split("=");

            if (key && valueParts.length > 0) process.env[key.trim()] = valueParts.join("=").trim();
        });
    }

    console.log("✅ Environment variables loaded");
}

function validateCredentials(credentials) {
    console.log("🔍 Validating credentials");

    const credentialsValues = Object.values(credentials);

    for (const credential of credentialsValues) {
        if (!credential) {
            const missingCredential = Object.keys(credentials)[credentialsValues.indexOf(credential)];
            throw new Error(`❌ Missing credential: ${missingCredential}`);
        }
    }

    console.log("✅ All credentials are present");
}

async function getPublicIP() {
    const endpoint = "https://ifconfig.me";
    console.log(`🔍 Making request to: ${endpoint}`);

    const response = await fetch(endpoint);
    if (!response.ok) throw new Error(`HTTP error! status: ${response.status}`);

    const html = await response.text();

    const ipRegex = /<strong[^>]*id="ip_address"[^>]*>\s*([\d.]+)\s*<\/strong>/i;
    const match = html.match(ipRegex);

    if (!match) throw new Error('Element with id "ip_address" not found');

    return match[1].trim();
}

module.exports = { loadEnv, validateCredentials, getPublicIP };
