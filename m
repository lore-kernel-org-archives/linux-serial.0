Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012013.outbound.protection.outlook.com [52.101.71.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDB91EE008;
	Fri, 21 Mar 2025 07:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742542796; cv=fail; b=LdKglnQ3cNxeoWiTN4SgbP6VgQ2HTTqdco1rv/ps2rGWxrcbxryouLY4UscBV4qfu+eIjKOJiE5v3wYSDLBr4uIRrfDttIeN2KrnLnAkd3RnIGRvM1tLz//AZJRyswSRS+L90JVMHi4MfpRfIJdsK6nPrQH9lv96OZctbwuV6WI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742542796; c=relaxed/simple;
	bh=CAbyxAwy7pNqmsBLGzog/W3ys+kBaQExYNJb1qAKe7U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dbckXqYkTbAbiTrTNCVNJ4HC5CLMbUGKNT0xoiMAo8fE2cpgmcBHLL/MB+8NPq+2RwOAHSEaNXZSeRWMnjloCkTQnuD6QiUs0CWwkLB+VNHdom4ejqwu8qhJ2U/xDGCTkN9/QhQzB+URVMnX+wbwKnesb8iTmLvepe10VcKNeDg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BLj63/pI; arc=fail smtp.client-ip=52.101.71.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BLj63/pI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DFbR6fAQSPcfkwUJ0N1P8NJwbUWiTmFfzA+dN63ZForYTw28LkhVLLFShK3h/Z6NixslCCGPt9o+sIuVsk51bVgGhin2S7d1XO0NA5yqqrFDe5iajSz6PNnxumt4AYWvwe/gXGDemgmTcyehDJ//qCy+NMOg7ikVXrg44+wOA1DAvksLl3rWYTACedGaoiOh9RdUVpCTjI6yYlg65G+2Im+FOdevYgZSh01JlmSZfSdK9ZpRlTFnWtteTZI0YSlAxfwCvf1UDP/YKmhRf0W7tepEw0N17DmvDSgT0dWA1KONzFI1ni/HGg0WFLVBlCk++GNc5RNlRCVgG2CH9w8pxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pUJJNiSJpy1qR3QrD1kEpxJP4nwf7uG0IXtZYaMZHbc=;
 b=UbkH5FlkTCcTiuSaufHxFyGzJ1F8g6s2+j1LASWKyb8tZ5GFYClROEZOPBTwEkER8lR3KA1YwZVR61z7l4fF+GpT7jlUaQ0fQE2eKXcLKNjlS1i0BBr5QJwaJixeUJE1QMOCScZAFn5mH+8fkQtv0tjBUYfcMjdk42txP+Y0i4X+NkgZ8sMtFt2qxMSFOlf54GXwL+XRMmhJRS97XNTzpb2bejMSWfHzBhhdY2G5nVqP1KYPgAcFgtlsmNMiWOhnvJuaFexqmSyXORtcNBd0FHwUvxRNVaDsXa2JnK14vseII94SNP40DUi9vj3gdGnSeaJrb2NifRMSGAeZwnYKNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pUJJNiSJpy1qR3QrD1kEpxJP4nwf7uG0IXtZYaMZHbc=;
 b=BLj63/pI4n7wnMu9IKFB2gj1mS3qlm6q1s78ThcnMbVW0gHWdH7eLLKLs+PbXScS1EAQqIO8VG7duCytSn2PzDNnOMCfxINblXrZVDofR/PXcm05e9K6G0mhqvIsYSYJTGeMxbmPT3B8aXDcHGI//hWR8THBPALnY2ZWXy17z0Tpkqh+NqO5L3VBwocev7b0FSfFMwSkm5xkyFAVIKD+7C5yMLpBY5yK1iIHP+MrS8IMm+RuBranjQSJvRt65jmPZ0fUiEslkmlWXgI5W/9fteIvsDKSl2eyM8aVc2ARR4+SqAxU4crZqmyC86+t6aspemLybpzsysuJXVrdF0HvDw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com (2603:10a6:10:242::19)
 by GV1PR04MB9102.eurprd04.prod.outlook.com (2603:10a6:150:21::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Fri, 21 Mar
 2025 07:39:50 +0000
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37]) by DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37%6]) with mapi id 15.20.8534.034; Fri, 21 Mar 2025
 07:39:48 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	shenwei.wang@nxp.com
Subject: [PATCH V4 1/3] tty: serial: fsl_lpuart: Use u32 and u8 for register variables
Date: Fri, 21 Mar 2025 15:39:48 +0800
Message-Id: <20250321073950.108820-2-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250321073950.108820-1-sherry.sun@nxp.com>
References: <20250321073950.108820-1-sherry.sun@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0187.apcprd06.prod.outlook.com (2603:1096:4:1::19)
 To DB9PR04MB8429.eurprd04.prod.outlook.com (2603:10a6:10:242::19)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8429:EE_|GV1PR04MB9102:EE_
X-MS-Office365-Filtering-Correlation-Id: ce15b680-191c-43da-6f13-08dd684b8ec7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ytcd2buk0kNKybaygimUzqFe3dUgeLy0pmY3JsO/PHdAdJ5xpXbhNcqVuOA7?=
 =?us-ascii?Q?5HEOGbaaRkILafk2OIuwlbttT0hR8dKO1Hdg7ZXiWnnSaQsDMDHerw62Xu40?=
 =?us-ascii?Q?IfwQyOL7235bzzWMFs/aw8ROY3+rlzTn+Hl3KRHnrQYWuNVqMpgLOx9qG2W/?=
 =?us-ascii?Q?JW/BFUsTXUQN9aJqMvfjPYyOVaCW6sYIAbt+Poha7RsJfcwdsLUTJSNYwoEX?=
 =?us-ascii?Q?O8jvNMvOGR0EuAFjmUv076DBbV3zDohei6/rdtNgAtC94gi8USsbxsX4FLAX?=
 =?us-ascii?Q?sbOaDUNuH8u8E7/ZjJl/FXoYk1leO7aMtLSeEnnLhJSol1B2LgQKvtSHiau3?=
 =?us-ascii?Q?altGKH31Lg0l1XTF+Cw0zT6toVaHknInro79IeK0TlNTMppGGk9ElvmvEYXM?=
 =?us-ascii?Q?3wPd5hhWa1miFfsSqEXvE9ARzml7BjSCc2XNhq9tzj/BHksW23+DjHyO11Fq?=
 =?us-ascii?Q?Ghb795dooFwMVJsrUrcjVpRxsaZnukwkkPl0KYkW6XVTCbe+jOk2zbrc6hhQ?=
 =?us-ascii?Q?oX3J8URI+ry52JmYUcCnQVrswP5FtfmNKGZXDrdV6o4y+0gQ3JdymeLqFHIh?=
 =?us-ascii?Q?hfnIwjdjL/QZ6MTy/ZDoKz0knYvq+G6W8r0STwcs6M9/gkn86Ca7YZeTRi1j?=
 =?us-ascii?Q?J9SExc3td5S5kdAFMw8nptcMxsD0saYrDXxmrVsEDTFOBOzpUuAmRKZgDWcl?=
 =?us-ascii?Q?nMNiwx97xNmq/2PIMg5QMXmsY5TZbLlgVE7qSMCnR73jtsGH1/TuxDgSImU2?=
 =?us-ascii?Q?aVgER5yd0jBdzyEu1SziHb1eTwXLxEZeeQpfG+wRNEtNuTcZvgzDGi+2PKt8?=
 =?us-ascii?Q?EPEyy/jHkm+Z0UXZD3N11qiXmMHLKiqpjfLOa08PgRmgnIKT8nvbdHHxQAOm?=
 =?us-ascii?Q?EaOrcKgKvE30BtE/hl+74aRPWBO4pXjqj8YHxYGUIn7ETOsX0znjdYlEwu0L?=
 =?us-ascii?Q?zlI52ZL0uTkhVl6+LTTIRrTn1x6Ox1XKnsPoHPRlvg+h+Tg5rVnVJVg36sn3?=
 =?us-ascii?Q?GxGQaKqp/KNQenMN0Md3v5xCtEwz058V2vYC0Q9tdVvQcZT3knd4odvkInai?=
 =?us-ascii?Q?00xVMx7aF1g4rbHQwO5iHkzMT7ksteeg+yxJzEAVA/aRuOsbnPpPEqdB0fuq?=
 =?us-ascii?Q?8tlsGqptMhvzI5QXRoQjAk/mEowTFWH4P+nhSduO43/zb+G5VTZHJ2XEQsaZ?=
 =?us-ascii?Q?mPiEtdYyxLc1j3w9Sb2PyGCEN09NwyCzjWtEzDFVEWbMrBjSbRendqGcH0ua?=
 =?us-ascii?Q?5EYrYE3hTIiZDlSZWiHJ4OSjw/42hXkdU0cJNgcjANHH7gvLC/5cclcbsT64?=
 =?us-ascii?Q?ZqnwjLg3ROsFwJ5aXRXdfFFKy6Iwsfdlekd+Ozz+OeBh9fT/uCAG4hkpaoHk?=
 =?us-ascii?Q?3r0/vCNJxGxg8mrio+Tho6d74NC90Xvj53/6w3bTasxZ2/UkcLGO3dqYOuLW?=
 =?us-ascii?Q?9TmA5YGOjWOSQza4CcI8uDK8N9Wdi945?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8429.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vtDs5IMsYe3na35YNwsvM7emR9cne8Wrble7EVD3lweCv3qYx23oXNCqLhFl?=
 =?us-ascii?Q?Roreka96szAnCTLJxDRM+F0wSNbkoFDcB+8XCvEC4VggvhKL6HeIRMfyL93t?=
 =?us-ascii?Q?1wUcNfEz5RpRtNeqeoF8unruBZmAWWPGqq0f1VZqWGz91boxnhRzwr7TSB6D?=
 =?us-ascii?Q?SlOLjJki1tKU2gGIMnmVitBitqDHTPofiFgpfyKFT4Yv/yiTjmoPvkAo3R1o?=
 =?us-ascii?Q?BuLY4gmxnUKNv8YF6GshyniqRiAQkfENVLwX/m4uDJEbciNI1Msr8MgnmtDz?=
 =?us-ascii?Q?kMSx0pwSPhvFZnqKgseVYNi6ZG5dNJKBQNOhKA46VzOnHWMU7LmsokSvYKT5?=
 =?us-ascii?Q?Ra7IIrN7LVZQlcWoiqdo2I5WCY4TatGbC3Ekaku9P+q3/2X83MZzlEGjhzLp?=
 =?us-ascii?Q?l/dkgtUcvMkcwniI1uQebCm9RRz1J1Pip3+CU9qAjTDIV0RICP5UiZUdj1+g?=
 =?us-ascii?Q?R3usFUZMSMwKiWl7GZ9IyEkdxrMCbOJ1O1iHZ1+GdMyfLULySbyWtwVGBdHg?=
 =?us-ascii?Q?Qt+1JTqS6U6zv3usq6jiNVRbhbrEfWQLCYBuj3PxW3WHirz9ni8Ro10UNwJQ?=
 =?us-ascii?Q?aw5sp2hd037vBzcIyTxyHM+Rn8tgpqxc9NXRJtNuEoAa+5eRSHHThAQA9NiO?=
 =?us-ascii?Q?AKy1rk6kAWES829aaUzfpy7IulJIsAESImZ+l8dhSYhYYm+de2GGojz8TSys?=
 =?us-ascii?Q?8Ws6vkOHJ96VRRgwX5eCPnuZRZmXH/oLTB6Qix4S/NnM5qWUvydLbmU1Exhl?=
 =?us-ascii?Q?46sWDAmDfMwofFU3G0RkU7bEcoRs5iZqKe+uPdDztLp9Aq1z4vvXckb962ZR?=
 =?us-ascii?Q?rJgR4VJepWPMqfR/jNuMSlI08eWEFfjgsMDvAHcmGSaGbe0GbB2aAvIP5lOa?=
 =?us-ascii?Q?0VvSNVXbLQXckxoh4PMdthOTMjedOLqIs8j21qoVLS6pogSYj6LMNphS4xqi?=
 =?us-ascii?Q?B34xNzEgW02oXyv55XDFQgbfDz6jkXBCaeTk2vhasixhp6pYJo1FTyOZepqa?=
 =?us-ascii?Q?5qaWQJZz1+Inqx1PWG4HV9uT/Wqr5kzOhbhSOXwZ2hTUK8WmJh46ta0vNKkm?=
 =?us-ascii?Q?qHKNSkiqlPSU3rflR0gPshhrLpLEtNyVX7sIpref70BWvyQnSViU1n9BGK+6?=
 =?us-ascii?Q?XvhL7X/CWf4UYGC5CqJGPOf/Wa8oqwix54UJmjU4ETubh8o0w4s0uXAwd9Zv?=
 =?us-ascii?Q?ZkDw2OsegLfpVX62zcj3XxHwB/3Hk3c1LXiVhLmkckh9DQkSU/jBDUaPq5Qx?=
 =?us-ascii?Q?gLT7XEXFy1WoSP8YU5CxbsMpb2vPSVsgJUYIq7An9vcPMz6LLvL+kLGymv/a?=
 =?us-ascii?Q?GZ8VXxVvdtlNVkgxVsCOA9rXh34O7H2sMy8OqrjD0CxjhvRageC6pnQtyr+k?=
 =?us-ascii?Q?Yfb6xua/9CF1+QSu+UYG/ism9YyJyoRwhkSFo6QTv6mOPRJji6CqTr9WhygB?=
 =?us-ascii?Q?IKyScDHL/xhUybtKrQThV6i63nbLmfbMbmTOvllaOmDixl4lHL17x3i1srSr?=
 =?us-ascii?Q?q+3pGZt/uBUswzLnKgIejVFmQEvNCwcbx6ok5xAPGuw/PjYYD2qlPHhUM3xA?=
 =?us-ascii?Q?9FEys3MvuKeLj9dtycSMLOAKN7TJU3tc/jMbEDV+?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce15b680-191c-43da-6f13-08dd684b8ec7
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8429.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 07:39:48.6619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wnfltys+DpKMK0lIe9W6sW90djfqb1SfqOzph0mX/OXvDqvbe6r0RUb/s6wvT8U61jLqMVzRSqU16ryjp5bUdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9102

Use u32 and u8 rather than unsigned long or unsigned char for register
variables for clarity and consistency.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/tty/serial/fsl_lpuart.c | 93 ++++++++++++++++-----------------
 1 file changed, 46 insertions(+), 47 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 203ec3b46304..6f64a3300a38 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -441,7 +441,7 @@ static unsigned int lpuart_get_baud_clk_rate(struct lpuart_port *sport)
 
 static void lpuart_stop_tx(struct uart_port *port)
 {
-	unsigned char temp;
+	u8 temp;
 
 	temp = readb(port->membase + UARTCR2);
 	temp &= ~(UARTCR2_TIE | UARTCR2_TCIE);
@@ -450,7 +450,7 @@ static void lpuart_stop_tx(struct uart_port *port)
 
 static void lpuart32_stop_tx(struct uart_port *port)
 {
-	unsigned long temp;
+	u32 temp;
 
 	temp = lpuart32_read(port, UARTCTRL);
 	temp &= ~(UARTCTRL_TIE | UARTCTRL_TCIE);
@@ -459,7 +459,7 @@ static void lpuart32_stop_tx(struct uart_port *port)
 
 static void lpuart_stop_rx(struct uart_port *port)
 {
-	unsigned char temp;
+	u8 temp;
 
 	temp = readb(port->membase + UARTCR2);
 	writeb(temp & ~UARTCR2_RE, port->membase + UARTCR2);
@@ -467,7 +467,7 @@ static void lpuart_stop_rx(struct uart_port *port)
 
 static void lpuart32_stop_rx(struct uart_port *port)
 {
-	unsigned long temp;
+	u32 temp;
 
 	temp = lpuart32_read(port, UARTCTRL);
 	lpuart32_write(port, temp & ~UARTCTRL_RE, UARTCTRL);
@@ -642,7 +642,7 @@ static int lpuart_poll_init(struct uart_port *port)
 	struct lpuart_port *sport = container_of(port,
 					struct lpuart_port, port);
 	unsigned long flags;
-	unsigned char temp;
+	u8 temp;
 
 	sport->port.fifosize = 0;
 
@@ -752,7 +752,7 @@ static inline void lpuart_transmit_buffer(struct lpuart_port *sport)
 static inline void lpuart32_transmit_buffer(struct lpuart_port *sport)
 {
 	struct tty_port *tport = &sport->port.state->port;
-	unsigned long txcnt;
+	u32 txcnt;
 	unsigned char c;
 
 	if (sport->port.x_char) {
@@ -789,7 +789,7 @@ static void lpuart_start_tx(struct uart_port *port)
 {
 	struct lpuart_port *sport = container_of(port,
 			struct lpuart_port, port);
-	unsigned char temp;
+	u8 temp;
 
 	temp = readb(port->membase + UARTCR2);
 	writeb(temp | UARTCR2_TIE, port->membase + UARTCR2);
@@ -806,7 +806,7 @@ static void lpuart_start_tx(struct uart_port *port)
 static void lpuart32_start_tx(struct uart_port *port)
 {
 	struct lpuart_port *sport = container_of(port, struct lpuart_port, port);
-	unsigned long temp;
+	u32 temp;
 
 	if (sport->lpuart_dma_tx_use) {
 		if (!lpuart_stopped_or_empty(port))
@@ -839,8 +839,8 @@ static unsigned int lpuart_tx_empty(struct uart_port *port)
 {
 	struct lpuart_port *sport = container_of(port,
 			struct lpuart_port, port);
-	unsigned char sr1 = readb(port->membase + UARTSR1);
-	unsigned char sfifo = readb(port->membase + UARTSFIFO);
+	u8 sr1 = readb(port->membase + UARTSR1);
+	u8 sfifo = readb(port->membase + UARTSFIFO);
 
 	if (sport->dma_tx_in_progress)
 		return 0;
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
@@ -884,7 +884,7 @@ static void lpuart_rxint(struct lpuart_port *sport)
 {
 	unsigned int flg, ignored = 0, overrun = 0;
 	struct tty_port *port = &sport->port.state->port;
-	unsigned char rx, sr;
+	u8 rx, sr;
 
 	uart_port_lock(&sport->port);
 
@@ -961,7 +961,7 @@ static void lpuart32_rxint(struct lpuart_port *sport)
 {
 	unsigned int flg, ignored = 0;
 	struct tty_port *port = &sport->port.state->port;
-	unsigned long rx, sr;
+	u32 rx, sr;
 	bool is_break;
 
 	uart_port_lock(&sport->port);
@@ -1039,7 +1039,7 @@ static void lpuart32_rxint(struct lpuart_port *sport)
 static irqreturn_t lpuart_int(int irq, void *dev_id)
 {
 	struct lpuart_port *sport = dev_id;
-	unsigned char sts;
+	u8 sts;
 
 	sts = readb(sport->port.membase + UARTSR1);
 
@@ -1113,7 +1113,7 @@ static void lpuart_copy_rx_to_tty(struct lpuart_port *sport)
 	int count, copied;
 
 	if (lpuart_is_32(sport)) {
-		unsigned long sr = lpuart32_read(&sport->port, UARTSTAT);
+		u32 sr = lpuart32_read(&sport->port, UARTSTAT);
 
 		if (sr & (UARTSTAT_PE | UARTSTAT_FE)) {
 			/* Clear the error flags */
@@ -1125,10 +1125,10 @@ static void lpuart_copy_rx_to_tty(struct lpuart_port *sport)
 				sport->port.icount.frame++;
 		}
 	} else {
-		unsigned char sr = readb(sport->port.membase + UARTSR1);
+		u8 sr = readb(sport->port.membase + UARTSR1);
 
 		if (sr & (UARTSR1_PE | UARTSR1_FE)) {
-			unsigned char cr2;
+			u8 cr2;
 
 			/* Disable receiver during this operation... */
 			cr2 = readb(sport->port.membase + UARTCR2);
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
 
@@ -1577,7 +1577,7 @@ static void lpuart32_set_mctrl(struct uart_port *port, unsigned int mctrl)
 
 static void lpuart_break_ctl(struct uart_port *port, int break_state)
 {
-	unsigned char temp;
+	u8 temp;
 
 	temp = readb(port->membase + UARTCR2) & ~UARTCR2_SBK;
 
@@ -1589,7 +1589,7 @@ static void lpuart_break_ctl(struct uart_port *port, int break_state)
 
 static void lpuart32_break_ctl(struct uart_port *port, int break_state)
 {
-	unsigned long temp;
+	u32 temp;
 
 	temp = lpuart32_read(port, UARTCTRL);
 
@@ -1623,8 +1623,7 @@ static void lpuart32_break_ctl(struct uart_port *port, int break_state)
 
 static void lpuart_setup_watermark(struct lpuart_port *sport)
 {
-	unsigned char val, cr2;
-	unsigned char cr2_saved;
+	u8 val, cr2, cr2_saved;
 
 	cr2 = readb(sport->port.membase + UARTCR2);
 	cr2_saved = cr2;
@@ -1657,7 +1656,7 @@ static void lpuart_setup_watermark(struct lpuart_port *sport)
 
 static void lpuart_setup_watermark_enable(struct lpuart_port *sport)
 {
-	unsigned char cr2;
+	u8 cr2;
 
 	lpuart_setup_watermark(sport);
 
@@ -1668,8 +1667,7 @@ static void lpuart_setup_watermark_enable(struct lpuart_port *sport)
 
 static void lpuart32_setup_watermark(struct lpuart_port *sport)
 {
-	unsigned long val, ctrl;
-	unsigned long ctrl_saved;
+	u32 val, ctrl, ctrl_saved;
 
 	ctrl = lpuart32_read(&sport->port, UARTCTRL);
 	ctrl_saved = ctrl;
@@ -1778,7 +1776,7 @@ static void lpuart_tx_dma_startup(struct lpuart_port *sport)
 static void lpuart_rx_dma_startup(struct lpuart_port *sport)
 {
 	int ret;
-	unsigned char cr3;
+	u8 cr3;
 
 	if (uart_console(&sport->port))
 		goto err;
@@ -1828,7 +1826,7 @@ static void lpuart_hw_setup(struct lpuart_port *sport)
 static int lpuart_startup(struct uart_port *port)
 {
 	struct lpuart_port *sport = container_of(port, struct lpuart_port, port);
-	unsigned char temp;
+	u8 temp;
 
 	/* determine FIFO size and enable FIFO mode */
 	temp = readb(sport->port.membase + UARTPFIFO);
@@ -1848,7 +1846,7 @@ static int lpuart_startup(struct uart_port *port)
 
 static void lpuart32_hw_disable(struct lpuart_port *sport)
 {
-	unsigned long temp;
+	u32 temp;
 
 	temp = lpuart32_read(&sport->port, UARTCTRL);
 	temp &= ~(UARTCTRL_RIE | UARTCTRL_ILIE | UARTCTRL_RE |
@@ -1858,7 +1856,7 @@ static void lpuart32_hw_disable(struct lpuart_port *sport)
 
 static void lpuart32_configure(struct lpuart_port *sport)
 {
-	unsigned long temp;
+	u32 temp;
 
 	temp = lpuart32_read(&sport->port, UARTCTRL);
 	if (!sport->lpuart_dma_rx_use)
@@ -1888,7 +1886,7 @@ static void lpuart32_hw_setup(struct lpuart_port *sport)
 static int lpuart32_startup(struct uart_port *port)
 {
 	struct lpuart_port *sport = container_of(port, struct lpuart_port, port);
-	unsigned long temp;
+	u32 temp;
 
 	/* determine FIFO size */
 	temp = lpuart32_read(&sport->port, UARTFIFO);
@@ -1942,7 +1940,7 @@ static void lpuart_dma_shutdown(struct lpuart_port *sport)
 static void lpuart_shutdown(struct uart_port *port)
 {
 	struct lpuart_port *sport = container_of(port, struct lpuart_port, port);
-	unsigned char temp;
+	u8 temp;
 	unsigned long flags;
 
 	uart_port_lock_irqsave(port, &flags);
@@ -1962,7 +1960,7 @@ static void lpuart32_shutdown(struct uart_port *port)
 {
 	struct lpuart_port *sport =
 		container_of(port, struct lpuart_port, port);
-	unsigned long temp;
+	u32 temp;
 	unsigned long flags;
 
 	uart_port_lock_irqsave(port, &flags);
@@ -1998,7 +1996,7 @@ lpuart_set_termios(struct uart_port *port, struct ktermios *termios,
 {
 	struct lpuart_port *sport = container_of(port, struct lpuart_port, port);
 	unsigned long flags;
-	unsigned char cr1, old_cr1, old_cr2, cr3, cr4, bdh, modem;
+	u8 cr1, old_cr1, old_cr2, cr3, cr4, bdh, modem;
 	unsigned int  baud;
 	unsigned int old_csize = old ? old->c_cflag & CSIZE : CS8;
 	unsigned int sbr, brfa;
@@ -2236,7 +2234,7 @@ lpuart32_set_termios(struct uart_port *port, struct ktermios *termios,
 {
 	struct lpuart_port *sport = container_of(port, struct lpuart_port, port);
 	unsigned long flags;
-	unsigned long ctrl, old_ctrl, bd, modem;
+	u32 ctrl, old_ctrl, bd, modem;
 	unsigned int  baud;
 	unsigned int old_csize = old ? old->c_cflag & CSIZE : CS8;
 
@@ -2503,7 +2501,7 @@ static void
 lpuart_console_write(struct console *co, const char *s, unsigned int count)
 {
 	struct lpuart_port *sport = lpuart_ports[co->index];
-	unsigned char  old_cr2, cr2;
+	u8  old_cr2, cr2;
 	unsigned long flags;
 	int locked = 1;
 
@@ -2533,7 +2531,7 @@ static void
 lpuart32_console_write(struct console *co, const char *s, unsigned int count)
 {
 	struct lpuart_port *sport = lpuart_ports[co->index];
-	unsigned long  old_cr, cr;
+	u32 old_cr, cr;
 	unsigned long flags;
 	int locked = 1;
 
@@ -2567,7 +2565,7 @@ static void __init
 lpuart_console_get_options(struct lpuart_port *sport, int *baud,
 			   int *parity, int *bits)
 {
-	unsigned char cr, bdh, bdl, brfa;
+	u8 cr, bdh, bdl, brfa;
 	unsigned int sbr, uartclk, baud_raw;
 
 	cr = readb(sport->port.membase + UARTCR2);
@@ -2616,7 +2614,7 @@ static void __init
 lpuart32_console_get_options(struct lpuart_port *sport, int *baud,
 			   int *parity, int *bits)
 {
-	unsigned long cr, bd;
+	u32 cr, bd;
 	unsigned int sbr, uartclk, baud_raw;
 
 	cr = lpuart32_read(&sport->port, UARTCTRL);
@@ -2822,7 +2820,7 @@ static int lpuart_global_reset(struct lpuart_port *sport)
 {
 	struct uart_port *port = &sport->port;
 	void __iomem *global_addr;
-	unsigned long ctrl, bd;
+	u32 ctrl, bd;
 	unsigned int val = 0;
 	int ret;
 
@@ -3028,7 +3026,7 @@ static int lpuart_runtime_resume(struct device *dev)
 
 static void serial_lpuart_enable_wakeup(struct lpuart_port *sport, bool on)
 {
-	unsigned int val, baud;
+	u32 val, baud;
 
 	if (lpuart_is_32(sport)) {
 		val = lpuart32_read(&sport->port, UARTCTRL);
@@ -3093,7 +3091,7 @@ static int lpuart_suspend_noirq(struct device *dev)
 static int lpuart_resume_noirq(struct device *dev)
 {
 	struct lpuart_port *sport = dev_get_drvdata(dev);
-	unsigned int val;
+	u32 val;
 
 	pinctrl_pm_select_default_state(dev);
 
@@ -3113,7 +3111,8 @@ static int lpuart_resume_noirq(struct device *dev)
 static int lpuart_suspend(struct device *dev)
 {
 	struct lpuart_port *sport = dev_get_drvdata(dev);
-	unsigned long temp, flags;
+	u32 temp;
+	unsigned long flags;
 
 	uart_suspend_port(&lpuart_reg, &sport->port);
 
-- 
2.34.1

