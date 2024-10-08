Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2068.outbound.protection.outlook.com [40.107.22.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D739D184551
	for <linux-serial@vger.kernel.org>; Tue,  8 Oct 2024 09:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728380647; cv=fail; b=PkfFp9y6N6lKM0SbDh9UitTszdKppFDYeuDisEtfGet+gOpwbi9zaW8y+7qWHb7E50DXEDOrP1kdXXiqz08pO2il2WEI7y9bXKWakdfWyfU1oCECm2/w+qUs9IlQ+rBBfUxhVtoejvmuQBOTNzN/n0zVmdVZaPMvAciR0d+Ner4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728380647; c=relaxed/simple;
	bh=leaYLAajTqFAFm+OZEHzcat7m0XOBBlbaLa0K3ivsyk=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=mUlbfI5fm8w/TC3wLFkGBVX2OJwIzPnimFiQNJ0depi20ULAd9siOPhyHXCifmphQ1dutp1NbO3vhFzKqPkcsYASlxvinE/2UeCFYDEZpbZbZLL5kQ61nTaLjHKcooTaFhmtnJN4mjfv0VkgUBAwr2J5bll39G1sMRxPq5PKWSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=H5FGPfqN; arc=fail smtp.client-ip=40.107.22.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="H5FGPfqN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V0ryCtv8Sda/xKjktqVDjH8kYO2t8+7jRxwDq6BMtb6b/3sDvB964JUOpEdpxCAjjciSKR+pP8Ua7FKKgzCtx4z9Ckq+FfhPYOgvhpyndZYvOic9YoqEGVAC7qjkotvEYVn/Mi2LfFDG2z8h0/g9Vlout8YCwlGzyNRsdzJymhVDUgkl0u95E0n82Zd7OpPkr3v14V3qbBmmeA6BUJca98b/Hg7Mk2aC6WhKEKpBBk3CaKkwNUSFRPiTwoRtc47EZi5md4dLXn7O7rMFugvxL1B8gQBrXvBXPCA2p9OVTblVFAoZ38InzOXE6/NVtJTiEUEW8ZHwkTaMtWQmRsPANw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/+NyCJxq3QDUunNOjbVEakM5P0GqUcEeHOskL9jnMDw=;
 b=s4yTsDUDOTAHvIosx0Q8jyGkJyzammBYPKQY1aUrllHTAbdT/49rs4rOkwkmO/00h8DmwAkGuPdn6v0T0UtRQMTKc1y3ZSVoL/ZJfV3o8avwNqNeXcbrvFrMUwCj0DtMbQ+rv52xoJtggZAyOS3xFhvI8P/C2APdvQrkhPb8wFcETPRnq+KKemK4xM72Yij13eSiA3X85eS53vHLOseIvWcC/HYo2u6c7e7y/lw6MTpUxCk8yAh4XE1scpFrTVtpjm6J9MeafpNEevRTg1kMUD8I9bdDLKy6ZWrt7QY698PCp6QpDAJAMgkb0Eiqnk+H7G9ycPAKikwSX7aSTFtRcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/+NyCJxq3QDUunNOjbVEakM5P0GqUcEeHOskL9jnMDw=;
 b=H5FGPfqNrfPId5W0m9mriBDBd7w4moVkGhHpUXk/vvby/zw1B/ub1yfluFdlfnsgpkjEily2CU9n4RVXZOqCvwBRgpdhlw9McO6Y4C8GL+fUACiiZfKT+waXr4G8dosCj3f5f2fx6P2lan8ByVCYaX5TlcRBXaxKkpJx9ib2By5x/ibdGvYtRJxQ7Fiq39V7n5McLVNGBU3HvxoaAhMZ98tkIfX3HZcgJoZepovmOyD1UhkK+1En/69Sg6AHpQcI24E92t1iW3NcizaA0gNMk39XcAyO58IbZnD4EDZApoUYPE4eJk7x5lWEPbiZq17VWL8a8K3d+K8XG/sg8DYEYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com (2603:10a6:10:2d6::21)
 by PA1PR04MB10443.eurprd04.prod.outlook.com (2603:10a6:102:450::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Tue, 8 Oct
 2024 09:44:03 +0000
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::4db:3dc0:c292:493a]) by DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::4db:3dc0:c292:493a%5]) with mapi id 15.20.8026.020; Tue, 8 Oct 2024
 09:44:02 +0000
From: ziniu.wang_1@nxp.com
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: peng.fan@nxp.com,
	sherry.sun@nxp.com,
	linux-serial@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH] tty: serial: fsl_lpuart: add 7-bits format support on imx7ulp/imx8ulp/imx8qxp
Date: Tue,  8 Oct 2024 17:44:18 +0800
Message-Id: <20241008094418.439706-1-ziniu.wang_1@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGBP274CA0023.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::35)
 To DU2PR04MB8567.eurprd04.prod.outlook.com (2603:10a6:10:2d6::21)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8567:EE_|PA1PR04MB10443:EE_
X-MS-Office365-Filtering-Correlation-Id: c7831c7c-7d91-4048-5536-08dce77dbe18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rEQx3Tr2NXGkPzCbMV904G1BfDJ4UwA1PGZVwTRHBBwKMZCCpJgrQZLj07iv?=
 =?us-ascii?Q?4bUmDjD+2zQ3xwgyruhJfxnQnuN8aZpk/Y+6rwCsjOd3+c1ABJ6kgLZLKh0H?=
 =?us-ascii?Q?5ZVXJdHZmo2lRx/9XWUhOLqHfnG94fAyvdOEnpHUtVQ8aLYCsdis7uh6I1fT?=
 =?us-ascii?Q?DNDSvmPo0AEiJsuj76VBA0jTP4/hAzClUE8BgU+l6KXRJd2LonFAHdFH0uoa?=
 =?us-ascii?Q?L2Fr2RxQWqS3wD5Q8EjFLZ7PLTmgJM/l4NZL64lVFES3pH7hCF4ZL25Noc87?=
 =?us-ascii?Q?KGOQ/6iWBphdQj2oH/yb8f39q8W5KqP5NyteHQ9z4pfbQjK4hTx0Us+34jdQ?=
 =?us-ascii?Q?MzO1r+DQPJPlGehSZRH1HOF9XI7iFLxVPATx4MZ62JGh+Q3/bMRIObZc4wCz?=
 =?us-ascii?Q?v9pE6ucjp88ToP5uadRs67UAXJQGXW5fFg1x4ZZYqEmwhrVsR7vaoqM6kQYT?=
 =?us-ascii?Q?dYYAg9j0V62jwdB2ejRqhs9i0KhOwom+VY/DSIyZlncMpbbaWB4TC7CbhbOz?=
 =?us-ascii?Q?hW967V/LmM4+sOHR9RY13hnNM/8MnUlTeIKbEjTrmIeYOIuBe4gj5BrBYU6A?=
 =?us-ascii?Q?Jmjns+FwO66ZDZ3kU2QpwNgxd/nVcnrfYpntxYrdzDtMAir8jYWfuM+nzkxp?=
 =?us-ascii?Q?lb4qVr9KqoGC2+7Hjox1gJU5t8l0sY6XvFa825Ro66tiV8kp57WEMUBiZR2A?=
 =?us-ascii?Q?FbO5GWYcNtipFf0NCFfoj/ON9ruKjzX55jLf7h+sZ78E3NjzTOtlEHd1+Jls?=
 =?us-ascii?Q?9bqwGjMhbtBgx4JkarXwI+cSROZIzalPPRhgqoL114eVvI6LOp9WlIKq34OM?=
 =?us-ascii?Q?/lSd1jFeP3bQKKQ8g2NrO+r+jcLNWeWbraIUWM2LAJlm5dpA3EpkmwoYfRUU?=
 =?us-ascii?Q?gUlVlKWz2sLzh/0kUq4oD4I2dFTO+9jPQ6IorGRY5fo2/L1RPz9FIyPt37AM?=
 =?us-ascii?Q?9J6gXy+T+XNoOMHM6jgYbnL4s1AuMRxhaRl2BqrxT9M9VID4TvV4UXWNy8MC?=
 =?us-ascii?Q?6YB6opbXpTFOhL6/ggCymkcjqHfBW0d6rKfoORDAq1SghKR7cdRu1ZhePlCb?=
 =?us-ascii?Q?0tHG6VwUtTL4akykDBttmu8xsZ7aq3StGpat0Q61+u0pxI67gCEFBOrg8A3p?=
 =?us-ascii?Q?96Eg6s383cXqM+AMrtzcVi/bV7uSDs6fGMdv/aiPKxZWWjG00HBaGvFpwsKu?=
 =?us-ascii?Q?yhj0RhVkfXCulTZw7u0kpa2zCCIukd9nKgFEpH0mK6s4wkfF/0XWUuGBDG22?=
 =?us-ascii?Q?NENt9PbDPAsvQ64tjbZ9Mp0FO0BqqROHDBvDhTvkQJk1oG3VPsSlHB5YUO4r?=
 =?us-ascii?Q?OjrrgnrXyl8ubAj+MpZmBvTAOuQsPB7zQVTK/40IezXrOA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8567.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HhpT1co+NMoZweMF1VsTJwX2luU/dJc7NzDpUtOCBC8LPK5qGXyXttq2ejms?=
 =?us-ascii?Q?310nSdvrp1p4JaRsSemUXwgDnu/6Dx7/p0WtTky8rr8cHuJHShcoxoycL1rN?=
 =?us-ascii?Q?PDb8iWNFhvXnduHpqx+zx092L9h1XZzK1gAYh4DCwfSQXwh6nC+wwF/lv3UV?=
 =?us-ascii?Q?zJtHDyc9P5FGMHOHeZcGVI58lBrNxiEi9c6JmUheOYqC66Jh+ig4je05jC9a?=
 =?us-ascii?Q?Naqf6TwlvMP/bYH6gPynNLhTItM+Yn2pOkpX3R4gmSXF88wIR9k+srFN0SVC?=
 =?us-ascii?Q?O6Y1TVD1GWmd1sCKM92GZmvr7Kce6JAFJXQX+IQFIFNq3WY7Uzl6vCAyN/M1?=
 =?us-ascii?Q?crirabapYr9Afg1AnsfLIx8NWNM9mUMkyZeSpJQbYPhO2O+FtprvuFYchYz2?=
 =?us-ascii?Q?TezXQwaJPsapxXjzCBsu6gwhZ9PhimdRqAMUArUvWZ30XfrOe9YTpcEpoFlj?=
 =?us-ascii?Q?ejNAUTSZVvDUEkEqVLzU9yT9MLQ6b32z+rJPIM8USjKMS2IjWePoNdqoXzTk?=
 =?us-ascii?Q?feLdGhSQvxAFGkVZgnaqj71bO6EqEtkDlOhhCjh8I1/4Y3jKyQCYkMad9I3q?=
 =?us-ascii?Q?zO1uZC96j4FFNrW/YQW9khFZhYJwFM8CcCzs0Q/YzqPNbdUjNear+Hjo0e98?=
 =?us-ascii?Q?YYo60x7k/VscgVimxhDsZr8Oolm9/54S1B7KDpTgEs5c+yM5/Nt//K9zRT3t?=
 =?us-ascii?Q?f/YVf+A/rx9YTO87/6YTBoupRlHzqe/xf/ZOeRHlRZrIdi2b8ueTc8r6wpu3?=
 =?us-ascii?Q?49adImqp0qwr0djBt43vg5p4klGpbvf7KpgESd/JxdGL6zO3YxzMseR2tYS8?=
 =?us-ascii?Q?KTJl/nxm+I5LXL2VtFflUOSNZbDl0fHNYqL4NRSbJbacCtla2gwrLj2EEsqb?=
 =?us-ascii?Q?OGSeuQT70rA18bYjSy4AxWlChdVSn4wQ/5iEXei5nh8WWKEjPUAKDWkk8RcG?=
 =?us-ascii?Q?RkDu6Nn4jKDw0NgMcqcXFj1aeWp3lmFYs68Y2Gh3rBKIl+BQemBiAy5kJJFB?=
 =?us-ascii?Q?6r9obrFZZ9tI2/yrA6K5VY0qMucJ+z0nTFXcBteBkjz9ST9m5J063/M8amq1?=
 =?us-ascii?Q?nSnPLXT3igDFP2U2+tEnkiDyT+ZwPC04MmYtRO0QGtY/Fpa+/T/4f5X5FJLO?=
 =?us-ascii?Q?/r8n57Y+Mhz5Cg1k734kjPzkB9ss5yofXrcEY3nadTn0jUU9el7KWHcJzR2G?=
 =?us-ascii?Q?oo67I4Oy/FjrsY/bohsqQ0REQoZh/tveN/BlBygKSSLM0ksnTtczqoktl/ek?=
 =?us-ascii?Q?KXLaAvx9ZTkVR3oBgR40sG/pHpkmHMcwuUctUOKPvNnEqn/4FUz5vcYCcdbz?=
 =?us-ascii?Q?xUYxaxrwayirszri+ZdAWFoxCSN2cl9RfzVFCJYkv79dv+PoFU2jmMAsuzCp?=
 =?us-ascii?Q?+Ka2PwLDCLZn3+/j27bIHYgU8sAJDr6xk3ofIOyCL0oKX1RRaaWbflPtd50x?=
 =?us-ascii?Q?ZHTQ71vw+lRnKVqw/NX9zGcMZrRi8C1kajy3qg3RkpyT3rbnRZkLNwiSZTz9?=
 =?us-ascii?Q?3DGQPlXmm6X3AieZuCuEKWuZWYo4UTG5gVxBY63qi1Dt660wQ0goTgVZ7HJJ?=
 =?us-ascii?Q?ArVBuV9nb0eagLUbOJORnTCyaJYvmeeExmjzCj/8?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7831c7c-7d91-4048-5536-08dce77dbe18
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8567.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 09:44:02.7963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A0tZTEnQvCbZUW5+zBZsPkQfYomjreE8XJ8qLMFmGoHv2//fpREKEmqI+uWiQCc1gildlVIHYFGw1IJ+a6ckVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10443

From: Luke Wang <ziniu.wang_1@nxp.com>

imx7ulp/imx8ulp/imx8qxp lpuart IP support 7-bits format and have no
limitation on parity when CS7. Remove this limitation and add 7-bits
format support on imx7ulp/imx8ulp/imx8qxp.

Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
---
 drivers/tty/serial/fsl_lpuart.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 77efa7ee6eda..832d4285b19f 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -184,6 +184,7 @@
 #define UARTCTRL_SBK		0x00010000
 #define UARTCTRL_MA1IE		0x00008000
 #define UARTCTRL_MA2IE		0x00004000
+#define UARTCTRL_M7		0x00000800
 #define UARTCTRL_IDLECFG	GENMASK(10, 8)
 #define UARTCTRL_LOOPS		0x00000080
 #define UARTCTRL_DOZEEN		0x00000040
@@ -2222,8 +2223,9 @@ lpuart32_set_termios(struct uart_port *port, struct ktermios *termios,
 	modem = lpuart32_read(&sport->port, UARTMODIR);
 	sport->is_cs7 = false;
 	/*
-	 * only support CS8 and CS7, and for CS7 must enable PE.
+	 * only support CS8 and CS7
 	 * supported mode:
+	 *  - (7,n,1) (imx only)
 	 *  - (7,e/o,1)
 	 *  - (8,n,1)
 	 *  - (8,m/s,1)
@@ -2238,7 +2240,7 @@ lpuart32_set_termios(struct uart_port *port, struct ktermios *termios,
 
 	if ((termios->c_cflag & CSIZE) == CS8 ||
 		(termios->c_cflag & CSIZE) == CS7)
-		ctrl = old_ctrl & ~UARTCTRL_M;
+		ctrl = old_ctrl & ~(UARTCTRL_M | UARTCTRL_M7);
 
 	if (termios->c_cflag & CMSPAR) {
 		if ((termios->c_cflag & CSIZE) != CS8) {
@@ -2265,9 +2267,18 @@ lpuart32_set_termios(struct uart_port *port, struct ktermios *termios,
 	else
 		bd &= ~UARTBAUD_SBNS;
 
-	/* parity must be enabled when CS7 to match 8-bits format */
-	if ((termios->c_cflag & CSIZE) == CS7)
-		termios->c_cflag |= PARENB;
+	/*
+	 * imx support 7-bits format, no limitation on parity when CS7
+	 * for layerscape, parity must be enabled when CS7 to match 8-bits format
+	 */
+	if ((termios->c_cflag & CSIZE) == CS7 && !(termios->c_cflag & PARENB)) {
+		if (is_imx7ulp_lpuart(sport) ||
+		    is_imx8ulp_lpuart(sport) ||
+		    is_imx8qxp_lpuart(sport))
+			ctrl |= UARTCTRL_M7;
+		else
+			termios->c_cflag |= PARENB;
+	}
 
 	if ((termios->c_cflag & PARENB)) {
 		if (termios->c_cflag & CMSPAR) {
-- 
2.34.1

