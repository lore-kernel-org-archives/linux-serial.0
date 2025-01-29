Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A369919DF4C;
	Wed, 29 Jan 2025 09:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738144232; cv=fail; b=Xr8hQFezKKwVj/jm9JEquXuEFhDIeNs1rRAjBJr495ORqDvpBxxWxWH0vtveZrJ/JpZc3mNqcCLe6hEosEHapq2S+5RXGEJRGYu9xJHMYg/yb2YEPaMe+jTDP8Db45k3URpra20gAxmDbhN51DFcCdu/f2NSclOyVnShbaefBYM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738144232; c=relaxed/simple;
	bh=uXZ3/Mh3RMu2Qrz3rHnNn+vYCB8F2DojmijAa3og4lQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=l3ng02uUYMvwg3Ue/k5sVoGm0ahod0EpSlLDsWVhiFW8pmQp90gu9OsvRB2MoO43bv55SsnkYVJxel4aj+alS/enEGm3MAe7/7qUqYlhKbU/Ao0Dk7EekuyM8oMNxXHSrPGV+gBUCQe5ti1wYot6KimuBiQU2lI8vvKbJE5z1nU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=g5xBcLY6; arc=fail smtp.client-ip=40.107.243.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="g5xBcLY6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iOqJhlq3Tp4tDHtX9ZXwKQK3Lnu9ayCFA8qUdCLKVQtO0/BEfinKNVJGCdBExRISfZjOciMX0vJHODci0mBAkkyghODBC2k7Uc/wqhUcs/tUDdZDsk4S/aq+tEHzgPfzZFHA+eB31sE9nRugsvmAVldQw4prOlf5cIaGyXtqNcl71pN18sns4Bqwy0AMMz/WJ2VF+cspsRlNSamzdLRFyJc/JOt/XBx6oSLJaJV1S8diYcfQ8fq259gV7wks1Y3LrnRWCGTE5D4X0jT4XiV8fTpp+vhhd2WBWNdw6/dSwPFqnGWatCJcCuYLKggWAtCDNETUZYWZjXvKElYwKQHJTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X+h6sq8oagyMPHRJWPe29Neb7fsmN1PyX8tRhvCmHgw=;
 b=hxe5F+uSCBzmLf7gBb4d0Zv/B8Ir2ZERWu+CxpfE32zpfM/BheiF8CEmlDm6BpKMWPRUFhC4cfHu/mQHRSMMlT+Dh6PijC5g42vzX9swuku/LAPEbCVwrWqDcaYsHyeD4fCrR9Av3bh8xKPL38whaZm1vnV2n8novKUUSwyFD/WDh7wZ8xS+S+7wMsoorVeKbtuGi2QtFF0CHH9mJfrCqPTX1KxQP1qLwW8z8u3u0kUlmhn88N/OB66aYnXAk+NJMFznz4YBJcSSLmgaDzGDFYcAoISRDWCzL/PEPpBhAvxkSb6nNewNoZs1Ee8X1884XaU6q9DuSmw4/VrQSYyfEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X+h6sq8oagyMPHRJWPe29Neb7fsmN1PyX8tRhvCmHgw=;
 b=g5xBcLY6LWLn5p6nYMa8cOq9X7nU/TvQliE94X0D0YUA37VeUahtLsR9WnOVf+0+v5wYYkarB4dd5YsyOAKYjT6kunOL3mURXskMdvhIaCwREXApHP54h8GZItO43+wqWtPfYb5nzR7hfM2o3yQ18BnkGhO4qJKqCNNlVwz2mR4=
Received: from CH3P220CA0024.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1e8::30)
 by BN5PR12MB9485.namprd12.prod.outlook.com (2603:10b6:408:2a8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.17; Wed, 29 Jan
 2025 09:50:27 +0000
Received: from CH2PEPF0000013E.namprd02.prod.outlook.com
 (2603:10b6:610:1e8:cafe::53) by CH3P220CA0024.outlook.office365.com
 (2603:10b6:610:1e8::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.18 via Frontend Transport; Wed,
 29 Jan 2025 09:50:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH2PEPF0000013E.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 29 Jan 2025 09:50:26 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 29 Jan
 2025 03:50:26 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 29 Jan
 2025 03:50:25 -0600
Received: from xhdsneeli40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 29 Jan 2025 03:50:21 -0600
From: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
To: <git@amd.com>, <michal.simek@amd.com>, <gregkh@linuxfoundation.org>,
	<jirislaby@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-serial@vger.kernel.org>, <devicetree@vger.kernel.org>
CC: <radhey.shyam.pandey@amd.com>, <srinivas.goud@amd.com>,
	<shubhrajyoti.datta@amd.com>, <manikantaguntupalli09@gmail.com>, "Manikanta
 Guntupalli" <manikanta.guntupalli@amd.com>
Subject: [PATCH] dt-bindings: serial: pl011: Add optional power-domains property
Date: Wed, 29 Jan 2025 15:20:13 +0530
Message-ID: <20250129095013.2145580-1-manikanta.guntupalli@amd.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: manikanta.guntupalli@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013E:EE_|BN5PR12MB9485:EE_
X-MS-Office365-Filtering-Correlation-Id: d32c91a7-abf4-41f9-7be9-08dd404a5bd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CRD0E8jJk6Ha6qYAayaD5ArrRUq+6O/aYkjxTLiJ865GqwBje1xBp8w4bm0l?=
 =?us-ascii?Q?/2m9BWHO2epR9mnfMr8/1abSYaWJgfw5mx72aTDOkjmDR1FlmE/Ekq/t256v?=
 =?us-ascii?Q?NKquu9ejzDFnu/PY5CGhU3YBv2Qlg507Pq++/hWEh5h6qEhBWl4OqmvnyfUI?=
 =?us-ascii?Q?CDkNTgaNxc/a6eKIKkq5LcDoxgjdgjQEaIp7vnY71FDyBRzm0PHcn2El1kYS?=
 =?us-ascii?Q?F3i4vObBCuJevzNtkynKHdzEM/Y569pILKImvjuBWe20cWMzRMkEp7ffYNa9?=
 =?us-ascii?Q?8p4bE+5sm3GUcVt+Zjxs3M8UQ6NCyjkGZUbdF6gXG7uiTT413V7vIlJWsvYH?=
 =?us-ascii?Q?saYvgyF5PPDHgEwP37i4benwPyKcenn0DHM5eqw6Y7A7l06CXHh4XzHmZe7o?=
 =?us-ascii?Q?n2ud25nDSqlX1zAgWGsmzwk/ORj9jkKKvmx73VxGyxOVPLvrQdo9DOGb9UhN?=
 =?us-ascii?Q?zckUrUZi8TEXlxCfrZRMeJz6up7UJFDajo+zc5vmGdtt0PXkk+38x+kmYbMr?=
 =?us-ascii?Q?XeCPSaC4puSlOQkD2nBRdttlFtA9hxUM1T5473Hx4ECDy4rXO8ZOg8cbA0AD?=
 =?us-ascii?Q?KnvP5OsHPqL1n715xKZKCFF2sL7j+2irjD7tfWIAcfMrHSt4UVK7HaHEQkXi?=
 =?us-ascii?Q?v2CKSwJbwnwbYPs0x1mebe9d4TnY46qwDjsfjmbfj85Dczc/sXJowv2+JrcJ?=
 =?us-ascii?Q?dp+YL8OAC+7UbbgNhXPtOzVPW3/Nv64j+yqb9YIH0svU513asKkeK0wwtf27?=
 =?us-ascii?Q?kI6XkBWuVRce/Z3W6oHZ3xrq2DKEpnJYo2LGXuiflcG/tRZIzM6dn3N8UUTm?=
 =?us-ascii?Q?aQ+khiHOfqMMnoS6MjjZR8JXHhEYCa27LjJzCYIihgHlpHKdC8yTj1EFwmqq?=
 =?us-ascii?Q?Vkq7Y9fLANq/9CBNF1U1fVYsnQx4ctllHqo+lJvgjUf/Sh1gM0blCTfYP9tj?=
 =?us-ascii?Q?vebBMSboy5X6xuRPIW8XbMsz8zlSaoMYkS9FWnyRheLZ42NnyIXo5qE3iO/t?=
 =?us-ascii?Q?Nu3r1BD2dwVogs9L2sIhPY2M4fV4ZLNBk8+ngPBDVDKIM0otEXbu6LIdszWg?=
 =?us-ascii?Q?1A0LV4Uw6puUT7q3+xH5soOGARJmVOaKBViSliPVk3BeqS2ADRfTZV5+oozA?=
 =?us-ascii?Q?c33rjQpIsKDZto1FK2yhibUWN3KyvtT2gHPl2a0dyb1mZ/IF8sa7qASGpgCH?=
 =?us-ascii?Q?S/nPDJjsEHRJQB0NHXVAwqMS8+2RNwAn6zqZCu9lknG4GdG3nWIQMy9Yttq/?=
 =?us-ascii?Q?2JfzJ/aLJiYcprfVL0JsB+E1kkSwPgQWCfhsqCAlS6y2Mufoy8dSAxHwlVOj?=
 =?us-ascii?Q?vBcRdicHlezFx6kRq8MH8ZR9tm+DCr4rFHm5OCoiV3p+8KT7hn+TUCjYWwSg?=
 =?us-ascii?Q?Akb5Yp+P/RJccDrWPMc4bPd6TjlBnzFpM9zIIWnSOhOqBcM1EBqJ1UB4xrzx?=
 =?us-ascii?Q?8XsRrzMBydCgpZuuew5qF50mDoOQc3wjNRRKH5lvGsgAhQFW7bnS3M0aDslC?=
 =?us-ascii?Q?hgv06qnfIftxjBB28GJHne/mcV0KkcdPka57?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 09:50:26.8434
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d32c91a7-abf4-41f9-7be9-08dd404a5bd9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9485

AMD/Xilinx Versal device serial IP has its own power domain,
so add an optional property to describe it.

Signed-off-by: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
---
 Documentation/devicetree/bindings/serial/pl011.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/pl011.yaml b/Documentation/devicetree/bindings/serial/pl011.yaml
index 9571041030b7..3fcf2d042372 100644
--- a/Documentation/devicetree/bindings/serial/pl011.yaml
+++ b/Documentation/devicetree/bindings/serial/pl011.yaml
@@ -92,6 +92,9 @@ properties:
       3000ms.
     default: 3000
 
+  power-domains:
+    maxItems: 1
+
   resets:
     maxItems: 1
 
-- 
2.25.1

