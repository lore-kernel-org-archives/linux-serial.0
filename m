Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011061.outbound.protection.outlook.com [52.101.65.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA401991CA;
	Tue, 11 Mar 2025 03:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741664216; cv=fail; b=oc1nc4HHqHuhySFkbFTVONk9HCfNCUQJx7XS5nwxGS4C56KIH1NHu7lGWiFYq5Su+LlmsRJVsk0AnjU/0nryYWJ6MVDtpuACoPb6fFz9jENJiWgFEdMnLcnCuTJISjaiMc50/mzd6v9hkmIUQn1tul0PwSBPMS0tBKQ/ba+RcqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741664216; c=relaxed/simple;
	bh=JisxMN9Zb7FAFGcQ/4J6XLhq1SD6orPrO1vLrTMfXoU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MpjfCxRd4cv+56r/yYw447xD4OscU59EdsJ4+YvkBsDDnuj/QsgsL7Cxw0UpDmLEGmlApK6JkKhO4VnKULfjirU/YoFV0t+fIkpPeGENVTed86ZTrZF6TsniFweSJtnlSZ0/oS/akmkhp4KGchsD6QcNCRfJgtcnNaA7QO01ykY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=kXuaK7Mk; arc=fail smtp.client-ip=52.101.65.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="kXuaK7Mk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kKSe/4y3oWIrPW1HbHOd8jHbpok2WamolIl1qduto3KL/5IlZ1TCdnHSHrUt9vHeXvW9v2UJrvZ2aMZw6W4UOUE9LNS2AM/l7Q3i2VLRJqYKF7PaMbuip0CCOskzh6LwDc0OcMbEPEdZBYtzIQ5PbTrTERDO9gs37oqxAlSxNOGZZRiRXH2qXtsXk+BgFe3nUgeArxZixYSDrOAtbPUlYWGhKnibo+nxoWLh9zulWS7mIFdO9t+L/LAKBS83tpefyvrmVFVZGy+2aWmx1ljQvBokYhCyeOFiGCXicQEWrN7Me0MkBoJ7LMqYrKFTjLqJh8PdS2wt5wuTf4iYNMqnnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wiej7i9634pkPg0VRODoO2s31a/t9mAEBo65axHF9+Q=;
 b=FGv9T5kGFkQC32EvE38E3Xo7CpwChCmskFJNOjzxyLB01zkvmVDd4aVbF5PGw7GLgM6+Zm0ycNf4S4+YmgNGV0XYEXmzwSCj4R3xoGyIgfibzweFn2mp9+I/womuNjKZ94VLvJID9F+15N91J5BCvVOBztrPJI95IFxnGhPNu37kAQ7u7Ji4BqhSmlX6VR/tt6Bgnxj46oSW3n1ykBDIx0b6nYa7mXrbTALTTVR9WfmwjpBXab4Xk8wsKz+vOtmTeHZjECFdcHuhhFf7haojiVDd7cmYPbu977BCoMR5lEhW6g82Lsu4PrpybaIZHj/obXIQhaPsd/LuemMHFXutOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wiej7i9634pkPg0VRODoO2s31a/t9mAEBo65axHF9+Q=;
 b=kXuaK7MkVSZPtaKG4v8wsXzv+2KaDruRGK3Bw9llxjxrRdt7GEYB2ycgomfKIjyKl8yDppDC60jyUVFKLnyd1UeHoHKVsG4tOOpOuM7YBVpW8cplGQmUTVctOnG/iCLMRL4aAIH8E1kbtuq8EAHeqvdDn5rpqmfHL/jZSOWJEDEnqyRS77tL4fIQifT8QvfBXbd8Z36QeA3dVouF+rJlEW7ymSHXYj3XQyiSMJC6LfI0N2pRhDD3S6US+fkTGZcDxLSm1XsykxwJwHQofnmQdRgzQ2APafCOMgZhY3X6S8bw8DGS9arbz9K7EcL17TowTjwP0suvrDQWWgKe+3Z1NA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com (2603:10a6:10:242::19)
 by AS1PR04MB9480.eurprd04.prod.outlook.com (2603:10a6:20b:4d6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 03:36:51 +0000
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37]) by DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37%6]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 03:36:50 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	shenwei.wang@nxp.com
Subject: [PATCH V2 1/3] tty: serial: fsl_lpuart: Use u32 for register variables
Date: Tue, 11 Mar 2025 11:33:34 +0800
Message-Id: <20250311033336.1254842-2-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250311033336.1254842-1-sherry.sun@nxp.com>
References: <20250311033336.1254842-1-sherry.sun@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0019.apcprd02.prod.outlook.com
 (2603:1096:4:195::13) To DB9PR04MB8429.eurprd04.prod.outlook.com
 (2603:10a6:10:242::19)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8429:EE_|AS1PR04MB9480:EE_
X-MS-Office365-Filtering-Correlation-Id: f907207a-5d04-4a74-da62-08dd604df52c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ISjcwTwwYE6B9m18bKhZ2MVZlXuzm0obLpwExgCdykB4tFB972dGRVAcjuiE?=
 =?us-ascii?Q?nx/wd4ANOHJiwq0CPuo657P9XjTa0YfI70WH2EAbacC7s4mgKJ40qYpuXfhw?=
 =?us-ascii?Q?G3F/T865TvJJjRh8pVhOrQ/7Y/wWr/U/6dl+XalicsQExVBHwcNDI2J5ZjZd?=
 =?us-ascii?Q?DuAjz9l6Id5zWKXDlQSy/vr6xxtgMgX1sTVw5CkS1BjK/10kMUQ8r38IYbzl?=
 =?us-ascii?Q?9IOrbuGkbMFpnwgGCaiuopuRdLktaPqnYH62WBeah+gqUlEsH+AnOvhIwUk+?=
 =?us-ascii?Q?0bZRSnMPq0aCfW66CZ8+tBc9UvaLknNw8X9PmfKIzfQWaaSGAHOFVFWkT2ON?=
 =?us-ascii?Q?hjvgwstZq3W74ixonW7pd3FG9kcecgC8v2pR63wWc4ocw+c4sO3r7TEeFvkF?=
 =?us-ascii?Q?/hRxNqWIrfhxdvYKztb1j6KeWc1zimDSPC0N2O3tEgjecI/s+H70t8vf3gAd?=
 =?us-ascii?Q?zVTahk/Sk/K/TCGTKrA0mpUoQ7pNHKQw614rAu4C6SFXtFm1ytp9aTJGlYwJ?=
 =?us-ascii?Q?7V0dnurnfic26a7fb8M7M1Dp64+WyEVf/CkhI2jHYEKDlmy2Uahr/KFn2ZE0?=
 =?us-ascii?Q?tFtKRYfErQrKyYY+gYM1yZuEFGNq9b+BiIjJygkP74NMPq0ZxwL70ofZFPQr?=
 =?us-ascii?Q?odhO2VSCwa6BV+U3/6o3PArVR9veJB8cCs2bsEjThbcq+RdsGYCAyH/7ROd5?=
 =?us-ascii?Q?OFZ6QOpIydxyI5t3ALXGD0fMkIGz6pndiMidjY4epqs02HyTu9q6QRm/bxjk?=
 =?us-ascii?Q?fXxLPGcOxie64DteClqOoNPNVG9gR2eOGSGluokZL4D9AasN5O4J/ZVbEXiL?=
 =?us-ascii?Q?NvYp5yJv5lyRp2dOCOJGar4juIXroBgFC+Nl6TiQc2zn7f7QHgzY1Nmcmjr3?=
 =?us-ascii?Q?iT6jbXGjwmPhrkmj2X3iSE/77mN1WryOenhkV08E7SrW/CvIXeqo6J9EIL8Z?=
 =?us-ascii?Q?a43y72t1AiLTWnOCFrYxIALL3SIDvWBOucgsKA8uIUK5ni+gLpgaAqRnwhUx?=
 =?us-ascii?Q?PWoHLTTb3vDnNT/1IznEeLDipNWEtrthk+B5gmbSLm3fZygoO8yXod2V3MlL?=
 =?us-ascii?Q?UkDE+B+GUfOAHAi4djIS46qp2xtYQ86fGz7fy4p99WL/Qs+ToT6n7j7Q02IO?=
 =?us-ascii?Q?lNyDrJ87FpmB9bTXdkcwOM5u86c1Y4n2roNVMev0oiQ7EL949sShj6TgeenF?=
 =?us-ascii?Q?pF8jVHE/CV87gJ4iMBBkGr+3haDJb1Y1RQg0eaU3VctNk7JteecTptiaMY97?=
 =?us-ascii?Q?bRWaulMAsVqb7+d3yTji7YjzR2myncvjyQT2hgmV/i5mVDfAOpRfJnnQwaFm?=
 =?us-ascii?Q?jV/pPenNg/mKai2Ya3zV36KSG+arfqvKTn0cJq9VgBRLHnO+lRsR5DgOP1MY?=
 =?us-ascii?Q?t6Oo63HWW2cWapi2zSWTltHPKX+g/qPZtzpBB3j5yYfyQdEY6h/liA59MJ5x?=
 =?us-ascii?Q?JUFjzWFJyF1QlgBrr8565vZMN/mv/rOZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8429.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?A8IJdhUD4AKVp9YiarfkSGFBkTI+qmFMoRtM7AStrNCXONEwDT2X7mAeSKdt?=
 =?us-ascii?Q?xH+dNiaQzfhSrUq7YF+08UoxwAAgbyhIMzWCKG7bY66RnhbdTJjo8tYyg6iw?=
 =?us-ascii?Q?VY/DhJEHgC8RK0177wI4mL81rkeNuwiozpiBzFqOkNctoCtxSebd14PXcUkE?=
 =?us-ascii?Q?kC+Ga1lv+WBT9Otubb5+iBdMKfxRG/fFt3g4Q0SrRQ38W7C/2N4IrveTGoyn?=
 =?us-ascii?Q?9Hf0bn5YUJ3iNL7/Nb+pouu+g7DJQZwLahWeCuorrkmfV5qCGLwm9f1UURZq?=
 =?us-ascii?Q?UWUHWyJ12oP3zhhYgOIUsKQQcWk+Rs/oH6gxjf6l8JAVlsiHNa78Cp0iebOo?=
 =?us-ascii?Q?8cSZsctv5h2vEOCqd2kqlHsuYUQ4tG8cb2fAWB1T0i+dvQXi9EiXOOynNbjn?=
 =?us-ascii?Q?/K91VvouBTX+q319+jfYK+Ri9oJOS/VgiWrjfYTq3HNYkinD718PREgAgG5y?=
 =?us-ascii?Q?DQIZ5blVjNI0MpNZ1cF4kLwsslO9VSwV/cClWjcFdKGXZhw92ZjbInU+VDB3?=
 =?us-ascii?Q?AvHch+6100+1gqhrF4dRakrjZv8zAISLm8PGjJ5VyGKyoAuf9YbR4Ci5oYyB?=
 =?us-ascii?Q?2ZLH7Us1upr1EyugauZ8Km1LNs1oB9wahhRnGbd7ysjYu6Xb1wEbN0Gv/oHN?=
 =?us-ascii?Q?fpf5UPgx08Ae1Vm2sGmdUkv1ev7Jfyh97gsPwqnNhXXa1NY+K7edp+K/fOxl?=
 =?us-ascii?Q?tpEj5CSqywQTMsLLHeL1P8F2Rp9ljPt60MXPV0ynkuCqAL5QYJ5f5/rHB3k+?=
 =?us-ascii?Q?TjBupLiVEiHXlr9svTCY+J1y57sEp1aF4U3Qp1Aw7ZjKPqV68qGTlhonb+dz?=
 =?us-ascii?Q?i5GwUGpJ5adEfk0ZQ24VGc1AxpjCloUGUaoIkPdNcYp3eEQV/nJiNUSWQyLT?=
 =?us-ascii?Q?JNkhTvorQFR1skcvmpQh/O6m/oI0TXfrWZ5aQ46Mbjgm8fKQXT2qOWYr9ebW?=
 =?us-ascii?Q?cEMkX7VLQ7Y0s0sEM9qqFuY31NSaNg6a2cA2RPMazF+lJTT3ZSuGR5uVlB/y?=
 =?us-ascii?Q?SrkBVl+SbpUi84ASNpxh61fEFJFkdCyTJokwqnHPbvVKIa541xJ2WD0Gk5qi?=
 =?us-ascii?Q?yXZMHb1QelRefUBLUoiXKWdIBjJ9c7X9KaDtIrxftdHKWIbDKS7FOsTr2xj/?=
 =?us-ascii?Q?3mC/5SJwm2dkJdzFy5VkBS8uFvCkHxtM/e66B1z3Xn9RA0pVOZXJH/3Jwqtf?=
 =?us-ascii?Q?v51Ks2KhtP102KO5VeqJJFeIof6QEhLR0Mf6PiBwTQrsgUOH0kCh84J8l4ik?=
 =?us-ascii?Q?t5bfHPlTSOpIogA56066i+hJjhyoag9GU9TP0NYjFi9ZkXoemd/qjMd45xQl?=
 =?us-ascii?Q?WgqpC66Ifwjn4YYE53RPem/lWUj4E9fzDOx6Pja0xDqUks0fShAphovVPwJP?=
 =?us-ascii?Q?nyvUOpciaE0Sy3i2I+Lw99pWdsDCJ1/NmQGI4oU8jgp4Jjc4WsiIO08jUEWv?=
 =?us-ascii?Q?6dSfKz54DohDwZJczYdLTswnbYX6Qk2vLQEZ+sgb3ouALJi7vHmWx+yMPrb1?=
 =?us-ascii?Q?DhEGmHy4FHm+AXKDbOh/7mk6UAhXZIxwVA9AhsiYWliU880zHnKCD55rFeLI?=
 =?us-ascii?Q?sr3s0x9cbZuuqSrK1/LrvJhPyHpWOi3zAuJ0VSNi?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f907207a-5d04-4a74-da62-08dd604df52c
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8429.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 03:36:50.0604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: POESk0j99M1jiPZKEf/XNCiQ86WafLmVqQeqrJo+re9RzWOAhFnF1L4lUGbhj4PBRnmumKe0hxfjgS1vA8TOtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9480

Use u32 rather than unsigned long for register variables for clarity and
consistency.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/tty/serial/fsl_lpuart.c | 54 ++++++++++++++++-----------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 6b2f3a73a367..29ce9b25b796 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -450,7 +450,7 @@ static void lpuart_stop_tx(struct uart_port *port)
 
 static void lpuart32_stop_tx(struct uart_port *port)
 {
-	unsigned long temp;
+	u32 temp;
 
 	temp = lpuart32_read(port, UARTCTRL);
 	temp &= ~(UARTCTRL_TIE | UARTCTRL_TCIE);
@@ -467,7 +467,7 @@ static void lpuart_stop_rx(struct uart_port *port)
 
 static void lpuart32_stop_rx(struct uart_port *port)
 {
-	unsigned long temp;
+	u32 temp;
 
 	temp = lpuart32_read(port, UARTCTRL);
 	lpuart32_write(port, temp & ~UARTCTRL_RE, UARTCTRL);
@@ -752,7 +752,7 @@ static inline void lpuart_transmit_buffer(struct lpuart_port *sport)
 static inline void lpuart32_transmit_buffer(struct lpuart_port *sport)
 {
 	struct tty_port *tport = &sport->port.state->port;
-	unsigned long txcnt;
+	u32 txcnt;
 	unsigned char c;
 
 	if (sport->port.x_char) {
@@ -806,7 +806,7 @@ static void lpuart_start_tx(struct uart_port *port)
 static void lpuart32_start_tx(struct uart_port *port)
 {
 	struct lpuart_port *sport = container_of(port, struct lpuart_port, port);
-	unsigned long temp;
+	u32 temp;
 
 	if (sport->lpuart_dma_tx_use) {
 		if (!lpuart_stopped_or_empty(port))
@@ -855,9 +855,9 @@ static unsigned int lpuart32_tx_empty(struct uart_port *port)
 {
 	struct lpuart_port *sport = container_of(port,
 			struct lpuart_port, port);
-	unsigned long stat = lpuart32_read(port, UARTSTAT);
-	unsigned long sfifo = lpuart32_read(port, UARTFIFO);
-	unsigned long ctrl = lpuart32_read(port, UARTCTRL);
+	u32 stat = lpuart32_read(port, UARTSTAT);
+	u32 sfifo = lpuart32_read(port, UARTFIFO);
+	u32 ctrl = lpuart32_read(port, UARTCTRL);
 
 	if (sport->dma_tx_in_progress)
 		return 0;
@@ -961,7 +961,7 @@ static void lpuart32_rxint(struct lpuart_port *sport)
 {
 	unsigned int flg, ignored = 0;
 	struct tty_port *port = &sport->port.state->port;
-	unsigned long rx, sr;
+	u32 rx, sr;
 	bool is_break;
 
 	uart_port_lock(&sport->port);
@@ -1113,7 +1113,7 @@ static void lpuart_copy_rx_to_tty(struct lpuart_port *sport)
 	int count, copied;
 
 	if (lpuart_is_32(sport)) {
-		unsigned long sr = lpuart32_read(&sport->port, UARTSTAT);
+		u32 sr = lpuart32_read(&sport->port, UARTSTAT);
 
 		if (sr & (UARTSTAT_PE | UARTSTAT_FE)) {
 			/* Clear the error flags */
@@ -1279,7 +1279,7 @@ static void lpuart32_dma_idleint(struct lpuart_port *sport)
 static irqreturn_t lpuart32_int(int irq, void *dev_id)
 {
 	struct lpuart_port *sport = dev_id;
-	unsigned long sts, rxcount;
+	u32 sts, rxcount;
 
 	sts = lpuart32_read(&sport->port, UARTSTAT);
 	rxcount = lpuart32_read(&sport->port, UARTWATER);
@@ -1411,12 +1411,12 @@ static inline int lpuart_start_rx_dma(struct lpuart_port *sport)
 	dma_async_issue_pending(chan);
 
 	if (lpuart_is_32(sport)) {
-		unsigned long temp = lpuart32_read(&sport->port, UARTBAUD);
+		u32 temp = lpuart32_read(&sport->port, UARTBAUD);
 
 		lpuart32_write(&sport->port, temp | UARTBAUD_RDMAE, UARTBAUD);
 
 		if (sport->dma_idle_int) {
-			unsigned long ctrl = lpuart32_read(&sport->port, UARTCTRL);
+			u32 ctrl = lpuart32_read(&sport->port, UARTCTRL);
 
 			lpuart32_write(&sport->port, ctrl | UARTCTRL_ILIE, UARTCTRL);
 		}
@@ -1482,7 +1482,7 @@ static int lpuart32_config_rs485(struct uart_port *port, struct ktermios *termio
 	struct lpuart_port *sport = container_of(port,
 			struct lpuart_port, port);
 
-	unsigned long modem = lpuart32_read(&sport->port, UARTMODIR)
+	u32 modem = lpuart32_read(&sport->port, UARTMODIR)
 				& ~(UARTMODIR_TXRTSPOL | UARTMODIR_TXRTSE);
 	u32 ctrl;
 
@@ -1589,7 +1589,7 @@ static void lpuart_break_ctl(struct uart_port *port, int break_state)
 
 static void lpuart32_break_ctl(struct uart_port *port, int break_state)
 {
-	unsigned long temp;
+	u32 temp;
 
 	temp = lpuart32_read(port, UARTCTRL);
 
@@ -1668,8 +1668,7 @@ static void lpuart_setup_watermark_enable(struct lpuart_port *sport)
 
 static void lpuart32_setup_watermark(struct lpuart_port *sport)
 {
-	unsigned long val, ctrl;
-	unsigned long ctrl_saved;
+	u32 val, ctrl, ctrl_saved;
 
 	ctrl = lpuart32_read(&sport->port, UARTCTRL);
 	ctrl_saved = ctrl;
@@ -1848,7 +1847,7 @@ static int lpuart_startup(struct uart_port *port)
 
 static void lpuart32_hw_disable(struct lpuart_port *sport)
 {
-	unsigned long temp;
+	u32 temp;
 
 	temp = lpuart32_read(&sport->port, UARTCTRL);
 	temp &= ~(UARTCTRL_RIE | UARTCTRL_ILIE | UARTCTRL_RE |
@@ -1858,7 +1857,7 @@ static void lpuart32_hw_disable(struct lpuart_port *sport)
 
 static void lpuart32_configure(struct lpuart_port *sport)
 {
-	unsigned long temp;
+	u32 temp;
 
 	temp = lpuart32_read(&sport->port, UARTCTRL);
 	if (!sport->lpuart_dma_rx_use)
@@ -1888,7 +1887,7 @@ static void lpuart32_hw_setup(struct lpuart_port *sport)
 static int lpuart32_startup(struct uart_port *port)
 {
 	struct lpuart_port *sport = container_of(port, struct lpuart_port, port);
-	unsigned long temp;
+	u32 temp;
 
 	/* determine FIFO size */
 	temp = lpuart32_read(&sport->port, UARTFIFO);
@@ -1962,7 +1961,7 @@ static void lpuart32_shutdown(struct uart_port *port)
 {
 	struct lpuart_port *sport =
 		container_of(port, struct lpuart_port, port);
-	unsigned long temp;
+	u32 temp;
 	unsigned long flags;
 
 	uart_port_lock_irqsave(port, &flags);
@@ -2236,7 +2235,7 @@ lpuart32_set_termios(struct uart_port *port, struct ktermios *termios,
 {
 	struct lpuart_port *sport = container_of(port, struct lpuart_port, port);
 	unsigned long flags;
-	unsigned long ctrl, old_ctrl, bd, modem;
+	u32 ctrl, old_ctrl, bd, modem;
 	unsigned int  baud;
 	unsigned int old_csize = old ? old->c_cflag & CSIZE : CS8;
 
@@ -2533,7 +2532,7 @@ static void
 lpuart32_console_write(struct console *co, const char *s, unsigned int count)
 {
 	struct lpuart_port *sport = lpuart_ports[co->index];
-	unsigned long  old_cr, cr;
+	u32 old_cr, cr;
 	unsigned long flags;
 	int locked = 1;
 
@@ -2616,7 +2615,7 @@ static void __init
 lpuart32_console_get_options(struct lpuart_port *sport, int *baud,
 			   int *parity, int *bits)
 {
-	unsigned long cr, bd;
+	u32 cr, bd;
 	unsigned int sbr, uartclk, baud_raw;
 
 	cr = lpuart32_read(&sport->port, UARTCTRL);
@@ -2822,7 +2821,7 @@ static int lpuart_global_reset(struct lpuart_port *sport)
 {
 	struct uart_port *port = &sport->port;
 	void __iomem *global_addr;
-	unsigned long ctrl, bd;
+	u32 ctrl, bd;
 	unsigned int val = 0;
 	int ret;
 
@@ -3028,7 +3027,7 @@ static int lpuart_runtime_resume(struct device *dev)
 
 static void serial_lpuart_enable_wakeup(struct lpuart_port *sport, bool on)
 {
-	unsigned int val, baud;
+	u32 val, baud;
 
 	if (lpuart_is_32(sport)) {
 		val = lpuart32_read(&sport->port, UARTCTRL);
@@ -3093,7 +3092,7 @@ static int lpuart_suspend_noirq(struct device *dev)
 static int lpuart_resume_noirq(struct device *dev)
 {
 	struct lpuart_port *sport = dev_get_drvdata(dev);
-	unsigned int val;
+	u32 val;
 
 	pinctrl_pm_select_default_state(dev);
 
@@ -3113,7 +3112,8 @@ static int lpuart_resume_noirq(struct device *dev)
 static int lpuart_suspend(struct device *dev)
 {
 	struct lpuart_port *sport = dev_get_drvdata(dev);
-	unsigned long temp, flags;
+	u32 temp;
+	unsigned long flags;
 
 	uart_suspend_port(&lpuart_reg, &sport->port);
 
-- 
2.34.1

