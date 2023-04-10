Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1ADBC76196
	for <linux-serial@archiver.kernel.org>; Mon, 10 Apr 2023 19:56:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbjDJT4S (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 10 Apr 2023 15:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjDJT4R (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 10 Apr 2023 15:56:17 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2088.outbound.protection.outlook.com [40.107.105.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D939E73
        for <linux-serial@vger.kernel.org>; Mon, 10 Apr 2023 12:56:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U+P/L+fupj7Y2QIks7735sdwYtTtPg4eHhQjQp2oJMhrNYu+B91sN0zcXfEVOmuKntxyTSekhzJrjJWj4t+i3RRdO/Nim9B4N4ypjzumEj9sTTVsZe563mnCPM6jP78tdY6M6Kw8M6/sUXbwOy4a4cxfGIjkVINB2AR6sR1D+P1UfzI3c6H0RpUrV+airRMTo9TPkk8J420EMXvZ9ALSK11c03F9ZlZwphCWTUTrCNdX7T7Gw1za03ogxiMjoYzCbtsMzG2iQ5vSoBfZ3C+JMJhv3Pa7+9xZkZ9FzWuOTeJ5Pp19RazkyqsYUcf+6w9Ehj5BnDb9rHvN7/HlISoRMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5qZsysnO77TeqFgBApIGGVaChr3GVGs9G4IIH3JON6I=;
 b=liuFo9VOFZ0SirriwvsqFZroMrDc2tPBV2prwypgDXtFMEQSGnKV9+Sj4gQZqZWxoPEqAVOmiP7M6o58a8BKOAYK/05Fdai5It4nIB9ADr7fn6Sby5g9OkB4GGON/MjGNSdhkAdEY8/SaTj24fh0LYdPcd6VlGmvxJ5FnGGHvo9HrssFukd5dLN2Rp8s4nMbvU8Cb4MFmazK2g1+xryRIBPC96+YFo4AcILLzvzWJA6glamcQ813BJaG29HZiCFFGGmHVkMkIxgSd4lRZZE/EM6THb4EhXYg3eVLpDthCwSljUXTUNZMotEkWqK2jUt9mAtzjozes/mLoIHEdNffCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5qZsysnO77TeqFgBApIGGVaChr3GVGs9G4IIH3JON6I=;
 b=SvWu+LARh26++qjkH7ZipScyo8dn+qcw/kB3TU/4ovRa0qW6eA9ZMgY6AYnwqL9ljZl4Acd5edxfjx7ZG7Wt1829Lin/xY4f7B8VJ9eorEz9XXM1Qk16qNolPgz/2Hp6JcU5U2oxBsGALlI/ZhktoHH3xRJMVEs+DYJrXIVxf9Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by VI1PR04MB9884.eurprd04.prod.outlook.com (2603:10a6:800:1d0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.36; Mon, 10 Apr
 2023 19:56:10 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::28fb:82ec:7a6:62f3]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::28fb:82ec:7a6:62f3%3]) with mapi id 15.20.6277.036; Mon, 10 Apr 2023
 19:56:10 +0000
From:   Shenwei Wang <shenwei.wang@nxp.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>,
        linux-serial@vger.kernel.org, imx@lists.linux.dev,
        Shenwei Wang <shenwei.wang@nxp.com>
Subject: [PATCH 1/1] tty: serial: fsl_lpuart: adjust buffer length to the intended size
Date:   Mon, 10 Apr 2023 14:55:55 -0500
Message-Id: <20230410195555.1003900-1-shenwei.wang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR03CA0030.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::35) To PAXPR04MB9185.eurprd04.prod.outlook.com
 (2603:10a6:102:231::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9185:EE_|VI1PR04MB9884:EE_
X-MS-Office365-Filtering-Correlation-Id: 42eeb9b5-d31d-4d4b-f00b-08db39fda147
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XZ7V16miS5f1ckY+KVYhL+B2RnW3NRWX4vnd0C0m9RNtHNBuhyM8N+tFww0CEd7Jgcl/hFh5SPvwoZCa5od/5GKFGVAws4nI3YfxHf4TCzF5eLo63gLeQO6idqeLhHucWMBSDKQVIQ8jJ5GEs67DOlbpvQAC+fT4mODXPPZ6rFa1JqvQhg0Wu2sJpVZ31UHhXKEhk7sVsW0rTiYtzf2c57oO2bL6uyrCLvN+EB6+K2I4qEEq4fvSItxcDGpL58kGGWFPrb87F41YAB3ia9s2wbvnTxjNl2lBkfXSw67EMWuj+o/uVxFXMggDROPyB8ds8+fD2DbO/am9zNgNZbZLT1TFExjNcrhnQGnViu++zOVLS1cqaAhZMEmyFdh7fonhTBk8ZkckbKXAoqvwkFY+RdBmw+V9FKsKSbBsA/GAo3FPJgBJ8WcZ2ZqjCHoMPOOIPqC584mayx4pMUjOksev9muo0lnfFnQvr3wC/RUxQzt7jtn3ou3jjmvsklYlE+3KDd4HMSls93JwuzWjMXXCUhMDIMdYe6KrmcS5BDKrBXFM380X9waocsgskjD0JRoqdWFHtnYzQ54EUndl+o7UUiYLwo942pqtDIxBcO+PYLh058HS+667MXx8ttgpG9bf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(346002)(366004)(376002)(136003)(451199021)(36756003)(86362001)(4744005)(2906002)(2616005)(6666004)(6486002)(52116002)(55236004)(83380400001)(186003)(6506007)(1076003)(6512007)(26005)(66476007)(6916009)(66946007)(478600001)(66556008)(4326008)(41300700001)(38100700002)(8936002)(8676002)(38350700002)(54906003)(316002)(5660300002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?W9LWM8PhKd02aibQanyd1i6wWFRfU3X2E8LSlcgSwsS7gUjTPPAlPuBgWyzt?=
 =?us-ascii?Q?8us9MuopCK+CgbQIbPk348WFoYJDAy8Y9AX6ybfw8lxyvtzUtoJXIqOe2pgo?=
 =?us-ascii?Q?v02lRy4pfinuJyCqNvrpYBiWp0KfMIiquoMXhIXKA536hgPgRFiTlUG9uwe2?=
 =?us-ascii?Q?9OkAMswpkwU/WER6duU3vWAuUOr4mMxBfBmBg1fxcwW3AQ0dBRtwChx56OHM?=
 =?us-ascii?Q?K/cYO976KsKajhJfdpPHL5FMpRrtaOEmT+WBnTcnCfwOcYogor/1BsRsuMek?=
 =?us-ascii?Q?HT3UL4MmupZ/QZuw9jGnYbI2QB0SowJL0f456EHViOh6LF9GhX6BHgVhg+5X?=
 =?us-ascii?Q?7jInM9lzSk/sjNWGpdGk4Nx2iBedTXqokMNC+iOBX9WtHLhPtKbISyPnPgU0?=
 =?us-ascii?Q?UfDSnWQLLw/RZChpuazFfVadhsb2uPFnJ882zyT+mLzxF6ZWXHKg2nYewy9s?=
 =?us-ascii?Q?Uqz9Y9zLtJTDF2C/tuvOajt73DODQwnGBPehNgH/8xb5C72RUI4OSCWfcvOr?=
 =?us-ascii?Q?4O+D2P4OlS6eoc3gKiQbCmGCEW1MPxFX1/RV4XsLUbfvVH+BHRX1p8t1iskx?=
 =?us-ascii?Q?ZhkOtAh7LvKff7UqR6VjG1JzQ9nNAMWrLGqKbdZwEE+RGXiafveKUxRYxwy1?=
 =?us-ascii?Q?yD/eBNmTHcKwb/kFhRLKTErzHTsXguwzqq9oFDO5w88camXB5A0oWeF1vYrN?=
 =?us-ascii?Q?60GaQFHQpfYI973qXeoN3K826onUaG4RNGbbSCRha0BYCNcX0yu5kdAZD8Ya?=
 =?us-ascii?Q?N1MpRtmhUxdkDIyGVTYCZ7KxQyyRmd6iP4KfdGdIIfKQOxzi0Kd3/oSh1qMJ?=
 =?us-ascii?Q?/h7FTL1RcYykrmnAHMSSfmAGgj2K1SO3RCQBfhPpNLN465OQ/meKbcd5Yuku?=
 =?us-ascii?Q?Eu2IovPUv049wMxD9iFIU01BA/eOC3A/ydXmSE6fuIWtZS36jdni/q/mr+3c?=
 =?us-ascii?Q?BR3/h3HL0ZkQ2QonfJLav/JkoJiKOqjMZ0H9dyIiDxGlkygCQndiNtf64yGd?=
 =?us-ascii?Q?gegxFI2dPTx94qhEso3AIM+NvPi7LKkj/IMHZN4fedKyzPw0oVXFiCYA+lJl?=
 =?us-ascii?Q?gB0gb++3Nh8Sy3BeKd2SlU5ryXs5y/kmjc4qjkoY44suwRjvJQYxH/LyALjv?=
 =?us-ascii?Q?+q79tXkwX8FbIOP6GIQyWdIIKScpny8doF7JNs0Fph+XMPBGAlxuML/6SeF/?=
 =?us-ascii?Q?ghEddGCr88cHzNb/K3KpnlrWcoTO6kdTYM9Wh5u1TTVrbReFHzt2/iEapuK7?=
 =?us-ascii?Q?HaonPkc05WeqLOuDzDbUWOj1LQmvEscuy1UuZaI4FduBAB7QIqYSnZeix3BR?=
 =?us-ascii?Q?co6nP+5Sv81GwHg7rIikAi2/ACjusI3Qy7kBJp0Gd8Z+lRmca4EETl8J47AA?=
 =?us-ascii?Q?K1HwkB2kEQSp8BAs2rr4p+32/Rq2VrwuccCZmUkwK4LmqpaP9fS9j69ezOjb?=
 =?us-ascii?Q?bHoXwAwGKJOpBcA9gYsZTvLpQafWtb4TXAh8OK/uf6P5oudJ0SSQ5F62Q+ik?=
 =?us-ascii?Q?ffVxBIFCzNfie1uKmSz2MsuNV1tkpw9bzR+ZotOKphdj9AuwKgrp8YGmXhGQ?=
 =?us-ascii?Q?AsyoU2zF2e9AW+/t8eqaGBUpPxojmCGoeIv8CdHN?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42eeb9b5-d31d-4d4b-f00b-08db39fda147
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2023 19:56:09.9894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HlVrwG9hbsTGqtD++EvJX5oApB/VHbbSMfv/vJi4CiDA9P60gDQTDMsU1qrQbXgrxG6rLu/X2pxj3c1satvSfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9884
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Based on the fls function definition provided below, we should not
subtract 1 to obtain the correct buffer length:

fls(0) = 0, fls(1) = 1, fls(0x80000000) = 32.

Fixes: 5887ad43ee02 ("tty: serial: fsl_lpuart: Use cyclic DMA for Rx")
Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
---
 drivers/tty/serial/fsl_lpuart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 074bfed57fc9..aef9be3e73c1 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1296,7 +1296,7 @@ static inline int lpuart_start_rx_dma(struct lpuart_port *sport)
 	 * 10ms at any baud rate.
 	 */
 	sport->rx_dma_rng_buf_len = (DMA_RX_TIMEOUT * baud /  bits / 1000) * 2;
-	sport->rx_dma_rng_buf_len = (1 << (fls(sport->rx_dma_rng_buf_len) - 1));
+	sport->rx_dma_rng_buf_len = (1 << fls(sport->rx_dma_rng_buf_len));
 	if (sport->rx_dma_rng_buf_len < 16)
 		sport->rx_dma_rng_buf_len = 16;
 
-- 
2.34.1

