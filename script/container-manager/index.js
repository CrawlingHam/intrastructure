const path = require("path");

const { validateActions, extractFromArgs, action } = require("./args");
const { build, run } = require("./compose");

const parentDir = path.join(__dirname, "..", "..");

async function containerManager() {
    try {
        validateActions();
        const { services, buildFlag, detachedFlag } = extractFromArgs();

        const buildArgs = build(parentDir, services);
        const serviceNames = services.length === 0 ? ["all"] : services;

        console.log(`🚀 Action: ${action}`);
        console.log(`📦 Services: ${serviceNames.join(", ")}`);
        console.log(`🏗️  Build: ${buildFlag ? "Yes" : "No"}`);
        console.log(`🔄 Detached: ${detachedFlag ? "Yes" : "No"}`);
        console.log("");

        let args = [...buildArgs, action];
        if (detachedFlag) args.push("-d");
        if (action === "logs") args.push("-f");

        switch (action) {
            case "up":
                console.log("🟢 Starting services...");
                if (buildFlag) {
                    console.log("🔨 Building services first...");
                    await run([...buildArgs, "build"], parentDir);
                    console.log("✅ Build completed successfully");
                }
                break;
            case "build":
                console.log("🔨 Building services...");
                break;
            case "down":
                console.log("🟡 Stopping services...");
                break;
            case "restart":
                console.log("🔄 Restarting services...");
                break;
            case "logs":
                console.log("📋 Showing logs...");
                break;
            default:
                throw new Error(`Unknown action: ${action}`);
        }

        await run(args, parentDir);
        console.log(`✅ ${action.charAt(0).toUpperCase() + action.slice(1)} completed successfully`);
    } catch (error) {
        console.error("❌ Error:", error.message);
        process.exit(1);
    }
}

containerManager();
