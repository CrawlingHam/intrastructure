const actions = ["up", "down", "restart", "logs", "build"];

const args = process.argv.slice(2);
const action = args[0];

function validateActions() {
    if (!action) {
        console.error("❌ No action provided");
        console.error(`Valid actions: ${actions.join(", ")}`);
        process.exit(1);
    }

    if (!actions.includes(action)) {
        console.error(`❌ Invalid action: ${action}`);
        console.error(`Valid actions: ${actions.join(", ")}`);
        process.exit(1);
    }
}

function extractFromArgs() {
    let services = [];
    let flags = [];

    for (let i = 1; i < args.length; i++) {
        const arg = args[i];
        if (arg.startsWith("--")) flags.push(arg);
        else services.push(arg);
    }

    return {
        detachedFlag: flags.includes("--detached") || flags.includes("-d"),
        buildFlag: flags.includes("--build") || flags.includes("-b"),
        services,
    };
}

module.exports = { validateActions, extractFromArgs, action };
