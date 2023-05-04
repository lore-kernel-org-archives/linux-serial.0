Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8216EC77B78
	for <linux-serial@archiver.kernel.org>; Thu,  4 May 2023 15:44:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbjEDPoy (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 4 May 2023 11:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231546AbjEDPov (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 4 May 2023 11:44:51 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2074.outbound.protection.outlook.com [40.107.7.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47EE45FCD
        for <linux-serial@vger.kernel.org>; Thu,  4 May 2023 08:44:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a0KTM2wQj9yCXZbqFTnhkb8HBVdY0d0sd/QRHU++Oe5NI2HhVEhiwZdSeSwOxTabadmcjVpy7dRCIL69uh4G5PMGmyIRSDax36cpq7glp2suzSxNu2uSHMvxU/RWOp8yBzV3SLhxiw0qceEMSmfIP/3eXugFBZ6wYFa6WnSfDMy0rf4yU/cSsUTLyM3oDRPKeLv0njVPJ+dSqIQds2Lg3n32MSKRRWtjLRErWaWMyxXJ5AolFMPAK5Go5t/R8Q4yPXQKcEj/CvvtQfr2KnaMkfGMVKhKqfpsUtSwTU1w9FA0Tr5XpNFNKwCOC1xka8pTMQ0QLugQT9A6Mrn+5ZlY6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dm7ysvoDvqPQByMjh+LDOtml/pAR9RmrG6Yad6YqJKw=;
 b=kyGWyHE5NE3GEIz68wKuQb2lRpgRMXWFgmfPqxG1xa0UfUqAH7voxii1I2YHxFsJi4A3YNcSIHX9BYaZNX4hUhzpRdtf8s37TKaut9OLjFTtjdv4xmns68SQqD66sNgYAwXti5S36mzC7rVb5JDL0gO4ZdhUIG6RVuZMybsR7T3gb9oa6XcWhQmU5vOLWpfY+qEM9xLWPHuYH40/HbflSpqywm0702aKAUx9kCML9FgTVL9yhGyPftZoxDfFuZ8f+iD1YpqaVG6sXNF7SpZ8xXdu6DGaAp0EqKN2hsNsRJNHx6wV5kb/Y2iefkQb3OWV36uyJXUY22kzosYsDTVBxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dm7ysvoDvqPQByMjh+LDOtml/pAR9RmrG6Yad6YqJKw=;
 b=n5Qpy+Nj7oHjNW4YxlrGfdrzLwJ5eq2WJ4QYP8retvXc4fBKHSUXquDeXVH1sXCNOpI1wRA9Uo5lc2ph2TYbC8TxhJEpSusowrqQmMyKBd3sAbkGIzkRXojNNFQ+GggurO3YrE7T52qgCCQHGGLY9CVKW8xg4HrOMnJ1dgJFfuA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by AS8PR04MB8262.eurprd04.prod.outlook.com (2603:10a6:20b:3fa::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.26; Thu, 4 May
 2023 15:44:38 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::28fb:82ec:7a6:62f3]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::28fb:82ec:7a6:62f3%5]) with mapi id 15.20.6363.022; Thu, 4 May 2023
 15:44:38 +0000
From:   Shenwei Wang <shenwei.wang@nxp.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, imx@lists.linux.dev,
        linux-imx@nxp.com, Shenwei Wang <shenwei.wang@nxp.com>
Subject: [PATCH v2 1/1] tty: serial: fsl_lpuart: optimize the timer based EOP logic
Date:   Thu,  4 May 2023 10:44:27 -0500
Message-Id: <20230504154427.816736-1-shenwei.wang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0299.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::34) To PAXPR04MB9185.eurprd04.prod.outlook.com
 (2603:10a6:102:231::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9185:EE_|AS8PR04MB8262:EE_
X-MS-Office365-Filtering-Correlation-Id: d4f3bcc4-461a-4453-d384-08db4cb677b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LaaD0cMegYdFIhNeA9fjlWKYttB18D3hlOd6stxgmC8vNelkfahx9VcHoR/QpzOhuem2sxUVEGCWLjYRWe+FyUU2uGMTkScADZ/rJiq43VBmS8Ro7pkZwOSaT+qvngYTC7krjy6UNOJeJ/++KAUUmP+PelSVddEgO7eW8SwpzHzdFSt6j+264EgZ9EXa9fih5QaI4d78837QrUT8XF4UoVW7o44zhF5VS9UihUf165FTcwenXJZD6M/usK6+XHNzq3zjOiyXZf7OJ8t4G0t3ZoG1uCByW6Ihde177K1cnbrIDhLVS6OZ6wxkZ/Qe4oppx9d9SS2Fr9SKPN6e2KDw8VNawo776T3S6SBHjvPROv+36lqb/eJqKfUqfSWyHXm3CDGVq0DPuvcLKF4jxuVwk3hPZp7nJS38dePFixomIgtrzWcwMlBypYFrA+bdkaZ+C2dZVznal0gyRSlUvWK1E1qOLZo+O+pEi9dop7KIX687/cdGPK6QdnYmZY9bTx7BvxENnueHjfm+9jzW5m+4ehRgwWq1kTlpvCP4sRyf0/TbPWxd9J4tsJYuOPB698tQ87Ni3K4sK+4VlYJDXEArHfg+Lb++sx3eWNNsxs9obM5vpKHe6aEfpbPmKeQMgRfa
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(366004)(39860400002)(376002)(346002)(451199021)(83380400001)(5660300002)(54906003)(2906002)(38350700002)(66946007)(38100700002)(186003)(316002)(66899021)(55236004)(8676002)(8936002)(6512007)(6506007)(1076003)(26005)(41300700001)(36756003)(6486002)(2616005)(66556008)(66476007)(44832011)(52116002)(4326008)(6916009)(478600001)(6666004)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1Co2y43biGmpV2BW1vibp+GHt7Q8UcvWmZEXmT681kN6vQKdo3p0Pm7QcdnJ?=
 =?us-ascii?Q?o3b8r/DRT1C1vO5dmW9yFE2SPwwdzRZ7lxR605zGM+MxPF6tws9JWawdTeSD?=
 =?us-ascii?Q?xXoNDXa3z9NsPwTBN7dGqm1Es+GhJumJEsy+EnWgM06IQgSDEMQuf0ESmi/l?=
 =?us-ascii?Q?nNkfWcVZ2gEGyhofb8XuvaGPBftrguMUYOkJUg0Ul508QPQWuW7GYipRXnqX?=
 =?us-ascii?Q?r45+p5qDDXNW4TxtLF4hpo8LwcBavESgkH1p6Xv1eolkxiIW5hZDnkSThzb7?=
 =?us-ascii?Q?1BWYoB/ycSUToYFPTr4qhzH/KdqXE/rHLoGk1kIL99T0phv8FcnY+6YhijW1?=
 =?us-ascii?Q?dvifhNpPcBn5MsIACHgnsq1bWi4ZKBPE1ebsfG/vXJR7oj4kcMAlfc+VpU/1?=
 =?us-ascii?Q?awxgJ29HM2g4yu/76ZtfqthNP3knlyHe3BfHrq4Lm88KpEdVCKATKtbMqXfv?=
 =?us-ascii?Q?eGQ0Bpf5L8UetghiwlAACDoABiTGOnh/pHxzLrUExvx+Vk8Hr0zPSsKaJUXD?=
 =?us-ascii?Q?85PlEONEmF0jBJx/CpkztuvsYhWLW2RJgHPOrLd0G8GQ0dZ6GA0tRIHSWnKk?=
 =?us-ascii?Q?o1Gz4LtYa8lfczpUfXyDLsq9tZPzFVaKtiUmdq8e4eClkat3PtdCYZrn7gi2?=
 =?us-ascii?Q?w7I+Z9a4CZI5+sGKdeqZTT81X9t67ICIaUA5K6DDiW9FUHkzESLoKdwrtOxK?=
 =?us-ascii?Q?ee7julXwgdLmCCayxyn1bA5XTiqtqIpnGj2Z3yIGbdTLv/pz54X3tzABg7hg?=
 =?us-ascii?Q?1UXl+v3teEpe17ER9niMOrgxUmqKLrygN2mW7rhaP8Em6f8kFU12D2LkJl0z?=
 =?us-ascii?Q?zOwGf1BZP1PkoArSXOwAcuuiphltltsypqLO1zmjXm5V2m91eXyb/BgYJTcj?=
 =?us-ascii?Q?BodIhCrXVlXmAbtziCV8tpDsQSjiGVAYnVxC5+iXocl0L4mJXoBpAD4flMZ1?=
 =?us-ascii?Q?AeFdU3fhUjb4MZDhYIo2tA8wllY4LRuFwPIVUXCJ1Mtz7WGbOUBr6GfW4p9s?=
 =?us-ascii?Q?CBrCNWwJGIRzZI0MkwLb7bb+XpziuSWot/m/Cwt85CqZSd1ihCvJGAEhNwhe?=
 =?us-ascii?Q?WHnw86blphbMgNHCZuq79DgYvh5ffBb8euzkUGLAr/DlwfVSSgVsfHWWDNuV?=
 =?us-ascii?Q?JSdHXHUYDTR+esra4WtGdVv0VCxOgJyNJZ68rhQXiaBh7xB/npjM4g7TqnN/?=
 =?us-ascii?Q?unSAIwmLJkU2K5uiJQClSUKsQRn+6gfTRJ8I0iFesQcW8gEP3rwKnrz19hHn?=
 =?us-ascii?Q?vpe7ah/VC36OjxcCGWKkiNxJ4s1QELQFW+P54wH2EmoRhZLNSXvLBAQ1IRco?=
 =?us-ascii?Q?4bBP/gxl6DlMkALo0BcPFLb/kSaqCPKLB5n2AiN2Um+ht+sJ+CantI53X8e8?=
 =?us-ascii?Q?CpyfpeFlTAZrPKaLjJXr8NOAgASU8UT5syAZ7RqBeS3f1CwHN67vKb4xzdO1?=
 =?us-ascii?Q?vxzWdRQwCDIZkUKa1rzG7zTkOtb7vdX3w2Zm3m3bEgsupCWUbAP/bIPu/MsW?=
 =?us-ascii?Q?d2JEZWf0vMue2rSh0NmXVpIvHfYlA85Mqsuw2+FG4mvuNrbrRDUfmWqjyVP3?=
 =?us-ascii?Q?D7MssoXhNK4GR6hHGOnPX7xk4S0ElBsQw+W/t7Z5?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4f3bcc4-461a-4453-d384-08db4cb677b6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 15:44:38.1752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KSJDhYA1CjNIyjegFoyuiRyOXLi+Ame54Ieu2qUf54xY2Xo+nU+LhN0MGx1m3t119ci78rjQ3gU/7uLgqGj44Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8262
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

