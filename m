Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3EE22170A;
	Thu, 13 Feb 2025 12:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739450935; cv=fail; b=dThqS+bdb7Sx1AqC3y6soqUNnEkKVu0l6bPVXrqSU3CC8sDsl+1hBwXCw153/55SChyNLEw5f7u3DyucR/Q6FrT5DTY3pNnG649zTrZpD0sV3Ye830Qgiwy+ApJaoIbMncui1Djq7QFw0OvRNr8WySVo77J0D1JOopZ2hSalxYg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739450935; c=relaxed/simple;
	bh=+oXLtNuzN/MiAuSoV1VeSd6iULsm2Fof2bH2ZB4ouMs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d7x6pNdTdGZRV4YnJTgqA58CjmmPN3L54jVW8Ps0PwOvuoOtYwLroW1s28nrRdqQ8w18ZZjaBj0YCIPJiz7nD/ZKNqzs68eITtXi+qsERa/9BsDXD9rBpoGWlU96BpU961cHXmWmoajcOMRfeVeVE99OVlGHrVdhut7vcOtK3Cs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sTTqKJE3; arc=fail smtp.client-ip=40.107.243.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sTTqKJE3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XU1VI3yU9s4/bdKMvcvxxDwUtDZD14Ju9siA+WeKlqhFsYE97YLnI/vcztZTvCDsq4yjj3H9UOHNeV+gpHlm/ccE7+FQDcd+sgsDETVYZD/EQ9jGhtGFFQkUmQ1D2Mf18FfRQ57AoPDBTBLwBiUKUJhzLtGfAZsTcWKup8sDo4THyCzkuuTqd33et2M/MpP0Jsk+tOe32VwMh8NgIHEINPdJOi6KxRvSNh+8qMVkuweileDnUbxcD8Ox+x9G8zvDmSuWUtfKy6Z2Z66Sh3EY+00ARyPB6meQuFrSFKsHe9f/gvQh7f59zHOn9FydwcJwnk6PRmGeIm209DpANto6JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xzeqpkVdZXTSeeBOTu6YzymZsn3HBiF/TstUOj1CCag=;
 b=XJXrqwUw2RazVj4EQaYje4wA0lpN9p17N6Lovey/pSRHnM2SoxAClvArtU1p105SjFYTsjd58Pg3hvSc2kQXadmZFuKvkvlwyD+XsY+HIhVxmAgMcT5mvWGTBWuntPuGS2kQYq0Ch6WS3O4jIXROZksEFP/9nM3KaU8iQyEQcUvqHmNE1tt7w3SlDEbzsylF0lFAV4hOkWRu5At09EC5aqEoqXjFKf1aV8SgAmSIgbWu1a9sIxoX1n77+bgPC7BYYxP+LpXZwXOI1c5ndrwEJtsAm87OsWYnHlAqDRl3W1Z/qL6lq2xXD0q5R4/OSHZ5nyhuuRGeG8WpgbW8KfCnpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xzeqpkVdZXTSeeBOTu6YzymZsn3HBiF/TstUOj1CCag=;
 b=sTTqKJE3Erc1+anvN0rH8tVWSKOUquwPzw8zRxJxfxA+XFsvVmnYh3+jm/uozutGoHbZrLhvPz22r2xyWys02Byp58T2en8r9s90Umoemd22nZPqVL5FLqTttibs4R/Z7UW/QUAX+odbaMFjB+AmJlJpw+SqDCjqDXQ+a1xv/cz/ibbLWzAD0s8+IfeTPd1jj+Qj9T1dDpuvIg5bQAG9s1TsjR7WJK1KkbbSpgYx/UzoOC+zEs5532BZADQU39U2WIbaig4PUbNhc55dc+6onL3/3uI7SWSS2+jR+uOOtpJ6Vag1vKsxOiUv6wGiURVvTkuJDc0kzY0buBbS9bBpmA==
Received: from BN9PR03CA0311.namprd03.prod.outlook.com (2603:10b6:408:112::16)
 by IA0PR12MB8206.namprd12.prod.outlook.com (2603:10b6:208:403::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Thu, 13 Feb
 2025 12:48:49 +0000
Received: from BL02EPF00021F6C.namprd02.prod.outlook.com
 (2603:10b6:408:112:cafe::41) by BN9PR03CA0311.outlook.office365.com
 (2603:10b6:408:112::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.13 via Frontend Transport; Thu,
 13 Feb 2025 12:48:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF00021F6C.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.10 via Frontend Transport; Thu, 13 Feb 2025 12:48:48 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 13 Feb
 2025 04:48:33 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 13 Feb
 2025 04:48:32 -0800
Received: from NV-2XGVVG3.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 13 Feb 2025 04:48:28 -0800
From: Kartik Rajput <kkartik@nvidia.com>
To: <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <thierry.reding@gmail.com>,
	<jonathanh@nvidia.com>, <hvilleneuve@dimonoff.com>, <arnd@kernel.org>,
	<geert+renesas@glider.be>, <robert.marko@sartura.hr>,
	<schnelle@linux.ibm.com>, <andriy.shevchenko@linux.intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>
Subject: [PATCH v5 1/2] dt-bindings: serial: Add bindings for nvidia,tegra264-utc
Date: Thu, 13 Feb 2025 18:18:04 +0530
Message-ID: <20250213124805.2588-2-kkartik@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250213124805.2588-1-kkartik@nvidia.com>
References: <20250213124805.2588-1-kkartik@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6C:EE_|IA0PR12MB8206:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a5c2066-1366-447f-5ad2-08dd4c2cc31a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|36860700013|376014|82310400026|921020|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MTBIE1IqXN6pbEa301ZmjIVtypUdc0EFslkIHuuzoBHAxnHEgX+spjzt4cZz?=
 =?us-ascii?Q?4WyJA4fuhiv+o4QXDyZXqNxbWiMwh4QKZbEnbQHe5ZmcPXWMoxkoJKN++q7i?=
 =?us-ascii?Q?aRzIc4AO3mPlh/nXUgoUJGAGYxTEAai4X9ocHdykcb5Y+XnWb9sNu4VSik11?=
 =?us-ascii?Q?nbatmdZqbOB1pWlgQbdn7HBu+zAWGhD2m6vVG/LXmX0zXax6Pl8sgJ0PCOLM?=
 =?us-ascii?Q?pbk/pX/FVwfPZq8DJQgMEjKStWimKSB9uFARBJU+yAcuO7naz9Wrt79ihrvY?=
 =?us-ascii?Q?j1ElCCTslKdiB3nNHS9A/6I+6lhg59DIH655YgksoluNb6DNSs1rbraJWOVJ?=
 =?us-ascii?Q?n2p1pem3F8sQPqoc53cKtwbC3/yaedR3d/a4ZjShQvO4X9IueFUTpjiQxfSJ?=
 =?us-ascii?Q?wxoPz7T/6rQTMOOWF97mUChpxxOvJKS2TFjH70nhuY6hnjQV/8NSY/9JErcN?=
 =?us-ascii?Q?sqp+kluVPbT5i0awh6dsyaXo8wDUxOrbl+lV2BNt0IgWq8fE21KW21TQQ3+7?=
 =?us-ascii?Q?Yq7jP8aVgOtF8TOLl1ZTEZJQiXLiId1X3YzRWO94P1QzySF2au4/5i2WXbfr?=
 =?us-ascii?Q?KEY2Z4zZvgYawp8eFe6r4N6mTdjMQZd0dxn9ezRVdkFHcB6S18bQZuEsCzcd?=
 =?us-ascii?Q?N9ziphY4rBnmeaXubWG+rpYeQU+De7F4h4zrlLqVDb7vz6gpjag6E67ksR39?=
 =?us-ascii?Q?EPObYaJRX0RY7l8caA37MqfxDifbBR3jPoYmaX9ibgp+cYEcAYQgdJjgZNjp?=
 =?us-ascii?Q?RncnZwa/FKc+D1hTb4rEO0hXp7woQRzKR2cYAfXUtrAY5XEvUEyRUMdImGSF?=
 =?us-ascii?Q?a9qaRJNpcEdjPadsrULYZMigtfA0QcTHCaktaFLBtccjWZEY5PEnAaD9WX4l?=
 =?us-ascii?Q?WHt5YleougM0DG4/1ViYOhsOilFFBKPZC+qjz7U6mqaiAb1S1HbAKShJo6CH?=
 =?us-ascii?Q?+m0+4OkyQXBwKTWieF9mbWwLW+SjJnHRCQbR/2mzWVnhrEumoWiBqvbdOVGF?=
 =?us-ascii?Q?0mVPN7wyBfPPVZqP7hrWOFdzgR8JNOug5gF8EY8Bf5ZKwq4db3i8KblK4HIi?=
 =?us-ascii?Q?nChMq7LFYYboaF4qkWAXgA3F+HKhiEJylHn9JqpsKO6LjcfeRZ3LBPDdPHsx?=
 =?us-ascii?Q?ZRbntyx0pftVPZwIL+hCEV7LD/ZPr72z0rC97x0ZlvE65XOR00SwjMl2hT3k?=
 =?us-ascii?Q?OqWTQtO/1lggeuSdMagzHfHnISPqwLewsJC84esd2tbokvHCpz2dfSDi1b5Z?=
 =?us-ascii?Q?wczZoK3ppSoxyy1E07tuVdedT0TZBPdqF8XhTQ4kh1FIso3Z9fuhEN5xbCf4?=
 =?us-ascii?Q?GDaIU6Z/OMWBCP7L11/jxHdOZDx+lBI8Ok4UpOOH01T79xooW6rA6SAdZJg3?=
 =?us-ascii?Q?oGC0XRZgT1NlQPDgNHr3gS9S2TydfqfxmyMnwBmcnKUY3lpv6nqrPxVHhhWv?=
 =?us-ascii?Q?G/a0JcloCtvVv+72OEGSZIJC2btJFeFLE6seBN0CObl6MjqZgW/Hi/sqOrur?=
 =?us-ascii?Q?DI4Y1BCw6q1aICuEHlvUJl6Mn6q2MxEs5+hg?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(36860700013)(376014)(82310400026)(921020)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 12:48:48.9690
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a5c2066-1366-447f-5ad2-08dd4c2cc31a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8206

The Tegra UTC (UART Trace Controller) allows multiple clients within
the Tegra SoC to share a physical UART interface. It supports up to 16
clients. Each client operates as an independent UART endpoint with a
dedicated interrupt and 128-character TX/RX FIFOs.

Add device tree binding documentation for the Tegra UTC client.

Signed-off-by: Kartik Rajput <kkartik@nvidia.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
v1 -> v2:
	* Removed current-speed as it might not be accurate as the Tegra
	  UTC multiplex data from various clients.
	* Use 'tx-threshold' and 'rx-threshold' properties defined in
	  serial.yaml instead of 'nvidia,utc-fifo-threshold'.
	* Add serial.yaml reference.
	* Define minimum and maximum values for threshold.
	* Rephrase the documentation to clarify that we are documenting
	  the Tegra UTC clients and not the controller itself.
---
 .../bindings/serial/nvidia,tegra264-utc.yaml  | 73 +++++++++++++++++++
 1 file changed, 73 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/nvidia,tegra264-utc.yaml

diff --git a/Documentation/devicetree/bindings/serial/nvidia,tegra264-utc.yaml b/Documentation/devicetree/bindings/serial/nvidia,tegra264-utc.yaml
new file mode 100644
index 000000000000..572cc574da64
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/nvidia,tegra264-utc.yaml
@@ -0,0 +1,73 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/serial/nvidia,tegra264-utc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NVIDIA Tegra UTC (UART Trace Controller) client
+
+maintainers:
+  - Kartik Rajput <kkartik@nvidia.com>
+  - Thierry Reding <thierry.reding@gmail.com>
+  - Jonathan Hunter <jonathanh@nvidia.com>
+
+description:
+  Represents a client interface of the Tegra UTC (UART Trace Controller). The
+  Tegra UTC allows multiple clients within the Tegra SoC to share a physical
+  UART interface. It supports up to 16 clients. Each client operates as an
+  independent UART endpoint with a dedicated interrupt and 128-character TX/RX
+  FIFOs.
+
+  The Tegra UTC clients use 8-N-1 configuration and operates on a baudrate
+  configured by the bootloader at the controller level.
+
+allOf:
+  - $ref: serial.yaml#
+
+properties:
+  compatible:
+    const: nvidia,tegra264-utc
+
+  reg:
+    items:
+      - description: TX region.
+      - description: RX region.
+
+  reg-names:
+    items:
+      - const: tx
+      - const: rx
+
+  interrupts:
+    maxItems: 1
+
+  tx-threshold:
+    minimum: 1
+    maximum: 128
+
+  rx-threshold:
+    minimum: 1
+    maximum: 128
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - interrupts
+  - tx-threshold
+  - rx-threshold
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    tegra_utc: serial@c4e0000 {
+        compatible = "nvidia,tegra264-utc";
+        reg = <0xc4e0000 0x8000>, <0xc4e8000 0x8000>;
+        reg-names = "tx", "rx";
+        interrupts = <GIC_SPI 514 IRQ_TYPE_LEVEL_HIGH>;
+        tx-threshold = <4>;
+        rx-threshold = <4>;
+    };
-- 
2.43.0

