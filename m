Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD276C77B7F
	for <linux-serial@archiver.kernel.org>; Mon,  8 May 2023 14:11:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234451AbjEHOLM (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 8 May 2023 10:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234466AbjEHOLK (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 8 May 2023 10:11:10 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2084.outbound.protection.outlook.com [40.107.7.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2DDF30E68
        for <linux-serial@vger.kernel.org>; Mon,  8 May 2023 07:10:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YujMPtpCvT9P5MmKJVf+Cl62SKVcY2qCU+mYELDPLsxaTxvdfgCcbgZ1jSv7qIT/nqPGcSZVk51uIn5DwiY76/NlZZ9Xvw8wZGgNcLwSgE8Z9DH4C/1RLXiDPl0Nu+Dlpq8GK1+0riBiZZ1Z4kRns0RAjD14cxQk+JwNFPQb1iUjQ5m+xWTt2XGYMRL+lvPHgzETaqn3ciDwkPrHsUUklqR2zASBI3kNqj08RZ6iMT+fDWyT+deaf3C2EghTabHMELxtFE1O2/+zoaBDBcFBi/LUYamHaGc8P6oFijpnN6tWKwW6O4kbOqS3l8VwXBE6ESYSSft/DKdS/pngKPviqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XNRSfsBuGRV7hbkretziTy9yhvmkI/iJPZp6VifvHhA=;
 b=UgYlB156cOXeKDLvj4CiL2qx98jUy6BVW52+ef5buCi4Zu/Ovc+qDNx89x2ejJ4/LcUqbsCgfN7TVd+sFJuFBldBBeW5PIlA1ZEmBcFX/XTucNJ6WF+DA/vjt8QwiTyEnta3HEqmq5ym1A4LOBX8QPOhPgDQcRomIergqo9mPVgVvw8sWNWivWgAObyFTHHjJZocvm8n3Jx3Ns9wDddpkrafSLeHRRGuRdCSyDbD8r3ZWbXH+nKw/JNW9DJ+1sL2/2hgxmFcFZ8Lt1vSDaWCGiBLB+tGx/qZZGtestwrn+algfRtKFybNBDfSA8LfC7HkTvk9UdVdgaNQtP3nHm5bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XNRSfsBuGRV7hbkretziTy9yhvmkI/iJPZp6VifvHhA=;
 b=r4nR0y8LYUxIeHx2wf+fydlbbtCu7JKoto4YyoMg502vm4yC6KeDw3HDZv0Ew8KulN73WW4NVah9gwYdYFajAQh+EacwSZX+DCB2toi9Sx98k5Xnzclm4Ucz66jzZcZifKSpHRJrlERju7WH/ueAoXFBKOYVd9tYf/7Z4PgqZ5U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by DBBPR04MB7786.eurprd04.prod.outlook.com (2603:10a6:10:1e8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Mon, 8 May
 2023 14:10:55 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::28fb:82ec:7a6:62f3]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::28fb:82ec:7a6:62f3%5]) with mapi id 15.20.6363.032; Mon, 8 May 2023
 14:10:55 +0000
From:   Shenwei Wang <shenwei.wang@nxp.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, imx@lists.linux.dev,
        linux-imx@nxp.com, Shenwei Wang <shenwei.wang@nxp.com>
Subject: [PATCH v3 1/1] tty: serial: fsl_lpuart: optimize the timer based EOP logic
Date:   Mon,  8 May 2023 09:10:38 -0500
Message-Id: <20230508141038.979924-1-shenwei.wang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0050.namprd11.prod.outlook.com
 (2603:10b6:a03:80::27) To PAXPR04MB9185.eurprd04.prod.outlook.com
 (2603:10a6:102:231::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9185:EE_|DBBPR04MB7786:EE_
X-MS-Office365-Filtering-Correlation-Id: 628685e3-11c8-4e75-10a6-08db4fce0a06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vl6wO5GKNKP8j2V6VcQ09CgQsOkiFdPQltwRkkQwz9QpxTl/1765nxwAuZAQTgAD474R9mwAB9sB1LfEh0BlSbfirhImdfi8mEo0FF9N/JWMvIDGXRGlcrlR+FaX3hr3nOtIRoq4fstft7cKGIXpfj4cnT6gYcFfZvv0rFxBjYr8wDqt1vMh7a1XuSqZPcIXIYq5BjcfgoSH5LyiU8QEPm+fY6QjUrqdfIHvYkS0PnIy9CBcjmyfSJfkq5sH3rfenAiETd1G9ZTAS7yd5zlxvLfC8pxmDxiXvrESMoUkIz2ZJSl6pz9t9UjJBM853Kb5HT5rc6Ed0ohooucdJ+nWEE/cM1nt71x4nLWWDJtdDTFzDv56kHh0rxKErAzmquNZ4Rk+k91vuJ6fwK3mYmaY3XurkUzaqTFsQBr9nSRsvU5CxTLrIcxVsbHU0VWaKfVSXWypeMB9QW+CaSlC4uT/tf5sNRinMxV17QKvnEH2Hfx+durhHjyRiDdMyouHhg0MqGrqfsDDIlOym4wDZ2nMRidBWp96xwR1m65YMuevg1LwBfHcw+Hor6A5X7SKozxpBQxRxKJXZr6fk61MuHrCAQUwZhUrIg4K4CCjeMFs2KyqJ3O2iF6i3Ac/BBvvSTKH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(366004)(396003)(39860400002)(451199021)(83380400001)(6486002)(478600001)(6666004)(52116002)(54906003)(2616005)(6512007)(6506007)(1076003)(26005)(186003)(55236004)(44832011)(2906002)(38100700002)(36756003)(38350700002)(6916009)(66946007)(66476007)(8936002)(4326008)(41300700001)(66556008)(8676002)(86362001)(316002)(5660300002)(66899021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QG8U81VjyZZA0fnfa5+4qsVPo1TTkxUGb9D2UIuMp+Wrfu4Gz784hBE2qkdE?=
 =?us-ascii?Q?OOQibL1+meUCHhyceKDnzYGSzYw3oGC6INqajtZnKv3l9G9gcjtEy9ZtAGrZ?=
 =?us-ascii?Q?2l43UTUJfqQo5dtSGUomK7o0EPuVy2+3jIC7XDgArHqHX2ebgSnh9Lxm8Sa6?=
 =?us-ascii?Q?VFpABVgOUA6WD8SH70urlOgZVH79+ad/jeuVQItOJTctoDANJBKjXiDqF0MW?=
 =?us-ascii?Q?qZBdifcrKClc11DC2bBq4z2+mcKErLJ0toWQF5UWECvIwSMU9FbW75ae7Tjz?=
 =?us-ascii?Q?x+yzmqvTX4t9gqmNcqqJeTJc2sxs7sFChHCpxbW4qLofeE6yyiBIXeHEDcuZ?=
 =?us-ascii?Q?FXnTD2WcGfdHvTutSlIPp5r5BFv8CuLOaoRRjH9XKSeneLmENa3oz8CEyq5I?=
 =?us-ascii?Q?OgX81I8Z/1KJTN+ba3nWqT35fqhvf8+ekO2wYT8R15PQ59+G6FG5Ecp4P5XF?=
 =?us-ascii?Q?bLTCgjPEJyH0EA8oaEGc/cz5hyRtsmJMi9psbV2VQiEcf4FbYxjS1RqT3Epa?=
 =?us-ascii?Q?2nXpg24A/L5pM33U2cwPVM0ChWJinRyApRLcit4Ni0nW+CCNcvNqQ7L40V9B?=
 =?us-ascii?Q?QrK/3rH18gkAslWB13KxykaceqSNcO71IoCJynOStiJyCDfJogvqiCKRUSap?=
 =?us-ascii?Q?5Xbps2tYZlX2QQbC6jlXmt8UVZZ6+oPLQinxc+NT9hjbrGxRpwaiFjtOm3BY?=
 =?us-ascii?Q?vGVvncuNnowgDr0djl7AqoJi2mO23tu1XFOngdVvyIoPMqDA/x+3xPmudXxv?=
 =?us-ascii?Q?GAXQYZOVuqiwRT2EwXfAz7kD8nOQW7BfHyNhV32GrpUghq7JWRRfGtp0ypHC?=
 =?us-ascii?Q?x8T/IEFjZxQ7y4BN34TNrDgsvh5CMxe8nTpJgSdw2uQHU87EF01OuF+zmiHr?=
 =?us-ascii?Q?od+eKAJHCvTyQ8+1uWJl0WVQeTeolpbb6PwoGC61vK2cwKYLipzja+u0QagS?=
 =?us-ascii?Q?VCjRLHBGlJhnaVE05WUm8HeP3NjgNJgdjATxxWPo/NlNIaEBQ4JtqFB7/mgw?=
 =?us-ascii?Q?9JqZcfqzdjHoK5z7IpC8V6DPh6irSnHFFGxRPqbhTKWF85lpm1A8dXS6Oq/c?=
 =?us-ascii?Q?uIH12EJkT1dfX1qrtKxFLcOFsYkn3hEtx5VtOaeh3faRTIPZdY9vFUPwQS0D?=
 =?us-ascii?Q?7/Ocn/KWdUjslal5aTnyb7daofZuyz21kyvnrfA5e8mHaxB1V4VFzCyQUF1J?=
 =?us-ascii?Q?/ifSFDmzr+a1ROq97HR54JB8S2veatk06OF+9nI7LfusDpLCaRKz6DyNbkS+?=
 =?us-ascii?Q?duthk+c98nNlC4Y9JrH9aML6E16iMnF/I94Rw+lB0ixPdydjky4VEGudYQ0E?=
 =?us-ascii?Q?iqf2llHMz3pv2h/YO553QB0iIQXLlQ1gm7e5uHJVlmyeEWap4iVtXBerDNmt?=
 =?us-ascii?Q?mwsHS3zh8A1jlQt7mxG3vGICA3OOMuGU5ZPQWeoYeWpg8g4NKVkrC3t5cG/9?=
 =?us-ascii?Q?g+VXoruZ2wngausaUYYOeg39nQ7e/GqrmtPH3/TAkxR2r/B8MFrdqrAYFpgD?=
 =?us-ascii?Q?oH1knXkteyi/ewXd8k+dbY1JxtgwAaJmthy3EUoA1oAQTKe7A1mQfL/2huSg?=
 =?us-ascii?Q?LxexcoBn0dAIlE3iEgQFekJ9HL6l2OEg2WP7MTEh?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 628685e3-11c8-4e75-10a6-08db4fce0a06
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2023 14:10:55.5008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K+QG5pUHHfy5JGaFE7Pzof+3qpbN7kSuIGXOsE9XmrIvr3A9YnBsAqscGVsqAC1WPFZt+25cErHk9jzdYH2SUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7786
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
complete as an EOP event. Otherwise, it indicates that new data were
received during the interval, the EOP condition was not met and the
timer restarted.

Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
---
V3:
  - change the rx_watermark from 8 to 7 because the dma request is
    generated when the fifo level is greater than this value.
V2:
  - this version is to address the review feedback from Ilpo.
  - reset the last_residue when rx dma starts.
  - simplified the character counting in the RX circular buffer.
  - use max_t() and DIV_ROUND_UP()

 drivers/tty/serial/fsl_lpuart.c | 51 ++++++++++++++++++++++++++++++---
 1 file changed, 47 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index c91916e13648..0ee1161bc789 100644
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
+	.rx_watermark = 7, /* A lower watermark is ideal for low baud rates. */
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
@@ -1272,11 +1276,37 @@ static void lpuart_dma_rx_complete(void *arg)
 	lpuart_copy_rx_to_tty(sport);
 }

+/*
+ * Timer function to simulate the hardware EOP (End Of Package) event.
+ * The timer callback is to check for new RX data and copy to TTY buffer.
+ * If no new data are received since last interval, the EOP condition is
+ * met, complete the DMA transfer by copying the data. Otherwise, just
+ * restart timer.
+ */
 static void lpuart_timer_func(struct timer_list *t)
 {
 	struct lpuart_port *sport = from_timer(sport, t, lpuart_timer);
+	struct dma_chan *chan = sport->dma_rx_chan;
+	struct circ_buf *ring = &sport->rx_ring;
+	struct dma_tx_state state;
+	unsigned long flags;
+	int count;

-	lpuart_copy_rx_to_tty(sport);
+	dmaengine_tx_status(chan, sport->dma_rx_cookie, &state);
+	ring->head = sport->rx_sgl.length - state.residue;
+	count = CIRC_CNT(ring->head, ring->tail, sport->rx_sgl.length);
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
@@ -1297,9 +1327,21 @@ static inline int lpuart_start_rx_dma(struct lpuart_port *sport)
 	 */
 	sport->rx_dma_rng_buf_len = (DMA_RX_TIMEOUT * baud /  bits / 1000) * 2;
 	sport->rx_dma_rng_buf_len = (1 << fls(sport->rx_dma_rng_buf_len));
+	sport->rx_dma_rng_buf_len = max_t(int,
+			sport->rxfifo_size * 2,
+			sport->rx_dma_rng_buf_len);
+	/*
+	 * Keep this condition check in case rxfifo_size is unavailable
+	 * for some SoCs.
+	 */
 	if (sport->rx_dma_rng_buf_len < 16)
 		sport->rx_dma_rng_buf_len = 16;

+	sport->last_residue = 0;
+	sport->dma_rx_timeout = msecs_to_jiffies(
+		DIV_ROUND_UP(sport->port.frame_time * DMA_RX_IDLE_CHARS,
+		NSEC_PER_MSEC));
+
 	ring->buf = kzalloc(sport->rx_dma_rng_buf_len, GFP_ATOMIC);
 	if (!ring->buf)
 		return -ENOMEM;
@@ -1687,12 +1729,13 @@ static void lpuart_rx_dma_startup(struct lpuart_port *sport)
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

