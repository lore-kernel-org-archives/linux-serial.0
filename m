Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA50EC77B78
	for <linux-serial@archiver.kernel.org>; Tue,  2 May 2023 19:07:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbjEBTHT (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 2 May 2023 15:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjEBTHS (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 2 May 2023 15:07:18 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2062.outbound.protection.outlook.com [40.107.21.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 943A61BD8
        for <linux-serial@vger.kernel.org>; Tue,  2 May 2023 12:07:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZnB0WsYC1+6E3icW+1xOr/JWYmiwAqitO93f8/mFxaSvqLoIEux4ITlbShj34DSCWpa87mnUXa9BZgSa11xrXEddUITsxB0bSLj/83HgpMsFQpS/LGsccPmbwHj5OSPCGMsFPVWMBRkSHfejiEToHUoUvqU6gCKKoO9ko8OKKDs27WVoo1ZcrRRcXcRo4LKy/4amtu3JovNQHYmQpldkXOuGMcIF+Nt2IjV4GidSl4D8+yB9iNGUyu6A40YgGYagT1QjavdzF4Ti3IhMBWvN6TaQc6MHhFzl6zvk5QLJYZiqdhX5ksesACHn4jTluMVoK/n6TVDw6c8DO6v4HvF0hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B0UyvTleYzwDDtFG1ALHjUeLsuO8bjyPg0PEMdsoFQI=;
 b=jkx78+wwxreClmR/S/H5HzcaDUhcmfWCYMGaaW89I+2d2aDiFG+8E7nsU+vQK1X83URWAj5K6BYI3/AWYiJ2OIbn9OWehpI7JVhbeQ8JPmUYFbmd6xEMny9mRYTeSRkDGZj8xAgkpoAnqHMQqGsFVytwEdjSUtEmxRhBwX4V/RvPvM/4W/emsMZpaSPfWxYdX1SBOMrVD2SX/fqVXCMEB7hkc+9vDqFIoWUjsnAlqDJ6XypVEOJBUElQZ9cFJvrZOJlTwxv9nTMn70eb5DgaDgYdx1rMMP/jyccWZFdH26wG0ovE5RUEXpVQXwXYCbVEunoNuFf51QkItmooJqddAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B0UyvTleYzwDDtFG1ALHjUeLsuO8bjyPg0PEMdsoFQI=;
 b=maiz/SOJ9b1/uSOVyvgO3ZLSU3S62hpuL+nc7yym6v76jld5l1HjQOsK9d0n6Hi5zf/zXAXccq6gUCUrbtcenaKKzYIkNTX/Q+HS2e08gIOmzLY0sZilTfAo8dGakpqFOIx+AZX9MT670ttwl1buLE05Q2HLxxVX8yNVE9nEnww=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by DU2PR04MB8952.eurprd04.prod.outlook.com (2603:10a6:10:2e3::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31; Tue, 2 May
 2023 19:07:13 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::28fb:82ec:7a6:62f3]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::28fb:82ec:7a6:62f3%5]) with mapi id 15.20.6340.031; Tue, 2 May 2023
 19:07:13 +0000
From:   Shenwei Wang <shenwei.wang@nxp.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        imx@lists.linux.dev, linux-imx@nxp.com,
        Shenwei Wang <shenwei.wang@nxp.com>
Subject: [PATCH 1/1] tty: serial: fsl_lpuart: optimize the timer based EOP logic
Date:   Tue,  2 May 2023 14:06:41 -0500
Message-Id: <20230502190641.657483-1-shenwei.wang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0093.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::8) To PAXPR04MB9185.eurprd04.prod.outlook.com
 (2603:10a6:102:231::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9185:EE_|DU2PR04MB8952:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f668baf-f253-428c-d344-08db4b40702a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nMZUppaGimZWo/BKqeXbltLx+4v9hbYtvKhomAhZ+S7uXMDgHnnGdXW25TiROt9+0HYlmrUiFyfankIKfoMY8LV/oImIdDWbJQIyzFy1bVluVXDfK2XPp02tVAGfj2BUSNGLLhydAaACm25izaEjkVHOMZT7LH3fSVGl73NrHXhAeJ3PlSyvJhnpVxPUyMVR8z5sW1UstYrVQg9vw3jSbZx+n2RRAjWX5Jyw2IKO1tpvAGRSU6gtLLGUcLtZbmxTUZBefdaThd3RFFd8mjUlgWyBi8tRS1ttXl2RIzrajunNwQ7aWOvTu2DrfXM0p4wXduKsCypp/vm6i4l2i5GXp8uXA1/fku6eqy0yf3nYFjU2/+DsO2Ag77qyO5d10VRzWLwwU1z5l96hxVHO/asurwMJjg8fewFTYCWPVtXfQY2i3AWuTbnZqfo4CKSBoTI5Z+mOv7Z47QUeKM66ZExDmGj+lQs+AOOtk/mHCJtuCNzCbBJu6plijHsd84pNSDtAlg99WLoIY20MXgaYXzEDZvRkvcAuSJi57AGaOXI1oWBW0kt01tno+Jj6BSPxlAu4jNRJwS7c13suKZeooU2fj+pG1P7yPGqmg78bubzXooYptE5vTltzwEQJg2Z/Elz5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(376002)(346002)(396003)(136003)(451199021)(44832011)(41300700001)(5660300002)(83380400001)(2906002)(66899021)(2616005)(8676002)(8936002)(316002)(6666004)(6486002)(6916009)(38350700002)(38100700002)(66556008)(66476007)(52116002)(4326008)(54906003)(86362001)(478600001)(36756003)(26005)(1076003)(186003)(6506007)(6512007)(66946007)(55236004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5WeQvHXltMrRqI3aAXf5dFSiuPDh+mvfP2JrSP8HoRj18Qj1ArklSfFEr1pj?=
 =?us-ascii?Q?wSNbdyMvashiy3Qa7x7Ph+BrBzfAhf2HZeDBCO9DMdx4uHEAI/8aY45hsS5F?=
 =?us-ascii?Q?4uJPXPLnXQJiLvvxr34QjGeJLKciTEF/AzY6bXzv161ekVScw2tymZ55QLp1?=
 =?us-ascii?Q?Dxc8aZ7tMq3gkwwE24ijycDKivMaz8NN06113PVqeGoy5em8aynhf5+gvoX3?=
 =?us-ascii?Q?941NnYoMcyMSRAxPyiYsb4lSOZPnhMX9qD5Hrl8Zn4pL1VjXB8MkNzNnujib?=
 =?us-ascii?Q?d22fA2ZmuXe/9scEvGqJDZgDKYbtCRsuAJ7rBqSiSaN55rZ5fsoshUKSwZAo?=
 =?us-ascii?Q?L8pZQhluWM2TJinpSCG+VGuPM5oNcOgjLLah9286JimrjH6kP+TeorZxeGG9?=
 =?us-ascii?Q?TPRjB8ro2pZEm3yn62DDqUCrr6wQpv+5v0Bgh7f8gvNTbbARpUZ7qbLbW+xC?=
 =?us-ascii?Q?vRT+v1t769KvBUA82Llh15nJSkjCKCEmFOrErGE5D/toq4Uy9GoeTEOFcPZg?=
 =?us-ascii?Q?FFgtijuqUmO2rbk7hrUSvF0Lrk6jaW0cYR+q8zbGPegdI9ld1zcebDY0uDz6?=
 =?us-ascii?Q?f6t3M/JHsN9MwjKigj3fUsVxZqeeuRYnMKbhdjGlURUs2Sz6wsWQPojU5hyD?=
 =?us-ascii?Q?9qgmBzmvs6naqwNDVBqLKTO0QqAawbQgeHzW0aJgzY9ncPo8BCqLxbwHMkoA?=
 =?us-ascii?Q?PrcPt+SQO69nwGl4tXHnx3ajFSxRJJFcF6Gnd99fVXlkfatP4DKvX0Cxmgun?=
 =?us-ascii?Q?Pby6gGcYgcvcikDHHR3oWIqlXPXQUtsCKlpsjn7PRLFHinEpl9Wp44KIgQK5?=
 =?us-ascii?Q?DI0zkWUe4YHuMm4f7tQ57RwgiOMGxlpTuShDcKc1nIROUEKyzkNojiJ1YYZk?=
 =?us-ascii?Q?oUjHjIPDfN9zkjVGT+js9i15C8l0TTWz+OQag9FmWcI8HGGiZ5dNfqPkXLep?=
 =?us-ascii?Q?soD7gEfQZUYBUCJd2JbM+EnEhMUfu2hgMIboM7d++RET6hF88xX6LzhBeDnB?=
 =?us-ascii?Q?O3ROO5Ce1m67dAq/cdgJuRkdTC2fm4VywtmbQCUxdHoPnnGIi7ZXTzDBgfAt?=
 =?us-ascii?Q?wOw6rA68DBxxvdL5oeDUP6G+qvkI1iHDn6E22FrORte48HTBTpbI4u2LcOA7?=
 =?us-ascii?Q?Rup8Z6ZojzswfA3iXZ6/YkK6O4MvdOups0n6ZvEfQ3xPq59JzknnCWmo8Cv9?=
 =?us-ascii?Q?bfhYS8O3SQ9Sm/Xh4OycvYbrrxvfKyaCTsV7l0Mv0Qc2KkYo3jaqIb9n9a3s?=
 =?us-ascii?Q?aMRLrIa0vREqpOQFPXZuz1ZBBr7WErGCHVrJczmpaRAsMv8wQHQDiuMH0yeP?=
 =?us-ascii?Q?+vxuvgTlQ5vzDtdcugC7a96Z+hsV7kUob2pdaTyVnl75iCOgAuvfN/gU6lJ4?=
 =?us-ascii?Q?LQrQ+XKkdNRwC5Lww/2mkrkNFKB26zpUr2ShKxPkUzBmpNW4aCGXaZXD8axj?=
 =?us-ascii?Q?x+Cuf+hI86u8MUts6a6WbBxknWc/bD3Hl6A46oGyJwGCn+/Vi2Muxfmp1gWw?=
 =?us-ascii?Q?TYp29ZwbyUbgGQ/hXGIY9h0HtArPtvkMW6hOEnQ49IuXxu/lYjCwHnN1qvEz?=
 =?us-ascii?Q?GI+FA9tnv5KyYf20SxRHzdr3X8qS1LyuyJ3agA6o?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f668baf-f253-428c-d344-08db4b40702a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2023 19:07:13.7650
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZuWLvQvubcwiyzQvfz2DYz+VJtz1XlT7j6Ef6OFUnWivn6qeus+jMZ0gCEu7IQwxOhREr7nc30iJwF59lsxQ4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8952
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

At low baud rates, the DMA transfer may end prematurely due to the timer,
even during an active transfer. This does not accurately simulate an EOP
event as intended. We expect the timer to only complete a DMA transfer
once the idle period satisfies a specified interval.

The patch checks the DMA residue count before copying data to the TTY
buffer. If the residue count remains unchanged since the last interrupt,
that indicates no new data was received. In this case, the DMA should
complete as an EOP event. Instead, the timer restarts.

Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
---
 drivers/tty/serial/fsl_lpuart.c | 52 ++++++++++++++++++++++++++++++---
 1 file changed, 48 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index c91916e13648..8d21351fb3bd 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -238,6 +238,7 @@
 
 /* Rx DMA timeout in ms, which is used to calculate Rx ring buffer size */
 #define DMA_RX_TIMEOUT		(10)
+#define DMA_RX_IDLE_CHARS	(8)
 #define UART_AUTOSUSPEND_TIMEOUT	3000
 
 #define DRIVER_NAME	"fsl-lpuart"
@@ -282,6 +283,7 @@ struct lpuart_port {
 	struct scatterlist	rx_sgl, tx_sgl[2];
 	struct circ_buf		rx_ring;
 	int			rx_dma_rng_buf_len;
+	int                     last_residue;
 	unsigned int		dma_tx_nents;
 	wait_queue_head_t	dma_wait;
 	bool			is_cs7; /* Set to true when character size is 7 */
@@ -331,7 +333,7 @@ static struct lpuart_soc_data imx8qxp_data = {
 	.devtype = IMX8QXP_LPUART,
 	.iotype = UPIO_MEM32,
 	.reg_off = IMX_REG_OFF,
-	.rx_watermark = 31,
+	.rx_watermark = 8, /* A lower watermark is ideal for low baud rates. */
 };
 static struct lpuart_soc_data imxrt1050_data = {
 	.devtype = IMXRT1050_LPUART,
@@ -1255,6 +1257,8 @@ static void lpuart_copy_rx_to_tty(struct lpuart_port *sport)
 		sport->port.icount.rx += copied;
 	}
 
+	sport->last_residue = state.residue;
+
 exit:
 	dma_sync_sg_for_device(chan->device->dev, &sport->rx_sgl, 1,
 			       DMA_FROM_DEVICE);
@@ -1272,11 +1276,40 @@ static void lpuart_dma_rx_complete(void *arg)
 	lpuart_copy_rx_to_tty(sport);
 }
 
+/*
+ * Timer function to simulate the hardware EOP(End Of Package) event.
+ * The timer callback is to check for new RX data and copy to TTY buffer.
+ * If no new data since last interrupt, restart timer. Otherwise, copy data
+ * and continue normal logic.
+ */
 static void lpuart_timer_func(struct timer_list *t)
 {
 	struct lpuart_port *sport = from_timer(sport, t, lpuart_timer);
+	struct dma_chan *chan = sport->dma_rx_chan;
+	struct circ_buf *ring = &sport->rx_ring;
+	struct dma_tx_state state;
+	unsigned long flags;
+	int count = 0;
 
-	lpuart_copy_rx_to_tty(sport);
+	dmaengine_tx_status(chan, sport->dma_rx_cookie, &state);
+	ring->head = sport->rx_sgl.length - state.residue;
+
+	if (ring->head < ring->tail)
+		count = sport->rx_sgl.length - ring->tail;
+	else if (ring->tail < ring->head)
+		count = ring->head - ring->tail;
+
+	/* Check if new data received before copying */
+	if ((count != 0) && (sport->last_residue == state.residue))
+		lpuart_copy_rx_to_tty(sport);
+	else
+		mod_timer(&sport->lpuart_timer,
+				jiffies + sport->dma_rx_timeout);
+
+	if (spin_trylock_irqsave(&sport->port.lock, flags)) {
+		sport->last_residue = state.residue;
+		spin_unlock_irqrestore(&sport->port.lock, flags);
+	}
 }
 
 static inline int lpuart_start_rx_dma(struct lpuart_port *sport)
@@ -1297,9 +1330,19 @@ static inline int lpuart_start_rx_dma(struct lpuart_port *sport)
 	 */
 	sport->rx_dma_rng_buf_len = (DMA_RX_TIMEOUT * baud /  bits / 1000) * 2;
 	sport->rx_dma_rng_buf_len = (1 << fls(sport->rx_dma_rng_buf_len));
+	if (sport->rx_dma_rng_buf_len < sport->rxfifo_size * 2)
+		sport->rx_dma_rng_buf_len = sport->rxfifo_size * 2;
+
+	/*
+	 * Keep this condition check in case rxfifo_size is unavailable
+	 * for some SoCs.
+	 */
 	if (sport->rx_dma_rng_buf_len < 16)
 		sport->rx_dma_rng_buf_len = 16;
 
+	sport->dma_rx_timeout =
+		msecs_to_jiffies((1000 * 10 * DMA_RX_IDLE_CHARS) / baud + 1);
+
 	ring->buf = kzalloc(sport->rx_dma_rng_buf_len, GFP_ATOMIC);
 	if (!ring->buf)
 		return -ENOMEM;
@@ -1687,12 +1730,13 @@ static void lpuart_rx_dma_startup(struct lpuart_port *sport)
 	if (!sport->dma_rx_chan)
 		goto err;
 
+	/* set default Rx DMA timeout */
+	sport->dma_rx_timeout = msecs_to_jiffies(DMA_RX_TIMEOUT);
+
 	ret = lpuart_start_rx_dma(sport);
 	if (ret)
 		goto err;
 
-	/* set Rx DMA timeout */
-	sport->dma_rx_timeout = msecs_to_jiffies(DMA_RX_TIMEOUT);
 	if (!sport->dma_rx_timeout)
 		sport->dma_rx_timeout = 1;
 
-- 
2.34.1

