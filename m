Return-Path: <SRS0=K8LB=D6=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D17F9C4363A
	for <linux-serial@archiver.kernel.org>; Fri, 23 Oct 2020 01:34:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50AF4221EB
	for <linux-serial@archiver.kernel.org>; Fri, 23 Oct 2020 01:34:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="j1NaE2QT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S374315AbgJWBeq (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 22 Oct 2020 21:34:46 -0400
Received: from mail-vi1eur05on2066.outbound.protection.outlook.com ([40.107.21.66]:42208
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S374313AbgJWBeq (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 22 Oct 2020 21:34:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SciEahLJFDsilatKfQ/kxgsTND2CPSJoHFzwKXd/NxpbHGT/XYnJoBKTjxSOqTfsE5BamVkkANM5lc12Qf3GH9/od/JdD6L6okneOvDkN+OtqYAT3YRQmjJbyUDSZCMdh0yIafCyoRzAcuj9P+DmF7SaCMWN7iVM3McKkeudV/9YDBjKgcp7fCzj4LhZQdG6cBfHn3/OUGSYCupAgRPGyvSSiwX6cGx8O55/Cq/Lwb7m15W/GPU49tkCtMGZTDbDevMGAkTc4xRtlFQNgRdvxrUZQCSYx3cwO4A2qNDtZ13MuUtLS2ToSRjMwutfSbP+O4CAE9LJk4BGhdjov2TXOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qAN91Vjb6jjWx+sd0ntrCGdspgEFE3Db3pRk/gbfQIs=;
 b=RpPOFK8y5+QO0JvNAFFSTBZ41K7oe6ZyqlLIeYuswMOYbCaLXzZ+gzKFUc9znsDf/KD7Tq1ajXOZZpY8kbk3lEqVxZpYHbkbU/JR2JrvdYtHMFVqRCntszORehntw36TrOSEMg8TWMOpQTnvO5q70YG/iHa6z7N7Xrn9cZQkLtkpgl5ngtVtGdFEjAsvDF1+mWAqVFfmN2bcJLpDZB+syb1p7zgmoN7cMZz5QyOVD7HaEn1QbBE/51ZUdoyv8cGxNlKg6S3nfEIoasu7nux6ab0RSVw2bIAlt6fz40ijYlmc4B0tG6Z/hHJVMnM3SAhIjxLIRiymZ320GoBgTq8jwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qAN91Vjb6jjWx+sd0ntrCGdspgEFE3Db3pRk/gbfQIs=;
 b=j1NaE2QT9+RtskeRfoVwbslKnnswatsfgXzsk4+q6YdvJoZE3GP1SBWuqGYZnJrUXnlL+SKTTMQLU9HUg3tW70lUfd69k6ksYbpBxMOyPNrJxDH1Hnx18FUbSYqWO0d48Xhb2q5iOfP/9LSuBEx8XQIFQPX1jVhRwRPQQuQDyUg=
Authentication-Results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=nxp.com;
Received: from VI1PR04MB5696.eurprd04.prod.outlook.com (2603:10a6:803:e7::13)
 by VI1PR04MB5503.eurprd04.prod.outlook.com (2603:10a6:803:d1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21; Fri, 23 Oct
 2020 01:34:40 +0000
Received: from VI1PR04MB5696.eurprd04.prod.outlook.com
 ([fe80::983b:73a7:cc93:e63d]) by VI1PR04MB5696.eurprd04.prod.outlook.com
 ([fe80::983b:73a7:cc93:e63d%3]) with mapi id 15.20.3499.018; Fri, 23 Oct 2020
 01:34:40 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Fugang Duan <fugang.duan@nxp.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Walle <michael@walle.cc>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH v2 tty] tty: serial: fsl_lpuart: LS1021A has a FIFO size of 16 words, like LS1028A
Date:   Fri, 23 Oct 2020 04:34:29 +0300
Message-Id: <20201023013429.3551026-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [188.26.174.215]
X-ClientProxiedBy: AM4PR05CA0009.eurprd05.prod.outlook.com (2603:10a6:205::22)
 To VI1PR04MB5696.eurprd04.prod.outlook.com (2603:10a6:803:e7::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (188.26.174.215) by AM4PR05CA0009.eurprd05.prod.outlook.com (2603:10a6:205::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Fri, 23 Oct 2020 01:34:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 772c9e55-d11a-4162-91b7-08d876f3cf3e
X-MS-TrafficTypeDiagnostic: VI1PR04MB5503:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB55038ED46F8048D0F16E1537E01A0@VI1PR04MB5503.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ONuMLLP2/zxUk039x1dd5pqqhgdV2ghGU/5JyevMVj8cCrYIlp41pnRmNiNc7gYspQd6YaS2G9qsv24vIDpIzhsdi/mxkPbKQhaj9ZhYgd8ELA36Oxqvhvg369vUY+h7zQbyNq56rJiWwRz9UAzI+YSBiCia2KxTZtLERCi2V4hfWjvXzZK30/YBD4TtoaeLjhwgy5pWeLwK/dKfelGCt4bEIaTnnGYG5uhm9Yf/5vzewCfVZsZt4ppRcg0lT79COUEGG7aJqxBJulc+ygufcOTCiw07bepe3lfXoL7NsD2ZN+d7Ke0tnQPirjMkRYSVil9C5OvzvHaNkd/p+00SF0omWEr94Zq9G5tT8wQ1spD/oLnOpgSGm0Co3Wakm98d
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5696.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(366004)(136003)(39860400002)(396003)(36756003)(44832011)(69590400008)(8676002)(2906002)(6506007)(316002)(110136005)(5660300002)(6636002)(66556008)(1076003)(52116002)(66476007)(186003)(956004)(83380400001)(2616005)(6666004)(86362001)(26005)(66946007)(6512007)(478600001)(6486002)(8936002)(16526019);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: R8Yl390EqU7M5UlDahpqD3wHsObDL7w10J3pJuaDlqeBoMwD2RwTCtsjmOzZtPxpL3yhTletCdCQI2s12hxno2X5cWf/G7PCu6/1FMMCiP/h20pUp1VQO5NezYeDRW93BDEFTOWs8jSm7mZJppDG+BCLnsvMplpqOjhhMg0gJEN6QOPmWe8T+fZaNB3twMWwuob9hxHK06U/65ejRTHRdA8zcpbo2uczM/43qupz0dRrGOvrcypo6IkdisMK/re/8eZEJFrWT+B57UtKM5BIcCQx/F3n7lnvzy2L7mYJ2xj1tYXzrRdolVyAHFJYbnsmFySHpfTqCv2aiaoYWLYfOpslARnl5r/Ps+vJWTPkAfm6vBbWr1f4dNS4IS8ql6WZGO8eVwci5eW9fv+L7vwi41LNuhE0YPUGM8WTrrFSjMVmC7On0ib6kl8ZNnb0Lo9Ssh2OYeA97RlUyOcDUonjadaeY+gjuksDMKHIysoqhq45v4G4PJFnVjjeydpgJyB9iTS6uDmEddCmNI5wu5pLkwLngQVEx3XtGBN6evwUx9RNtpmQ/fgaQ933J/ye0hLLpJ+tyJf2oJR7iU/4rCLiHE9sqnqCMwAkjYxN5ffi1725YRh1Fwws+nu+YPgl6w6gf5gzm6nxnAAh0fQAPZeIUg==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 772c9e55-d11a-4162-91b7-08d876f3cf3e
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5696.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2020 01:34:40.0739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IOaTlsKAaSSpnBsZD6IFQLrOKrjhiRBEOUDc92jRaJStsxeQar4iTOZvtQarPjtGUVDvtoNwiibCLQ+z4QiOVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5503
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Prior to the commit that this one fixes, the FIFO size was derived from
the read-only register LPUARTx_FIFO[TXFIFOSIZE] using the following
formula:

TX FIFO size = 2 ^ (LPUARTx_FIFO[TXFIFOSIZE] - 1)

The documentation for LS1021A is a mess. Under chapter 26.1.3 LS1021A
LPUART module special consideration, it mentions TXFIFO_SZ and RXFIFO_SZ
being equal to 4, and in the register description for LPUARTx_FIFO, it
shows the out-of-reset value of TXFIFOSIZE and RXFIFOSIZE fields as "011",
even though these registers read as "101" in reality.

And when LPUART on LS1021A was working, the "101" value did correspond
to "16 datawords", by applying the formula above, even though the
documentation is wrong again (!!!!) and says that "101" means 64 datawords
(hint: it doesn't).

So the "new" formula created by commit f77ebb241ce0 has all the premises
of being wrong for LS1021A, because it relied only on false data and no
actual experimentation.

Interestingly, in commit c2f448cff22a ("tty: serial: fsl_lpuart: add
LS1028A support"), Michael Walle applied a workaround to this by manually
setting the FIFO widths for LS1028A. It looks like the same values are
used by LS1021A as well, in fact.

When the driver thinks that it has a deeper FIFO than it really has,
getty (user space) output gets truncated.

Many thanks to Michael for pointing out where to look.

Fixes: f77ebb241ce0 ("tty: serial: fsl_lpuart: correct the FIFO depth size")
Suggested-by: Michael Walle <michael@walle.cc>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
Changes in v2:
Reworded commit message.

 drivers/tty/serial/fsl_lpuart.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index ff4b88c637d0..bd047e1f9bea 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -314,9 +314,10 @@ MODULE_DEVICE_TABLE(of, lpuart_dt_ids);
 /* Forward declare this for the dma callbacks*/
 static void lpuart_dma_tx_complete(void *arg);
 
-static inline bool is_ls1028a_lpuart(struct lpuart_port *sport)
+static inline bool is_layerscape_lpuart(struct lpuart_port *sport)
 {
-	return sport->devtype == LS1028A_LPUART;
+	return (sport->devtype == LS1021A_LPUART ||
+		sport->devtype == LS1028A_LPUART);
 }
 
 static inline bool is_imx8qxp_lpuart(struct lpuart_port *sport)
@@ -1701,11 +1702,11 @@ static int lpuart32_startup(struct uart_port *port)
 					    UARTFIFO_FIFOSIZE_MASK);
 
 	/*
-	 * The LS1028A has a fixed length of 16 words. Although it supports the
-	 * RX/TXSIZE fields their encoding is different. Eg the reference manual
-	 * states 0b101 is 16 words.
+	 * The LS1021A and LS1028A have a fixed FIFO depth of 16 words.
+	 * Although they support the RX/TXSIZE fields, their encoding is
+	 * different. Eg the reference manual states 0b101 is 16 words.
 	 */
-	if (is_ls1028a_lpuart(sport)) {
+	if (is_layerscape_lpuart(sport)) {
 		sport->rxfifo_size = 16;
 		sport->txfifo_size = 16;
 		sport->port.fifosize = sport->txfifo_size;
-- 
2.25.1

