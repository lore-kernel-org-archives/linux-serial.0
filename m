Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1725AC433EF
	for <linux-serial@archiver.kernel.org>; Tue, 23 Nov 2021 10:55:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235547AbhKWK6O (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 23 Nov 2021 05:58:14 -0500
Received: from mail-eopbgr130048.outbound.protection.outlook.com ([40.107.13.48]:27399
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234319AbhKWK6N (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 23 Nov 2021 05:58:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b/+6u3ROlqt740WTUgGL0phhWHXDfAAlnCe0XnWqEwcxP+ve/M4t7fWGQgGzZjUmFTciXJ2tK2jonozM7aU2YzCtX95muSFDXpwUlKcFOzs7wmbOqpcMmE1xqCCozdQgKlBBL4TBl/pa9A/eegRa4MC3ZX3hx9cBW0DA5c7lFR/qMx/Pmjsxg5DG6/RCqPYNrxDEFnpjXeOvbRp0LnNtzNvTRaq0qYIKaepVgLUuilkx/nO9s5fAFRCxPqJJyR5LFKULqtjb/uTVlqRhO6vwwpX3AATZ7cWqiihRI8sk6KDB+isi5bnj4AIZsEJNWHPBRe6eW8gbaMhEPgv9caXiBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Wi4B3s2M/MXNVWO52HjBIeE6t1iooRfI/yDNtTTwQo=;
 b=mP/iQmV3Uhpapk5RC42XBB6R9a7b1DPELb1d6YTGit7MOsbYWt9Nx6Yl9iEAxDriX/p5QEr9GFwvx9MZ2OyvFBPgAwlsYTB5FRTHRhBbTITZ1Q8EdYNtBeuHB85Nwh+FERNg/Hj1aEvKsv7cAHVZ5PxffGmuyYW5B7vQ0MaeVFiLXaYgVhgIAdjpJ0kdNW6gn3uutEqkQxts2DpKcABYEORF5UuUv42Nu7J5I8/mboXbzQpAzt2J9UfPxJX8sqbe4wkIw3nF9KgUL/oLrGKehmwxPwF6pHb9eAzLW8ug38SlUEKnoiZy32384ZBt+QaANCUaUmvz4Og9jdOm7tGiYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Wi4B3s2M/MXNVWO52HjBIeE6t1iooRfI/yDNtTTwQo=;
 b=Q8zDTp08x9hPZTQWyEW0/YOOQn7oaUROI8B3dqaqZWJlHUI5cUlC/1Rm0dg52ETbXbJIjkRn+uHjPaNOdQj4+s6bz5rwo0EYPX4ZLMde9FMkydlqVPA6NLMJvCRo4iJJzV9s2kx7LoWM/FvK2DNRrE8AzMbKPtkwR/fba6lZM9g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by AM6PR0402MB3686.eurprd04.prod.outlook.com (2603:10a6:209:1b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Tue, 23 Nov
 2021 10:55:01 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::c9fe:7982:c657:b423]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::c9fe:7982:c657:b423%9]) with mapi id 15.20.4713.025; Tue, 23 Nov 2021
 10:55:01 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        u.kleine-koenig@pengutronix.de
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH V2] tty: serial: imx: disable UCR4_OREN in .stop_rx() instead of .shutdown()
Date:   Tue, 23 Nov 2021 18:51:22 +0800
Message-Id: <20211123105122.7913-1-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0128.apcprd02.prod.outlook.com
 (2603:1096:4:188::20) To AS8PR04MB8404.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f8::7)
MIME-Version: 1.0
Received: from localhost.localdomain (119.31.174.71) by SG2PR02CA0128.apcprd02.prod.outlook.com (2603:1096:4:188::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend Transport; Tue, 23 Nov 2021 10:54:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e0f8bf5c-a875-4478-1e85-08d9ae6fb2b9
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3686:
X-Microsoft-Antispam-PRVS: <AM6PR0402MB368694CC9281021B0C185BE992609@AM6PR0402MB3686.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:499;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4mzRMQie8rxvI2WLhqRLplV15ek2fW08AgyQsaa2uMNF22rjke5k2uszgBrbXje62YzXAPvbcEZAOL6Asq5Lm1H4XaVbrZ9oHxid4GWOk5MpBQ4JwZ3CDLdrttiufmYn2dmgzaxH0x1YTkWpti+X8XcVPLHFYMCt/i93LcJ/sRqX8B6DEtBY3v8S1pnsVXGHITBzFamSxs6lydGTHqrwQuhqI47ky68pmaUHil1edePPHMlc7zpyEFo+PbRn9oanPV3iieffvkj6hvLSSEluYFBK+GLpNmdjUz+49CDdpi9ElyJpJpD9mzGvS/RV/OMTZbQZsmHU2UFUE7NjJlpokKBUgWW0u5VLa+D20Luneu1wUGIfJZrMchw+Q/q+DvnRLlU33GS+onCwPY2OtsEf/dHyOCnYPFOt0a3rpHTYeXS9160BPIV9NAJ7nsn3q9GcC2uAxVjGmPNjHDJXClVC9jZILfnzbDn7AxowGkq5TtmuYWD1MfG5gud40HGXBX5BP0/50kQ+NkvYldXKuJSYnGCzmA4pPDlO11ZH9sjVC0CQctLNsLTxCpetSLmVH96l477oLSIZEwqW5HHAvT7ck+bKBAq1g4hy6n5N//v1U6tEo1sL+PtwrBGTcWo1kKut0XqRKliAHmvuEn6ZYQkjkLju5eNq0LjDvl8+W7z8CteaWmOXn3p9UfyfYk+aryNx/52ZsHD6JDj/PQOwBP+nfClznxTQk4TF4hsheVBRx98=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6666004)(38350700002)(86362001)(26005)(1076003)(66476007)(66556008)(508600001)(83380400001)(66946007)(6486002)(6512007)(4326008)(38100700002)(8936002)(2906002)(44832011)(8676002)(316002)(36756003)(186003)(5660300002)(52116002)(956004)(2616005)(6506007)(142923001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?G4WTs7b37hAzhmC+YZ/Oy9McK+MkQm7XG16mKkdl30B/fzODt8MJdgH+KXQC?=
 =?us-ascii?Q?HzvkX97FviBd2Q43MbIilyuXbiakyeBsiLH9kEAlGKjZt6s646dIUsZMUgZo?=
 =?us-ascii?Q?BlatKXcFaT7fdPDp0jcUyck4zVgAA+ZX4yVsgneuVjLXJyJkwEf6KNBoDy4o?=
 =?us-ascii?Q?a9RqJYQGdqyCCQlWKQoHCudprKtRuUQFSAt6YtWcMjeP8vamGeNSvEjstK50?=
 =?us-ascii?Q?qbAqtQzEPLYXTX6Y0j6+5HLDZApJX1xkLLbg4C8XmRzJUmvX0w67xuZ2XBeL?=
 =?us-ascii?Q?51DFFUCTShBlazJPhQw2+BSECkygAx/gctWaoOngWWUJ8KYB76/eiy/UNVJW?=
 =?us-ascii?Q?GkRPUA3+8SjINEX2ToovWDbR+cnvog2genTrjrpLyV1cjJAT3Ku4QRq2zj93?=
 =?us-ascii?Q?ddkynTaZN7qmz8ZH0578DOgl5zTo0CVD2lqTqpsAnaK8a08U4Ihl7LNVuu7p?=
 =?us-ascii?Q?mkMDvUwuXVVkWtZEYZknVwBMtp9Dz8FoZ6yR8lPo3Atcv3yzJ9agUUBs1DAB?=
 =?us-ascii?Q?yG3sgkzkgP1HlfRRr2lt7rWTdm9Le83fs45Wx5fSJqpcfwEhl/adEsWS6vcV?=
 =?us-ascii?Q?rhFzHlfUGblUH+5FyU4Q77cBKLAns1GXsMH86oEATZAHydl4Q70s5v32aYBT?=
 =?us-ascii?Q?Y3kuhe2m5wwNCq90PTFnJjZcJMvWXs4hrOgpp0Z5OpojHp9DENvUrdHQIhJW?=
 =?us-ascii?Q?VqB1jN/H6wRKBv7iB75aTAvN3YKc/gyOBQE5pdJ+dGNc1PF4IahboCkni6C1?=
 =?us-ascii?Q?z2NC8YF3Xd3zKWNvn7gmvfcwj6GX5A2CbpftRfKpuBpkpQB+vWheJyMiD+fB?=
 =?us-ascii?Q?E8bO7k8Lh5oz4rW2+AzgtOBoE13LLNZJW07baTb+xJKm7LOvtWpKvlGffIuu?=
 =?us-ascii?Q?Y4XKUzpFGlgcGhOLYUo48+L4tiZt0s/pXDlLEzkfEz7fKMp4r0cJRdwu7wGC?=
 =?us-ascii?Q?D2rONFo8dxbMRyya1MSS8FBh00l5qSkDUmqhARpM49v0hRAcRujJL0zgtxZ5?=
 =?us-ascii?Q?IppN0J0RWYCcNFZIXg2YHp/lJCubKSa5ojQaL9wbVyA9qSUxkrRk89KY3o4k?=
 =?us-ascii?Q?cYAIEDqaHcgxS6N1cG74sM+hvsyB8snPsm/j4HtCSpGJ3h+MxEqzpkHAmsHs?=
 =?us-ascii?Q?egZQRHtMVFh7Ll9aaNG9RVd8RXAaDej7l5S5J72+Ol93DyPru+nKzy1jND2X?=
 =?us-ascii?Q?6LpGpoiGFKYYtgLwxzP/ubjH/eFDZBgZ9kxvP1yPJ2a6C088KvpoNUh/fTy2?=
 =?us-ascii?Q?mfAawaQMFuwZycz7Hi2cMURCTLZtayt/Dr0ZK+doDvzDkvkadGo9O8YhtEb7?=
 =?us-ascii?Q?vpcXgkzTfk2//TRy4YES2avFlrEH1auY+tkuJwis9njRjGRU/2c9uNqqJRrq?=
 =?us-ascii?Q?l5A7mCxMuwgozcNtyFHiBPunKRbsArqSrH2ClpIoKXXS9Ixk1Zn/CpEZTx9b?=
 =?us-ascii?Q?/2I5n37AsCNjGOhLvSn9MGiZndH6VQKPw/EAMbsQCM+io2Deolp2P3xjphuT?=
 =?us-ascii?Q?80Ny3QyfatsARuKKvulKM2dQoiEg9YpyPFR/1pKEwStGqDaNx7oICwoyRXfj?=
 =?us-ascii?Q?Da1trKqN09PacSjYxP8TgXx+QulkPjkX1umXrNd4vQgID3ttWDdfchn6q8AT?=
 =?us-ascii?Q?1xbbPzWEJ0/NFNtpPL+qLq0=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0f8bf5c-a875-4478-1e85-08d9ae6fb2b9
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2021 10:55:01.5084
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: puOLxkVkCLsX9G1G63ki2XlZ/jTGcs+w4jg316EX51Q/a00Up7qzPLkXuI1WthhMqz8HTEWJIX/lrtvg2+ZMMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3686
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Fugang Duan <fugang.duan@nxp.com>

Disable the UCR4_OREN bit in .stop_rx() before the uart receiver is disabled
maybe better than in the .shutdown() function.

Signed-off-by: Fugang Duan <fugang.duan@nxp.com>
Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
changes in V2:
 - remove the UCR4_OREN clearing in imx_uart_shutdown as this is not needed any
 more.
 - change the commit message.
---
 drivers/tty/serial/imx.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index fb75e3e0d828..df8a0c8b8b29 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -486,18 +486,21 @@ static void imx_uart_stop_tx(struct uart_port *port)
 static void imx_uart_stop_rx(struct uart_port *port)
 {
 	struct imx_port *sport = (struct imx_port *)port;
-	u32 ucr1, ucr2;
+	u32 ucr1, ucr2, ucr4;
 
 	ucr1 = imx_uart_readl(sport, UCR1);
 	ucr2 = imx_uart_readl(sport, UCR2);
+	ucr4 = imx_uart_readl(sport, UCR4);
 
 	if (sport->dma_is_enabled) {
 		ucr1 &= ~(UCR1_RXDMAEN | UCR1_ATDMAEN);
 	} else {
 		ucr1 &= ~UCR1_RRDYEN;
 		ucr2 &= ~UCR2_ATEN;
+		ucr4 &= ~UCR4_OREN;
 	}
 	imx_uart_writel(sport, ucr1, UCR1);
+	imx_uart_writel(sport, ucr4, UCR4);
 
 	ucr2 &= ~UCR2_RXEN;
 	imx_uart_writel(sport, ucr2, UCR2);
@@ -1544,7 +1547,7 @@ static void imx_uart_shutdown(struct uart_port *port)
 	imx_uart_writel(sport, ucr1, UCR1);
 
 	ucr4 = imx_uart_readl(sport, UCR4);
-	ucr4 &= ~(UCR4_OREN | UCR4_TCEN);
+	ucr4 &= ~UCR4_TCEN;
 	imx_uart_writel(sport, ucr4, UCR4);
 
 	spin_unlock_irqrestore(&sport->port.lock, flags);
-- 
2.17.1

