Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2048.outbound.protection.outlook.com [40.107.96.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F29C1A5AA;
	Thu, 13 Feb 2025 12:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739451421; cv=fail; b=AzZFYTA0U6NT4F6p4BVlFJqMNXszJnBxH0PwPMtdabmd+IqOCEYX9K/FyXE9HW772y7w8KorI8mww1LOK+MTb7ZJkA6agjE4hnnrEj/kmGPFVmr87euEboj5EJ7cNgR5+/1GwVzxZb3KChTgGtKtE9vJmKuJ63axpMTEXnKE2sk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739451421; c=relaxed/simple;
	bh=+oXLtNuzN/MiAuSoV1VeSd6iULsm2Fof2bH2ZB4ouMs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nEPeywgwo910Z4VOuP7c7a9ntJj7Nk0olFzP00tr5m8iw4GvFWdoeRGH4h7OTVVIFUvOQqYuwpv5PdBffixnk+zMVgUt7CTiuQOCwmnDhq467oryDNFpWXSIBvROk7dhSYsIaM1cdsgE0Mp+pffkfbwRgFcEvkRU7CISu6JJQzk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FFX32qdP; arc=fail smtp.client-ip=40.107.96.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FFX32qdP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hrV3K7noW1Jc6685xqw4eh7cgRSH+bL2JEBqAII1MkdJf0XMlXjVyK65Lf/8NjBGGkVLh8jhg3PpjOp/MyS02pFjyoPifOpZgdCPF2AxjmQp5bS7s8bIV5RxKD5WQPKTOT+w9RqYSJI9u0l6QU6XWfciwfMG8T80i3NjQpbgKSsjZ8W4wuEP6UsRM28bZE5P0kg+B/4qtBGxSnWt+SOvgSdJbBVtad4xfsDd34nHbuDDQF7vGOHDs6GOinrTRuitwJia4giAh1uMLX69EYUY7O4jECFklOC4Yyl5NB+4ukEMC66iwtAv6g8ztB/MDWGmePBeshuj7qAIAzZ6Ck2RNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xzeqpkVdZXTSeeBOTu6YzymZsn3HBiF/TstUOj1CCag=;
 b=XsCLm8UqyCzkd6IpRx1W9LCRpRL8Uf2OKliTTDGl0wYiQy8NpW//PvjtPnddbDKhxbi8pefBgulRoLL7a5FG9CLPQIpBtdbFjT844SVcBy2KL1hjiH/k6ozqxU7zyO+cgyMphQ6lSDp4Kgv9eBu34trEYPRjA96ipYda1KZMzK0oJlrpiw8KJgU6tDfBAXcj4JKnddD2yPn2MGZPPDEJF8sDjfZ8pw5kW6cDqGBfD1MT8PsxdXSM4zxwo4JgiyZMjr5yqL1/b73Fn8fe+NZcFkHcE5pZ+24gKKDus5hKr/5myBkVJrNFyziSiWGUu3ugOkxrOuTzlTR4JKamHFdscA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xzeqpkVdZXTSeeBOTu6YzymZsn3HBiF/TstUOj1CCag=;
 b=FFX32qdPyv1IAz2uScT8AB7lxG+DPZL0wdVTfg3EmayunfRLnObBgOcqo829SNHOZjnBxwhUnQ0TWv3J8xg7jP5skjMTtHSaMJ/MZvIIQjTa8JBDN/HDYayRf2kgbqJ3EJxarfReeOopT+JbZq31WyOg5TQnFgb/J922fUu5ErsPnFLlVi4AapUfpvAWHtzaHJ2suQcp9uY6DjqzA14u4rsR6DNYv1YN4iAxX76sh9ae2A/vE2GnY0KEHqJSDVOWoxlrIC6/LsN8RqzBH4y4NId6X9sWkGqIGyLDd033xq371x+BDcZHcKV+9n1VmoQbXoBrB5PmffZTY+3xX8GBaw==
Received: from SA9P221CA0022.NAMP221.PROD.OUTLOOK.COM (2603:10b6:806:25::27)
 by PH0PR12MB5679.namprd12.prod.outlook.com (2603:10b6:510:14f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.14; Thu, 13 Feb
 2025 12:56:55 +0000
Received: from SA2PEPF000015C7.namprd03.prod.outlook.com
 (2603:10b6:806:25:cafe::d1) by SA9P221CA0022.outlook.office365.com
 (2603:10b6:806:25::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.13 via Frontend Transport; Thu,
 13 Feb 2025 12:56:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF000015C7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.10 via Frontend Transport; Thu, 13 Feb 2025 12:56:55 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 13 Feb
 2025 04:56:40 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 13 Feb
 2025 04:56:40 -0800
Received: from NV-2XGVVG3.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 13 Feb 2025 04:56:35 -0800
From: Kartik Rajput <kkartik@nvidia.com>
To: <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <thierry.reding@gmail.com>,
	<jonathanh@nvidia.com>, <hvilleneuve@dimonoff.com>, <arnd@kernel.org>,
	<geert+renesas@glider.be>, <robert.marko@sartura.hr>,
	<schnelle@linux.ibm.com>, <andriy.shevchenko@linux.intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>
Subject: [PATCH v6 1/2] dt-bindings: serial: Add bindings for nvidia,tegra264-utc
Date: Thu, 13 Feb 2025 18:26:11 +0530
Message-ID: <20250213125612.4705-2-kkartik@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250213125612.4705-1-kkartik@nvidia.com>
References: <20250213125612.4705-1-kkartik@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C7:EE_|PH0PR12MB5679:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d4c8583-3d69-4ceb-6cb0-08dd4c2de4d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|1800799024|82310400026|921020|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HRyzVJEpHu7lCK9t/UBNUpbQtlAgFfzStpPoz6LFirThEkzm6qkDS7JQkeCi?=
 =?us-ascii?Q?BffQMnfbAgQ0UkLYe9y6JUp9ZkHw6EagOJ3IkQxcV9tV46mUvHn+paFmrpbb?=
 =?us-ascii?Q?YeX6EiHhCND3MDRubljUl89vNwaN/9r+EyephhFlrzBjMv4PxiSyPK09UslR?=
 =?us-ascii?Q?S1TUawmIkF1AtyWmMDw+ByKuAVvm7uEAa+8baCk6qZpnG0IVHhBljRJbKWJ6?=
 =?us-ascii?Q?DnJVXY8LO/ximAwuPYQLwfxAnHN6tX64ORNMly+AQxEz66ooAzFdCczulUc7?=
 =?us-ascii?Q?he4aB58dFzRC1zOpi2w+oIu3Ubm87twpQpnf1LDoN9HUS77tNNU9WXdfWf1K?=
 =?us-ascii?Q?gmcSEZJBsOR9A0fninw144JiUiVPBDEGLktcBXg2wWyCPxL6qnyo9OWGqmfL?=
 =?us-ascii?Q?XvDv9M1GHcuzYf9c6Ro5ErgR32gIK4mwYCBBOkINp0MqqK7hofMR/9QEk0Qs?=
 =?us-ascii?Q?DxlGSkz9ben0spMripZHArfnaLoduF4qmM8ehOcEJYnKmm+dypHCF+Go11BP?=
 =?us-ascii?Q?KhdodNdQhFNoTjZzFhuYRF9oQEcE/a2q4+xJSQix7Ha8QHEf+dnfx5mLQmx+?=
 =?us-ascii?Q?cKLqa8Rp0OiU8R/6Cd9Bs/kDIFSEZpE8EJi0mEr4eU2ODMO+CVS1o11W9dX/?=
 =?us-ascii?Q?0Ji8m1ENcfZLRmDz/LxsmWJNdfgZDBQz7qWMTMhOlCrAj/E7AAkBPa+/xft2?=
 =?us-ascii?Q?hVVrr4PRRZ8zRPn2xe09GeIVorRXfb5OPALwlK3YBtUe0Ub3yvnYlFMLGYFw?=
 =?us-ascii?Q?mL+AA9zrx6LTFF0doTO0J8tnR7RI0QhbjCLdnxOFMbOewQudqc1sJk8K7v+r?=
 =?us-ascii?Q?8SRV4Gf6pHhBMYNAYlu7Wb6ycS+9Ko254d903kRryBaBCjuhx+NcLBBtMniY?=
 =?us-ascii?Q?HapzkNPm7IcJBkR35+JrLIuLs8oVIXbKtdAMraLgcEbBuMuIcLWgr8AQLoA7?=
 =?us-ascii?Q?HFU6rZgnMvRAot9xaex8SMpJyuOhT2lhNjlDuOP0BG3vw+pI8DbAi6yrhn+w?=
 =?us-ascii?Q?IuCpx16D1O8zkYKz3iLakqqK1TGHyzbeW3ygegjtKXcT/lNg7Idlt5IzWLsN?=
 =?us-ascii?Q?kbEMuNw8aLESRJpY/3vxQ1XtUOzT5o9x8DKBfqDBn+N/QCfcKULTp1Aw+riV?=
 =?us-ascii?Q?pgE7jgfyj8DtN8XZFSkhsuq6xypLtjhzUMfcZqXKVtWpI/7IQiqQv5ptxu3v?=
 =?us-ascii?Q?Ext6zKfXotNUKRLC7L8SyiO+AP+k6jFoAIwqC9qvpPQlNik5wo1F7+UCrmQi?=
 =?us-ascii?Q?p2Jt8BaQQIXM86KKJk1CYPMjsYBS7ayqN5xt89d4HfnisFoorYvnCS3OpuFl?=
 =?us-ascii?Q?YLeL6pI8JFDt7IM1YTUONEzJTpd0ITYsAIx78goznAi62GaU+1/qi+ijPMA5?=
 =?us-ascii?Q?twHZ2lcV9TZ+FIVCUQRsbQ68bS6GN/4NYGHpTXWixn4gHaYa3tvBVGiR+uG4?=
 =?us-ascii?Q?88AxrtFUYchl2rrSJiWcRWBjvXrBdaPq8f+KTo8+d1HIe7TAiWJ3sA+uOfG6?=
 =?us-ascii?Q?BzZxGcHsw7ae0l0OtEqmiskgsvw+U0bY3VQL?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026)(921020)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 12:56:55.1700
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d4c8583-3d69-4ceb-6cb0-08dd4c2de4d8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5679

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

