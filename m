Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2100.outbound.protection.partner.outlook.cn [139.219.146.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A662A125AE;
	Fri, 17 May 2024 06:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715926726; cv=fail; b=Tx4Yyv2ajELtyeepLE9Kg+q21bzNUulcRX6qSL7IfbYEFmdaQfX/CUXEaY8uzIQvV5JGIB91ryownIAi7438jxkNLNxsLgmNLRqTn7JIQeLYH/R9OnrCTPsRZYowtyvMV7sEEVCAybByQZ5bGzF/LV4QWUysl7JFbVQHMQYaC2U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715926726; c=relaxed/simple;
	bh=nVLlZzeC0Us5FkY+nUPc4t+BRTtI++PuZaC+XgC7SB8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pYLNlJ6Yhlw6A3hZJPEY/Xq2IPsO5DPsb0uyzwCUzIiaVeXab8gqodvltJGhKbbTm5NKgz23jajbTVzyqJvnY4nrBnb/bjvziI07l3ZludanHCoRS8gMsKFJZNNcP9q49U5Ofce2J/R5BYooJUW1ZgH20sRlx+ah7qVyIhzNttY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Omk2gL9YSbHYX10YsFCgR2wkYDHGJ1Jm6CGzp04XYP3tRZSu124+oPbNFmplZC6Z4WqSeEYWG95CVMbNW4Zr50FRbZHEzyGCv7mOtlTD+Gu4VHvVJJD9+IG5IB3wEQU3mLFHUKdvibeZahNf2EqdXTfZMqVC9qQnDvC5k2ZZ1d9xTKxjonKhoE2GyK41hdehdAfpkuHtd5ZeDBKCuzn5T1MfLqwdizurP2rb437YDkKV89fnVDRrE7Ofo7O819Pq2av/M5G6NL8m2mde4UClE6w21trCEw04T09/UkCkeC3OQVSq5F1EhbJtJyCA93NjF7VF5reOfELrXyhh1RsGtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IE4zIxAhMRPh9qWj9lE/eBl6HO2y+aTeVuj1F4gxdxQ=;
 b=XOCsxzoCh6u+u1hiCIrVzVuOkY3HLLShTyxR36g5f7FdQoDT+WVPe2SloHXEIWJq8klLxnYRr+6EUCjPUxKavnKY6np+PJfB9Oya/9gVJMpCHsewX4w7wTgaMRQCAfbIM4eKEJEhQUxW0Ui9fssa2l5A0yAajj8DqJ5H7q+Rk+nW3U+ersWPn1Z2Cv6yqcFMoi8QWVX/kJlKpLj7dBYLAju8T3Y9VBCz8m0tapr6rD+f7lJTPaxQpHnH6zrB0kwJil3g7THxv6tYfab0O9gCbbZwIOL5h/ycrx/oQbc+7ooFxtF9C6qPSiurGoUPO9CC+KCa8q18+EK/Ej6BfZo92w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1164.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:12::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Fri, 17 May
 2024 06:17:24 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::5de:15b9:3114:4f45]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::5de:15b9:3114:4f45%5]) with mapi id 15.20.7472.044; Fri, 17 May 2024
 06:17:24 +0000
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
Subject: [PATCH v1 3/3] riscv: dts: starfive: jh7110: Add the core reset and jh7110 compatible for uarts
Date: Fri, 17 May 2024 14:17:13 +0800
Message-ID: <20240517061713.95803-4-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240517061713.95803-1-hal.feng@starfivetech.com>
References: <20240517061713.95803-1-hal.feng@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SH0PR01CA0012.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:5::24) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1164:EE_
X-MS-Office365-Filtering-Correlation-Id: fde5e8fc-bfec-485e-4ac4-08dc763904ab
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WMY847P/GwP1fHRINUFrMDoBR6ljjcfGnVnYI8s3ORUgpv2CbwjSbs95eCCYR03i6bl4ozXQ/nlGSbQsjl1jOlDnA4ZLjQsdzPH8bKTJAfES4nVRUL3JzqBEknzLQNr+db9bemf8doazSq9pPXP0+ytyLGymBZNAh5PmnC0SIyLtjJwsyMcfAlWEO7WYhj8swn68cztaydCgIweod3d8tnJDZzyFtlO7gw3l3PEAjAhAHhaQwE3V24jrb14L2kvLqbUwVknIuqJ0O0ssv+xYsqXiWum16xxXgtUP4YT8uJB6zHuadpfT47MeA6UJgR41L0dSBOcap9omJRoip6Gcypj5/+FHf8TWTlqHeVkJo9evL05ZR/NoPqTlBsYkL7HYZ3RWcNhXBldNiAOHg0rxWb8ImMflmTD3tC2mcS6jCVRpWXX/xJOHimBf/lFB0FX9Ech2Y5GBg/uYPPsKS+i7W2Yp1McDDOh+6CSB0TbSaKPVqdWw9pn3d3xCWlvuSdIi+Pxpy+nWAvh3OWy2t7zq842ywynwjQITqogZ4dvOWiw7wwFcsP1ffC4EOHi5QY0r4htDI0RiC5tmOyR6Drk20YL/KzKbNrY+OaT6kqztMADGbsHGbFSwlyXfgVHMqdXb5E3nZyPt9GQFhsDjQSoXiA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(41320700004)(52116005)(7416005)(38350700005)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IaJ+p3XH640YzhI7qK28IjPHQZfTs8ZD827YY6U0AMAtauhFvpD0cOVmQg0X?=
 =?us-ascii?Q?u+UcYOtHixSS94P3xVVcC0Qdktxbc0JdLBMMGlLxf7IIUg0NoJtO6zx9XWN5?=
 =?us-ascii?Q?OZxmmQWSKCsl4FQGeMJF61aTyy9vQNzFZCLZ79B98KvesVQuZLJtayzewhxc?=
 =?us-ascii?Q?I+g8GuLiCsfXoTm/5QTbhT/tbI+4SODqXng9a389Ri4ftrErXro+vmIZ13C3?=
 =?us-ascii?Q?frhbGDiCCOvYKC1caYEdXZ32QAyGRCphpN63YH8WKoGAdHhLHwFZsMykx7fO?=
 =?us-ascii?Q?kruFSBCkkbgub15IeGT+e84R0FH+wZMgQYAhHC/GhZFqcRmIZHQEl2G6enn1?=
 =?us-ascii?Q?O9DnnT239iP0Bc6600bkzGjARBU3G2v9AJhkPDxbXiBfD4koSVIWrubz/efs?=
 =?us-ascii?Q?6m+c3fyhofUgBtklhjrlwzdNaAmm3pCPl2fAyEIq5j2oLjQVfMz3wmiKmmZO?=
 =?us-ascii?Q?LsZZ1xPp7V8C2lLRVLzdODbIqM1xUeM4K5WjpiDfFV2Pm8HN5QsaJVwxm2TP?=
 =?us-ascii?Q?gopgzvVDaW3PQtYmsEqktNYZGFUoox/OQvN6U1MCPPp+F1bFoSKZwdbgtNwy?=
 =?us-ascii?Q?zxBZdjBc5RwiuhznNGHTzudSIUTPNLLIhLrUZcqgD4s3ULKZDr2AZkUyyCom?=
 =?us-ascii?Q?wSY/RWcx5y4r64YTx7T7QHdUxdEOEkmGAOVrzQM+gRteHu/HxRkmRZEVCs0B?=
 =?us-ascii?Q?Iw6kVcLZl+5+2zGyaQnhMnkowSGwub0/LbyPvRK+IfAxLTVRFPmRrUyHYhFs?=
 =?us-ascii?Q?VhBsB6EAt/D1OkaiIg8iOSA+PWiUzi//AF2SKMyORYQJlUejVH53fBvw+ivj?=
 =?us-ascii?Q?uInV2aZrKVv5MHSkuCmSyxxCPck15sxHy3Pv3s+E5826y805FMXhLNpT8wJV?=
 =?us-ascii?Q?jXrSAvgkTy+OI4dKIEy+GbO21TAsY5I7TawbNSf/Pm7C73e7RnoXj/5SfS/4?=
 =?us-ascii?Q?GvnP2HDx3USotTHEgZyC5SYUNHjjuG0YaQw3L9KJHkSMvGv0X3twRBYA8LjR?=
 =?us-ascii?Q?rV0fMc8Z/uXLEinPcDYhZ5CCmZ7MFKhHFcd371Q+DGiuZ6m4P3WvzhXZVEC2?=
 =?us-ascii?Q?9xmtkmE3Hqz+inrosfab6LIOaonM4gYBGFyjEGBUIvMnI6uEQYEM9PtfmI8G?=
 =?us-ascii?Q?nz2TXqKpR8rEWXoxsiup1M07hmlIrAwiem+AEdPur24O5xRdHOJ9T9H4/Abq?=
 =?us-ascii?Q?683j52fKdHoRFpy10ir4drBKSCpb+H2cRUrWIJWyz3XYAdBmt4BLgXfy8VMK?=
 =?us-ascii?Q?5WiCgkD/iW49GP3FPP9Flc4LXg1AaBiwH/XqrJ5dCxEp8lkjnCJ90fu7Q+BJ?=
 =?us-ascii?Q?1rrGBxT15P1C0kv2RiJEVGDwHr3PKO85zz1eWz7grybnFe763G50/Mus43zf?=
 =?us-ascii?Q?DNv5gi5d5Uwwj958rSV5ficJqGvrqMYSz8SzlHb5+HwZpmx5unmTuR2CNfNZ?=
 =?us-ascii?Q?IUvuA9uVmL2FGePyKTaUFP6GaajpL26it3OwgLf5yBD0PiOrjz6LXNoZUwrb?=
 =?us-ascii?Q?yPcwLekmhESkvdKoXW/bD7ndqu3cGLPw+bVu01+0u8KdXkNxO6fykvYme/e/?=
 =?us-ascii?Q?Vw6kKrbFhCrQ2kEXYdHSNvPU8SIIU2moTS08x8q+l2V3gaTKQkPfIK6LGu3E?=
 =?us-ascii?Q?oA=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fde5e8fc-bfec-485e-4ac4-08dc763904ab
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2024 06:17:24.4392
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZdU+GRXhlw/fRG2nyinryx7R2G2TRexKTC2MlfgfQdbr0B48ZsHPXAoAgWMo8hK4XQctoX8UfF9LQ6V8VN5lhJL7wfaMaeYL9eMqxNWZMh8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1164

Add the core reset for uarts, which is necessary for uarts to work.

Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 arch/riscv/boot/dts/starfive/jh7110.dtsi | 30 ++++++++++++++----------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts/starfive/jh7110.dtsi
index 4a5708f7fcf7..872f52253a2e 100644
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

