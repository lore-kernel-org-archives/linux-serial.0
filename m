Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11EC5C77B7C
	for <linux-serial@archiver.kernel.org>; Tue,  9 May 2023 15:37:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235118AbjEIPhM (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 9 May 2023 11:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234828AbjEIPhK (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 9 May 2023 11:37:10 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on062d.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe0d::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC444498
        for <linux-serial@vger.kernel.org>; Tue,  9 May 2023 08:37:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=knSCz3mHcwPsB+5OELNTv6kQ1XiY6mTOG1b6EJRPPAvnogFXZ5Zepr2CkcpFd8HLVw77kXYM5odAdGCWeOhmWvRIbrJGL0tzIY1Js7hq49gUgyO4A9O6vKC1oj7XQPvGB33FG41k6BAqJNnZpuOEjmbhfTfPb5/QdTw0/buKGsdLUhF/askf/KfR5oLVNDSRR/8mrnERPXZm1o7XKnNqnQZuJCUZo77/KdnYPQzhC6S4BhDm+atAx6trBnZ0dOHJvBcdl9YQlly9geG3KMJswrXX7vkT2FgIXwJu/y9Wt2YOd2pFKHmRJ5qEJwny6M8wnOLrGb8IEEYhB3fWT+NNtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fhLUB8obnr/7VNHLSw5H9RgP0eZUG3TnrTceUsOI6M0=;
 b=SZ407LYX+RNAES82ubfTQUuqBcM0oQALc0uOnOx2mkMzaRuY91Hu94k7HQr7mhINN0new8qPRbh1dy3/KFFg7XJcYhoIuBJ/qr7ifn3FtGBfBv16C/mxxcgCHeCeKrVUkuXzDkpJIkp8s1VOWI+ao4uetZBw45EHan7sWo7rVrN1Q+VTbuS0n/BzxrxPuTynrn/19Ix3b7r/+LaId7q2mV+tdgJV2aAhJdGnr6cWjOKDnphjLQ8Mag7hXhVpk/NDk6uvUpbb2WVdC1pUq7NBllPHFUJEvCVCmAe7GuA9IIlv2bevpPm6nYYKb2kuUGpROvjqBwHkbWizqyaV9QDRNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fhLUB8obnr/7VNHLSw5H9RgP0eZUG3TnrTceUsOI6M0=;
 b=MZqF4x5gEzapvkuwhnU5kjdp+5SZ+HpE2xQ6ViDXkwy+pZhrVmucb/P8zx90YJd4Woz6VSXzmTyLVloh9fDv/cDQQsRejC5hOvXXm4qDOtSDR81T4Xa8PRoEEPifrJBYDcesUPFV+sNb1tmhBAmP4D3MP1DHiF9tYL7rmfVu88M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by GVXPR04MB10069.eurprd04.prod.outlook.com (2603:10a6:150:121::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Tue, 9 May
 2023 15:37:03 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::28fb:82ec:7a6:62f3]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::28fb:82ec:7a6:62f3%5]) with mapi id 15.20.6363.032; Tue, 9 May 2023
 15:37:03 +0000
From:   Shenwei Wang <shenwei.wang@nxp.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, imx@lists.linux.dev,
        linux-imx@nxp.com, Shenwei Wang <shenwei.wang@nxp.com>
Subject: [PATCH v4 1/1] tty: serial: fsl_lpuart: optimize the timer based EOP logic
Date:   Tue,  9 May 2023 10:36:24 -0500
Message-Id: <20230509153624.1073946-1-shenwei.wang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0176.namprd03.prod.outlook.com
 (2603:10b6:a03:338::31) To PAXPR04MB9185.eurprd04.prod.outlook.com
 (2603:10a6:102:231::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9185:EE_|GVXPR04MB10069:EE_
X-MS-Office365-Filtering-Correlation-Id: f8947b17-67e3-4601-8e99-08db50a33c81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GSUjwyp3BfI56Og0JE3Q1GXOyHVFSF36x0cPD70EDyHKA/VSMGTJ2x17Ke4a20gv9RrashZ4b1b1XxTUmK1+jsB6/9zM7kNbvolZdjmFd+LjH24N9God2UFs8fH6Hkq0PyKJj/g6f7W2vB0JP+bCirpGJl+G8+9/WEGmABqCqW9Fw5Mv/2K6IxYYKe5fT+ENmFBMuAaw+oYkBcEDZ7mVohcwhSrvlS5ivhevk/RhsYcnEYQS6fOX6shdXGiNEfqRh1w5JYoJ+aS24tD+QtdSxAH/X0hdZYMecfN3rCkM25UXaDDl61czi7rGibXWUIt0AgJ6SA+oNgeT/nufnrpvj0mlq0B23H2cdjKaXFd52zyxXbAPkUH6juNyXA0NKDoncOPkSt19I1dhrg3WA8GkWPrdSvnraRARTE1hczBvRrOPOcwiHXJBY9K87RpkvY25tZ/MdZ+ramKcoYTCnYoMMXt0c9gEiXsx55jztCE67jIHHSj6J17wDsMUZdKeu80H2nFeKs9c2OsERVFsrS4Z9FMfjS26Lq2keveNLpcTjSM0KpJeTWSwiV96xkovis9vpYyjPzYvLpkQMCju0bVQTbQkMO4+qjX45x5dWuFOL3bBLgWLWTpFP/oWN12Vkifq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(136003)(376002)(39860400002)(396003)(451199021)(66899021)(6916009)(4326008)(316002)(478600001)(66946007)(6486002)(66556008)(52116002)(54906003)(66476007)(86362001)(36756003)(83380400001)(2616005)(55236004)(6506007)(1076003)(26005)(6512007)(6666004)(2906002)(5660300002)(41300700001)(8936002)(8676002)(38350700002)(38100700002)(44832011)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2BMkBjMqtDfu4eDoyyFnha8v+LaxXruUh1nREu4974j/j0oNKP3yHa9mDH2I?=
 =?us-ascii?Q?f0tqj5nB3JB2zi6iuM+cDf65AaVOd5yVeDaUDvYJuktB043ZgQGtMtOZ27yy?=
 =?us-ascii?Q?wYNqbNcodxnQu4DpNVBi6PgSHG2qvKECEN4YNEzCgUmYVND5cMOpiX7G7WP+?=
 =?us-ascii?Q?N83zMB3ngiZNn/VTsrCXUe8LD7oOvd8Mopfr5sVpqc+/7H1PE5eIb2PfMbXi?=
 =?us-ascii?Q?IT1l+18Ke2xfAvnHgbUIpX1abcpWvGbWIkvit6mOcte0qJm0RrvPWfLvsr70?=
 =?us-ascii?Q?2QFssh7Y+xCfVUL/y9EX49BauiW3DWO9jsD0aa8XOQrrHEhRKTbf+aD94KBK?=
 =?us-ascii?Q?UOXiF1DV9b5mkrro2vJwrHRSuaoyv6KZBQqL9EtlfboIqHJyi0TfEWFqPOKa?=
 =?us-ascii?Q?v4+3oI79uj0D0bhWZ2zoyvpq0WJVYf5tQXVAEZxcglYaP6LNQbkzYsY5C+33?=
 =?us-ascii?Q?EqsYJU/6peecaCB1JNdnL+bALvGF5glttdeixEhsrhFZCJhVnvQo2qECxO8v?=
 =?us-ascii?Q?YBvteO07qrnJAg/aLkRACC+jkFYz2gG0Sq6IOgRXoTZFyTdmq6G+1nG3yY4S?=
 =?us-ascii?Q?/1mW2MAwawoKN08sbqFCvMC7bDQdfhMyBwgNEOLzMdISRwpT/FGFSJbqG9B8?=
 =?us-ascii?Q?mte46RJEEFwiik8GrR9FxAwiRKmCcoWYi5eDGSL0l2DiuCTVhZwf21tCOi61?=
 =?us-ascii?Q?l19BoYar39pDZm9zQXS3Yog9PO48X0X72xa2xGHGuLT57422ysJgitcMKmt0?=
 =?us-ascii?Q?JgNUooFM2lnBi8WI8FGfmwrM4Dh8Fs9yMed3PnMrv7gfpyVBGCFLcw43sF+Y?=
 =?us-ascii?Q?B8yI63tC97kZzAMuHv+Kt+bvTUjhnQZCjSddTYgWrrwkjsTi9UCQtX5MC8Gl?=
 =?us-ascii?Q?tv8lJegN/Tv64obN4T2lOpvt0uycClHrwyPwUbY9WqaKXojabR9MyxbFfbp3?=
 =?us-ascii?Q?VCy+GWP8eF0r0ZhZ/q9+MMU+DpG3JfS0njGNVzAaifU3KO5Mhw1tqONjoclo?=
 =?us-ascii?Q?SQd6vvRBFHXRPwteAF0vZhL837E2yXm/IjJNh1U7oNAquQk2ir2gtt7lVL4L?=
 =?us-ascii?Q?NZ+D4Eb53OnH8EuTwOJYNYQrlTDCYZW6EVnvom2e38HcjPlG3ZDy+J8tshv+?=
 =?us-ascii?Q?8iSeCC06vJucYEWekoMunHCbWBfq1FeufLbOKT7tG11h4AtMN1YlOM9JVqLk?=
 =?us-ascii?Q?lkNHohHDKDUlwKgY8//lIXwCJXcXgcVnki917O1OSM1W/AqryktAYioBmU3A?=
 =?us-ascii?Q?LH53h+yUft8qbMs3k7zls6KQ/0CU6SjL/GE1vOiLR29uz0Kp9/mfkY79SKqM?=
 =?us-ascii?Q?/oFMLND//bkS5fI/6dOPkyh7zHKmkj8CCXMsaQdWS/wU4ArD/FmyrKSVOvhm?=
 =?us-ascii?Q?sVpXm7QVCKU3mPvRQBkpgWMjh79ZZOn5rb82Nu47jJX/oRr9qKuLXcY1BfHd?=
 =?us-ascii?Q?eQu22+3peti9HQk/QOjbn0QTw5zcoLc7O8Hv0lnb3O3cJJ7XmaQqXqMo0Qtg?=
 =?us-ascii?Q?Wqhq1zLrUBL8ieRps3d+BmpqQKG30BBZM0JqRdzxfVzkF9xLtQ4YzOZIoGEo?=
 =?us-ascii?Q?6mrs2uFHBLJbyryEY4YX0pnKlH5KdvWpUNv2Ib2A?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8947b17-67e3-4601-8e99-08db50a33c81
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 15:37:03.1012
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xv+c9Qb8n3YRNsElaTUynn2dwk7nydn+03FXhm40l6UX9iomNsQ+v5Pv3wn/eIKOHU6CqJax0I1WA+OZckFamw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10069
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

DMA transfer may end prematurely due to the DMA Rx timeout even during an
active transfer because a constant timeout does not accurately simulate an
EOP event. The timer should only complete a DMA transfer once the idle
period satisfies a specified interval which is baud rate dependant.
The problem has been observed with low baud rates but could occur also
with high baud rates.

This patch uses a timer to simulate the hardware EOP (End Of Package) event.
The idea is to make the DMA Rx timeout baud rate dependent and check the DMA
residue count before copying data to the TTY buffer. If the residue count
remains unchanged since the last interrupt, that indicates no new data was
received. In this case, the DMA should complete as an EOP event. Otherwise,
new data was received during the interval and the EOP condition is not met
so restart the DMA Rx timeout

Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
---
V4:
  - improve the patch comments per Ilpo's suggestion.
  - use nsecs_to_jiffies

V3:
  - change the rx_watermark from 8 to 7 because the dma request is
    generated when the fifo level is greater than this value.

V2:
  - this version is to address the review feedback from Ilpo.
  - reset the last_residue when rx dma starts.
  - simplified the character counting in the RX circular buffer.
  - use max_t() and DIV_ROUND_UP()

 drivers/tty/serial/fsl_lpuart.c | 50 ++++++++++++++++++++++++++++++---
 1 file changed, 46 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index c91916e13648..f21920024618 100644
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
@@ -1297,9 +1327,20 @@ static inline int lpuart_start_rx_dma(struct lpuart_port *sport)
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
+	sport->dma_rx_timeout = max(nsecs_to_jiffies(
+		sport->port.frame_time * DMA_RX_IDLE_CHARS), 1UL);
+
 	ring->buf = kzalloc(sport->rx_dma_rng_buf_len, GFP_ATOMIC);
 	if (!ring->buf)
 		return -ENOMEM;
@@ -1687,12 +1728,13 @@ static void lpuart_rx_dma_startup(struct lpuart_port *sport)
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

