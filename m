Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3E8BC432BE
	for <linux-serial@archiver.kernel.org>; Mon, 23 Aug 2021 08:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9662461214
	for <linux-serial@archiver.kernel.org>; Mon, 23 Aug 2021 08:18:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235353AbhHWITk (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 23 Aug 2021 04:19:40 -0400
Received: from mail-eopbgr70044.outbound.protection.outlook.com ([40.107.7.44]:60555
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235316AbhHWITj (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 23 Aug 2021 04:19:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VO4IQrpZIFuUgISq8jllbh/4T4oyPT52jNtGeuH+wVCZj3QHspirxvXRTUhbfElWeR+MA9ODUyahAo0uMAzuABp0iKrN5oWg2DRjKqbIyN7WZshdMFGyF7a4FmIkGiqU0utELHe1gtEcyWZv6710IS5z6KKqSC9UgCRJHskMpXl2DIhjcV0GV4eUL34mxAnTJqBM8orFDuB3PJ2wGKVYnGA1EXNR1w5YC/dMJKfRG/xbMWwf/i2TOSmR+ViTo0lllIEP/ALR1JrLA185c4jCLIkoA6+FGoeQpkorg7+gRERBczeFqFUYKyb4HbPu5rMmWLxs3BV68aLoOiGtK0OHyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O373SYE6fdpq04V86WchJ7I8CmnyhAo2ndeZGg6ohL0=;
 b=l9DC78aPMK9JBmX9yxKuDFf8bnA96g7ZDQBZrHcp1NrLwIub/NHiBWD+OMxSJUe0o4YsgNQtNgRRn1OjgYwUHgUifkorJ7kyyarWkt/v4hAwtYVM4E87sCB224ClYtkTuJrdLpYNSP62Xdo5+dCKWVgj9OYVZyeT6NwNn+XpSYLQegzz4SXjjq6pAMYcjoQJwD3mWQwQzLVSQpAiqEsSymACXq9RsRaHbeOYv4CxAWb5bhrpOGdZA+fEoOBWEkic8BfTUP5lSKmlnPX9RRMvfW21MKZO3fODYofIyYziy2EIuF7AN2YM50RDYmdYereyGKR8dKwWZ+96Eu8odybfsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O373SYE6fdpq04V86WchJ7I8CmnyhAo2ndeZGg6ohL0=;
 b=LMcoj8E+uFLdFjJRMh112UnyMdDew4fS29f4ygspNOMzGFGo8+tXyYud4JvrHRR+x2qnNRsbzNbH/w7At/EoX3C6kqdkO28KjaVbHtjvi8CkK57J0c5AnXd9QEJGsu/gQQI0U24iF4xq5aXfSau5X+20pq6PL8SPd9NzXjLtiGg=
Authentication-Results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=nxp.com;
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by AM5PR04MB3172.eurprd04.prod.outlook.com (2603:10a6:206:c::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Mon, 23 Aug
 2021 08:18:54 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::3425:96f2:c80b:1e03]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::3425:96f2:c80b:1e03%8]) with mapi id 15.20.4436.024; Mon, 23 Aug 2021
 08:18:54 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH] tty: serial: fsl_lpuart: enable two stop bits for lpuart32
Date:   Mon, 23 Aug 2021 16:17:33 +0800
Message-Id: <20210823081733.31941-1-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SG2PR0302CA0016.apcprd03.prod.outlook.com
 (2603:1096:3:2::26) To AS8PR04MB8404.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f8::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.71) by SG2PR0302CA0016.apcprd03.prod.outlook.com (2603:1096:3:2::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.8 via Frontend Transport; Mon, 23 Aug 2021 08:18:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 45d91367-28b4-4a54-bdac-08d9660ea5a8
X-MS-TrafficTypeDiagnostic: AM5PR04MB3172:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR04MB317277392675DA94B84F8BCF92C49@AM5PR04MB3172.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iUpgD1fvAdPOBie5ef+AtAucMatFCBSoAaW905W5vpzARCot+6G3d71bNYkLBSaVtGsCPVs/b43LO3fYjrWr7PQuYv4rECFUhnsKfqUdM8YdklpJbUEC/XJW84MDseP5R9qBQwsU+l99Sajn2tiZuYwUHRyaA+5NFQmwVRCxIS9o5X/swIfHvWHI2zbid37F1ruXR4iHOycdrLFE91M9cTYPlQU9+OsgC7ul/nKM/xbRGfAKR9kP4CGEPHeEOGGZGDd2UvzNR00o+VLrltz29iznOQl671OeYfOLyv0OwqFZktVA0/7zLBVn2kEq//hPqYkdAe7D2mi3YGZeoPH8yB3xOiXo9xTT9xUiqYE9WPIMCm/ZEyTK68HdlRRD850Pgp2U7SOkWzSXyPlJp+a94tweCsDndXGe9ON/1eVBP7DV2QiFkkdIRsOlyOHULQkhLe7PkAowlibS0kkGtTZHBiTHSOK8sU+lje1DRV9et/DpOqOI40+81bW/RaeASdH7+KSqhsW8hJsC8v3JJ4Y/Q9CieQuEcCqAofiZc+XVOijVYzKEg/bAJaWGzw13kRpcz8StpBAwdH7KYJAqoDrq8Z4exwJuQXVzwUVbjjJX89Rn4tjIM31ZMA7xdcDYLBv/nNFn3lk+sWloZnFxW4w57v838gbLCqHlVyoEERP6pVLcTgrOCO0A52gYhMw0Ybs/Fly09uVJ4ZKA/I8UVVw+Lw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(316002)(6512007)(83380400001)(38350700002)(38100700002)(5660300002)(6506007)(52116002)(6666004)(186003)(8936002)(1076003)(66556008)(956004)(8676002)(86362001)(44832011)(66946007)(66476007)(6486002)(2906002)(26005)(508600001)(36756003)(4326008)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YXKKibpKRz7uSJBIiRPqgrpVbkyIzgsrH3ReDh2v85fpQIT7xjAfDEGCZo7t?=
 =?us-ascii?Q?2dUIBKwxl/t5CX2xOkm/m/zDE5+AvojxwqmPwyGgBm/ihHg3uKr/lS4L3X9w?=
 =?us-ascii?Q?F+02yv9OViMpxj63QeufJYkZ9AK2IMwPTMSZOOna0dMecbfhbC0vSPKoZ2Rl?=
 =?us-ascii?Q?XwkFFrAkZ6LejhIdB4Zn4KqnQpQMb7isTrCZrNLjmvWZxJWWW6pTgGgHuTqh?=
 =?us-ascii?Q?LPL+glAazUXnLeVkNqxHhRVqVad4W5xpnwriaq7p32Yickaxep9uLLLvCO6G?=
 =?us-ascii?Q?uhcuzmq+OG/rCugQZhPIPIv5vHHJDuAJNFZKGUsHsLuy/+bKcIYfGTmj+QcW?=
 =?us-ascii?Q?s2Biq6cOkYmSjhAjAiuHaua2br6XsEZFofQOQgiuLhJOcInd0yLghR4CJjHd?=
 =?us-ascii?Q?kvynQPmsUN4Ybqqp2ot4jiwUMzNLS9CCE5QCCgV3/c74DRHF6EtJm1qjyPOU?=
 =?us-ascii?Q?DQzpyQM6VQ0kQqeV4ezBziLlX0pn44C5xzOw8gPURdgX+hC8HI/NPDvO7nRw?=
 =?us-ascii?Q?64vE1BHTzKajCDUup2Cw3a03MrhbrSUakCZvnJV0SW9XMx17Y2E96M6ZRT+Y?=
 =?us-ascii?Q?VeLaYzGpvW1ozou7AhM+DxR0a86KLbIjolaF8X+fcl/rIoqRASLtalnJHKVz?=
 =?us-ascii?Q?1vYIWgENjrjKNYEKLzP0bwu3YfRknMZji/noLJGkeKtHQW6ZBc1zwOu+MwfB?=
 =?us-ascii?Q?7nIvcWYRL3UbCOctQzbRoltDPPBvI2HT2a9Sk+llRH/kS6Y7IKqeSf2818pt?=
 =?us-ascii?Q?oLfvC1U5ILHjnsQEWNgDWcDaM/FjuWs/gBDtS1pxE01Jj+zPIOmMeG4DHBV7?=
 =?us-ascii?Q?7Jg6WVekg9Hs9s3v/oxoxfSOm3gFq6cY0CEZK7R5T062fgYjhGq2MddFc/Wa?=
 =?us-ascii?Q?WGBq3sLMlPkUZSjiDbldPehg2aBcnbE1Q0ADcq0SKi5N8nmx0HHHcKKuRu26?=
 =?us-ascii?Q?RfKvNcNHCnzDWmwNLOyLSd0IRV3x/2Qy4w1Pt9W1IW6ZeUYQfvDATYuzWXFL?=
 =?us-ascii?Q?2+KE82G5FaVhAa9KUxIGPcrB2fQhWrAq/t00xDcoghHuipkgCNJ3XSBT6ZJK?=
 =?us-ascii?Q?FCLbhH6VUwfd7752G6DoBXRXzFyOLGV4LByEUiVPHvRUSnxasCji6ePJbkoj?=
 =?us-ascii?Q?qB8YytocnQakvj3rAwsHAKGv4d5iWA7d4a43bh4OirEOhviMk7HfYPlREm4G?=
 =?us-ascii?Q?X8Fd0LgZEIS7llikUvWcFHBmSK6tjnINlT+0xhupWEPkUPTK+tVC0a+qpfrO?=
 =?us-ascii?Q?bOIcTWefrJO+OHpf21jLEqw9Og6U7gvRxBZbsPq6w5knGPScC/CDh+EOwcFK?=
 =?us-ascii?Q?MU6p78l/GT2FxOJ8WuYUv6M6?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45d91367-28b4-4a54-bdac-08d9660ea5a8
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2021 08:18:54.7417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Be8I1xhE5J2xsra4mym6F6nsu6gD4D7jjloAxfOIKKwFpgyLAwAKvZ/0zCR4Z7F80AhYj+xpLojTyKmDIT6n1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB3172
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Fugang Duan <fugang.duan@nxp.com>

Add two stop bits support.
User can run the command to enable two stop bits for test:
stty  cstopb  -F /dev/ttyLPx

Signed-off-by: Fugang Duan <fugang.duan@nxp.com>
Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/tty/serial/fsl_lpuart.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 117e011aff5f..55097e068908 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -2049,11 +2049,12 @@ lpuart32_set_termios(struct uart_port *port, struct ktermios *termios,
 {
 	struct lpuart_port *sport = container_of(port, struct lpuart_port, port);
 	unsigned long flags;
-	unsigned long ctrl, old_ctrl, modem;
+	unsigned long ctrl, old_ctrl, bd, modem;
 	unsigned int  baud;
 	unsigned int old_csize = old ? old->c_cflag & CSIZE : CS8;
 
 	ctrl = old_ctrl = lpuart32_read(&sport->port, UARTCTRL);
+	bd = lpuart32_read(&sport->port, UARTBAUD);
 	modem = lpuart32_read(&sport->port, UARTMODIR);
 	/*
 	 * only support CS8 and CS7, and for CS7 must enable PE.
@@ -2097,7 +2098,9 @@ lpuart32_set_termios(struct uart_port *port, struct ktermios *termios,
 	}
 
 	if (termios->c_cflag & CSTOPB)
-		termios->c_cflag &= ~CSTOPB;
+		bd |= UARTBAUD_SBNS;
+	else
+		bd &= ~UARTBAUD_SBNS;
 
 	/* parity must be enabled when CS7 to match 8-bits format */
 	if ((termios->c_cflag & CSIZE) == CS7)
@@ -2167,6 +2170,7 @@ lpuart32_set_termios(struct uart_port *port, struct ktermios *termios,
 	lpuart32_write(&sport->port, old_ctrl & ~(UARTCTRL_TE | UARTCTRL_RE),
 		       UARTCTRL);
 
+	lpuart32_write(&sport->port, bd, UARTBAUD);
 	lpuart32_serial_setbrg(sport, baud);
 	lpuart32_write(&sport->port, modem, UARTMODIR);
 	lpuart32_write(&sport->port, ctrl, UARTCTRL);
-- 
2.17.1

