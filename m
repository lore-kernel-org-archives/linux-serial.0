Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013057.outbound.protection.outlook.com [40.107.162.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FFB1EDA03;
	Tue, 11 Mar 2025 03:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741664224; cv=fail; b=UTVA+k451xxgSITJH/hFB46geRpSlZyE10W3W+rNEg8zE7epmGkpan3WvWkscbZg8BQw8+5YQzEyUeJ7dQxYVHwFyVwWoz3Yl5Pr1UpU+j6oPK4yFmJ4JbDlynk/MiAsPe8la+NRUaYDJBelfCCnXjzwdrVws9HDzK9HAwrpyyA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741664224; c=relaxed/simple;
	bh=Z2axqzaNorXTMNYGKosvBeRXZNgG4stUjXJ4+dkmmsI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U1aAW1gMBlaMeMI8yMZCL2lGMsAjKq3Q8E9FNn5bwUKPqDVvuCFUuWGsh07G5X2ziTNzL7Ruih/LEkFKt+yjQ9zbAF2m9LrekO1ICWqn41Sel2Jjy14gIFspy6dF8rlCh32VXenBFamC5M3oN4ASwckfcsWFyZMelp03tkgStVw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gsr9fsWn; arc=fail smtp.client-ip=40.107.162.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gsr9fsWn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xbN1QXzCqK9d07JIzEbl2hbnNzGQVmFhq3JfDVWc2f3LqNyaKxfkWaoaRMj3xRyMZCCG32t1El9QZUBeLmGvK063W9Oeyio8upScI10/QZMc4iC+R1PYH0rQ+7Y32Kt3YqhvT3+P0TgnLNjYBtS8ui1WysAc0k6nMhxjCJIYh4eHUyVdCp1U9k/O/mTW8871yoDeuAAlO3AXiAHb4tSsLjinHPibkrxU+pKxx+1oG1V6NTQGicYGu9keM/9HNRr4LaWhDJjJwK0Fk+W7UdyCy8tRSNyABnoyKN4QRATDI10FhdE83/lgXYRR0M1aClPGN2NotAwJihrF4NWJWCvo/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kxecN82h/OsOvd3ovqJHvPRo3/M5uymOIR/t1v875e0=;
 b=nyk/DrGBdiWVwLKfieZZjLQ6L7/SLmgTNxQHJarYJR07+M7H0U8G6RPC8UTzRbDTL8CM3ZuKuFk/zb3w8WRtriaye98kO8oO37qN8Z5aOmTDDtv/l06eUP4UN3vOxeuXm5Wf2/uoj75Gli4zoACHdDWhCF9vopmDKqUUD1C/t7/9OP4VIZQF+Tjg/xFG9uMtbKTPJ3bRUozGXky+HqVP7AJZVGvH8Y98rPcnb2UInWowBdgWkucAD/TvZWkbg6iKyPrT/SUaSVV2oNJ2oNyC3iI6MERgjQXh4v0dPR6E++fBwKSVj3YJOXkE3DNb/+TcFOYZy25PGTJOZRL+SATYNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kxecN82h/OsOvd3ovqJHvPRo3/M5uymOIR/t1v875e0=;
 b=gsr9fsWnLGIk2/PBbxWFforsDBsA9suKrA3kqNc+LJtBZZ25o18eKsoZqmWost4a1hDkuEdTdXCz5RP7NMjnavDzPmraNe8zQG7aQl6piHXsJfssN1y61YsGrEwsb2ICwLkeEFPhzMHQYWOzD0gtXTDfKdRerFtvGcfar9+1MsSxWLTHNEEqTRxbG0iu+wXkN40V/TulRYGv0t2+5x4uXXn/QIxE7ZtPEcU31WpAjTYki4IyeNbmfM6yYf2H+ufTFHMfgV8kLz+QMvuLBLByNXys9qIjNjuL6VfMYT0i6Miyeh77Kfl+c7oqoezi1NdrOOw1ydkLw6WyN/GfusgAsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com (2603:10a6:10:242::19)
 by AS1PR04MB9480.eurprd04.prod.outlook.com (2603:10a6:20b:4d6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 03:36:59 +0000
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37]) by DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37%6]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 03:36:58 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	shenwei.wang@nxp.com
Subject: [PATCH V2 3/3] tty: serial: lpuart: rename register variables more specifically
Date: Tue, 11 Mar 2025 11:33:36 +0800
Message-Id: <20250311033336.1254842-4-sherry.sun@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0efb9a0d-88db-4684-d298-08dd604dfa13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2HVSt/MFMdWY+4q8ohfbJIhi2bHzsmNOmBluK28biD4rOeE37OETR+20t2Q6?=
 =?us-ascii?Q?VVIKd2EW3co+QXjs9uAioqaXudpFDZTrNU4HhzCUXDbfQMZ9DAXm09zZWe3I?=
 =?us-ascii?Q?OhqW1aupF2WsF5wANY7V8LCUQKx66T0PVQfHyPIwyWZ83AjI7h0gTL/6Q8ly?=
 =?us-ascii?Q?H0nFrmff9v65YBlBe0yIEyQ3VY5FcMSwTxL+rwkuc/+8WEgdPApuOAMTAhUW?=
 =?us-ascii?Q?Dl2KFKKBad2+Bwgq5EbN+RkJ5U9QfQSAaFR8zlL+OyzafYbPQ2mnd1aav6gL?=
 =?us-ascii?Q?c+aHV1yi6U/hQQU+HCyfZ2F2w0UTGELrncdBRpcqgZhWyfNOYINhb75ZftMG?=
 =?us-ascii?Q?lUF9QPF9NJLrHjimvOOgy8EAc+L2R2XYFntivLlurRiF2mIzlUQHI+OE5YjP?=
 =?us-ascii?Q?tEUrDsNG3q4GEpZHboWGr87Iaxclye4w27+cxxTLnFyazxE9zu//KzhNhasx?=
 =?us-ascii?Q?mN8ds46U3lq3/RrLoAlrBgwop+XuzHsxfnbVzcIpAxXp3sEogUWAPqDC65QL?=
 =?us-ascii?Q?4GHKNP1O32SRTZWMNXDX5BR/W2LBSb68XkWTC5ZXDc3h43OLtOSAwgVddekR?=
 =?us-ascii?Q?ciC4feGe2qv2uZvY+cmCZcruE+4Bb5W6NUtDX7DLbaerdyve8vXsIaxI2ywz?=
 =?us-ascii?Q?AGlFsHd4qHDWOLLEOReRQmfQwcC/2zKn1AEon2bOUPIls0XvVUZ+GbPiRhoh?=
 =?us-ascii?Q?yeffx5vP6loRQj9GfkEpjsr7+BtZd0KRGs7jhYU8rZMCDjS6/M7rIhQ2+cCV?=
 =?us-ascii?Q?DIlQcyKhSDsLy9YMfUXhmnUyNBocZsTHibQaSZ0dzrBe/Vd/tQzarXUGT1ZE?=
 =?us-ascii?Q?Oh10ZNPkp69zKUj7tcTrHSycs0Ltk8gLmi9m3G2W5PAEQRiuX6urtjYTlh7j?=
 =?us-ascii?Q?qBpHgChzxviHl7q8wMGEHf0gZVthpiJ0LWn2WBX66Ls537rB4TZNJPvi4tZy?=
 =?us-ascii?Q?J1Lhxxq3SziqO0pswsI2fQl32h7L+HFM5XRPZBPCPDKGvtnr+S3i07biF2uA?=
 =?us-ascii?Q?3ChZ8QcQDtwHDkEHcos7lammTIS4ZXVH/MDYf1tJZmYb9D51ojqIBVSZiDpu?=
 =?us-ascii?Q?KAIAe6dDAYeHtfu9loJvye9QLGMlshIVZxik4UNVNgLnlJNFu4AxAY/wmtbe?=
 =?us-ascii?Q?W08SSYUWhaDjYed1mPu7LNhFBW9DXxEUWLbICj2CbYCci+0DpHhHfBStyl/E?=
 =?us-ascii?Q?E6tatIliJ+agkNCbRYdZreAIXLCQqersGmaJDT4zmD18S86x+LuNhqRFn8eW?=
 =?us-ascii?Q?msWil4F9HUCVRV7Cq/WVNzEUDD6gXcCc/FLFPx389IP0wJLfEgevdZHKs8Zv?=
 =?us-ascii?Q?Cfyw2eO3aXADtVsoNKgWiU0cYf6HcoNL5msZ2yaio0duhZwaUU+M4pvtmrnd?=
 =?us-ascii?Q?38Dz/pzy5HXhI7iyWA2QGprSjmdWS5qMqOTbpPsDMir6d0OfnEjQV1pHlIbK?=
 =?us-ascii?Q?iwdL9utVGwLCXvRtlGvArhBK47jhM5rw?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8429.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vfQ3tCTLkAQJ7yWh9P24R9Apo974z3ukbTOMJgmSUhA0dX5x65YoqJ2TUJXo?=
 =?us-ascii?Q?xQ67ljN07e33o1vVSsi8BZSpqnzAYBl3WU6tbShyGnY352n1ah/a4S3iRj31?=
 =?us-ascii?Q?zLwAIk5zTeygLV0Qror371vOJI06C4QcskSTJ7WbRzvArC0uWJNa+2PFvSSz?=
 =?us-ascii?Q?0B5S3ntBxA8y9oVHEBoCFAofsB2jY0Lgs5fFW917z33Vx1SyaakjWP7lJKti?=
 =?us-ascii?Q?2romCAz4j+uqOejb4GI83AvvMFOmFfGAO0uqC4HmmPEjjPmL9kgpBwKM6NXK?=
 =?us-ascii?Q?Q4kfey0iamHtRNs/Zt6x+Q8KcVgV78TXGr+QrFmXJ425w8jlZzQYWBkpx3Vn?=
 =?us-ascii?Q?U71C1a7G93j7AMmKXaqVvsk3PXyMz2NjrWlQkAsINNAWqcGqwhiPy27Fj13o?=
 =?us-ascii?Q?lrzRem4qNQd0yOdH/b/J4L5NB2cU+4aEwFKOz5SbLDEknEVYFZfy8LDrjnMi?=
 =?us-ascii?Q?FKbRCvkHH6QzSm9SSFp8mcYYrhNOC+Wu667ueYbi8e99n0KXVTKjzEvrXMWo?=
 =?us-ascii?Q?m57IaSPMFy60nicB+YNQ6RTvbaViRk08iZ2mLtBXrT3QY9GzQjvuMSFgilMz?=
 =?us-ascii?Q?GdXui3YELadgvzrvzN5OvUcCv+ueqe56aqV0A6DMpKi673cfc+DIsLk3B9AX?=
 =?us-ascii?Q?sZEs7Kip3bvzNdlL0AqIo9EnYiJ8rNO6XCui6+xtf90b4W0hLyBLCm5VRBhc?=
 =?us-ascii?Q?b6E5f5F0KqzLBr+7zSWtNlLSDC+1ARRSu1rpzCEaGLPJASG7zwR+rj32xfLd?=
 =?us-ascii?Q?Cd/EMD4ZK6Mkg4LCxquztdUdJBM7z9PPkEdHxcl3NAUMQyeilqEHsa5WXZN7?=
 =?us-ascii?Q?JiuxwOj3M0Drn6t29PcLJzjIp8D7tMBRIpmlaDb0ior5Sp2gUOJN8urCiNq+?=
 =?us-ascii?Q?k/4qBCR92p3e31SLdXuh3Qur8EFSTkk2VyxHY6kEyXf6oZrmB1X+ifvEBme7?=
 =?us-ascii?Q?npSEn8nP9UG/nMRkZ008tt/NwZ5LQg0YDctQ4W4Zc5xYo266ugLtkxahnA8Y?=
 =?us-ascii?Q?Tn+p4ZZ8CvGz1NaC+Nv7s/h9DvPF51mHWsomOWFr4Kql5Ji2nOe9sURpHrHj?=
 =?us-ascii?Q?qQFncXtfGWuQdQriUzzjY4tcFoFIfMV0I80sLVGfJolTVLiLOJDjx706BlXt?=
 =?us-ascii?Q?U5Ow/ytPPKlR/jBq6rWglI/szWOUrQvrnE99OgyzpIrHLTo8KUlcdqWeMXy+?=
 =?us-ascii?Q?u7cUmjMGNzBx0WD56RJnXdFuFexhwuid4rGmpcVt3Lp9ZHcHVZ1gtjgdbmNi?=
 =?us-ascii?Q?RiHWjTNXrQJMQdOMUNYRrBkjolIOsmn+spI3217kFbi9J3Su/x6wCZMzHrs2?=
 =?us-ascii?Q?X0FmArxQ89kVIvEq8fJgiTku7yJNwG9Ub3fwBu3aanVsyV/H7ewgvxbpqF7A?=
 =?us-ascii?Q?2/mHprGJg6KB9Cfljm+vvGBzk7y1tHIfHJ93gOxp75YC64oDDX824dLUYBR2?=
 =?us-ascii?Q?ykBdA/DJZ3+IDFhm0wHI96/NuCdi9u5AiaAhxfBlgBy+kORFYrk3byfFsG+g?=
 =?us-ascii?Q?l7YOwtEkp4fZg7BhMRVfO9KBg2LQZs9b0Tg/2edL3Kcva6Vv2yRhLMoVCYrP?=
 =?us-ascii?Q?yYYQUhawv8pnnaq2V5X7Dy7nhjv5756rYPi+8SnS?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0efb9a0d-88db-4684-d298-08dd604dfa13
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8429.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 03:36:58.3416
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hb5vduS6YPYkSuyyyzSJix3ZZ6aqr7BEDYCO4jWk89UVl2x4hQtcOhfAPD+ObPQdNjo8s2smB+EpPjki/k2KNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9480

There are many fuzzy register variables in the lpuart driver, such as
temp, tmp, val, reg. Let's give these register variables more specific
names.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/tty/serial/fsl_lpuart.c | 220 ++++++++++++++++----------------
 1 file changed, 110 insertions(+), 110 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index f830b5a3ba8e..901c83461bfc 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -441,36 +441,36 @@ static unsigned int lpuart_get_baud_clk_rate(struct lpuart_port *sport)
 
 static void lpuart_stop_tx(struct uart_port *port)
 {
-	unsigned char temp;
+	unsigned char cr2;
 
-	temp = readb(port->membase + UARTCR2);
-	temp &= ~(UARTCR2_TIE | UARTCR2_TCIE);
-	writeb(temp, port->membase + UARTCR2);
+	cr2 = readb(port->membase + UARTCR2);
+	cr2 &= ~(UARTCR2_TIE | UARTCR2_TCIE);
+	writeb(cr2, port->membase + UARTCR2);
 }
 
 static void lpuart32_stop_tx(struct uart_port *port)
 {
-	u32 temp;
+	u32 ctrl;
 
-	temp = lpuart32_read(port, UARTCTRL);
-	temp &= ~(UARTCTRL_TIE | UARTCTRL_TCIE);
-	lpuart32_write(port, temp, UARTCTRL);
+	ctrl = lpuart32_read(port, UARTCTRL);
+	ctrl &= ~(UARTCTRL_TIE | UARTCTRL_TCIE);
+	lpuart32_write(port, ctrl, UARTCTRL);
 }
 
 static void lpuart_stop_rx(struct uart_port *port)
 {
-	unsigned char temp;
+	unsigned char cr2;
 
-	temp = readb(port->membase + UARTCR2);
-	writeb(temp & ~UARTCR2_RE, port->membase + UARTCR2);
+	cr2 = readb(port->membase + UARTCR2);
+	writeb(cr2 & ~UARTCR2_RE, port->membase + UARTCR2);
 }
 
 static void lpuart32_stop_rx(struct uart_port *port)
 {
-	u32 temp;
+	u32 ctrl;
 
-	temp = lpuart32_read(port, UARTCTRL);
-	lpuart32_write(port, temp & ~UARTCTRL_RE, UARTCTRL);
+	ctrl = lpuart32_read(port, UARTCTRL);
+	lpuart32_write(port, ctrl & ~UARTCTRL_RE, UARTCTRL);
 }
 
 static void lpuart_dma_tx(struct lpuart_port *sport)
@@ -599,7 +599,7 @@ static void lpuart_flush_buffer(struct uart_port *port)
 {
 	struct lpuart_port *sport = container_of(port, struct lpuart_port, port);
 	struct dma_chan *chan = sport->dma_tx_chan;
-	u32 val;
+	u32 fifo;
 
 	if (sport->lpuart_dma_tx_use) {
 		if (sport->dma_tx_in_progress) {
@@ -611,13 +611,13 @@ static void lpuart_flush_buffer(struct uart_port *port)
 	}
 
 	if (lpuart_is_32(sport)) {
-		val = lpuart32_read(port, UARTFIFO);
-		val |= UARTFIFO_TXFLUSH | UARTFIFO_RXFLUSH;
-		lpuart32_write(port, val, UARTFIFO);
+		fifo = lpuart32_read(port, UARTFIFO);
+		fifo |= UARTFIFO_TXFLUSH | UARTFIFO_RXFLUSH;
+		lpuart32_write(port, fifo, UARTFIFO);
 	} else {
-		val = readb(port->membase + UARTCFIFO);
-		val |= UARTCFIFO_TXFLUSH | UARTCFIFO_RXFLUSH;
-		writeb(val, port->membase + UARTCFIFO);
+		fifo = readb(port->membase + UARTCFIFO);
+		fifo |= UARTCFIFO_TXFLUSH | UARTCFIFO_RXFLUSH;
+		writeb(fifo, port->membase + UARTCFIFO);
 	}
 }
 
@@ -642,7 +642,7 @@ static int lpuart_poll_init(struct uart_port *port)
 	struct lpuart_port *sport = container_of(port,
 					struct lpuart_port, port);
 	unsigned long flags;
-	unsigned char temp;
+	unsigned char fifo;
 
 	port->fifosize = 0;
 
@@ -650,9 +650,9 @@ static int lpuart_poll_init(struct uart_port *port)
 	/* Disable Rx & Tx */
 	writeb(0, port->membase + UARTCR2);
 
-	temp = readb(port->membase + UARTPFIFO);
+	fifo = readb(port->membase + UARTPFIFO);
 	/* Enable Rx and Tx FIFO */
-	writeb(temp | UARTPFIFO_RXFE | UARTPFIFO_TXFE,
+	writeb(fifo | UARTPFIFO_RXFE | UARTPFIFO_TXFE,
 			port->membase + UARTPFIFO);
 
 	/* flush Tx and Rx FIFO */
@@ -694,7 +694,7 @@ static int lpuart32_poll_init(struct uart_port *port)
 {
 	unsigned long flags;
 	struct lpuart_port *sport = container_of(port, struct lpuart_port, port);
-	u32 temp;
+	u32 fifo;
 
 	port->fifosize = 0;
 
@@ -703,10 +703,10 @@ static int lpuart32_poll_init(struct uart_port *port)
 	/* Disable Rx & Tx */
 	lpuart32_write(port, 0, UARTCTRL);
 
-	temp = lpuart32_read(port, UARTFIFO);
+	fifo = lpuart32_read(port, UARTFIFO);
 
 	/* Enable Rx and Tx FIFO */
-	lpuart32_write(port, temp | UARTFIFO_RXFE | UARTFIFO_TXFE, UARTFIFO);
+	lpuart32_write(port, fifo | UARTFIFO_RXFE | UARTFIFO_TXFE, UARTFIFO);
 
 	/* flush Tx and Rx FIFO */
 	lpuart32_write(port, UARTFIFO_TXFLUSH | UARTFIFO_RXFLUSH, UARTFIFO);
@@ -789,10 +789,10 @@ static void lpuart_start_tx(struct uart_port *port)
 {
 	struct lpuart_port *sport = container_of(port,
 			struct lpuart_port, port);
-	unsigned char temp;
+	unsigned char cr2;
 
-	temp = readb(port->membase + UARTCR2);
-	writeb(temp | UARTCR2_TIE, port->membase + UARTCR2);
+	cr2 = readb(port->membase + UARTCR2);
+	writeb(cr2 | UARTCR2_TIE, port->membase + UARTCR2);
 
 	if (sport->lpuart_dma_tx_use) {
 		if (!lpuart_stopped_or_empty(port))
@@ -806,14 +806,14 @@ static void lpuart_start_tx(struct uart_port *port)
 static void lpuart32_start_tx(struct uart_port *port)
 {
 	struct lpuart_port *sport = container_of(port, struct lpuart_port, port);
-	u32 temp;
+	u32 ctrl;
 
 	if (sport->lpuart_dma_tx_use) {
 		if (!lpuart_stopped_or_empty(port))
 			lpuart_dma_tx(sport);
 	} else {
-		temp = lpuart32_read(port, UARTCTRL);
-		lpuart32_write(port, temp | UARTCTRL_TIE, UARTCTRL);
+		ctrl = lpuart32_read(port, UARTCTRL);
+		lpuart32_write(port, ctrl | UARTCTRL_TIE, UARTCTRL);
 
 		if (lpuart32_read(port, UARTSTAT) & UARTSTAT_TDRE)
 			lpuart32_transmit_buffer(sport);
@@ -1411,9 +1411,9 @@ static inline int lpuart_start_rx_dma(struct lpuart_port *sport)
 	dma_async_issue_pending(chan);
 
 	if (lpuart_is_32(sport)) {
-		u32 temp = lpuart32_read(&sport->port, UARTBAUD);
+		u32 baud = lpuart32_read(&sport->port, UARTBAUD);
 
-		lpuart32_write(&sport->port, temp | UARTBAUD_RDMAE, UARTBAUD);
+		lpuart32_write(&sport->port, baud | UARTBAUD_RDMAE, UARTBAUD);
 
 		if (sport->dma_idle_int) {
 			u32 ctrl = lpuart32_read(&sport->port, UARTCTRL);
@@ -1520,10 +1520,10 @@ static int lpuart32_config_rs485(struct uart_port *port, struct ktermios *termio
 static unsigned int lpuart_get_mctrl(struct uart_port *port)
 {
 	unsigned int mctrl = 0;
-	u8 reg;
+	u8 cr1;
 
-	reg = readb(port->membase + UARTCR1);
-	if (reg & UARTCR1_LOOPS)
+	cr1 = readb(port->membase + UARTCR1);
+	if (cr1 & UARTCR1_LOOPS)
 		mctrl |= TIOCM_LOOP;
 
 	return mctrl;
@@ -1532,10 +1532,10 @@ static unsigned int lpuart_get_mctrl(struct uart_port *port)
 static unsigned int lpuart32_get_mctrl(struct uart_port *port)
 {
 	unsigned int mctrl = TIOCM_CAR | TIOCM_DSR | TIOCM_CTS;
-	u32 reg;
+	u32 ctrl;
 
-	reg = lpuart32_read(port, UARTCTRL);
-	if (reg & UARTCTRL_LOOPS)
+	ctrl = lpuart32_read(port, UARTCTRL);
+	if (ctrl & UARTCTRL_LOOPS)
 		mctrl |= TIOCM_LOOP;
 
 	return mctrl;
@@ -1543,49 +1543,49 @@ static unsigned int lpuart32_get_mctrl(struct uart_port *port)
 
 static void lpuart_set_mctrl(struct uart_port *port, unsigned int mctrl)
 {
-	u8 reg;
+	u8 cr1;
 
-	reg = readb(port->membase + UARTCR1);
+	cr1 = readb(port->membase + UARTCR1);
 
 	/* for internal loopback we need LOOPS=1 and RSRC=0 */
-	reg &= ~(UARTCR1_LOOPS | UARTCR1_RSRC);
+	cr1 &= ~(UARTCR1_LOOPS | UARTCR1_RSRC);
 	if (mctrl & TIOCM_LOOP)
-		reg |= UARTCR1_LOOPS;
+		cr1 |= UARTCR1_LOOPS;
 
-	writeb(reg, port->membase + UARTCR1);
+	writeb(cr1, port->membase + UARTCR1);
 }
 
 static void lpuart32_set_mctrl(struct uart_port *port, unsigned int mctrl)
 {
-	u32 reg;
+	u32 ctrl;
 
-	reg = lpuart32_read(port, UARTCTRL);
+	ctrl = lpuart32_read(port, UARTCTRL);
 
 	/* for internal loopback we need LOOPS=1 and RSRC=0 */
-	reg &= ~(UARTCTRL_LOOPS | UARTCTRL_RSRC);
+	ctrl &= ~(UARTCTRL_LOOPS | UARTCTRL_RSRC);
 	if (mctrl & TIOCM_LOOP)
-		reg |= UARTCTRL_LOOPS;
+		ctrl |= UARTCTRL_LOOPS;
 
-	lpuart32_write(port, reg, UARTCTRL);
+	lpuart32_write(port, ctrl, UARTCTRL);
 }
 
 static void lpuart_break_ctl(struct uart_port *port, int break_state)
 {
-	unsigned char temp;
+	unsigned char cr2;
 
-	temp = readb(port->membase + UARTCR2) & ~UARTCR2_SBK;
+	cr2 = readb(port->membase + UARTCR2) & ~UARTCR2_SBK;
 
 	if (break_state != 0)
-		temp |= UARTCR2_SBK;
+		cr2 |= UARTCR2_SBK;
 
-	writeb(temp, port->membase + UARTCR2);
+	writeb(cr2, port->membase + UARTCR2);
 }
 
 static void lpuart32_break_ctl(struct uart_port *port, int break_state)
 {
-	u32 temp;
+	u32 ctrl;
 
-	temp = lpuart32_read(port, UARTCTRL);
+	ctrl = lpuart32_read(port, UARTCTRL);
 
 	/*
 	 * LPUART IP now has two known bugs, one is CTS has higher priority than the
@@ -1602,22 +1602,22 @@ static void lpuart32_break_ctl(struct uart_port *port, int break_state)
 		 * Disable the transmitter to prevent any data from being sent out
 		 * during break, then invert the TX line to send break.
 		 */
-		temp &= ~UARTCTRL_TE;
-		lpuart32_write(port, temp, UARTCTRL);
-		temp |= UARTCTRL_TXINV;
-		lpuart32_write(port, temp, UARTCTRL);
+		ctrl &= ~UARTCTRL_TE;
+		lpuart32_write(port, ctrl, UARTCTRL);
+		ctrl |= UARTCTRL_TXINV;
+		lpuart32_write(port, ctrl, UARTCTRL);
 	} else {
 		/* Disable the TXINV to turn off break and re-enable transmitter. */
-		temp &= ~UARTCTRL_TXINV;
-		lpuart32_write(port, temp, UARTCTRL);
-		temp |= UARTCTRL_TE;
-		lpuart32_write(port, temp, UARTCTRL);
+		ctrl &= ~UARTCTRL_TXINV;
+		lpuart32_write(port, ctrl, UARTCTRL);
+		ctrl |= UARTCTRL_TE;
+		lpuart32_write(port, ctrl, UARTCTRL);
 	}
 }
 
 static void lpuart_setup_watermark(struct lpuart_port *sport)
 {
-	unsigned char val, cr2;
+	unsigned char fifo, cr2;
 	unsigned char cr2_saved;
 
 	cr2 = readb(sport->port.membase + UARTCR2);
@@ -1626,8 +1626,8 @@ static void lpuart_setup_watermark(struct lpuart_port *sport)
 			UARTCR2_RIE | UARTCR2_RE);
 	writeb(cr2, sport->port.membase + UARTCR2);
 
-	val = readb(sport->port.membase + UARTPFIFO);
-	writeb(val | UARTPFIFO_TXFE | UARTPFIFO_RXFE,
+	fifo = readb(sport->port.membase + UARTPFIFO);
+	writeb(fifo | UARTPFIFO_TXFE | UARTPFIFO_RXFE,
 			sport->port.membase + UARTPFIFO);
 
 	/* flush Tx and Rx FIFO */
@@ -1697,14 +1697,14 @@ static void lpuart32_setup_watermark(struct lpuart_port *sport)
 
 static void lpuart32_setup_watermark_enable(struct lpuart_port *sport)
 {
-	u32 temp;
+	u32 ctrl;
 
 	lpuart32_setup_watermark(sport);
 
-	temp = lpuart32_read(&sport->port, UARTCTRL);
-	temp |= UARTCTRL_RE | UARTCTRL_TE;
-	temp |= FIELD_PREP(UARTCTRL_IDLECFG, 0x7);
-	lpuart32_write(&sport->port, temp, UARTCTRL);
+	ctrl = lpuart32_read(&sport->port, UARTCTRL);
+	ctrl |= UARTCTRL_RE | UARTCTRL_TE;
+	ctrl |= FIELD_PREP(UARTCTRL_IDLECFG, 0x7);
+	lpuart32_write(&sport->port, ctrl, UARTCTRL);
 }
 
 static void rx_dma_timer_init(struct lpuart_port *sport)
@@ -1821,16 +1821,16 @@ static void lpuart_hw_setup(struct lpuart_port *sport)
 static int lpuart_startup(struct uart_port *port)
 {
 	struct lpuart_port *sport = container_of(port, struct lpuart_port, port);
-	unsigned char temp;
+	unsigned char fifo;
 
 	/* determine FIFO size and enable FIFO mode */
-	temp = readb(port->membase + UARTPFIFO);
+	fifo = readb(port->membase + UARTPFIFO);
 
-	sport->txfifo_size = UARTFIFO_DEPTH((temp >> UARTPFIFO_TXSIZE_OFF) &
+	sport->txfifo_size = UARTFIFO_DEPTH((fifo >> UARTPFIFO_TXSIZE_OFF) &
 					    UARTPFIFO_FIFOSIZE_MASK);
 	port->fifosize = sport->txfifo_size;
 
-	sport->rxfifo_size = UARTFIFO_DEPTH((temp >> UARTPFIFO_RXSIZE_OFF) &
+	sport->rxfifo_size = UARTFIFO_DEPTH((fifo >> UARTPFIFO_RXSIZE_OFF) &
 					    UARTPFIFO_FIFOSIZE_MASK);
 
 	lpuart_request_dma(sport);
@@ -1841,24 +1841,24 @@ static int lpuart_startup(struct uart_port *port)
 
 static void lpuart32_hw_disable(struct lpuart_port *sport)
 {
-	u32 temp;
+	u32 ctrl;
 
-	temp = lpuart32_read(&sport->port, UARTCTRL);
-	temp &= ~(UARTCTRL_RIE | UARTCTRL_ILIE | UARTCTRL_RE |
+	ctrl = lpuart32_read(&sport->port, UARTCTRL);
+	ctrl &= ~(UARTCTRL_RIE | UARTCTRL_ILIE | UARTCTRL_RE |
 		  UARTCTRL_TIE | UARTCTRL_TE);
-	lpuart32_write(&sport->port, temp, UARTCTRL);
+	lpuart32_write(&sport->port, ctrl, UARTCTRL);
 }
 
 static void lpuart32_configure(struct lpuart_port *sport)
 {
-	u32 temp;
+	u32 ctrl;
 
-	temp = lpuart32_read(&sport->port, UARTCTRL);
+	ctrl = lpuart32_read(&sport->port, UARTCTRL);
 	if (!sport->lpuart_dma_rx_use)
-		temp |= UARTCTRL_RIE | UARTCTRL_ILIE;
+		ctrl |= UARTCTRL_RIE | UARTCTRL_ILIE;
 	if (!sport->lpuart_dma_tx_use)
-		temp |= UARTCTRL_TIE;
-	lpuart32_write(&sport->port, temp, UARTCTRL);
+		ctrl |= UARTCTRL_TIE;
+	lpuart32_write(&sport->port, ctrl, UARTCTRL);
 }
 
 static void lpuart32_hw_setup(struct lpuart_port *sport)
@@ -1881,16 +1881,16 @@ static void lpuart32_hw_setup(struct lpuart_port *sport)
 static int lpuart32_startup(struct uart_port *port)
 {
 	struct lpuart_port *sport = container_of(port, struct lpuart_port, port);
-	u32 temp;
+	u32 fifo;
 
 	/* determine FIFO size */
-	temp = lpuart32_read(port, UARTFIFO);
+	fifo = lpuart32_read(port, UARTFIFO);
 
-	sport->txfifo_size = UARTFIFO_DEPTH((temp >> UARTFIFO_TXSIZE_OFF) &
+	sport->txfifo_size = UARTFIFO_DEPTH((fifo >> UARTFIFO_TXSIZE_OFF) &
 					    UARTFIFO_FIFOSIZE_MASK);
 	port->fifosize = sport->txfifo_size;
 
-	sport->rxfifo_size = UARTFIFO_DEPTH((temp >> UARTFIFO_RXSIZE_OFF) &
+	sport->rxfifo_size = UARTFIFO_DEPTH((fifo >> UARTFIFO_RXSIZE_OFF) &
 					    UARTFIFO_FIFOSIZE_MASK);
 
 	/*
@@ -1935,16 +1935,16 @@ static void lpuart_dma_shutdown(struct lpuart_port *sport)
 static void lpuart_shutdown(struct uart_port *port)
 {
 	struct lpuart_port *sport = container_of(port, struct lpuart_port, port);
-	unsigned char temp;
+	unsigned char cr2;
 	unsigned long flags;
 
 	uart_port_lock_irqsave(port, &flags);
 
 	/* disable Rx/Tx and interrupts */
-	temp = readb(port->membase + UARTCR2);
-	temp &= ~(UARTCR2_TE | UARTCR2_RE |
+	cr2 = readb(port->membase + UARTCR2);
+	cr2 &= ~(UARTCR2_TE | UARTCR2_RE |
 			UARTCR2_TIE | UARTCR2_TCIE | UARTCR2_RIE);
-	writeb(temp, port->membase + UARTCR2);
+	writeb(cr2, port->membase + UARTCR2);
 
 	uart_port_unlock_irqrestore(port, flags);
 
@@ -2142,7 +2142,7 @@ static void __lpuart32_serial_setbrg(struct uart_port *port,
 				     unsigned int baudrate, bool use_rx_dma,
 				     bool use_tx_dma)
 {
-	u32 sbr, osr, baud_diff, tmp_osr, tmp_sbr, tmp_diff, tmp;
+	u32 sbr, osr, baud_diff, tmp_osr, tmp_sbr, tmp_diff, baud;
 	u32 clk = port->uartclk;
 
 	/*
@@ -2171,9 +2171,9 @@ static void __lpuart32_serial_setbrg(struct uart_port *port,
 		tmp_diff = clk / (tmp_osr * tmp_sbr) - baudrate;
 
 		/* select best values between sbr and sbr+1 */
-		tmp = clk / (tmp_osr * (tmp_sbr + 1));
-		if (tmp_diff > (baudrate - tmp)) {
-			tmp_diff = baudrate - tmp;
+		baud = clk / (tmp_osr * (tmp_sbr + 1));
+		if (tmp_diff > (baudrate - baud)) {
+			tmp_diff = baudrate - baud;
 			tmp_sbr++;
 		}
 
@@ -2195,23 +2195,23 @@ static void __lpuart32_serial_setbrg(struct uart_port *port,
 		dev_warn(port->dev,
 			 "unacceptable baud rate difference of more than 3%%\n");
 
-	tmp = lpuart32_read(port, UARTBAUD);
+	baud = lpuart32_read(port, UARTBAUD);
 
 	if ((osr > 3) && (osr < 8))
-		tmp |= UARTBAUD_BOTHEDGE;
+		baud |= UARTBAUD_BOTHEDGE;
 
-	tmp &= ~(UARTBAUD_OSR_MASK << UARTBAUD_OSR_SHIFT);
-	tmp |= ((osr-1) & UARTBAUD_OSR_MASK) << UARTBAUD_OSR_SHIFT;
+	baud &= ~(UARTBAUD_OSR_MASK << UARTBAUD_OSR_SHIFT);
+	baud |= ((osr-1) & UARTBAUD_OSR_MASK) << UARTBAUD_OSR_SHIFT;
 
-	tmp &= ~UARTBAUD_SBR_MASK;
-	tmp |= sbr & UARTBAUD_SBR_MASK;
+	baud &= ~UARTBAUD_SBR_MASK;
+	baud |= sbr & UARTBAUD_SBR_MASK;
 
 	if (!use_rx_dma)
-		tmp &= ~UARTBAUD_RDMAE;
+		baud &= ~UARTBAUD_RDMAE;
 	if (!use_tx_dma)
-		tmp &= ~UARTBAUD_TDMAE;
+		baud &= ~UARTBAUD_TDMAE;
 
-	lpuart32_write(port, tmp, UARTBAUD);
+	lpuart32_write(port, baud, UARTBAUD);
 }
 
 static void lpuart32_serial_setbrg(struct lpuart_port *sport,
@@ -3086,7 +3086,7 @@ static int lpuart_suspend_noirq(struct device *dev)
 static int lpuart_resume_noirq(struct device *dev)
 {
 	struct lpuart_port *sport = dev_get_drvdata(dev);
-	u32 val;
+	u32 stat;
 
 	pinctrl_pm_select_default_state(dev);
 
@@ -3095,8 +3095,8 @@ static int lpuart_resume_noirq(struct device *dev)
 
 		/* clear the wakeup flags */
 		if (lpuart_is_32(sport)) {
-			val = lpuart32_read(&sport->port, UARTSTAT);
-			lpuart32_write(&sport->port, val, UARTSTAT);
+			stat = lpuart32_read(&sport->port, UARTSTAT);
+			lpuart32_write(&sport->port, stat, UARTSTAT);
 		}
 	}
 
-- 
2.34.1

