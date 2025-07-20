const { loadEnv, validateCredentials, getPublicIP } = require("./utils");
const { updateDNSRecords } = require("./cloudflare");

(async () => {
    try {
        loadEnv();

        const ip = await getPublicIP();
        console.log(`✅ Public IP retrieved: ${ip}`);

        const credentials = {
            recordName2: process.env.CF_A_RECORD_NAME_2,
            recordName: process.env.CF_A_RECORD_NAME,
            recordId2: process.env.CF_A_RECORD_ID_2,
            recordId: process.env.CF_A_RECORD_ID,
            apiToken: process.env.CF_API_TOKEN,
            zoneId: process.env.CF_ZONE_ID,
        };

        validateCredentials(credentials);

        const records = [
            {
                recordName: credentials.recordName,
                recordId: credentials.recordId,
                description: "First A record",
            },
            {
                recordName: credentials.recordName2,
                recordId: credentials.recordId2,
                description: "Second A record",
            },
        ];

        console.log("🚀 Starting concurrent DNS record checks...");

        const { updatesNeeded, noUpdatesNeeded } = await updateDNSRecords({ records, ip, credentials });

        if (updatesNeeded.length === 0) {
            console.log("\n✅ All DNS records are up to date, no updates needed");
        } else {
            console.log(`\n✅ Successfully updated ${updatesNeeded.length} DNS record(s)`);
            if (noUpdatesNeeded.length > 0) {
                console.log(`ℹ️  ${noUpdatesNeeded.length} record(s) were already up to date`);
            }
        }
    } catch (err) {
        console.error("❌ Error:", err);
    }
})();
