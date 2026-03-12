Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013052.outbound.protection.outlook.com [40.93.201.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093AA2FE066;
	Thu, 12 Mar 2026 17:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773337236; cv=fail; b=uEy/I0QaT3nUyJqxCbiZyYghTKuzLXN8olVVZzsQ1OcdFyibdrRcrIsVM6RWjGvgT5cfDmIrqUldBDKV9MOwmLyd0DVShb0T1YVkRdl5/0hAUL56DkHt82GPK/pkPHA8zxV+M9vlzhSV0p+bikeOvKm+DnE2Dij/u0MiFKZdwl4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773337236; c=relaxed/simple;
	bh=ZU8xLLT/vrCpIXzZkrOd2sADSyB7j09v8TmW/6oWJWk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tWcG9veVZBrCghNwMa4T28kkUdUAGPdJtSa4tCZaH/RaWUSUncndUOpT4+xGUSMTH9ZmLdjsf6NdzAV3Ce/w5L7rZCL4klmKQaznVXQSRep3ULASfqn+1NaalqCgMZj8NIg9BP82NrPEyLbeReS7iALiSBA8TalsYhtHum3Y4H4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tFkT9u02; arc=fail smtp.client-ip=40.93.201.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tFkT9u02"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sg8uF+fEJLpMLAmcI23RxViePufPtat9MchzkTBk7UpFttNlcazkvPCvn4u456q5nTr8yh2ENfvzEeZEk1vSb7SllMG/4ZOs+YATz+SvlbX3HtbIE0BRENfN5zJNJG+UauGLE5pMdK9yA/jDgMgT+Dk1zCxI4KtIXh84+UfiS1EeQxh/GGu8ClVpzN6zKEUIGI4Hb6AlUnc2SqYWxZtlTGj2LUF9cpXSpVftQdjDmwcAzTU45DNSQw96Go/qNOFzd6WYPjSh0hxw1z2Et/zMtqTQf4uAGd8Pr0WwUVnt3wJY/OYnJ0tZaFdyxrfRYVcDQBPFErxFcu5FjOo2ifZbxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=07vyBeJURv8H6MFtvs6x930jEhHUd3uoBFGZSqh7bsQ=;
 b=J4WSCBwD1+wEVEZIg9OLjcabtRlHw2/ot4CV9bPZFoFKyZfp6xQosE71yxBuqAULsK6Br370uw8zwJkLb20x3HqOACMZX+g3ZlS6xeWks5D/D3+EozGyP2yMNq1CzfSbJEzW3ARy0L1zO+60Rnf8R0vmNToxm5gfp46RGb0L+pFHBtMlVoN4x1ZzQwcTxQoFjgYPSVcOcaueJ561y2e/9VmuGLvQnltJPOgzuN+Mt6KVuXQ15LwvdvK5+q5gFIL2G4SFFaL/xnGDmNoQlZ1QHMmb68BTwIU0E7fs6luVv5hBeimmh2Q4LqDZulVQuF5ppivw6lJ9pPoC+104vLs3hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=07vyBeJURv8H6MFtvs6x930jEhHUd3uoBFGZSqh7bsQ=;
 b=tFkT9u02dDgQNoikKUp9dnGg9b3GdI1uKD6suq0li7IZl3fsNK4dOJ9499/HykDcGz464jIW/YgkXCAOxJecpyuTyt2Vx4rit6Qw3otyZjSmMqPmZOuOb+sDnjo9mn5UGbuaBn3wV2M4ptguZq07xHTbqFNBCnI0VXZ7/mAsHU8=
Received: from MN2PR01CA0066.prod.exchangelabs.com (2603:10b6:208:23f::35) by
 IA1PR12MB6211.namprd12.prod.outlook.com (2603:10b6:208:3e5::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.7; Thu, 12 Mar 2026 17:40:32 +0000
Received: from BN3PEPF0000B06C.namprd21.prod.outlook.com
 (2603:10b6:208:23f:cafe::bc) by MN2PR01CA0066.outlook.office365.com
 (2603:10b6:208:23f::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.27 via Frontend Transport; Thu,
 12 Mar 2026 17:40:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN3PEPF0000B06C.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.1 via Frontend Transport; Thu, 12 Mar 2026 17:40:32 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 12 Mar
 2026 12:40:25 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 12 Mar
 2026 12:36:15 -0500
Received: from amd-BIRMANPLUS.mshome.net (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Thu, 12 Mar 2026 12:36:13 -0500
From: Jason Andryuk <jason.andryuk@amd.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
	<jirislaby@kernel.org>, Juergen Gross <jgross@suse.com>, Stefano Stabellini
	<sstabellini@kernel.org>, Oleksandr Tyshchenko
	<oleksandr_tyshchenko@epam.com>
CC: Jason Andryuk <jason.andryuk@amd.com>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
	<xen-devel@lists.xenproject.org>
Subject: [PATCH] hvc/xen: Check console connection flag
Date: Thu, 12 Mar 2026 13:38:44 -0400
Message-ID: <20260312173845.47235-1-jason.andryuk@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: jason.andryuk@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06C:EE_|IA1PR12MB6211:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d4849b2-c6fd-4998-a035-08de805e75a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|30052699003|36860700016|1800799024|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ymtyRnfE3ZvQUhU1pERSLT7qLhoAJ8g+hmJl/BfwnAjMx0BV+l4EKysHcFWfZlccmVCiZlFv/zcqtRE38nvlOieIwnlzILJQ0Zdqfg+BOMfGWjHiKtkYkHkw14yjx8fCA4J8EgaRrHrpd35JY1fDkl6iJ8DwEH+i/BSijn/geceaDZ97RDYa1OHI4RqOPI+udOGw+dDN+rRnMknjV7f2jpo9E0YzLdqSsOFLuVEO2bit72BxZUwuPqVfUnXD6M56hy8Lzkz9U/xe0jkMTh009HIiwa+vs/RJU5eAG+7kfCfqbfmFDgeE43j8IAF3I2Prioh9zL2lfSfZmeThl15QyRndGOOJF+nwfPtylgIZbWtG3Hquf0i4r4+Vbp+QCDYNzWrMdoKtOcOZBVKhxHI2ncuWTH4Bx0OJbt8NJdOnHQrCRzXkk88Lg2amz5gBNs4VMNIrbDlGHPKQAFU5NAJJcYme4qyxpDFuOJL9B+cGZqzevfil2+37Prqafrc9u5PTkcxKVfI3HwNhwy+98EblccjtB2QeFOnJ0EUQ5j7AtReq8wxKnJzrvrkCilUn5Id3TRdzSLV5yVbMTgpi1osJsL6QTuNuAjkoaG6d1AxXkpw6kmOEPTSXSLiIPvsJ9cAPtBKon21strWohTSPEQIIhg93+9NkLE+gmCF67kHASAJbYFpFwSnx4/MDXvLM+L/q5ZR71W0is7trAt2Cpm49WMQsffxmI5zbFWoGxMfBaqU9rMM8KRy/Sp+xjxz/JMbTh6gHq5k/5Ml+wSTiXNc+Kw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(30052699003)(36860700016)(1800799024)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	KgGtq4XNktfI7JVL0t7pdU+cJRf26J3nng+D5I13pZK+pCkB0kmwNvYQoEFoztC7GEJQU/qZl2YPBm1YIQpasWp/0tPWSNTPXysFk/yRGSTIPqCxSYudm/rXFrQMC7o8+7krF8kemS+S9HCnnu/pLYrUeH1ujPe507wXXxBKI2+Rkv6MqPXmiAlk2k1zYaAJvxPzDJJiNcRKnXSEyg0mLRfEZyCtd84dOzuXPGeDFIX1zeYqskuMyv74jP8rAopWBb/oO3/pO3IEBUYFYdL6UqCF3QMnrLfbO82+fcvw5RGy0TWHmgSXJCQ/fLUzi7DUlQ9G6RD1s/iBEdbvADGAsek4R4K+FMrUb6XrMiLwkcnMRk/WaVfQR9n19n17vq5rlr0t/fMKGeXkakOcZo1KROIRlDSJCKaZJWmXzBR67GU8hduVFMbLIpa/dRji+zVS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 17:40:32.1929
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d4849b2-c6fd-4998-a035-08de805e75a8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06C.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6211

When the console out buffer is filled, __write_console() will return 0
as it cannot send any data.  domU_write_console() will then spin in
`while (len)` as len doesn't decrement until xenconsoled attaches.  This
would block a domU and nullify the parallelism of Hyperlaunch until dom0
userspace starts xenconsoled, which empties the buffer.

Xen 4.21 added a connection field to the xen console page.  This is set
to XENCONSOLED_DISCONNECTED (1) when a domain is built, and xenconsoled
will set it to XENCONSOLED_CONNECTED (0) when it connects.

Update the hvc_xen driver to check the field.  When the field is
disconnected, drop the write with -ENOTCONN.  We only drop the write
when the field is XENCONSOLED_DISCONNECTED (1) to try for maximum
compatibility.  The Xen toolstack has historically zero initialized the
console, so it should see XENCONSOLED_CONNECTED (0) by default.  If an
implemenation used uninitialized memory, only checking for
XENCONSOLED_DISCONNECTED could have the lowest chance of not connecting.

This lets the hyperlaunched domU boot without stalling.  Once dom0
starts xenconsoled, xl console can be used to access the domU's hvc0.

Update the console.h header to bring in the new field.

Signed-off-by: Jason Andryuk <jason.andryuk@amd.com>
---
 drivers/tty/hvc/hvc_xen.c          |  3 +++
 include/xen/interface/io/console.h | 13 +++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/drivers/tty/hvc/hvc_xen.c b/drivers/tty/hvc/hvc_xen.c
index 7f0b6262488c..c407592442cd 100644
--- a/drivers/tty/hvc/hvc_xen.c
+++ b/drivers/tty/hvc/hvc_xen.c
@@ -139,6 +139,9 @@ static ssize_t domU_write_console(uint32_t vtermno, const u8 *data, size_t len)
 	if (cons == NULL)
 		return -EINVAL;
 
+	if (cons->intf->connection == XENCONSOLE_DISCONNECTED)
+		return -ENOTCONN;
+
 	/*
 	 * Make sure the whole buffer is emitted, polling if
 	 * necessary.  We don't ever want to rely on the hvc daemon
diff --git a/include/xen/interface/io/console.h b/include/xen/interface/io/console.h
index cf17e89ed861..687949bdebb1 100644
--- a/include/xen/interface/io/console.h
+++ b/include/xen/interface/io/console.h
@@ -19,6 +19,19 @@ struct xencons_interface {
     char out[2048];
     XENCONS_RING_IDX in_cons, in_prod;
     XENCONS_RING_IDX out_cons, out_prod;
+/*
+ * Flag values signaling from backend to frontend whether the console is
+ * connected.  i.e. Whether it will be serviced and emptied.
+ *
+ * The flag starts as disconnected.
+ */
+#define XENCONSOLE_DISCONNECTED 1
+/*
+ * The flag is set to connected when the backend connects and the console
+ * will be serviced.
+ */
+#define XENCONSOLE_CONNECTED    0
+    uint8_t connection;
 };
 
 #endif /* __XEN_PUBLIC_IO_CONSOLE_H__ */
-- 
2.34.1

