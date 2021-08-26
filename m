Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 591CCC432BE
	for <linux-serial@archiver.kernel.org>; Thu, 26 Aug 2021 19:26:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F2B260FF2
	for <linux-serial@archiver.kernel.org>; Thu, 26 Aug 2021 19:26:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbhHZT0z (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 26 Aug 2021 15:26:55 -0400
Received: from mail-eopbgr60045.outbound.protection.outlook.com ([40.107.6.45]:5604
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230008AbhHZT0y (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 26 Aug 2021 15:26:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KBVE1pPGKmTbMOQmYWja3Idewd/DMwjcSE2b6LtvP4oeVMUmzJObIBxwnxA7F41VE7KOe5YvGxDS/lQRU3/EW5r31yJfxCmeL/CpdKKMdll72I8IjKmyOOYrujLjwM/P64MZ2hk3bDpaxR0UnuSFALvoxpjAFpCHfj+2616q6sBrp19pTUwn3g8HpX9py8BjOJDgSh+pLPWoOhVQ48khwJT2NwuOHIn2yzGTt/bXG28vbYEmcJ73Tz+VR/TCfN8yw9gvh6dMbbzzn32H31GAEGjjlk3QQOmnFbNMjXQ3dzrXSyqrZaYXDZyHqv+msyUzzYO/MMPk75GbOB2RXZYltg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4f8MZasYe4nhS3nwiJw1d2V4mgHTZqg0+gKaX673WJU=;
 b=ePb5EDhgWlzCAmaGwhAvVcMldYVV5YpSQPRVGQKZ+iGkrD3fZqacGnHVHcYGUe2qv3NSlBl6gCU55Ca4sI8frim78wistpfzh7BE8AxzD1f7Rc0BrRDycuQTZOV7cHa2+XdJhd9tJln0GLZuqyVUAq/0PFTHWk+ZovxqJmBGbOQmMuo6nBMncnqSKOV/zy6hPYz15muLKkpGxdaU7+YPQOFrq8xoRwFZKnQ/egkrEUpSnPse1stP9gBs4xApHjDFdDkkT4BQ7vjOCECyoH/wqBI1VuCQKyFInp1Ytf5LAIlTmJAo6On4ilcnX+o3gUYvpewxpE1h2VT34EidX8sSNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=secospa.onmicrosoft.com; s=selector2-secospa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4f8MZasYe4nhS3nwiJw1d2V4mgHTZqg0+gKaX673WJU=;
 b=L+93JAFK3k0y2aiMwBe4TxCZbTugCoOcwTWsURWppijCSIDfUZRl1kk5UN1zZC+dVq2shjaLQcey6KtrFi7fdzWdbv0qVNzdPLxa64qt/bzZn89T58bZZBM748K0EaUaRDg8tH/SRi75irYvQcqj5NPRrQQ5dHhlYrF/BmVzTW0=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by DB7PR03MB4859.eurprd03.prod.outlook.com (2603:10a6:10:33::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.20; Thu, 26 Aug
 2021 19:26:00 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::dc6c:815b:2062:d1f1]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::dc6c:815b:2062:d1f1%7]) with mapi id 15.20.4436.025; Thu, 26 Aug 2021
 19:26:00 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     linux-serial@vger.kernel.org,
        Peter Korsgaard <peter.korsgaard@barco.com>,
        Peter Korsgaard <peter@korsgaard.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH v2] tty: serial: uartlite: Use read_poll_timeout for a polling loop
Date:   Thu, 26 Aug 2021 15:25:49 -0400
Message-Id: <20210826192549.3203071-1-sean.anderson@seco.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0207.namprd13.prod.outlook.com
 (2603:10b6:208:2be::32) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from plantagenet.inhand.com (50.195.82.171) by BL1PR13CA0207.namprd13.prod.outlook.com (2603:10b6:208:2be::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.9 via Frontend Transport; Thu, 26 Aug 2021 19:25:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b183ccc8-b3e4-4f3a-d139-08d968c75627
X-MS-TrafficTypeDiagnostic: DB7PR03MB4859:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR03MB48592226C38A20741CBB385596C79@DB7PR03MB4859.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1148;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aZagetzt6OqyyoufZpyLwPSnO46gyMP+Ea/c1J0hIx7RV2K2KJMWHogZ4sLMRo/lQvRFagEl0N9Gy1dsIPrMsDwk2nRxnT7D1/h2UcX7Eim7Tm7++K9aMV8dVLytFUarVm4ICTKx9JpgZ5VVF8drWuDYIH7ZVWHXj088rbjYLSNPpKiI6cNKuSLfBOPOo4+SAx8bC9p+++jFrJrmyGwnhIE0JZepLrBTbxbRQQ+QicvdxrRlnPodLQqyZE74XeFsrOfU89Lj3vwSyoO28cwfpNaJzNaTvznuVpWoBuRvxUCozH7tgzqeUmAA2ExsIkAkEkL+ke88SCy5S7lvgvxz15zH2lEtIgkyqADQH6XP+ufO9EimTYIGKncGUwJ+p9VWguZdaaK/a0EdErAxNf0SJSnIYADy70eiWoV7au5oMABVpgNZLEnwaRiaqVbLQnBtjnSJyYiaBil2d9flzvi0L9Tg4ADNnFs79CotljaDwWFMwxXCulhmSlfPGK2I4PlV+SGDQTtAygOp7O26h7ldYtyyaRicVIetoJ4KfJxcoMrRiHI61BISTso8f116KMpsq8FdB5dO+BlelwY+EWuNe3LsWfrwOw62vghqkKcN0lWO3yz5N1vUg9UbC6jgyWQV81nSHbBnMcwkBFYv50mgvAj7pqsCUT7qTzv/GWP+lCYyIhfnmONz3GXzEA4UaPuP0KhfX/nkeOYJ/Ml5Jsh0aA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(39830400003)(366004)(346002)(376002)(52116002)(107886003)(44832011)(66946007)(66476007)(66556008)(2616005)(26005)(4326008)(6666004)(956004)(36756003)(6486002)(38100700002)(38350700002)(2906002)(316002)(83380400001)(6512007)(478600001)(54906003)(110136005)(86362001)(6506007)(1076003)(8676002)(186003)(8936002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EVmLEkJiOr7vBQfwqVZlTgAyGZoBfU+JyWJe4bA3jvXB32e3AO64USVnv+ne?=
 =?us-ascii?Q?/7Vpqp5x+3Ic9mRXkx+WnDu6VYYsRo4Ngpxq98/YqJ6M2BRj7xYo1VCZNrWo?=
 =?us-ascii?Q?NGzFsnmI0iRR5HtnzOFYlT0136E+HDbMxPWxgS7nhPQrPoD2UUKH5VGaYzeb?=
 =?us-ascii?Q?69f8+4gSkEn8QK4I4dw1YCjOcV3yMYw0Qn9WIkD0+MrsTwAa39ozxvkiT24h?=
 =?us-ascii?Q?+WHc+cwlnPkGY2JHXwXNqL5ki07UO+i6mlXKr2gXmD0YWbXSwWRrXNWbAjaY?=
 =?us-ascii?Q?TMKjUrapG/k59yoq2yi/JfU+SYa1CPxVOOewiLUb5Ij9hYd8KBbGKqXYUlCr?=
 =?us-ascii?Q?CWBqkYz+H8cdeTUfZ+8gF69a8mmemNqeUacDTPp7o9Boim7PX8a69pGI8cn3?=
 =?us-ascii?Q?cCwMtxh+b1k+eTeUnzFmrvYcQxDA+7dlnsrAwTy48NO3dywNwYuRb6200S2G?=
 =?us-ascii?Q?+EQiNlsj+XkK0pzYq4rjOnOmltZaNaVJWsxPpgNmkb8uXAPlw1S8QWhXpAJW?=
 =?us-ascii?Q?UMEYeonwRlixM5Jdj9v0sUR5S8YdC8C7wKM7KWTujv6Es65TbI625g9IXxCz?=
 =?us-ascii?Q?nV2VE2GWJrpvHXo36mJFaxltI5FmxNIGIGb1XZIepHMRTdg6Syzl81ykwV/p?=
 =?us-ascii?Q?pAeLc014RmYJRi7w7rRLfJNEG7zE5xVjUMhKlaDi1Rmx5eLId/DbFFVcRdbY?=
 =?us-ascii?Q?Pqm3pFRmHubbtGJxWk/a3EMs4gc+SIK5W10mdlbM5eR3NhVhVrXB+B6gSnZH?=
 =?us-ascii?Q?xlViedVWKCPs04BdlIY3OS4a41YGm2WwWcbhvPFK3tJBoqBpk0g34YvRh2cP?=
 =?us-ascii?Q?PCY/yeWkHsIQ2hgIt+7PpliJWoyaepaiyn7IlLCGx7Lq7VnbpsFzbl3/Qh4U?=
 =?us-ascii?Q?AJfSYhy4qEJKguq12TV2y9MFNwdgFudPKlMOvOMB0CaeQAUhBJlPWZwDygGV?=
 =?us-ascii?Q?x09NmT/lMZ4GirSCTBvOc6JdPh8e6xwt2s8r9zRocxOWXwTgbNmRD6EGu4Fs?=
 =?us-ascii?Q?6rUHf2IgTNc6u6DCcKxmWT2eE71uPoneakVDq1gML37JagjyslXhLhxxRvto?=
 =?us-ascii?Q?Z1E2hdi4pZDcxKLb4at0y53xEMlhg2olX9PtbDzhwTnLw+Eknab1aNBQdly3?=
 =?us-ascii?Q?yqltrpN/4QWIHetRS56vodhRWonFVMq0a/s6KvR5PvyFIrRCpLRGHtKObtuv?=
 =?us-ascii?Q?VzOCVLX33YmRunKRkza4H9RYlT3R9HpMLV50pXR1a4/xX7Kw0RIeJlGrcgq0?=
 =?us-ascii?Q?VH/yDGpKHXPr3YrHfHOLG+hnWOZ1/aByzWjm5o+0mP3UqNAFdJIvWi1M9LWx?=
 =?us-ascii?Q?GU2C3A/qUM+rAa5S30YkyMhz?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b183ccc8-b3e4-4f3a-d139-08d968c75627
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2021 19:26:00.6764
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GhZ8iwemCihtXoWIToTQ71UKMs+AAcLOijRR4oXO118IizloLXA1G3QAY2IuMbVQsvt28U0ybLeuwjHThvNO6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR03MB4859
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

read_poll_timeout was recently introduced, and can be used to simplify
our console polling loop. This results in a slight reduction in code.
early_uartlite_putc can't get the same treatment, because it can be
called before udelay is set up.

Signed-off-by: Sean Anderson <sean.anderson@seco.com>
---

Changes in v2:
- Elaborate commit message

 drivers/tty/serial/uartlite.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
index f42ccc40ffa6..106bbbc86c87 100644
--- a/drivers/tty/serial/uartlite.c
+++ b/drivers/tty/serial/uartlite.c
@@ -17,6 +17,7 @@
 #include <linux/interrupt.h>
 #include <linux/init.h>
 #include <linux/io.h>
+#include <linux/iopoll.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_device.h>
@@ -448,24 +449,15 @@ static const struct uart_ops ulite_ops = {
 static void ulite_console_wait_tx(struct uart_port *port)
 {
 	u8 val;
-	unsigned long timeout;
 
 	/*
 	 * Spin waiting for TX fifo to have space available.
 	 * When using the Microblaze Debug Module this can take up to 1s
 	 */
-	timeout = jiffies + msecs_to_jiffies(1000);
-	while (1) {
-		val = uart_in32(ULITE_STATUS, port);
-		if ((val & ULITE_STATUS_TXFULL) == 0)
-			break;
-		if (time_after(jiffies, timeout)) {
-			dev_warn(port->dev,
-				 "timeout waiting for TX buffer empty\n");
-			break;
-		}
-		cpu_relax();
-	}
+	if (read_poll_timeout_atomic(uart_in32, val, !(val & ULITE_STATUS_TXFULL),
+				     0, 1000000, false, ULITE_STATUS, port))
+		dev_warn(port->dev,
+			 "timeout waiting for TX buffer empty\n");
 }
 
 static void ulite_console_putchar(struct uart_port *port, int ch)
-- 
2.25.1

