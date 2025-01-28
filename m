Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2058.outbound.protection.outlook.com [40.107.92.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861581DE8B7;
	Tue, 28 Jan 2025 06:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738046829; cv=fail; b=eHAPNKlAWnDhi+OSeT+pyrW+vO2Lxuvaw1x3BZHPt8ehiE1lU+Q7yjpwbzTbSe+aeqv3qQuZjsMqekl4U/o6wTeD84vsMS2i1eRMeMOmzVLyD9pRhqD4nnGD9D0M+/1IKOW0VHT5nSmnwdNGU0y9bB7FaCOE+v5QtSbi1QCF6qg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738046829; c=relaxed/simple;
	bh=yXHTdTa4K92+JoNLwaJAo4q9kctjo60AaQwpcgEFwjI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hnJUprZxmEuElUo+7a4dEMsY9YrzasXImVamVnCzrbJY9Ey1Rneh9IYVoqMR1Fo8tZOLKMHn6F+7C5cwhc1AEYH1oTy1wfbIZAQtF09+4jFsKO7w7JGO57uzJZMQv14Q2wmYQZ+rk70KedMtdB5Nbf/8lX3ENhulXttKGYCZfoI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oqMv6emH; arc=fail smtp.client-ip=40.107.92.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oqMv6emH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U8V1upFcRwWPbv3D6IUrhGnWx+sL5afvEOAbthxy7WkqgE9alzkMV3lY6DvJgxMzJq9r6/MdUCHFjwerkSZt6UtBuxVBPDILGq66FPdyg826czOkISa7q5NYinJYsKnRHzIzLa+gEnKHR0epL5YWohPI92nWok6XKCmUfthU7wpca572/eBY3OZ3mxn3tjQ1CstEqtvFsaK0IXmGrFLXjD8tNQ2DjBKDj7+93Eyv0qd6ZSOQjHYZShHXfk1eG42qmDaKx77KQihmDfD/SOj99mVL1xfEMo9vGLWhs60mit1VGbvf/hzp+1FS7cbZTaU6xcSjHTHNOqzyjNpLoRJJiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b/u9lP0CA3PMTZR+28aiBZyr8tVQjJD0Y9Jj0cO3+ZM=;
 b=g1vZrRrfLCdkdIc2gkQICx2zDqKCBpxAp+69n1T9fEQosxkPFQz/S79pf5mikbvBpRLzku6UG0MATeRt/3f8d15//WpDN9Ouo20KTDtiQXv2U0YsdARlAS8vrZGlGmL0HBxvXWu+LspjVismX3BIdwzo/0wwVlrsoop7/ZuZdvUMLj879cxaZOFOM6YaUJynduR9TA2NpUA41PUGvPGmtsPH0aoRCrPjHytWcToiKeRJagXn+CNqmcbMxAzTwc1xa8vHOkbRs3iiQRQUKnGZ0/kctSKl8HFhlv+VY0/MVgoC/x+Akxf6PdJZmKEoPC/IWyeVNiXdeztn30p0JcjDuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b/u9lP0CA3PMTZR+28aiBZyr8tVQjJD0Y9Jj0cO3+ZM=;
 b=oqMv6emHBr9Qe1QMSE7roLCZCXbWWPDbpamNG9C1rzMV757EO7PuzYFljwcNuBpW9guOlSQBrD2qdPqS4++HPd7ZrjeBOKNSsBjwbFqkw9nQ0RYhd6LBhzjCD9GacjbuCfeGVj16vwl6J2zRKQ+AfizUjvBNGsch9MFEPx0wdp9iaFAZ27RVZt3K0QitgLksHBG0Gj6UciEC/WuSTWRB1DK+cBzlykFfy+N8QqHpYe3KC3A/AJ6lzX9cJ16iWatLo5SYdVp06lejnaIxvsteksek+YTQKtiJSkOREL/4IWeA+RCnmTyWgU+GtC4LPrVIdaitKSr1nLcCrJl402BF+Q==
Received: from SJ0PR03CA0038.namprd03.prod.outlook.com (2603:10b6:a03:33e::13)
 by CH3PR12MB8994.namprd12.prod.outlook.com (2603:10b6:610:171::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.23; Tue, 28 Jan
 2025 06:47:01 +0000
Received: from SJ1PEPF000023CF.namprd02.prod.outlook.com
 (2603:10b6:a03:33e:cafe::6e) by SJ0PR03CA0038.outlook.office365.com
 (2603:10b6:a03:33e::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.23 via Frontend Transport; Tue,
 28 Jan 2025 06:47:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF000023CF.mail.protection.outlook.com (10.167.244.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.14 via Frontend Transport; Tue, 28 Jan 2025 06:47:01 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 27 Jan
 2025 22:46:54 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 27 Jan 2025 22:46:54 -0800
Received: from NV-2XGVVG3.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Mon, 27 Jan 2025 22:46:49 -0800
From: Kartik Rajput <kkartik@nvidia.com>
To: <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <thierry.reding@gmail.com>,
	<jonathanh@nvidia.com>, <hvilleneuve@dimonoff.com>, <arnd@kernel.org>,
	<geert+renesas@glider.be>, <robert.marko@sartura.hr>,
	<schnelle@linux.ibm.com>, <andriy.shevchenko@linux.intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>
Subject: [PATCH 1/2] dt-bindings: serial: Add bindings for nvidia,tegra264-utc
Date: Tue, 28 Jan 2025 12:16:32 +0530
Message-ID: <20250128064633.12381-2-kkartik@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250128064633.12381-1-kkartik@nvidia.com>
References: <20250128064633.12381-1-kkartik@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CF:EE_|CH3PR12MB8994:EE_
X-MS-Office365-Filtering-Correlation-Id: ad19736a-58e1-4919-c9c8-08dd3f6791d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|376014|1800799024|13003099007|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IrICY+MEMmD5X2+qZpuXgc2e+ffKuPbkoAeEAtTQGHVxidoP+bbQmh+M3dY6?=
 =?us-ascii?Q?SJsTbc7Ux8HWYB0mgEadueD0dAeEB/s2AHWuea71MmdIYCejThrB8EWm6RAR?=
 =?us-ascii?Q?Efsf2hSX9YJ2JqufHDv2UIz1Eo0aIhc3gJ3uA7VXI/0UNX42cztDUgE+39gq?=
 =?us-ascii?Q?NaNV8h8Fz/euVv7bqIViN1txgeLAMt2XHR57bnNkrJf/oOWmlDpsZ3DhsYpZ?=
 =?us-ascii?Q?X+F/2LSD88mG0Mzw2+R2coHEWNFODtE34iPAbozpeLgzL1ez1OMBFhyjRGO0?=
 =?us-ascii?Q?Wmqi/r1rdPSzAjfsOH3uUQKIVBPV+ljWbxN7EjPKdYfTsddS276W/Yw+tEPP?=
 =?us-ascii?Q?cq2GN6ma9juiAYc6Jc8CuTxSvXzeJU1i1IWQAuw7GbW2kPxdSiKoh/Spg54n?=
 =?us-ascii?Q?/tbPeTHk9ITW7AYTZIlQL/0y4oqVzc//yf0fex+El0+K9ZxwVx1k6xC9ZA1D?=
 =?us-ascii?Q?Z/dq7K+EVQdbUYYmYZM9X5TY4aeCF43vNTz+FCmTMyZylG24DiGbhAggeP1G?=
 =?us-ascii?Q?OMhXqkWrHZx+BU7K3igIRurdbcYvetTJkJNl3hpfBBis6RKu+Xn6y9wKBjYN?=
 =?us-ascii?Q?i/3nIZ2IMADwxG5XNCGETB/wiFflEdniWS134wTUDzD1FWoiSfIWNX1vJHE1?=
 =?us-ascii?Q?qa0lCLjUDfOKZuJKjLZsYduz+W8CjhutpuL1W37pOm4h+KNlQS9ZW4OSFaX2?=
 =?us-ascii?Q?D0TmWXMqFEdS00JwzMpLDrAxxH+CWSEL9Jf91HzRHPgL4ippiSDHAzcYyG3D?=
 =?us-ascii?Q?i6OGiy1+YjhTnQQjh+ftbzjyP3MbLeUrgMb3VWR/m+rffygBVv39d/o24InV?=
 =?us-ascii?Q?pv8NVRQO5vgfw5u3DPrTsueYzHUt3z2961gfrJZghrijYqPSWz4XwlEut3PA?=
 =?us-ascii?Q?pLl9r9g32QBurwBmWLfEWEHX4a85PWfHwqasQbyzoDZ9hoabZs8o9N8WIk5c?=
 =?us-ascii?Q?lCqRuVvE9dAe7gHImQirKSytQl6eKLvPMxZ0C0GrdpHFsomRKpamtrnvalYH?=
 =?us-ascii?Q?a1rS7rZmQetJTlE5M1kfIRhCCmQnrYyF5v534q5dSce8cmJCZIHiTMuCMRHg?=
 =?us-ascii?Q?cKIWLQ/Q8hSA6HdqUX0cpywUPo5rPcSVMG+WYkl3cqFnvtSs/3GR+XL7ohqm?=
 =?us-ascii?Q?Kl4dVQry8ucVWbfOVJSK66BWpVkLGmd0Coxf6Jcd3JSb3h1rbRSmAqr0gE5n?=
 =?us-ascii?Q?P7z+QWxsD1pmedz7XQiryovfpdu4StffK4ZhWPh11BHoyjZsZb3fslxwNls1?=
 =?us-ascii?Q?BqzxScnCKui+4pGBiQl1SSIErSvDXfuoxsNzvON8a0yjNH1/nPfGISk0BnAb?=
 =?us-ascii?Q?u+h3pXbluygNmKkMf+mDvznecVUiEOaVoL2J5Jdj+YyFdGsbdHwGoPzJehoe?=
 =?us-ascii?Q?CKGRzxEzM1vmCtcFITpcAMXZRlo3QssNJJ5vMg0BxRTLy8louxdRDFjcPzi+?=
 =?us-ascii?Q?291XszQTsnLdbPFYis7ahP+FkFlbVAM2TAuGrMYr91xE2XTOBAO8l4m5AORG?=
 =?us-ascii?Q?XyICNHuZzjqhjykMtzoMjAH8BJNTANlNor1r?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(376014)(1800799024)(13003099007)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2025 06:47:01.6988
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad19736a-58e1-4919-c9c8-08dd3f6791d4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CF.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8994

The Tegra UTC (UART Trace Controller) is a HW based serial port that
allows multiplexing multiple data streams of up to 16 UTC clients into
a single hardware serial port.

Add bindings for the Tegra UTC client device.

Signed-off-by: Kartik Rajput <kkartik@nvidia.com>
---
 .../bindings/serial/nvidia,tegra264-utc.yaml  | 83 +++++++++++++++++++
 1 file changed, 83 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/nvidia,tegra264-utc.yaml

diff --git a/Documentation/devicetree/bindings/serial/nvidia,tegra264-utc.yaml b/Documentation/devicetree/bindings/serial/nvidia,tegra264-utc.yaml
new file mode 100644
index 000000000000..63ba3655451f
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/nvidia,tegra264-utc.yaml
@@ -0,0 +1,83 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/serial/nvidia,tegra264-utc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NVIDIA Tegra UART Trace Controller (UTC) client
+
+maintainers:
+  - Kartik Rajput <kkartik@nvidia.com>
+  - Thierry Reding <thierry.reding@gmail.com>
+  - Jonathan Hunter <jonathanh@nvidia.com>
+
+description:
+  The Tegra UTC (UART Trace Controller) is a hardware controller that
+  allows multiple systems within the Tegra SoC to share a hardware UART
+  interface. It supports up to 16 clients, with each client having its own
+  interrupt and a FIFO buffer for both RX (receive) and TX (transmit), each
+  capable of holding 128 characters.
+
+  The Tegra UTC uses 8-N-1 configuration and operates on a pre-configured
+  baudrate, which is configured by the bootloader.
+
+properties:
+  $nodename:
+    pattern: "^serial(@.*)?$"
+
+  compatible:
+    const: nvidia,tegra264-utc
+
+  reg:
+    items:
+      - description: Register region for TX client.
+      - description: Register region for RX client.
+    minItems: 2
+
+  reg-names:
+    items:
+      - const: tx
+      - const: rx
+    minItems: 2
+
+  interrupts:
+    maxItems: 1
+
+  current-speed:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      This property specifies the baudrate at which the Tegra UTC is
+      operating.
+
+  nvidia,utc-fifo-threshold:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      This property specifies the UTC TX and RX client FIFO threshold in
+      terms of occupancy.
+
+      This property should have the same value as the burst size (number
+      of characters read by the Tegra UTC hardware at a time from each
+      client) which is configured by the bootloader.
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - interrupts
+  - current-speed
+  - nvidia,utc-fifo-threshold
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
+        current-speed = <115200>;
+        nvidia,utc-fifo-threshold = <4>;
+    };
-- 
2.43.0

