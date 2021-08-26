Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FF56C432BE
	for <linux-serial@archiver.kernel.org>; Thu, 26 Aug 2021 19:43:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70BCF60F11
	for <linux-serial@archiver.kernel.org>; Thu, 26 Aug 2021 19:43:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbhHZToY (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 26 Aug 2021 15:44:24 -0400
Received: from mail-eopbgr10073.outbound.protection.outlook.com ([40.107.1.73]:22611
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243360AbhHZToX (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 26 Aug 2021 15:44:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LkrlOU4nF9rHvSy1quNYd/QWSXNEcVJNHQSoGAMZDbnElZCgxlcIIgCR0iRK1rcNjwRYizEjib6j9GZGix418BkyY3sd/e8L5y/Xrf/AczTZ6VeoTboz7lrS47UrgB+JqUasLQGbCGUqpgIN6Ku72eAE0Y7yu5g7xfoNmfPHANhNdGKsUVBvyvBmV0jZlzJLm71kROz9REmbdy/mRKCN6Egyjlhj6JKnREFLJEMBCKtPqeq3VQfjTtDn+Oe/9A0RiHDc37b9zAK4nOKLnEcOv0gqNNqdJ3uMlQvRGdJkiE4x9RktPMPMZ4UbrzUweEleKO1JjJ8i56pt5pcb0rDsiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LmZyGEbnwy5EUcni39cIgbVP6x8kh6MVPU3wHwVrql0=;
 b=PHIj4RUSGjK07b3uScjXAp6ETSTsK7e9XbsmgpUm9A+P5LTfwX2hbMbaJ5DLY8EeLeHWhEHLDKEwskYARmNgm8JzmAxGWKJqzCS0m1GjHog9KNwTS8TWE1n5TMY7Yrlw2sWHgbqbldZmzp8aPbpaRmTayt6vcfbAFjS/p3k5tG2/z9KlzA9NVMVK2teIUaLxvvngEbvMFPIJIX/AzO1TBZt0x6KyCsjxsemrx90p8rgL1KL33+/vp3tLgK7LGDrgI9yk+Qg0MPm1Aa/BdFYIL9fpLrtkvg6Da/L6sCuJkwuwG6fwEl328jytVVQZOSFywtl4SMtl+gih3JL11MSc3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=secospa.onmicrosoft.com; s=selector2-secospa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LmZyGEbnwy5EUcni39cIgbVP6x8kh6MVPU3wHwVrql0=;
 b=5DeT7dcu4mIQF8dvm2IcLMwdHJ2M+OUeYrMx/5r2Oa3/upt7kiZxwrfAceDhZDR5HKEXgCKzUIDileCvPiDcv7JoSwddxxZObfos9aJnLhvkOkKRMBYjzUMwamCKw9YIpKVBaiQ8dgqq+1NHplDiAAQtzcAYdi0k6Vg3Y7C+ruA=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by DB8PR03MB5883.eurprd03.prod.outlook.com (2603:10a6:10:e4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.20; Thu, 26 Aug
 2021 19:43:33 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::dc6c:815b:2062:d1f1]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::dc6c:815b:2062:d1f1%7]) with mapi id 15.20.4436.025; Thu, 26 Aug 2021
 19:43:33 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     linux-serial@vger.kernel.org,
        Peter Korsgaard <peter.korsgaard@barco.com>,
        Peter Korsgaard <peter@korsgaard.com>
Cc:     Michal Simek <michal.simek@xilinx.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH] tty: serial: uartlite: Use constants in early_uartlite_putc
Date:   Thu, 26 Aug 2021 15:43:23 -0400
Message-Id: <20210826194323.3209227-1-sean.anderson@seco.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR05CA0039.namprd05.prod.outlook.com
 (2603:10b6:208:236::8) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from plantagenet.inhand.com (50.195.82.171) by MN2PR05CA0039.namprd05.prod.outlook.com (2603:10b6:208:236::8) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.10 via Frontend Transport; Thu, 26 Aug 2021 19:43:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 80640caf-94bf-4879-f45c-08d968c9c9f6
X-MS-TrafficTypeDiagnostic: DB8PR03MB5883:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR03MB58830AC494E20F27CCE5623C96C79@DB8PR03MB5883.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5iM+iQKCRV+RfsezNOhtP6hHKVwdmyXYkJIG/YqXFFeDw4vyynLWksKx/+vSGo7MtG1Vn8171VIxh8ru0SXtEOd2rw6/XlrFwusp3thDQOOabyQLRjPH4Ky09/mTaWUNWdE68EZfYf0KEsDPjug23Qe0Kj3ZYP6mnibd7UCLoHiIl7iDSX+1qs2+f3fEyuXGsxsgpsDUaQEFYopt/FmpqgF81hup6+BRLqypAMiy5kaU/kkkNhqXQrRamN3zY7J7dX0sg40A2yrSoxIhJN+fZOi/Cg0TH2px0Fvb3FrHI1+Do9EI2S+Mgwr0kE6DPvdifysdEVktZd8SA/sPYsSqHw+71Gkca3ZinZF1kGIVRnA+TzCS3NmPrpMTqgQdy7gGz+12+6eL6aNdgqtfsYukVgNfHkrL4J0f5ILVvEPtwsVtA1l0wkTxlen6OS7/h+4I5r2XdOm5bTG7s4FU0iLRvrQs4YtTqv3xzPDXVdhNSkx5qtUwz3dUQM1jyXUTY0xwHlKO94s+qctGCINHINK4GebxX7B5R9ged5EUncCjpu9783aW1jeTl+iLJFGUL14BQKfJCdYl1zZ5cTa79i8shcly1MUgBffKjibUuwK0IBS0mFkJjDHDxk3yWPLW/DFICbTFPNtpRTLODCXqzkMHlM9QqaTCx0fVeILKFhftI6GKknoYBnhxBI0j2EfBTQoRyEe2LoCYcGu2MBa+0Iqvfg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(110136005)(6666004)(86362001)(8936002)(54906003)(107886003)(5660300002)(316002)(8676002)(2616005)(44832011)(38100700002)(38350700002)(956004)(1076003)(66946007)(66556008)(26005)(66476007)(52116002)(186003)(2906002)(36756003)(6506007)(4326008)(6486002)(6512007)(83380400001)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rGTIh15dULtYjK5ET/yyJn0f2Ci+Od8esCN4n+8NRj9im9At0YeW3aUh02HZ?=
 =?us-ascii?Q?PholZC2TVasQWjU1sDVefwZPxUBIK8OtzLys6jDZ6nD0L+95zxLMIuspL/Vd?=
 =?us-ascii?Q?i9arvt6KUYG7bvxQieKKGAfY/TdgzKpEXH5y5iZEcV/mkxAMMsZ2rWzurFfI?=
 =?us-ascii?Q?89w7vAEWkcUjjZaSRU0JYI3Z+2/7CfmqMTnFDBxpvfyjec0CQviRAjXVGv5B?=
 =?us-ascii?Q?89qpjVnpdYWwPATpX4pkF1WE6/d9+JxAiFUMA8BxHzsATXMWjwTVqEQb2qEv?=
 =?us-ascii?Q?y1Wsa7F36qOdmA4z7kOcXkyC52DB9ZL5DTSANWDhY81i8SfZx6RJccmFVACF?=
 =?us-ascii?Q?nHm25FSZAnSKt/LM8CQulELtmv5wGsPiTG0emxVxtlWxnVWGr0E/iu4eEThA?=
 =?us-ascii?Q?JYb4Q/EfYlE6FBFEq15sytdUqAxSe2I2EMC7w0+7hl28T93OhpxTVn/fUqLw?=
 =?us-ascii?Q?oXtv6Yn8xFcNnCp+LnCf3FxlXR8wFko+zizvDsxiXTi3neteMFtud21ok472?=
 =?us-ascii?Q?wlf0a/kQZgZtnAYoxZJdf05hIp488Z7sUke9zTaspPscFsfwU4KRyGpbgvH1?=
 =?us-ascii?Q?JybLfaPvhRfcVlCkmyw96howlOTyuXAtY2HhfhvGfYC9AmXp+xavn7KyY4RR?=
 =?us-ascii?Q?lMK5qzWNcMK/ohQejKd3Cat1zfeT1biBFIjYfQb2Xy8eT6+rZaHRtLdErD9m?=
 =?us-ascii?Q?NAlbPsBU2m2q8Ee4qdfYww8zjek/5UJW34FicYfJpmL4P9KvYPxU235lddTO?=
 =?us-ascii?Q?T067LRwTqUtsdj5d1DOQW2Svftno3L02xQbITQk49o8UdMHH9ZUQsOw7nfug?=
 =?us-ascii?Q?P0aPHsDDbQ9Sj5ej01yuVA2EeldbbOuBdO9aHtGzbUSrE+s6D9pc3gO/qOYs?=
 =?us-ascii?Q?xCIzCPN1mTfPTR5sKX1TZjlTskaWr6rO9e5GQsxXwSFGsfJmt8N2cl2MZvJr?=
 =?us-ascii?Q?5BLk4t9mt1DcsMeyWi8XPJyajVcdxAPstcsaeTwnv6bK2eGSicfMsncjTSqn?=
 =?us-ascii?Q?W1myzDmrchgG7JJh+8T+3/TJ0sUPe5MGueA6zE+07mLJOGPEwv55wItu8BRS?=
 =?us-ascii?Q?QvEpzOvSQTMk482H+PSenDfHAJGWaQmsrPREA9qOc4l4QdW3CTUvvlFwbNTh?=
 =?us-ascii?Q?9K2rQUs3SRIo1mnFjRWYae/tWCBJUydPmPm1rooKiQ1z5rBkuwQWvcH2DDK0?=
 =?us-ascii?Q?LIG7yHPbTpBWxa2ZLqwE6U5XjVRCbqVicry7/8sQtNDXh8K76xB5jbRP2RVp?=
 =?us-ascii?Q?hwLRypiOlG68G9Z4DFOG4sxBO++IHALpCCBt/XPWArq8gJjhR7NjJ+gsaooS?=
 =?us-ascii?Q?pYWAFwD5mR/dLyptc7aQCiMY?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80640caf-94bf-4879-f45c-08d968c9c9f6
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2021 19:43:33.7844
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rI78zfTpzJznCxJIc/W9U1QkgtVNF6+vIIdWQTmpOQMAh+biuEOu9lh2VCdWhQARWoC9Zr28s1DpUH40NXLQmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR03MB5883
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Use the constants defined at the beginning of this file instead of
integer literals when accessing registers. This makes this code easier
to read, and obviates the need for some explanatory comments.

Signed-off-by: Sean Anderson <sean.anderson@seco.com>
---

 drivers/tty/serial/uartlite.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
index f42ccc40ffa6..bcea7ef4699f 100644
--- a/drivers/tty/serial/uartlite.c
+++ b/drivers/tty/serial/uartlite.c
@@ -553,16 +553,15 @@ static void early_uartlite_putc(struct uart_port *port, int c)
 	 * This limit is pretty arbitrary, unless we are at about 10 baud
 	 * we'll never timeout on a working UART.
 	 */
-
 	unsigned retries = 1000000;
-	/* read status bit - 0x8 offset */
-	while (--retries && (readl(port->membase + 8) & (1 << 3)))
+
+	while (--retries &&
+	       (readl(port->membase + ULITE_STATUS) & ULITE_STATUS_TXFULL))
 		;
 
 	/* Only attempt the iowrite if we didn't timeout */
-	/* write to TX_FIFO - 0x4 offset */
 	if (retries)
-		writel(c & 0xff, port->membase + 4);
+		writel(c & 0xff, port->membase + ULITE_TX);
 }
 
 static void early_uartlite_write(struct console *console,
-- 
2.25.1

