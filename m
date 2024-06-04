Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2128.outbound.protection.partner.outlook.cn [139.219.17.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76608143879;
	Tue,  4 Jun 2024 08:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717490880; cv=fail; b=DrCLNt03JfabwI9J7j5JOKfAKh98sepZFhp+1yuUEMR+k3pCzVJ+1DUxj8U+rPqRTr1tDi/vTbVLNlG2NcCIFM1Vw5bVEklS3zWk1BcEhgVI715IHYM0x6sh+C+uA26jOZMxfR52azoK8721K64CvxNZnmLoLTzrxE7s5bGg4io=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717490880; c=relaxed/simple;
	bh=mh9w7BDjSgmzXr1FH2jB2/qV8In+X/hncrD4s01gfrM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uQUYwcUIP+WWmyVIn96rvuHP0+tNuxY4V2hD5Qoga6MsxwOUExYhOq4h4UaLXEsWsPE+4uZnx4rEue46hOAOjIEIjBrlJT44OydYg5Wet223nXauin/aAwqw3qZ+ldfuhTZe+pUxDyU4nFobbnIvdUlCO1T2LYZw7PESb5f2ixs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IsBQRDC8VnnclIMqQOqKVtnbLdHgYcbL0L1iIkIj2oflAOTkggPVU5Mpm9aKOPj/vt/AARg8Iy8LtfXBCgYYrec1n6C7M9QodROp5hKuGbIssaMrspbw869MmZlUFfpEitCctBzCiOBPOffh6wywqqoxwTQZmgdnpY3FcoMs5VkG4SB4HtnKGlnqbwNKIJqNQHPXDiuwRrNEXx/iNkaAsTwBxJPIcoaMmJJiZtikcN0a3NNsrMlRGMnFdtPDEKOzrUVkNw6XjlUZ9VfzmLPBPffiA8THUtGDzabsNmdXJLiKNlipdc158Oy9WoFlDmcPm8gJoIHIjjl2AuVGDvC26Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HkvZmyyxgmqyrX3e6z7Witz+u+BdUG2bCDwf5kjjqVc=;
 b=PgnIn9t69Khezm5t56VXE6CMJL3N6GghQg0z/MEvTeZczIOXNmhigd2TWGx2FM7CBN1MPMjUZbdeE0j3FpPYJhVpfK1BZuZUi7faly9Pb9EWeP9ZDEJLJZ3oVQTnbfOh7OuIV6chcPMvvHdsn5UzLNARQ9z6djfW7XInh2+XwmSAzgZH/5Na7FyF0BTt6R8cPGlo/aPsUpA45vaxM8MIhZONibBaT4EE2Vpadt+9AUjiNsouV3q/EnMIcGlEAgGHMO1+UbIHSEHIjsByRTE22x7+a7pwV4d/J1uNvJpZIKYusiqh1Gx871CZ+xFMcahnJqudjBKuWdlJXpBSx8kw+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1324.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:12::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.42; Tue, 4 Jun
 2024 08:47:40 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::61c0:a8fc:1462:bc54]) by
 ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn ([fe80::61c0:a8fc:1462:bc54%6])
 with mapi id 15.20.7587.043; Tue, 4 Jun 2024 08:47:40 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Conor Dooley <conor+dt@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Hal Feng <hal.feng@starfivetech.com>,
	devicetree@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] riscv: dts: starfive: jh7110: Add the core reset and jh7110 compatible for uarts
Date: Tue,  4 Jun 2024 16:47:29 +0800
Message-ID: <20240604084729.57239-4-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240604084729.57239-1-hal.feng@starfivetech.com>
References: <20240604084729.57239-1-hal.feng@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJXPR01CA0055.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:12::22) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1324:EE_
X-MS-Office365-Filtering-Correlation-Id: cb4ef7bc-6058-4ed8-a7b8-08dc8472fe2a
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|7416005|41320700004|366007|1800799015|52116005|38350700005|921011;
X-Microsoft-Antispam-Message-Info:
	0lfbFGCkYcPAZ85odcy1hmP7lNv9xUu64ANPXuXdZA7vVk1oeKSq/cArLCxfMNcPv613VKSpa+bU2XYeLBo42BwK+20kSg4v1LFhVQPfAMShJwGGV6YUiNOH/FniwFI5OGqe1vreh2HDXy7X5R6Nh9bEQ0hS6q/XhZGRgMuB56mG7G1Go4ds9GRTch9qf5KBDVktgrnVFrWFCg9idCC0Iecv8XFb6tCLUXy5eqwnyWzDHq9OQbFCURfi7TeC+s3lXsaLZhfzT1Wg3wmbD1h+yrFvPZBILDPR9SgQy3371Qb+X60Zsro6y4TzGcux7x4qo/inHM8N+3LGgt/NRW6toL1d81rLxgMvoKryEJ86JspBD55sI7iH1fMtHGV1lLEjyAlGCwEfF/IqEuA1qYp8sH6okLUSWPupgTOB+hpMUzngd3hRF1L4VrGRnJvpP3+T357GAaD9KQdG1fw8NGWuZoPrwz89747wHy/e+dPj91sGPw0w+f9BJgkVDpqWBVZ+0/Nv4Td/B5dyxTLD/yEFRk6+XroEnMEK+bfGT9X7ECe1UnPBNeXrHcu9PluiHCpVDQWhZ9xzSL9UWfD+T6Hdl14vnzdSWpxE1RkWrwr+xpPWxeGseKCd4BKmBTJ0yi0y26opvbYHivE7ZKSmC6DlfQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(7416005)(41320700004)(366007)(1800799015)(52116005)(38350700005)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4VnrpvRKdmo5qngze15IiAUlFs4eXzA/OF7CIQZNXHLo01dzETaDfFSEASrK?=
 =?us-ascii?Q?bfTiqLvNskFbyRd4jzRkJdi2t5HvfCjlEc0MWG8T5cWpbKd8ALLuzz4H1S+t?=
 =?us-ascii?Q?6NU1kIpn9FHrnjeC90E6nsEAfXHzyq3RiQkiVKOLT9VqrjbVCxaNHdufRfvu?=
 =?us-ascii?Q?R4kHznXXNN1kOfY5DlETcEMbJ2ebC/e7NLvqxoEoEg6D1CPjbD5kKcwlyoLs?=
 =?us-ascii?Q?Fh39j7trVgB0VGiE5yKvVOwz4rg9PgWSw8XZaNE1GEubuFlLpSdKpRXff5/C?=
 =?us-ascii?Q?e6pWtjATEZnSaqRwsjxWijRewRP0N3km4Tnrzu92NQzw7eGnNJLOVktjS2Jt?=
 =?us-ascii?Q?CnrvBys6bYy4SeQwluurle5iA+a2NLVcveqSHMcUxTddkMOqLbpMEtSUaFXZ?=
 =?us-ascii?Q?QDthK4Af0WgTafSZJJy4blHQxTECamUCY2lXOwpP0pU46EYC7sxtSZFqwXSP?=
 =?us-ascii?Q?6q9voQLCdxPYRYwkTw14rvjUAoPSzN4TMoTbOXZMRkcqLPdaLugRsxAhkNDV?=
 =?us-ascii?Q?xL08YNrk3NK+uGtsN80shXWfOJWbnmPw928slnec0NJX7WncOzzDRNyi6VHd?=
 =?us-ascii?Q?uIReFjtTTD2HbGHlsS2an2pFmhBV/NwK+VkHXRU+VyB6wRnpA988O8W7OJtf?=
 =?us-ascii?Q?l7HCydLBdxgPQkt4aUZTkxeIZz3hRz5FusqbHSsdxOrKH9KV70HAyIqBeKiR?=
 =?us-ascii?Q?ob4o1ZcikCx5/o4xzT60cBhkLrIRRtvkoIqCQovZFW+tPXqfF+ld74oiF3t/?=
 =?us-ascii?Q?oZfGpAE9wP73f63QMl4QSarb/lkGBhRXaQWTQh4iDI3G0dd4o+g1kdfS9OP+?=
 =?us-ascii?Q?ejjGnqEJV5r8YtmTdv6fk3usuBYMpEsEFcIiA04StBjkAb7fCs3KRU8Gw4j2?=
 =?us-ascii?Q?zQ1vLdChDJq0hm0tC/GW9SLH1gas7D5eeG+i6nDuW149eCIBwR11sfZQOxWR?=
 =?us-ascii?Q?J4XWJtjmisLptbkFzp1YAO/4Z5O6IewjLegxNuqRm45d3wVqED/eeyteyPsH?=
 =?us-ascii?Q?j5xks5Jys2ozuTY6Z38lwVLkhfh/IdqGB8BcOsA+Ecqo832GrxSjE44hk8jM?=
 =?us-ascii?Q?W3FFNOuMrY8MldwGKiTCTl8jW4jltTFu5eh+bSz3Sz9N8ebtxh2nkfipdUjh?=
 =?us-ascii?Q?rXXAPxWU5HX06MylmAkqj89pY5hjSifxTf2NptmFeQ7EUHT7Sw5J65ZTfZfi?=
 =?us-ascii?Q?I9KXmmGs0XkHodfCNOM+YXZB8jNRpXPNmiETs+mGGJRMc5ZPgSiFXK/OESzC?=
 =?us-ascii?Q?c2CVGbh2iCYiANeXxKMjS+eWOvqV6LbShavzjthhbgkwaCkedZKk1YGp7vSt?=
 =?us-ascii?Q?iwGk9ug0JfPs8PGMv/Y2nJgvKG+jqJ0vzQGBv7nTXAvLhn06CSOSb8ktQr3u?=
 =?us-ascii?Q?JXuuLHKIBfGYdQEqwnu47PB8R51+0tv3/af+hFFL/BqA66lt1OT4OJR344n4?=
 =?us-ascii?Q?C6KTCRZdMzh6uJXxY3tG+BM3qx/v4n+vB8Qtm+37MZm9IMg6CPdv5PSiqXpe?=
 =?us-ascii?Q?xCkJTtcDj1nC8LNIhTvFCepmpfwfMZi010GchPfI43hJHPCMduooGhkI3Woq?=
 =?us-ascii?Q?ejHiit3KMoPda3IB9vxyEJ1PbdPqeK2W7KHVG2QMIahAUeqmY7BeLMcQo0Cr?=
 =?us-ascii?Q?YA=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb4ef7bc-6058-4ed8-a7b8-08dc8472fe2a
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 08:47:40.6357
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xyVLXdX/H2bf+6CLdO+3nekHkMcuSeAv9hTA25RUjguF2ISeWQY5X3OMGJp2ZBj9eZLE/UXqDAQPijkjJP1m4YX3h9ZoTviHZIWSVlQfoN4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1324

Add the core reset for uarts, which is necessary for uarts to work.

Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 arch/riscv/boot/dts/starfive/jh7110.dtsi | 30 ++++++++++++++----------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts/starfive/jh7110.dtsi
index 18047195c600..7661ccf7406f 100644
--- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
@@ -387,12 +387,13 @@ plic: interrupt-controller@c000000 {
 		};
 
 		uart0: serial@10000000 {
-			compatible = "snps,dw-apb-uart";
+			compatible = "starfive,jh7110-uart", "snps,dw-apb-uart";
 			reg = <0x0 0x10000000 0x0 0x10000>;
 			clocks = <&syscrg JH7110_SYSCLK_UART0_CORE>,
 				 <&syscrg JH7110_SYSCLK_UART0_APB>;
 			clock-names = "baudclk", "apb_pclk";
-			resets = <&syscrg JH7110_SYSRST_UART0_APB>;
+			resets = <&syscrg JH7110_SYSRST_UART0_APB>,
+				 <&syscrg JH7110_SYSRST_UART0_CORE>;
 			interrupts = <32>;
 			reg-io-width = <4>;
 			reg-shift = <2>;
@@ -400,12 +401,13 @@ uart0: serial@10000000 {
 		};
 
 		uart1: serial@10010000 {
-			compatible = "snps,dw-apb-uart";
+			compatible = "starfive,jh7110-uart", "snps,dw-apb-uart";
 			reg = <0x0 0x10010000 0x0 0x10000>;
 			clocks = <&syscrg JH7110_SYSCLK_UART1_CORE>,
 				 <&syscrg JH7110_SYSCLK_UART1_APB>;
 			clock-names = "baudclk", "apb_pclk";
-			resets = <&syscrg JH7110_SYSRST_UART1_APB>;
+			resets = <&syscrg JH7110_SYSRST_UART1_APB>,
+				 <&syscrg JH7110_SYSRST_UART1_CORE>;
 			interrupts = <33>;
 			reg-io-width = <4>;
 			reg-shift = <2>;
@@ -413,12 +415,13 @@ uart1: serial@10010000 {
 		};
 
 		uart2: serial@10020000 {
-			compatible = "snps,dw-apb-uart";
+			compatible = "starfive,jh7110-uart", "snps,dw-apb-uart";
 			reg = <0x0 0x10020000 0x0 0x10000>;
 			clocks = <&syscrg JH7110_SYSCLK_UART2_CORE>,
 				 <&syscrg JH7110_SYSCLK_UART2_APB>;
 			clock-names = "baudclk", "apb_pclk";
-			resets = <&syscrg JH7110_SYSRST_UART2_APB>;
+			resets = <&syscrg JH7110_SYSRST_UART2_APB>,
+				 <&syscrg JH7110_SYSRST_UART2_CORE>;
 			interrupts = <34>;
 			reg-io-width = <4>;
 			reg-shift = <2>;
@@ -642,12 +645,13 @@ stg_syscon: syscon@10240000 {
 		};
 
 		uart3: serial@12000000 {
-			compatible = "snps,dw-apb-uart";
+			compatible = "starfive,jh7110-uart", "snps,dw-apb-uart";
 			reg = <0x0 0x12000000 0x0 0x10000>;
 			clocks = <&syscrg JH7110_SYSCLK_UART3_CORE>,
 				 <&syscrg JH7110_SYSCLK_UART3_APB>;
 			clock-names = "baudclk", "apb_pclk";
-			resets = <&syscrg JH7110_SYSRST_UART3_APB>;
+			resets = <&syscrg JH7110_SYSRST_UART3_APB>,
+				 <&syscrg JH7110_SYSRST_UART3_CORE>;
 			interrupts = <45>;
 			reg-io-width = <4>;
 			reg-shift = <2>;
@@ -655,12 +659,13 @@ uart3: serial@12000000 {
 		};
 
 		uart4: serial@12010000 {
-			compatible = "snps,dw-apb-uart";
+			compatible = "starfive,jh7110-uart", "snps,dw-apb-uart";
 			reg = <0x0 0x12010000 0x0 0x10000>;
 			clocks = <&syscrg JH7110_SYSCLK_UART4_CORE>,
 				 <&syscrg JH7110_SYSCLK_UART4_APB>;
 			clock-names = "baudclk", "apb_pclk";
-			resets = <&syscrg JH7110_SYSRST_UART4_APB>;
+			resets = <&syscrg JH7110_SYSRST_UART4_APB>,
+				 <&syscrg JH7110_SYSRST_UART4_CORE>;
 			interrupts = <46>;
 			reg-io-width = <4>;
 			reg-shift = <2>;
@@ -668,12 +673,13 @@ uart4: serial@12010000 {
 		};
 
 		uart5: serial@12020000 {
-			compatible = "snps,dw-apb-uart";
+			compatible = "starfive,jh7110-uart", "snps,dw-apb-uart";
 			reg = <0x0 0x12020000 0x0 0x10000>;
 			clocks = <&syscrg JH7110_SYSCLK_UART5_CORE>,
 				 <&syscrg JH7110_SYSCLK_UART5_APB>;
 			clock-names = "baudclk", "apb_pclk";
-			resets = <&syscrg JH7110_SYSRST_UART5_APB>;
+			resets = <&syscrg JH7110_SYSRST_UART5_APB>,
+				 <&syscrg JH7110_SYSRST_UART5_CORE>;
 			interrupts = <47>;
 			reg-io-width = <4>;
 			reg-shift = <2>;
-- 
2.43.2

