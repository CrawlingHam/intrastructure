async function getCurrentDNSRecord({ zoneId, recordId, apiToken }) {
    const url = `https://api.cloudflare.com/client/v4/zones/${zoneId}/dns_records/${recordId}`;
    console.log(`🔍 Getting current record from: ${url}`);

    const response = await fetch(url, {
        headers: {
            Authorization: `Bearer ${apiToken}`,
            "Content-Type": "application/json",
        },
        method: "GET",
    });

    if (!response.ok) {
        const errorText = await response.text();
        console.log(`❌ Response body: ${errorText}`);
        throw new Error(`HTTP error! status: ${response.status}`);
    }

    const result = await response.json();
    return result.result;
}

async function updateDNSRecord({ zoneId, recordId, recordName, ip, apiToken }) {
    const data = {
        name: recordName,
        proxied: true,
        content: ip,
        type: "A",
        ttl: 1,
    };

    const url = `https://api.cloudflare.com/client/v4/zones/${zoneId}/dns_records/${recordId}`;
    console.log(`🔍 Updating record at: ${url}`);
    console.log(`📝 Request data:`, data);

    const response = await fetch(url, {
        body: JSON.stringify(data),
        method: "PUT",
        headers: {
            Authorization: `Bearer ${apiToken}`,
            "Content-Type": "application/json",
        },
    });

    if (!response.ok) {
        const errorText = await response.text();
        console.log(`❌ Response body: ${errorText}`);
        throw new Error(`HTTP error! status: ${response.status}`);
    }

    return await response.json();
}

async function updateDNSRecords({ records, ip, credentials }) {
    const results = await Promise.all(
        records.map(async (record) => {
            console.log(`🔍 Checking ${record.description}...`);

            const currentRecord = await getCurrentDNSRecord({
                apiToken: credentials.apiToken,
                zoneId: credentials.zoneId,
                recordId: record.recordId,
            });

            console.log(`📊 Current DNS record (${record.description}): ${currentRecord.content}`);
            console.log(`📊 New IP address: ${ip}`);

            if (currentRecord.content === ip) {
                console.log(`✅ IP address unchanged for ${record.description}, no update needed`);
                return { record, needsUpdate: false, result: null };
            }

            console.log(`🔄 IP address changed for ${record.description}, updating DNS record...`);

            const result = await updateDNSRecord({
                apiToken: credentials.apiToken,
                recordName: record.recordName,
                zoneId: credentials.zoneId,
                recordId: record.recordId,
                ip,
            });

            console.log(`✅ Cloudflare Response for ${record.description}:`, result);
            return { record, needsUpdate: true, result };
        })
    );

    const updatesNeeded = results.filter((r) => r.needsUpdate);
    const noUpdatesNeeded = results.filter((r) => !r.needsUpdate);

    return { updatesNeeded, noUpdatesNeeded };
}

module.exports = { getCurrentDNSRecord, updateDNSRecord, updateDNSRecords };
