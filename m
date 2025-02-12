Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2060.outbound.protection.outlook.com [40.107.92.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6E2209684;
	Wed, 12 Feb 2025 10:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739356935; cv=fail; b=GVz7tRlPoc6BLFkj9c4I376uD1yDKEPx2E5pU9+Zey+CI7QN0RLE4GCNOtOZAH6NqTDxPv9H7pxtpVAjKc1YyvFqTYWn73th7G0p9rAN/NngwqGy4iqydUVr4JB7KSr8SlJkFqzlI9Wmz6r9kHjRm/OVnJnAQ1v0sF3DgZow2Fk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739356935; c=relaxed/simple;
	bh=7A7fEiGVvaIHePSwKja3Xm3fh5Snf2afEg7yJzquLII=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ju1Dq06jW1t4fmPBsz2gSIf43J4fk6/5NSXWikM1FH4GTAm54o/qYDKZKbC0OTjfdx3h0qda8yOrNSFyOwJ7ho7plC/TlMmDA0k+xzQVw3DwmVT2glP+HGyuYJ94uFWeBFGsCr7UGRKCt6DYXnKjiHmogh/SlP4XycTnpAGlMrQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bKSAiG9G; arc=fail smtp.client-ip=40.107.92.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bKSAiG9G"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dqicBSHUblNWIlGAA7jCgW6+EQikiwqVP8xIEa9pZnq3lX6l7xa2SnbH3zccLlIV/tPUHueQo/C1HrRoZ7yI+qKrGdKZ9x2chm4czSYQ7fIFARXiOrLcFMAy40xgJdpvYDVD4ldvMAdPLZEiTGCzu1IuvUZF9aoFrIWqivjM/YEMixNJiMsw7GyFcBUWG3SCtMKIKM9SYwVleJGruwGY2+t4tezhTdIetXMV5QPWDJ9BiEQDRvW2bNUaUMxgQHYgvD3IDBM8BQAD8uf3MysFK1+AIgW3limHP1Uw0Ym2VKOmilqP15qArDl4f6kwnrGWlzkRC7TSHJyqiAFCoFRxkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p7JIFu6tnjLi8ACJNcRmSii3PR9IjQ6SFebdfr7Q6Vw=;
 b=xxZDUxDuRmZG6ojBsfQ2vrc9/6gDyt1GEj/dQ/7m9ygoWA6GBDnqymDkNzhtLzK/s23Wgo8d9ILw9tirc5KTRv0jnJeLxjAXr9AlBLC7Rzf1VXWvzQ4BGgxnZKx2SIyecxA127t7fZnXH/cft0BYN5jLGSj/4hI2qxibK8AQPn3HcrZh4Z1w4fzTIqYlRt8F5qHhp09sSxJ7mqzGqrwVsutsLBKbSjRlzJGYZqD7yOC2BfEM0qAL1gHKo5elwNl2ponfvv4Q7ONxq/VnuQFoxPovxXCXID6Vf7JzcoDKDmTbRTMqiGXMrkcCQ12NFjuBnFkMszKtJHWvoQmsWf90Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p7JIFu6tnjLi8ACJNcRmSii3PR9IjQ6SFebdfr7Q6Vw=;
 b=bKSAiG9GST9ZwXZYsRrB1EKS/77AVqiKQykmc1mtzS0c93bMW5Z37z7kjuqF964L/Uyo0e2gqurbJKRxl7AEbCeN62O56J7PsVV+8NtObtTR43hDlm3A4uIzFwuagx2pFn0IfsC8gLEiCVBwBBYzJjHoKoryg+WDsZHw9b0TxAeBkgKGMOVFWPWHF1KpeAV7G8kT9XNShB0mw1DrFH7Cud9CA3RzOsEO8xhFuk1m3/+AizN+0XrO2x+7Quez4Oc27dtNK2568Z2S1mSaGNnLyXCNtUfa5AtTv4U0hGpSqE/BGaZD9DRme5lEcZbblqTmwBuUHpexrzcedmEhsAiclg==
Received: from DM6PR13CA0014.namprd13.prod.outlook.com (2603:10b6:5:bc::27) by
 DM4PR12MB6592.namprd12.prod.outlook.com (2603:10b6:8:8a::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.13; Wed, 12 Feb 2025 10:42:09 +0000
Received: from DS2PEPF0000343F.namprd02.prod.outlook.com
 (2603:10b6:5:bc:cafe::5d) by DM6PR13CA0014.outlook.office365.com
 (2603:10b6:5:bc::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.12 via Frontend Transport; Wed,
 12 Feb 2025 10:42:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS2PEPF0000343F.mail.protection.outlook.com (10.167.18.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.10 via Frontend Transport; Wed, 12 Feb 2025 10:42:09 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 12 Feb
 2025 02:41:58 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 12 Feb 2025 02:41:58 -0800
Received: from NV-2XGVVG3.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Wed, 12 Feb 2025 02:41:54 -0800
From: Kartik Rajput <kkartik@nvidia.com>
To: <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <thierry.reding@gmail.com>,
	<jonathanh@nvidia.com>, <hvilleneuve@dimonoff.com>, <arnd@kernel.org>,
	<geert+renesas@glider.be>, <robert.marko@sartura.hr>,
	<schnelle@linux.ibm.com>, <andriy.shevchenko@linux.intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>
Subject: [PATCH v3 1/2] dt-bindings: serial: Add bindings for nvidia,tegra264-utc
Date: Wed, 12 Feb 2025 16:11:31 +0530
Message-ID: <20250212104132.61060-2-kkartik@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250212104132.61060-1-kkartik@nvidia.com>
References: <20250212104132.61060-1-kkartik@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343F:EE_|DM4PR12MB6592:EE_
X-MS-Office365-Filtering-Correlation-Id: ad4315c3-c2a4-4b93-1ae6-08dd4b51e6dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700013|921020|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?j6yyBuiKDEVPwgrByfHfn84LQSjVmmXQb0KF8OzCl4rCGK7+Rh5BifylgDKk?=
 =?us-ascii?Q?Of5BvCIEcr5kFErmD2/RA49Zo8S8bm4TP90wLF7whpAyUjG/MU+DrdRVKKPY?=
 =?us-ascii?Q?pw4N7/XJwDnFoIgL74086bvtwn3N/jIByNaPopzgC1b2ukyRCKLHapRwjJsN?=
 =?us-ascii?Q?HtePwU24b+bp3ZtlxPXI+l/RqxEZyd2hOvDQCmt7j+NB+Tybx0DeEsUSwbSB?=
 =?us-ascii?Q?Q2s1Wg49mM/msI2stpoiwBNdGEvHMEmzAvfeZmhmMEz6jYMeuGhS+Uv7L0C2?=
 =?us-ascii?Q?ZKxz+EfkhyPewch1vrEU2jBl8PykYfqU9MRTZn7Rga0AhZQSEDmXMf2Dcd+B?=
 =?us-ascii?Q?D8oGRvM0AqoMGUfUGRRXmoOSyXhF409bOezN3NaMfP5FwKPkvOfgnb8l3BaF?=
 =?us-ascii?Q?KP3mW4HQhwNYFpKJWCt/ewqBnQkCo95PxOcGxBbZxGpbIR+aVWLBtLMe2BNY?=
 =?us-ascii?Q?YP6ocJZPIa8CX7JPXLCXcuW6aR5sdpsSYJ0gA3feQpl8J2cL0Y4PP05bdldr?=
 =?us-ascii?Q?1FE7F6VP8HbHKynpTdubLwlqB7b27pkhzY1Vv4UaDI+hon6CxoodvbbAe9f5?=
 =?us-ascii?Q?ZLDP8f8+WfMQpKNdyYYQZM8wVwnB/4fFKsyte26V3/q10uKWZS97ggNhYlMs?=
 =?us-ascii?Q?IbmcEE1ikwnoTndxwaJvGJ+Rak4wW5KHLpj7ac94r0FpgHOnT9miouYxQDmR?=
 =?us-ascii?Q?QDeQOvdpoFVslcsgtuQzwvqXMLIyb7DrDVJYf//djKoPfcezYuttIGyHkk61?=
 =?us-ascii?Q?c+2W4OoB/qqgQixwMeB0ypMXzyszVZdMb/GBfcX1fr2YAs3gn9KIULeBGqd+?=
 =?us-ascii?Q?DQCIEqSKe2DnxhIN/3MyF2HL3/6G5aEmyHan5ouuiaKF9lwzE8eYTivn4Wqo?=
 =?us-ascii?Q?P+A/WRwv6L4xRgQCYOOXm4zGEIC8G3DJTPcPfggR77nl1Aj+xLgCQAFjU+SP?=
 =?us-ascii?Q?vXayzbVBPqoUPSzkYxFcUFsZy4lZD5LZl2YSFDkU/6u6onSGcDAMv/vvJJU+?=
 =?us-ascii?Q?TXOGN025sEjf7JuiaJLSDI/9VEQ6k8hdV4Vyr9LKtkun9tgT3wWtKIhLns56?=
 =?us-ascii?Q?ruRVg8dRqZ/N5gpwPxyHcVd0SwJIk8NGo5w2oyHm/4slRpKEQiFZl/uuwljO?=
 =?us-ascii?Q?fIjmzfdahhsBJkpap7dR86+tbKYbuwmwZxdCTdN4ziH5bUqYWWQOiiYYIDzC?=
 =?us-ascii?Q?2rCso7kvSVJYZP9rsjFZyifybhSglkcH9SI4vNC+Ky0ivJRIeXY/+cTF0XCl?=
 =?us-ascii?Q?TG7S1+Ggt4pyJgT/s/0zeuTUUrSMFIiJSn2zsKKAnIjIiOJ5Q9IL6Y94coJJ?=
 =?us-ascii?Q?nDwisi+OpYbY7qqU5umnEQ/rmRkUyjrlBthDGsHmJ3B1aei4Ab0Jt35yVD6M?=
 =?us-ascii?Q?cZ6F1XUpPiiNu2WN6/Jn6iVrY59lEYF5jaNM7Ynt+4C23h1hg+Mdacm5/980?=
 =?us-ascii?Q?EIaKqPEYVLrfLNvR1y970IcwUXZRvM2AbnAS6+MXRWD0mSX9aIYDNp/Fmcsz?=
 =?us-ascii?Q?Yzfg6Tde2ziVPk6r4kttKiK6T5BJJ0PKeoHq?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700013)(921020)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 10:42:09.2756
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad4315c3-c2a4-4b93-1ae6-08dd4b51e6dd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6592

The Tegra UTC (UART Trace Controller) allows multiple clients within
the Tegra SoC to share a physical UART interface. It supports up to 16
clients. Each client operates as an independent UART endpoint with a
dedicated interrupt and 128-character TX/RX FIFOs.

Add device tree binding documentation for the Tegra UTC client.

Signed-off-by: Kartik Rajput <kkartik@nvidia.com>
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

