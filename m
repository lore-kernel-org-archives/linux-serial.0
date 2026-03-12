Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011015.outbound.protection.outlook.com [40.107.130.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8AE531F99A;
	Thu, 12 Mar 2026 09:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773308648; cv=fail; b=nihSSy7MCHkU7mZlKaDiwn6svZgR8cDRyFuGfljlIvDjmp0BNPbCjNiEqj1ZkKejYTdsFfKyWmgROMcRnbI8DGKrUGZRapHNfXQP6Vulj0abKF3Am9i0WYAubGaldcLbnarYp2JOL+Dza06eD0nNyFH7XzcMmMO69gArdeZAyXU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773308648; c=relaxed/simple;
	bh=CY1evUv9Hzpqa6YgAG39O3A90KZfaalv6pvEmsCKtQQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=chZ+FoB2rtwTSpBTInP/cojasg0Uf1ydlUaWLL8jGoUfxao7vI4RvKbV4g+iMijz8YdxBD2qNt7+4DAApRJL8B5V/VVQSYETpvUAJdTU5kRQoXsZMZCUJeCiHku8NrG/YXxfW4TsqJcs1CQBElXt+khhjO/rC33BBjHQJ9CSEz4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RD/D2INr; arc=fail smtp.client-ip=40.107.130.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RD/D2INr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ePoShjHvzRs17iXETHU9kn0l1AHs7iNyFVSD3xhlEh7QTF0GNsPgWwH2Pnatdq0gtU9J3Gt+j98WRhLDejJvpm1yGWk1DRwpqbs8tR9vaxJGhmlOts7F5jS5YOIdtfDTQ5ygWZ5Nv1CWS2OzJfJApmm4GtlLT0FVcVS+C1TSctvtyuoSsMFdLY2oeu2fTwF9ALCGb7sJX5PnaWJWaKSy1Jlu+8S23Dx2dkUavVjH+r74vCQ2aifYjVtkuBH1MZ7JjLSsr60b7BM9HNCrgfYFbFV92RUaqswETHXThFdWMe+joKHfBRCAPega5IsRrCifo3IbOxOqSd65i+xIXeKwmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b3md465vdF/NM6Hcav66l6d4+u4+XCQH1ODs7r8HWqg=;
 b=iErHWqkJ+XXhqSQ3CjDQ7rneNQuYvevVWmGsFoXZANddlPY3Q/Qn/q3meRP4xqRYQ7HZ6igvMaCPDRiMguDVo/1Q7p4DFVrI0eSrOMtSmlZN3wsSdUXW5YQN7Ed43iHz4deiWYBpXKUuBPZj1rT691qqUtRA1SWt+kHpAEwNqxu885JML2XIrK1KHcuLHtdd2SJ0qo4LbIg/j7+rQeRJ6ASgRKxLLIQPsK3TcbgVZywv+9xwGhyfycGUQRkzdM20k9dAc27Yw1LW2dDcIG4siCkvyLhHTm69xfS3tSJmhWS2cwMGnbZMiG7/3QqgvFnLBNXHbfpIY/2+F6wQiT+w2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b3md465vdF/NM6Hcav66l6d4+u4+XCQH1ODs7r8HWqg=;
 b=RD/D2INrBTTGayrh28mfyQMgmdNnnZCTnKwGQVDw/+SqIWQehMGpn3CdtgRUnlhaK2dijo9x8ArorSK9xIPoXB7tXrq5TeEPYbsX2Yi1Mt7USfNApGmRfZ7IEnRCWrVqfkWWigOHjWTpge15sotyiioHtl/5AplMJey/JNaqc/gQl+rn/MQIknLKSNuKYZSboVW9R9T4iWuL5ovSsXtCHJ8eFtpyOi+txucObtwq2lRGtRvs1Qkvi/z3z8QgrcXbOo5W3BNaCa6SYCdgTsynGuLCJDaebpjINwA8veTdWkIilX7aH4jLYasm3SDHbqNoJKlyFhediDVwDZ86S4p++A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by GV1PR04MB10653.eurprd04.prod.outlook.com
 (2603:10a6:150:201::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Thu, 12 Mar
 2026 09:43:57 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::feda:fd0e:147f:f994%5]) with mapi id 15.20.9700.010; Thu, 12 Mar 2026
 09:44:02 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	Frank.Li@nxp.com,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	tglx@kernel.org,
	mingo@kernel.org
Cc: imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] tty: serial: imx: keep dma request disabled before dma transfer setup
Date: Thu, 12 Mar 2026 17:45:26 +0800
Message-Id: <20260312094526.297348-1-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0083.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d8::15) To VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|GV1PR04MB10653:EE_
X-MS-Office365-Filtering-Correlation-Id: ed05e90b-fbcf-46d3-e427-08de801be4b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|19092799006|7416014|376014|38350700014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	AFroCi1g6yykCAo4agfl6Qz/0ZtzAC3ZWBQpqntmke0Mc6C0PSnI/SFyYpWj52MAiZE/2A429Uvzv6+pSnyArW/bmtKDiAhRojhPulwKZvyLum1z2uC3tlpBS+lwq2GzIAY845Ai8EnsBaZfCB+tBSelag9B0qFwMT3Uzl7aGeJbBDahE0CHnSamqK4aUKRQX9oztqVaZ1zgAbHh47qsrnj8DAhtK55/6BSL6+qgLWzlR882k0+eub2Dun6WveYzaHamrS6v1+CRCbSsMkJVfO3DB9O+ODSAhL9E4oSctliQlgSI+hy0Cw29hCzOZPzZ5KitJodRYNsm91aYllV1/MxZsIn/lMk+cAx0PHjIs7KOiIMhSFArNCzqHSAsVWw3tF8ihrCT6FLd5FsDTDiloJAPeP5djXu8QMUeD0l9rxggC5meZJ2HhnqCQiEJ36T9GWvQydhSVfbSMa50yUoGfhFyqv/8s74FjOmrTPRWAumsEDUcSgl4/TzhU6kklKbGfODOABa/t3UOf/bKWgAN+tJYroeR/bJxr0/C0CGdAVwdlCxO5OPcsN6KLf0aEibkItLlc4k66uiBa+nu3IIzPc7ZfovZi5D1htfbEHUSLz6hof70NQP6XUR9T2pyx1jCIoIEx6U1B0k8GfJx+lBOO/lfVgDXsxk1JojTM4nm4INZI1V+lKdAGyqT+xEwbLt8DhHFe1C3EvA3TRL1DP938iI/ecup4Qd4p9hLDayabjqNNBbM4IkCxUn+WZ5hU5gGH8qo+oH+9Rhv0C7Nv5apX8ViHyQpxWNuXiaEGfoe28U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(19092799006)(7416014)(376014)(38350700014)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0Nw+QNxPPiM+Ik9QN7+qXa46UVKGV2jvXvVFn7lC/uAbvtQIoKVvmHqpqJop?=
 =?us-ascii?Q?p4mf5AnMbLuhTomoddu5BntMb/P+j12l5KM3PkzSe2Gc5FuGJ9+6UKQ+mosz?=
 =?us-ascii?Q?SpF+MbQcSLduUwl0RWuWX4isRkm6iObBJqN2YLt1IkUA0jey3GANhQJo9Q9e?=
 =?us-ascii?Q?484+GYCIh8qMEqHnGC8CYUd660CHZEE1/C4ObJh3fUmPRbIThxouOgpoSqvh?=
 =?us-ascii?Q?RKFa0yGZE9NfY3nq7aU/Bk2m/7A1PcmtboY9FiVcPmUh5TOQWvCiVcxD+xhl?=
 =?us-ascii?Q?yYVHejxTwQd8cYhObHlaZz/ETu/m2xEuF8PTtSfp/kXgr++/gmxAH+iJ3c7X?=
 =?us-ascii?Q?sG36z5A1hAiJx20XbiUerC+YrfpN/pjbmmILIcKVcZ7o1IW+JZrBH7eXyVV2?=
 =?us-ascii?Q?qiryZkuHhoK9wR8SfQpLSCDKiH5gHwvBmewmv/keZyquflTHmdTgbLWKV/i1?=
 =?us-ascii?Q?S0TtoPhLOi0M03zSP2kt0MGzeV64aN0FaWEzc5K0y8Q72OVCoHMUfwTfXtDo?=
 =?us-ascii?Q?Cl8lZ1ub/cfya6GKBel5NF10+2zjlHyw06e1JwGu7Lijp8dTswMHedMR0v+4?=
 =?us-ascii?Q?UZdvgonQ+fqMiBE3HU7orgzx5UU5Aqq8vgttYavIrrlkj91uTj8nz/AFlLZ5?=
 =?us-ascii?Q?1aCrluN+vT3jJU+4cbgJXFRhZyMUXaCbVxFN4Yp9XG4fPJbxta3OipFxfGKR?=
 =?us-ascii?Q?DZjzuHZrD3xnSeJln4Nc6GF0FltCzcUheTeLhlZukFPmfiNEYk6BQZglJT3E?=
 =?us-ascii?Q?g94+vKr+QtguNhpX0QdPIVmpnxApcSDdb8j/01rhVHEB/+ktmzM1w6+p5NFV?=
 =?us-ascii?Q?FP8tb0lQ2MjkXtSdrYeLDMIPYgDXBTP9PuPX1VeWRQWBgrlpCA56R7h2wYHy?=
 =?us-ascii?Q?wuwOejQVx4PHiDsfhkpgLOvCH642FS8gP6NiAO81Wl7rp+OAn2UTF4kw1JqK?=
 =?us-ascii?Q?dwKfAHTTepE4BdlbiQOUhIYI1F9CP11E/ws7vdoFlZoivXQNfIl09o5YQEMB?=
 =?us-ascii?Q?LB6U+qX4g4VVutU7/TBAHFM8cy826d49kXQxV9Vl5u1ZM1QHT7fvSOUbBYeH?=
 =?us-ascii?Q?cw64d8in+4OOtL0y0yLQpJoUFSnjaQZR7z95x1ajjUIy/MX2/BhfN0SaE+35?=
 =?us-ascii?Q?JaIi7NwONqnw21Xoys02D7RT0RTBTiZYnj8uAYBbQ6hvuojgiL08qUTS27U0?=
 =?us-ascii?Q?cjqXTviIGAsrSnY+DwVW5syf/mlQVAf+wQnmBPrPFZeYHCjsuI/YKcqWOdpG?=
 =?us-ascii?Q?vhv8zzCwAaR0musXEfHYPUEHyDRgj8tpLx7r7GpRoNvEoIWK1MU88BPmV+5/?=
 =?us-ascii?Q?6nntIdwRAWlicRqFqIzQ8v/DJL/wmV/VY7QCEfFvchKZd3D6Yy2hfPy4n64a?=
 =?us-ascii?Q?nyBVWCkk6BLtGe9jmSF73GTyQ3qJlV1Y6ziqmBf3MxAUvf5Y8MV0pCZFr6ta?=
 =?us-ascii?Q?up+tPyNauIAAlTXZvUYl19S61TFwQL55pb5EzcsODTf1MXVmhn/+vCCLe/z+?=
 =?us-ascii?Q?5NoSjAHRwIDLXvbuhRfgkKfal9UHsu9dk8rCUeSzM3QgXzKoQR/IkDs2qhe9?=
 =?us-ascii?Q?53NRlqB3OUnmclUsigWWjhOrcWTcnA/K/+mEpT/bIoOLpYIK57UnvbMt4LJu?=
 =?us-ascii?Q?ce4avPXP8WkKpyCrYBCowEXIFzxp+ANF5hEOaX3/XoCRYMcaSJAF8c7Pc9rX?=
 =?us-ascii?Q?LkZ/eJJdYF7FyNo7ohkupQmXyGiXvjcPamNsv+lG31n+2d3UIFdrtubz1f6R?=
 =?us-ascii?Q?904VqNvDdA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed05e90b-fbcf-46d3-e427-08de801be4b1
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 09:44:02.3893
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HXY/L9ZOgxYelD6Q/eL0savH4orlsIAM9DYte6cpcPEBoeVnzuCS37xIgkdkJGM32FJko6aKACi2mzqKD7+ppw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10653

From: Robin Gong <yibin.gong@nxp.com>

Since sdma hardware configure postpone to transfer phase, have to
disable dma request before dma transfer setup because there is a
hardware limitation on sdma event enable(ENBLn) as below.

Refer SDMA 2.6.28 Channel Enable RAM (SDMAARMx_CHNENBLn) section:
"It is thus essential for the Arm platform to program them before any
DMA request is triggered to the SDMA, otherwise an unpredictable
combination of channels may be started."

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/tty/serial/imx.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index c488e5d372ff..251a50c8aa38 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1442,9 +1442,9 @@ static void imx_uart_enable_dma(struct imx_port *sport)
 
 	imx_uart_setup_ufcr(sport, TXTL_DMA, RXTL_DMA);
 
-	/* set UCR1 */
+	/* set UCR1 except TXDMAEN which would be enabled in imx_uart_dma_tx */
 	ucr1 = imx_uart_readl(sport, UCR1);
-	ucr1 |= UCR1_RXDMAEN | UCR1_TXDMAEN | UCR1_ATDMAEN;
+	ucr1 |= UCR1_RXDMAEN | UCR1_ATDMAEN;
 	imx_uart_writel(sport, ucr1, UCR1);
 
 	sport->dma_is_enabled = 1;
@@ -1567,8 +1567,9 @@ static int imx_uart_startup(struct uart_port *port)
 	imx_uart_enable_ms(&sport->port);
 
 	if (dma_is_inited) {
-		imx_uart_enable_dma(sport);
+		/* Note: enable dma request after transfer start! */
 		imx_uart_start_rx_dma(sport);
+		imx_uart_enable_dma(sport);
 	} else {
 		ucr1 = imx_uart_readl(sport, UCR1);
 		ucr1 |= UCR1_RRDYEN;
-- 
2.37.1

