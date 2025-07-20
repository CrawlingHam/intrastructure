const { spawn } = require("child_process");
const path = require("path");

const FRONTEND_SERVICES = ["auth-app", "nav-react"];
const BACKEND_SERVICES = ["auth-api", "gateway"];
const SERVICES = [...FRONTEND_SERVICES, ...BACKEND_SERVICES];

function build(parentDir, services) {
    const baseContainers = [
        path.join(parentDir, "networks.yaml"),
        path.join(parentDir, "proxy.yaml"),
        path.join(parentDir, "frontend", "proxy.yaml"),
        path.join(parentDir, "backend", "proxy.yaml"),
    ];

    let args = [];

    for (const container of baseContainers) args.push("-f", container);

    const servicesToInclude = services.length === 0 || services.includes("all") ? SERVICES : [...new Set(services)];

    for (const service of servicesToInclude) {
        switch (service) {
            case "auth-app":
                args.push("-f", path.join(parentDir, "frontend", "authentication.yaml"));
                break;
            case "nav-react":
                args.push("-f", path.join(parentDir, "frontend", "navigationbars", "react.yaml"));
                break;
            case "gateway":
                args.push("-f", path.join(parentDir, "backend", "gateway.yaml"));
                break;
            case "auth-api":
                args.push("-f", path.join(parentDir, "backend", "authentication.yaml"));
                break;
            default:
                throw new Error(`Unknown service '${service}'`);
        }
    }

    return args;
}

function run(args, parentDir, showOutput = true) {
    return new Promise((resolve, reject) => {
        const child = spawn("docker-compose", args, {
            stdio: showOutput ? "inherit" : "pipe",
            cwd: parentDir,
        });

        child.on("close", (code) => {
            if (code === 0) resolve();
            else reject(new Error(`docker-compose exited with code ${code}`));
        });

        child.on("error", (err) => reject(err));
    });
}

module.exports = { build, run };
