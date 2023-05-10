Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F8FBC77B7C
	for <linux-serial@archiver.kernel.org>; Wed, 10 May 2023 20:34:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232452AbjEJUeT (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 10 May 2023 16:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231455AbjEJUeS (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 10 May 2023 16:34:18 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2087.outbound.protection.outlook.com [40.107.21.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E65E4C16
        for <linux-serial@vger.kernel.org>; Wed, 10 May 2023 13:34:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K4JC60WZaFTBIFRNHhqJtSB67yCVyonZHPfLYBAAIK2ktl3zCIsJGCGlrnM1SiFpiVexLt6lJzql1Lk9PThdi564GvFspfoIeEN1N6v7k+kfUVn7EIZwkvmCZAT+hJxpEEm0jmPRryLljcy5KElFEN/u4c/Qu32iWQ4V9gblpDWmc9doqC8tWZodWwn9JYeN/t5DUOX7u1heWmXHWmFURyZixcQRx/TVHzORo/Sx0+Fo+X59Hp/un3LV3xiLy8oe6yXGADaiwXHAipKTessT7WV00v5SOldgk8VcjUX0wr1bPkggYEvwqT9dBZ8Rnvb1U7UaINzpw6t8gL8CawLMZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q8mNA+vhiEqjP5qIoIHfYFTwhuh6ysEtQaW24yhYA/I=;
 b=TwxICC3OX3g+tkMH8Jn/lE5Gcsi1zptIXCKFlHwF1frfwb3Y8RqcSTzX1/N4PF/nuvMghALqpqs9y9RRmixo9kW6FooXXq2Ae/pR/FOQyGX7p2X9HHfcH0XpmdDhtnRoX7GaFkK9uwKzgs+kAlBSEndzdgNTbzWlyEKSnOANJS47PQ3i4xETvM+ho3ooA+rSC1MICJcnovWJiu1jBGDhpBpiVYXKTLRvnm6IENo7HiD4WM0LQ6qhEriaO0xL9z1b78oSSzp3K3f6GPewbcC5UIGEqAMQYbVnWuZdno5IMKePKAjo7lAnQA+lFt2oHiUn6LuRDmVsFZMzwB0+C84DKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q8mNA+vhiEqjP5qIoIHfYFTwhuh6ysEtQaW24yhYA/I=;
 b=TZQPaIHWT4IHEsn0ZCnoSVBWKINc3T6R/h4pjPryhBjfcp6kU+d5raINDqvvaXWZgl2kChbvPy08n0XUm0ww5Th16zGdl09xgErv9oKFCV3MdZ+N/MFV3kshgqFZkhujHvyqkbvxl3E5LIna1qQRE4Da6Uo1NDfLjSS0IgCkmiQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by DB8PR04MB7148.eurprd04.prod.outlook.com (2603:10a6:10:12d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.21; Wed, 10 May
 2023 20:34:10 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::28fb:82ec:7a6:62f3]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::28fb:82ec:7a6:62f3%5]) with mapi id 15.20.6387.020; Wed, 10 May 2023
 20:34:10 +0000
From:   Shenwei Wang <shenwei.wang@nxp.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, imx@lists.linux.dev,
        linux-imx@nxp.com, Shenwei Wang <shenwei.wang@nxp.com>
Subject: [PATCH v5 1/1] tty: serial: fsl_lpuart: optimize the timer based EOP logic
Date:   Wed, 10 May 2023 15:33:59 -0500
Message-Id: <20230510203359.1353469-1-shenwei.wang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0158.namprd03.prod.outlook.com
 (2603:10b6:a03:338::13) To PAXPR04MB9185.eurprd04.prod.outlook.com
 (2603:10a6:102:231::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9185:EE_|DB8PR04MB7148:EE_
X-MS-Office365-Filtering-Correlation-Id: 03d7c668-a327-4c54-26de-08db5195e89c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BK7gqTx4z7Mcv4+J1dNf1HyIma/EcoG8OE/D+N88R0pXgBDL/jNgRSBcvayggzj8pP0Lyn7YGX6Fxi0OIm4CgqCwTY6dlHDYsJ5H2oV80Jsft5LBGcoTcc2XNsYsN5gcptYmStSqbAvdeyo7c/EFhqCpipQy5RHfZlOQpX5Y9WOXpeP+nSNsOZkUUvzElcPxzcaqsWIxqcDT8CMDI4m7cI44pqIyMoJS5AOuQUQNMqfTN7cKMrelyzQ2s8TD3FnZgAEDhmYekcbX0EZG+2tJyvI3AHvZbiYWH1SC0+ehpAt7CF4DiCeYsXuB50SRKZuD9Lwf9Lq6JjSyrjw7tWASLio52BDhdKYjF76N0mjQWPDGESY9RTKeZ/FRNim6H++pRNLBAj/UhphcPVJJZNd34InAkFsNdUuMy7w6fUodoWI/hKQ3429tzxzDnULyJsMCJNbVWCjX4kNOgZbUuu6pRUKfo/IhlKiz57BRG5HA0PY4HBacSqg2+jRyjFQZ9c1EX18hZm3C4ri3g10luoRMOYje6FB2nXyejbFyh06oEJgTlPXze8pgVctLekhR1ZUZKce+UR2qSeDBaRfs/88UZJMwNpUH8s/2gntsNcqE3Tk0jgkwkvblVV93zttY0Q1h
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(346002)(376002)(39860400002)(396003)(451199021)(6916009)(66476007)(66946007)(4326008)(66556008)(316002)(478600001)(86362001)(54906003)(36756003)(66899021)(2906002)(52116002)(6486002)(2616005)(186003)(83380400001)(6666004)(66574015)(41300700001)(6506007)(26005)(1076003)(6512007)(55236004)(5660300002)(8936002)(8676002)(38100700002)(38350700002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WnhUZllyeG1lWEtib0VzeHZsREkrZ1k2RUtRT3c2SGl0WDd6WU1kZnJydDVm?=
 =?utf-8?B?d0tFMXpkRE9DSmdKTjlzVjJmZnFyMmVId1gxekZwTGt2dkFFZHE3TkpxMm1B?=
 =?utf-8?B?dVQ3YzRHSWswSk1zbEFob2FNbnZJalN2ODN0eEk1ay9jOUVaQmh4TFBKZnNY?=
 =?utf-8?B?OW43bjFVd29WM2p0aUhJS2ZQdnV5eXExVGdtazFRWlJhR05TZGpqZ0VrRXBP?=
 =?utf-8?B?RmQ4dmlLVitJQk04dm1EQVR3NnJ1ZCtrbHhQZTMxK053c0NpNURWZG1oZnox?=
 =?utf-8?B?Y2llbk5nYUlnTFlLUThJTCtmVDlnclVZSi9wWUFyeDFuR1hsSzFDSEd3anEw?=
 =?utf-8?B?cnhWbmNuS2U0VWJaeWw2Y3htb2VjanRjUmJzNHZGOWFNVGh2TFBGeUdCVFVZ?=
 =?utf-8?B?V3hSNG1RSC93LzNSSWdSQ05MR0dZSDBVOUJ5NnZQZ3p1SXFqSmw1VjZjUmR6?=
 =?utf-8?B?U2hHTG5GOUUrU1FyZ0ZHYUtVa3RvRkFjcEdNSmRNY2lXUTVKV3Y0WElhVEdT?=
 =?utf-8?B?NzFPY3kxYm1FRU5BSUg5Mk1rei9JZkt6WWJFbHUvcjNRMjI5NkMrWm0wbUEr?=
 =?utf-8?B?WlBnNmNvTXdhbVpYZldpcWV5MXo2YVlIMDZQcU84bDBtTGFNT3pyekhaOHhN?=
 =?utf-8?B?cElHM3BMcDF0Nm9sTU5aeWd6ZlNnejZuV0VibFNoZ1NjREN1N0d4K1ZOTSt0?=
 =?utf-8?B?WHZVSlpXS3J3ajVkdGQ1d0xHWUs0bllWVStsd3lmdnZVSU1ZejFSRkRBR29x?=
 =?utf-8?B?bVNrK1lKOE8rSDJLUUVKdUNjN2NkUWd4RiszZ0ZIYzNLbjhiT3d0S25mQzlV?=
 =?utf-8?B?Z28zRm1QVVN4ME4vL3BrYUlUTE1kMzJlUFhVRnZYUUZmTEVHUHNDUnVML2dF?=
 =?utf-8?B?UE12cGdoWmJ2dTIvSXpoVmpBcEtMZklWS3pzNTJwR3pxYUNpeTN4eTBEOXRk?=
 =?utf-8?B?NStsWUN3cU9ybG9pN25uNTNmK0psWlJZY2VuR0ZTeDFBTjVBTStDbkJ5VXda?=
 =?utf-8?B?WUtrUzdnR2VSaGNYcS96R2pka3dZVnh6dzVVbzdqSGlNemlMbGxmMk5FUzFx?=
 =?utf-8?B?RU9FSEdaZ2htVnV5aXdpYlRnSWNKUkVOYVFRNzlJUHZLS250dU8wNEtzd0pK?=
 =?utf-8?B?ZFVJeittY2ZnYm5pUkczblJUWitGL3pvV3VSVnRXQk16b1lDSjZsdjArT2Rl?=
 =?utf-8?B?b21JVFFvTlVYQTlxVkl3eWw3eVJLblFNYVh1ald6b2NwdFlGMWc4WEs3cjRn?=
 =?utf-8?B?M0lVMmF5ZVBib3czQlVsU1VXMm9QaE9URnZDeDFGZllsMThHSUxKcldUM1N1?=
 =?utf-8?B?NUY0LzlJaitWbWlhQys3bDBRd3VSMVRmeFRRakFHZE5KTjB2U2RjYU9RS2Z1?=
 =?utf-8?B?bmUwOU83UHBEZnJJQjR5WGFFZGJZSDl2d1dNTkxqbEJ0djdtM2p6dVlyMFRq?=
 =?utf-8?B?bXljV2dLQ0ZmRC8zbmtSc3pib09TNS8zUm9oNklobDZuSkNLQzRycG9zNFVz?=
 =?utf-8?B?Z0p0UzNsc09rSFE5SklIUXd2ck1WNXZnY3RBNWZFTkIxNGxYYnh0cDFhalJY?=
 =?utf-8?B?NGNtQ2JXVWh1ZC8wa05MT1ZFV1lBQyt2Z0VpOFhnUEtYS0Q5NDhwZkNnYWdm?=
 =?utf-8?B?Z1hKVWpISGE0YnU4dUdDNjRnSWx0Q2ZjUjFtSC9ic0RLNHBUNG41WWwxZHRD?=
 =?utf-8?B?Vm9FQ2pXVjNMMm1waDJyNE9ob3kxQmppMFZjOWZnanN0V05BbnNVUExvREtu?=
 =?utf-8?B?VGlJVDFWdVkycytPcElUUmZwTk05MTRaZnFCSXBXVUlXU0JhWTY2c2JsNnMr?=
 =?utf-8?B?c3FuemFSbUV4bVhqQXlON0VJV2VnVlFJekl1OFZMQUVxLy90eUpPZW14MmdV?=
 =?utf-8?B?Q0tMc0gxNzFMSmJhV1NrcTliOHJ6MytEaXRpZzF4ZG1DdDl1YzhpaU1RUnhV?=
 =?utf-8?B?ZkVhN3lNU2g0Yk9PUTRvV1A4R1BIZk9BVC9NeGdBNEEyeWVXVWMzdFJvOXUw?=
 =?utf-8?B?WTZvVE13dkhwV2pjYkdVbzFCOFk1ODJGUlk1QlM5c1lBMVE4WTJIaUZTQTlp?=
 =?utf-8?B?OXhVa2RHb0tuYUgxZEhOaHR1M0hTUzdGc3dZY2VUM2lBdDk0MThTeG8zV0lE?=
 =?utf-8?Q?UtHXFR5VHGxlJA3LwnK2H+KtS?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03d7c668-a327-4c54-26de-08db5195e89c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 20:34:10.0141
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5BZ3f1PkISynCxkOhr2UpAbn6twrVgx9oPEKCL05rX+22hJdf2mMkC8lah4K4RurpkyqlFmibt3y9JPiCcYrxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7148
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

DMA transfer may end prematurely due to the DMA Rx timeout even during an
active transfer because a constant timeout does not accurately simulate an
EOP (End Of Package) event. This patch uses a timer to simulate the
hardware EOP event. The timer should only complete a DMA transfer once the
idle period satisfies a specified interval which is baud rate dependent.
The problem has been observed with low baud rates but could occur also
with high baud rates.

Make the DMA Rx timeout baud rate dependent and check the DMA residue count
before copying data to the TTY buffer. If the residue count remains
unchanged since the last interrupt, that indicates no new data was
received. In this case, the DMA should complete as an EOP event. Otherwise,
new data was received during the interval and the EOP condition is not met
so restart the DMA Rx timeout

Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
V5:
  - fix various align issue per Ilpo's feedback.

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
index c91916e13648..0e56fa64b4ce 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -238,6 +238,7 @@

 /* Rx DMA timeout in ms, which is used to calculate Rx ring buffer size */
 #define DMA_RX_TIMEOUT		(10)
+#define DMA_RX_IDLE_CHARS	8
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
+			  jiffies + sport->dma_rx_timeout);
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
+					  sport->rxfifo_size * 2,
+					  sport->rx_dma_rng_buf_len);
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

