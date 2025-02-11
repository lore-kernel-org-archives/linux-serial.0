Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BDE1E9B3C;
	Tue, 11 Feb 2025 06:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739254836; cv=fail; b=G90CX7z9lPhma2MnTeA/PovmHfE26WacpJG/SXbj6T5+6MPiD8UHUGhwOlHU8BK7BwJBOxziCDzqB/DwcGYwwuXQcyswbe/UuCfgME7YhLYpvkzdjAs4OEV635rjcnDe5uCvqYdnJ2wflOjbiqFXzywMGd6zNL4NluL2f0Ftx2k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739254836; c=relaxed/simple;
	bh=7A7fEiGVvaIHePSwKja3Xm3fh5Snf2afEg7yJzquLII=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uoD+C6Ia9xjbCHwNpaMSyUcUUSvorhCo+raRUmGbbPT6DmO6XxJHQW16bVFDSCJD+m0uLP6VJn7N7SBjHh6KVODGFFL2GXRlcg8mJN/DtWqxGIBa45QdHhOz/FaA6rAlV/Cpz6wQBddSL2JvAtk6QxabPXviuP9/qlE9hb3NnK4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=COTj1yvj; arc=fail smtp.client-ip=40.107.93.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="COTj1yvj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sbKOEJV3tFU034OnXRaglVofqel4NHCNJZqHJ1b1A9O82aMzbZebfwQqzY+ME1G2N+mVV4p112b9LmpDP74WK3UXbBHJXqc+ex6Rrt3w5ft6GlrzrEiN8oImXu+SYnpLRi4rxL/rSkGssfnH1wAyq7i30ecCZrGdn6kgiCJdViqqhMFR7Hk+ZGiiokdTtQj2Fw84N4TghWeUzpZHnDoXdmK5dBIsLRKseL2JoQr13P4b105m7OjSx1fU714zZlKLP8LZt3qmIC1ZABWAduOhkhYl4kEPb2uButsSbZPGCVjfrClBdalEK3L/3RonaAvGG7+QgtjzCOJPbziQ8oBmYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p7JIFu6tnjLi8ACJNcRmSii3PR9IjQ6SFebdfr7Q6Vw=;
 b=bTz9m+2B1lePfFWo3C5cYkHrCMumkW+b0308I5wPSzJ320PhDxtVMrG8zZ59Uss3cUZDv1btIXC1vlXAYlbgYVFfUKgsHnKKI1/JykQdCfBGYBHaFUIuz0gVMcmRfcQIW2FxNoiil4xxcm3QTjz10eq8Y7ioGJYsQyCIQcSzafeGpH5MNhKvq4rufiSXywJZ0JkPIlipZuqPya7JenSeMKn1TDJ7J/0r8LaOml8UBlKl+s7wfOQKcfOOmRImQVSdhw1T9GOksRPajEVvJLjCBYnxhLldf3yY7Yzoj4wMm8YRT14/zikhbFHU8oiQPd/jURvUJd42dO1k3DSrw+2Tag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p7JIFu6tnjLi8ACJNcRmSii3PR9IjQ6SFebdfr7Q6Vw=;
 b=COTj1yvjsJ+Rg87JQu2b/fKQz/4wb5Phv9Urz953AHOmL7IU96FJFw1zI6eE2lSEigtRQLdXOXJKZHtelKuB8vUK5Jq41DpY5X0AwVXmOVaCcNfqesYNqMtD85J5EHm/hrF/ePko77QPS7SiCfZwRAVs+fiBDdNesfLoGrvwUQe/lSR31hWM646OZOXy/uvZ87Mrg0nlDtyAiu7kfuujsbyLRHaVzE8dm7khHYu1w2VC29R1ixb+Xi/XyB3cC/HjmjqYzbMjSMtbP5n/kEU/ekzzLCxRRngn4NKVRuWRPXm8fY+VulKmo4L0jfdHDbz++Dtg/oApfsAZxkHsnYQr4Q==
Received: from SJ0PR05CA0191.namprd05.prod.outlook.com (2603:10b6:a03:330::16)
 by CY8PR12MB7684.namprd12.prod.outlook.com (2603:10b6:930:87::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Tue, 11 Feb
 2025 06:20:27 +0000
Received: from SJ1PEPF000023CB.namprd02.prod.outlook.com
 (2603:10b6:a03:330:cafe::ec) by SJ0PR05CA0191.outlook.office365.com
 (2603:10b6:a03:330::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.10 via Frontend Transport; Tue,
 11 Feb 2025 06:20:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000023CB.mail.protection.outlook.com (10.167.244.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.10 via Frontend Transport; Tue, 11 Feb 2025 06:20:27 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 10 Feb
 2025 22:20:11 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 10 Feb
 2025 22:20:11 -0800
Received: from NV-2XGVVG3.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Mon, 10 Feb 2025 22:20:06 -0800
From: Kartik Rajput <kkartik@nvidia.com>
To: <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <thierry.reding@gmail.com>,
	<jonathanh@nvidia.com>, <hvilleneuve@dimonoff.com>, <arnd@kernel.org>,
	<geert+renesas@glider.be>, <robert.marko@sartura.hr>,
	<schnelle@linux.ibm.com>, <andriy.shevchenko@linux.intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>
Subject: [PATCH v2 1/2] dt-bindings: serial: Add bindings for nvidia,tegra264-utc
Date: Tue, 11 Feb 2025 11:49:44 +0530
Message-ID: <20250211061945.18836-2-kkartik@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250211061945.18836-1-kkartik@nvidia.com>
References: <20250211061945.18836-1-kkartik@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CB:EE_|CY8PR12MB7684:EE_
X-MS-Office365-Filtering-Correlation-Id: b263c5f9-b6c0-46a3-7530-08dd4a642d50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014|13003099007|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HBpFiP7lk2+Vq+mlkGfCC/cRezz2md6tmHs8DP5/FGlDRakTibUAL2Fc7vMZ?=
 =?us-ascii?Q?Doy0uCu+8hjE1dzgLzBE/w7OCKvxbDOZ1XxNrcdtmKLTjI6JV786FLbicJVz?=
 =?us-ascii?Q?t8lazKPtjIPTl1lh/Fbu+p9c9mA1+N+4PDyX1U8KKyx5GGz+CNFSxLGC8UVZ?=
 =?us-ascii?Q?0n+q7CLTUCRvzkITCbMW3jX219zCRNA3as0Q/2sGo2O9W3lMF+uWIKX2v30T?=
 =?us-ascii?Q?JQt+iIy2Km0aREDTPrF8Oq0NpnBGkxSKjKpWI5fLCjM3bAuuCjcdROiSZehZ?=
 =?us-ascii?Q?Pre/7aJpqVKgGZuT2zNvyshzapoRKnrp637Tx2pf1MB2ABmeXRUY2CxXuEYq?=
 =?us-ascii?Q?ENS1aWP6xs0s3xSThlY+h20uFVLKNm6sCtxgVKBVOm0+pKN8cmxX832oWxZk?=
 =?us-ascii?Q?7DRPsi5eM2Cbq27BMi04qbpl1FYFjqdJKeVLhb26fx5rRPMVJ6G9I+Tbn+ts?=
 =?us-ascii?Q?VTY3YFX9gCJ+eBAbYIbTYGJRA95qFrOEdV0IC963m/hlmKy9nrLi+fFxXw3n?=
 =?us-ascii?Q?X7W7tFyr+ZvrAGJg3nLbO/CmrobsA1i/n19/kvlvbbWA2UTWY79+UkxQXy/v?=
 =?us-ascii?Q?e7uI4JhlTiAt7/8raQ3Dw8k5VfCSyOmFa+nY61as6A2QfMdWdHUjpMPSWFcU?=
 =?us-ascii?Q?S72Ys66EE2i9zrpliYlotg3ItOHc04ulI1dp/ld8xckUee0EDr+V3VjZfwKi?=
 =?us-ascii?Q?vqTzH7A1z0hlUnVbwE5Qa1/wQ+3ht/ml+MmF9Q4EhHOGc83fnt/nh+0SYX5z?=
 =?us-ascii?Q?D0ENtJ20fVLNi4kjPqdubovrFJ2MBtrAkHuTUDPQfBz5Vmntsav20NNLeMxt?=
 =?us-ascii?Q?w1ysyKPZlUuuSR4zvgo0dcju9X2AeK9/GPSt4I1tufTR2GtiFurKBT0J0SLf?=
 =?us-ascii?Q?fL0Jb7UvcYDdSTo0RiRX5Zr1M4xRqwQ8or4b4tv1BYsQaSw+E+aCECvu8e2t?=
 =?us-ascii?Q?TkhQithTUFiqJZLmN6EJiXot/ZaOM59E3z41J5CSSxZqaH8ISs7QdBePmkUv?=
 =?us-ascii?Q?0WrZQQXnSZ4yKSSutSqJrdhnPPsXAwo2oGQpk3Dr2FWGZnJ/70EtuiWbpwFx?=
 =?us-ascii?Q?cb69ah4lkXXpX7U9aqoFB8ou7Px0/VErLzKoFCGVYvJ8yCgZz8L8p5Y3LQkw?=
 =?us-ascii?Q?fpFey88DW9C9z0vGb9xhrsFHp+0IO+5OKCzK+XhD7LZgAjTMzXIMT1bGDM5a?=
 =?us-ascii?Q?Y/84BHYAMIqpHuZj+HRKXd29vNvUK9GNkt7T4ZwhsHBmHcXzaKqOBaGVxo/x?=
 =?us-ascii?Q?p8u6NUbDfAscHEFJlcMYuDbHueAyY+K9BLm+aXZo+D1yLr6Phtp9Z3ep9qIJ?=
 =?us-ascii?Q?biqe7+Vs03TpWW8vm95vLJnEY3iGHq7ANaFxhnA7fhtJcfU6DFFJO7DlOfrU?=
 =?us-ascii?Q?YFrl5m4ab0WWNq6YnCzaIOApsanlM7v5AeIF3LSO7FIWzfZwqnAI/eewl2+b?=
 =?us-ascii?Q?G7lbaEdqYDH6YjzfWbvEtB5yOeozzSX/p3BHhofbsAT7wxQ6rz0rb2FFrBAF?=
 =?us-ascii?Q?7X4f5Twg2A9W11xSAmC3njmTAutxse5x1S72?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014)(13003099007)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 06:20:27.2661
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b263c5f9-b6c0-46a3-7530-08dd4a642d50
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7684

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

