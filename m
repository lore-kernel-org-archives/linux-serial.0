Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2061.outbound.protection.outlook.com [40.107.102.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F171918E043;
	Thu, 12 Sep 2024 12:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726142743; cv=fail; b=GgbmhQONAIq60CrcDFMASiHSMs3ynhZ35fmeN37zEYm699L30gQFLA7/dxtZXCCXwa5mIMVQrtGDDgk3olLnTq6q/JQaVTv07/gYG48plXy1Y/vgOQQvvLaeEFOLMSc38P/FLYqwwTvrTAMbOhl7JJFRV9ufWyUzBoqEdQmdsdY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726142743; c=relaxed/simple;
	bh=b/qsS5U8p/xyERc/DPtNEsgPIF7AT3LmmQUsT2kFeQA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VIvhbhHQi94q+wRKemvMiXB6WhAGk+f0UAAdclyYbJPTQy40zLFVH77F+ueapA92ugQ+15q8JSmR1JSQ5XCRebhju7rIJZlISlh94Gy+Z8J5hdQs9XALbTttU0L9YPryJUGaX8X0U/9EPadtNRdjKUbA4vNYzp6tF9NUka7ppRg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=B1+KpUL/; arc=fail smtp.client-ip=40.107.102.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="B1+KpUL/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w8o/1K6caxjvSN6OHaeSKPCvQdytWK+m897Lg/sAM+yFLbu/NbAYydl9ggGJYRTvjwGyxxZGs/gjEzDZ6sKg9MXWgFLSMjeeTcwo1PoBnxysMkE7ZCBC+Szu7sYr/7y1TX6pSxFdUApUXxAdEZ52QuoLnPmnGFyynlsNg1d9h4CerzRap1mTTUQCDZBB4Oe1UDWn5EXAzaFEZNE9jEklNu6uh2PresxO+OCo1OhWM4fokGHUiPGQQQM3B76nyQGhHI9vogCh7ilWs6Cf0nDXyQ471C/cThYZJtpXQK2oKCbSeEhnVRKa0ZAISfqwn8UrZtSslFtUG55qR9KreoJwYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zkqat1xd0TmuYCwKREgB4KisGCV2TQEfCWuT9NgT6vs=;
 b=YqHgdqn8Ix7X8NoUOLnhQE64283uPRK5RcL13D4VaRo9ITslK5aQL48gjND7fX/6RZRDfll0/eEI8vVpksRkGQVJ6OCejDuQkAy325uaVPHC8OsojY0srJc1n9/BTOkWmluZL3I8nYodaa766DGjCy0nPL9t01frJSy2nIDsDS+S8fpGVYUv+YmDpk1rIQHXyj4KWL4KNK6mPIoq3ldk28Z+u4grg0kisaaYzYMNGU4NkX5D0iZSNfiJYEPCf1/4s082DO7QCxgux/SoNBb0zYIb82gBw1ZrFb/wncOQeOPASvdRTf8M7nHYL7IgX0anscT+T1PRPP8GCHudg7RdiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zkqat1xd0TmuYCwKREgB4KisGCV2TQEfCWuT9NgT6vs=;
 b=B1+KpUL/fzS0le1wD2IvfHrSHJi5KoQ4rgw6OU6xkQSB52PwMT5KaEs20lfeC3FY9kDMrIWIr3E5dyhkASV9EuRBTyBtRodAbFyWtCd+XxiGqeir0aBXN/6Urmr16ZsIlmGfXQfE9jh0m1qd0wjx3kTkgu/bV+X4YfHNDfoxqY4=
Received: from PH7PR03CA0020.namprd03.prod.outlook.com (2603:10b6:510:339::29)
 by PH0PR12MB7485.namprd12.prod.outlook.com (2603:10b6:510:1e9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.17; Thu, 12 Sep
 2024 12:05:37 +0000
Received: from CY4PEPF0000E9D7.namprd05.prod.outlook.com
 (2603:10b6:510:339:cafe::63) by PH7PR03CA0020.outlook.office365.com
 (2603:10b6:510:339::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.26 via Frontend
 Transport; Thu, 12 Sep 2024 12:05:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D7.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 12 Sep 2024 12:05:37 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 12 Sep
 2024 07:05:35 -0500
From: Michal Simek <michal.simek@amd.com>
To: <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
	<michal.simek@xilinx.com>, <git@xilinx.com>
CC: Benjamin Gaignard <benjamin.gaignard@st.com>, Conor Dooley
	<conor+dt@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Jiri
 Slaby" <jirislaby@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, "Rob
 Herring" <robh@kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE
 TREE BINDINGS" <devicetree@vger.kernel.org>, "open list:TTY LAYER AND SERIAL
 DRIVERS" <linux-serial@vger.kernel.org>
Subject: [PATCH] dt-bindings: serial: rs485: Fix rs485-rts-delay property
Date: Thu, 12 Sep 2024 14:05:28 +0200
Message-ID: <48055c01f7da7ba4e1592090d3bfedb0ac321bb0.1726142726.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1906; i=michal.simek@amd.com; h=from:subject:message-id; bh=b/qsS5U8p/xyERc/DPtNEsgPIF7AT3LmmQUsT2kFeQA=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhrRHNzmn63wT6pF40d7L/yp8ZzR7qM/9OzFeh4UFtTZcs S3YuHRdRywLgyATg6yYIou0zZUzeytnTBG+eFgOZg4rE8gQBi5OAZjIJl+G+dFOi2Z586okHLn5 oc/C1LVB8V8tC8Mczpt/boY6tjJsinl2cF/NxCDZatVsAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D7:EE_|PH0PR12MB7485:EE_
X-MS-Office365-Filtering-Correlation-Id: 7212f8c5-ee14-4960-2924-08dcd32336a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TgQgFgevFbD71HK/4Ngxsc71LLStdpGpkKjmzOuK1EDqhtzypI/ztZmYcBIO?=
 =?us-ascii?Q?dDfDDF2WpdfsdNfvQ7zcF85Nr+Bx8V/CYXqNG3TmKFCCMXck9nYDUiirKw/P?=
 =?us-ascii?Q?5Tg8JJ6CjnDJMNUgUzACLVke0GtKo+7o6hAXFL9i7A9HEc7LibBR4aQaRvR8?=
 =?us-ascii?Q?1GvYpeOMMQtPwurIb92aLRKLk39wZ3VtPdORAisfAJ+/1vZWXXOJvwq6X21R?=
 =?us-ascii?Q?ILivGEioG4OauPNJgclY0Bbl/7CgOBXrPo6uEZAaxHEgYwGTOc/7WJfqevoM?=
 =?us-ascii?Q?faZ9k5wDp3RwGmLpCvI1sFCxb0/X8OVM3ftD9HMcX1H9Ra05+5Yndh6WB7w6?=
 =?us-ascii?Q?CXfKqS7020Eeka2W/sPu66I7cZw0b9lMlKrAh/SSGRLqR8/X08XgYmYJYx5M?=
 =?us-ascii?Q?KNC5mFxwRsOGtqHhKQQSfK1ZecvUZnFBoK2vkJBTFC+y0F7cnbAv9YddmBYV?=
 =?us-ascii?Q?PMqTvqfQgPrrWtWML4KGA1eE+bmWWKOyd3jm9OEqs0P9vQF3RNYBSf9CYW3Z?=
 =?us-ascii?Q?cj/6Ucm3PgPH4WFoCLuHJHUqpN75AaP6N7pe0HoA8aPPRshXpKWzcGLCnwSP?=
 =?us-ascii?Q?G+DLHBZDGGDGynsb1rshTlu4vgpZyhCCTgHzFx3rlVeaRB2RHX/vTJJkkrAQ?=
 =?us-ascii?Q?7iPoBcj4mu5y2qfCBEWqA0ivYC19Y/RBglvP2Fcx/tLJb2wcu+Z3tM/6iZVJ?=
 =?us-ascii?Q?tK5sA6MpORDde8viHIV9qAwdmuNUEPl3WCByBJSyIXGyQ/b1KZ2EUoW5Xfth?=
 =?us-ascii?Q?ieUJmh8S7/wcvRhz5CJtgbsBGKpWt+YkpFRUpR6ukmTf92N86Lwa72GLXPW5?=
 =?us-ascii?Q?DPoqqFiwq0fmGdWyAHkvJKSLtRUriLHfTs2/Wvytd6Id0FEwa3znexnoEcMg?=
 =?us-ascii?Q?K2Z7Oblg/+zmhjLXpynzGXr0l4dTYhn7o+ZbKLQT51if8GA0MvSeBlICXl7N?=
 =?us-ascii?Q?u7Ra9TLR5OxcVgfBQx6cRt+pwOH+vpOC3YVSGi8RDdAE3APNcB8I8B4/7F1b?=
 =?us-ascii?Q?1soeQrvgLeP6q850DnP47APYto5redS2Jubb/M9DV3QFEBLGgEgA58tR6X0S?=
 =?us-ascii?Q?MeHVtDLnORHZeAPVQeoiaYifDw7Q+02124niAg6q+VQCfP0Ga6Ik4PbyIxPz?=
 =?us-ascii?Q?eNZFyPxNrli09Q3h3TnOLAj/ONiy96aSGJJh+rsNHs4yi380F73R64UAWm1M?=
 =?us-ascii?Q?o1DZDSELo1e2zcvijvaACc9sEvJMGTCYroYvtMqDeUN676e3cBWfBMx07Ny/?=
 =?us-ascii?Q?/4mzJxFSRn6bXQOO5wE1GWdhSen3yJQSINcePme4+e3QqU4b2EWHkpn+TJ3e?=
 =?us-ascii?Q?wE8hs/MZY9Kx7PplWvEmV4hKFGu69fEgz1eKmW0kXDglL5+Xcv4wr2+yZGKn?=
 =?us-ascii?Q?4eNtuvyPYJ4KNVcnD3kmDj8c82u8TRlU850xR3gCiNbrkygqa0zVEoejPNI+?=
 =?us-ascii?Q?HSqDnaYehdh9usbkTFUi/qTredkVKcXU?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 12:05:37.1896
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7212f8c5-ee14-4960-2924-08dcd32336a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7485

Code expects array only with 2 items which should be checked.
But also item checking is not working as it should likely because of
incorrect items description.

Fixes: d50f974c4f7f ("dt-bindings: serial: Convert rs485 bindings to json-schema")
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 .../devicetree/bindings/serial/rs485.yaml     | 20 +++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/rs485.yaml b/Documentation/devicetree/bindings/serial/rs485.yaml
index 9418fd66a8e9..fa9ad68ed24b 100644
--- a/Documentation/devicetree/bindings/serial/rs485.yaml
+++ b/Documentation/devicetree/bindings/serial/rs485.yaml
@@ -17,17 +17,17 @@ properties:
   rs485-rts-delay:
     description: prop-encoded-array <a b>
     $ref: /schemas/types.yaml#/definitions/uint32-array
+    maxItems: 2
     items:
-      items:
-        - description: Delay between rts signal and beginning of data sent in
-            milliseconds. It corresponds to the delay before sending data.
-          default: 0
-          maximum: 100
-        - description: Delay between end of data sent and rts signal in milliseconds.
-            It corresponds to the delay after sending data and actual release
-            of the line.
-          default: 0
-          maximum: 100
+      - description: Delay between rts signal and beginning of data sent in
+          milliseconds. It corresponds to the delay before sending data.
+        default: 0
+        maximum: 50
+      - description: Delay between end of data sent and rts signal in milliseconds.
+          It corresponds to the delay after sending data and actual release
+          of the line.
+        default: 0
+        maximum: 100
 
   rs485-rts-active-high:
     description: drive RTS high when sending (this is the default).
-- 
2.43.0

