Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B55211474;
	Thu, 13 Feb 2025 10:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739441135; cv=fail; b=GSm2IgP8W5AGACbUjXX8kxLJzlQ+3sDs2//Md/TUOvig1vzz307DeKKu0e2WixN7jsgamHJ1mgCaOJj64xBQC0yw1A+AI1VLfhJb7w+bF7xE38VS/WrrMqbonn+UvvZ8anMZ9wjikkXDJLHIb4xVgAcuQQRFG/ZvRkeUheKntVE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739441135; c=relaxed/simple;
	bh=+oXLtNuzN/MiAuSoV1VeSd6iULsm2Fof2bH2ZB4ouMs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lNwFTNHhOiEpssAMmst4OTGpQo9hJ5l6SC0ZAE3Tgo9i3sS16ig52P2Y9wMScFyfIfmK1+yJ6kLwSEOdq1f+rPUN31av7tAXaLBQ/u3DbTA+HmuMbRqg14uw83P6iG+OCpvaXKN8TX6IpYiEySTERWVb/pKRkkkSeGUHabVa6mM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=F4m4rdap; arc=fail smtp.client-ip=40.107.243.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="F4m4rdap"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RSgTzRrBZfsIovWmDTifSkPbGSJ/9HQsqT/Vi91xJxnU3DcVukxBNKNLJKBqS9EFgY4Ks7WYW2Wxya0F7zFmCr0+ESQny6bdXBun/dIPIAIEPcLyIgC8ss1/uCZXqC2u1BNGC0Z6Xo1zIEk5HwIdw73dNujFvhOr7dgCY+Dy1+4pEeI0RzjFdBDcFDJShqH7XejyElyA/a1zeFOD1i0IQEmXR8anLLcxgpiIlWilXfEQuWhcxpvHZsksNnZ2JZF+QCnkS8fDqDPsu6yb3KpjwE0Xsr3yhtQI2SY5L7CDJXFtb4764UPOBctRTfYRfcbxEWECVBk98id4st8146KdrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xzeqpkVdZXTSeeBOTu6YzymZsn3HBiF/TstUOj1CCag=;
 b=PVtVKhjNH1SdniLx9Fz8fbbgp3HCzJB/Tc9XrT0kMNLpQIARnFMJ5OEwJ7dpHpjhsYzs6h1np5Q5rT1re0SPXHp8cVGM4lqXDPVaFgn3H/ak+ncjiiJqdOZqj/b+RSgc48W28q3QgxSDlIUTvHQCPqvViQCVc7PYgoIXYgUbX1ZxUYiIBd0Gn+Elr5fY4CNXQ+d6OqYQUWojjCcgoEb/YqfdnYxPCCBCq024EM1uypi6jy9b9WdvqK9EtvhFjgmzCZgvEfyiamsdISHUDhWXbBXKJbm0TZbtmTqpyGgkzOgFxif5+joDPNx/tfo8LIA5uldh7eYqXhI34n/DFbJFAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xzeqpkVdZXTSeeBOTu6YzymZsn3HBiF/TstUOj1CCag=;
 b=F4m4rdapIP1gNMZcADNZCvmS8OdehypA8gbArS4OTrHCnHdMcrw/W+UdYq/pWf4YgWHHBg/Y4wYqxDZZFHvf9J3R7huSFPYaofCG6nlSAvE7RRVmxIENlmZb3xQPYhzooGHUOo30Sdg9IU3Ku38NJHOMApIAuzKp0aKrXtBPEajKXEGSOMdtNiTQvhx1wCcUKBLM1u3j6Zwc3UBSVhrohHhTQmlAwdfK6vUW6gCDaQ6YuAHo2PmwEAt4zBSK2/dvULPkpd21wwK/IXxY+MT5y92hqfvWKXK+ttZ9CiLUzJ4r1IooSCwdjN95HCzJ4Jiof+dAtkbwbcO3+Mcp/C1wbQ==
Received: from BN1PR10CA0002.namprd10.prod.outlook.com (2603:10b6:408:e0::7)
 by SN7PR12MB8147.namprd12.prod.outlook.com (2603:10b6:806:32e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Thu, 13 Feb
 2025 10:05:30 +0000
Received: from BN3PEPF0000B06F.namprd21.prod.outlook.com
 (2603:10b6:408:e0:cafe::e5) by BN1PR10CA0002.outlook.office365.com
 (2603:10b6:408:e0::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.12 via Frontend Transport; Thu,
 13 Feb 2025 10:05:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN3PEPF0000B06F.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.0 via Frontend Transport; Thu, 13 Feb 2025 10:05:30 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 13 Feb
 2025 02:05:11 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 13 Feb 2025 02:05:10 -0800
Received: from NV-2XGVVG3.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 13 Feb 2025 02:05:05 -0800
From: Kartik Rajput <kkartik@nvidia.com>
To: <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <thierry.reding@gmail.com>,
	<jonathanh@nvidia.com>, <hvilleneuve@dimonoff.com>, <arnd@kernel.org>,
	<geert+renesas@glider.be>, <robert.marko@sartura.hr>,
	<schnelle@linux.ibm.com>, <andriy.shevchenko@linux.intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>
Subject: [PATCH v4 1/2] dt-bindings: serial: Add bindings for nvidia,tegra264-utc
Date: Thu, 13 Feb 2025 15:34:41 +0530
Message-ID: <20250213100442.45773-2-kkartik@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250213100442.45773-1-kkartik@nvidia.com>
References: <20250213100442.45773-1-kkartik@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06F:EE_|SN7PR12MB8147:EE_
X-MS-Office365-Filtering-Correlation-Id: fefc1089-de2f-4f81-2358-08dd4c15f27e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sSSm5sdTOZVJFKZlc09ZxJe5Vr7P7i7ykqkoZ/os0K0dVGQkbUAHd+00tJWV?=
 =?us-ascii?Q?aD4NEvmuDLbK70C4UcTD9gAUNlgPkrqOjvbv8bN0OM6/DkE1p9Q/L2v9KZmM?=
 =?us-ascii?Q?6Q8mjsQcDk3m353rvlXnAkGVZAr8p1GwOZIiQZiZF73uqUZW157U8SGEa557?=
 =?us-ascii?Q?vHTKOb6hFvfzmcE/cQPpyxdbEeWN8y/qUSklcapVPzl5acmBkXUmM4Q/m5t1?=
 =?us-ascii?Q?t+noCino2jcTBL1IejaO6bX+j+3F31+CwgTLrNsYLZllJyjTlQ4p5K7RYeE0?=
 =?us-ascii?Q?ni9QmI5p/Fs01v9F15bfRYLbRRYxCyV4cxiV2w+ooWz+EiRxkbLGOpFsSez0?=
 =?us-ascii?Q?9Iqd3zTLbKVVPpMUhn7osx/BOHOsi2x4R5E6zE7gxbY8HPZWGEH0A8cSyyyZ?=
 =?us-ascii?Q?bqrYs/VPDC/cIV5hk1FSTw0bk9dMcTM0bJ2WGB00Pp0cyymX2rY5uJgunyOD?=
 =?us-ascii?Q?5rdkrGjRh7ZPHRn0iJp4EW7MOgJ+oajSmR+iTW2xQ8AALCWgV4CheWNeoIBJ?=
 =?us-ascii?Q?fVDOIZTnYQmUPC+mINeCNTfBokaA3Nv1u0ieGMYvRrn8ai69sr7wSsSundxv?=
 =?us-ascii?Q?Ua22o/k+PxlBPwr3SE7ZUcDhQqXN+I5Oxp2p0ZRf3dv1+QYJFNZMiM4GkHek?=
 =?us-ascii?Q?h9tX3QNEDj9SgfbrfToPeh+9CxMX14QqKLz/HzN3qv9nNM/GjHDZJE9hWsco?=
 =?us-ascii?Q?ZSTDJFo4iSq9rjNSJDx+NCgQoHKAgBJKUqBgJpc83PWuElye5jxkJnQ/RUjp?=
 =?us-ascii?Q?pMI3DT7q2y34wAclCTIcd9uz86jqCJjouFdJgMAdSBQPVofPrFVjoAeGu1bw?=
 =?us-ascii?Q?jxRnsKfXVRQ9eEkRXGkHmNlnhbzq13AlWSVSsK8qDGBrqxRMhzyiVrZR3uXx?=
 =?us-ascii?Q?/P+haBN76G4cSrcwlIw1UCYoxp5XoXKLFubRxNfRsy+AoCgSeJKHylmEIwfG?=
 =?us-ascii?Q?eu8ogqbtKL9NDyIUsE7tjlC101/ppC9t6zOg/MjvVMncPshWln0B2iT2Ts80?=
 =?us-ascii?Q?J66LBAuYGLS7HjQYq33q3tG6gXZzwzhgZaj15F0wdl7JrxCAYsTRJTnLd4h9?=
 =?us-ascii?Q?EvXiRIIeGVS9OprEF6ILrT/fq29E0g0WHeILoaXFqwlifx82+FQPy3ajz3Ct?=
 =?us-ascii?Q?dxaLC8E4CqlS9lOKjs4SSjfldMSPp4eL1qcW8VvS1mW/0bSirrN3TT2TPged?=
 =?us-ascii?Q?91jZ5WXxhJiMS+6R4RIzvbcPT9KjYgD1qw3hvCwtUWudJrlF46diuRqBPZux?=
 =?us-ascii?Q?ERkR/6hdS38rgUNGYNQRXXgDOozOdVN/h/NUGMYE54gsII1ELv5G0BrJopFu?=
 =?us-ascii?Q?rnTFBWgiDyPOID/JZZinaa51hWMqyf2njAjaWJ+gSXwjzMHa4EaUaT2XWr0U?=
 =?us-ascii?Q?yR8tOGyyuy+FkC7CcY4BSYI+MqxskbuyDUNsxTIPWejEy1HJwxvjaDg0PQho?=
 =?us-ascii?Q?w/rP8o+Nlha4VVahg8bcnECBEJY70LRHuTI5uLQUfWht0RMAn6PA0KRDc/zG?=
 =?us-ascii?Q?8m1IYpmGiWM36eylYlXBdqKgYJe0jgsmNI+V?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 10:05:30.0980
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fefc1089-de2f-4f81-2358-08dd4c15f27e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8147

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

