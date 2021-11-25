Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A72FC433EF
	for <linux-serial@archiver.kernel.org>; Thu, 25 Nov 2021 01:48:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243640AbhKYBvq (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 24 Nov 2021 20:51:46 -0500
Received: from mail-am6eur05on2046.outbound.protection.outlook.com ([40.107.22.46]:64161
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234909AbhKYBtq (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 24 Nov 2021 20:49:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b6Z1mAGJnCtCL5N0hCN/rk9mPgkoR1s2h3tfX3O2kVXGXFGdcBGwlbYeWowTpILq13NPnZGMoYn68akLdaAXvvw4kjdlI8xU1jyOTabXMnAu0subHpyXrWGbd9K22b2AvqsKKo/gMhQWTR1gMM2QwiCNifcaN9cMMdWyPKNPuuz4aLuCgkzSGP0f7k1QoqSo5OFEMfxnrAmuSxyFZIZGIFfW/rO3MBbpayENxHQmaoh2Bjop9DY/UbabWDKZ1//FDeOX8jiVyWM7xcbhskyXOXD2Xns6ldGkscT+XAM+TPp54YNht8Sz3vV4EliAafLKH6mhvXteyGL43p0DRUpZYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wEalQ5A7RDT4gjet5e16eHxrhOTAbXaZWZ7XLFriI4g=;
 b=m959e1mTzX114YJuOrf1Y7KKBvr0Tfv17NhwCVVnsI+MkCpcP3dA2doS9Rip2ZDQJrXaLbUekZ+S4mmWsAFQbStWdIRKNAnfVqALbK2LN6HXi4teJ+PwTy2DXcneGB/54dOScldgL6IXUpbINpVz8jJJep2H41EoZYf4d5kvNuCLskwfjSAYMnVlw0uHV+1CWb06PmwrNuaj/UgwtYa69pomqVHDJzkNfhvBDHAF2BuzOSNmc2JjWG3jZKNvtC1YpDHX8dLDAzWDvDaF1Ismuy7ijmmqQpfUGLcVAAxPbB2cPfIfABC0YeARj9flpGx3ZnGl+WCOAXdd+60p3Th+EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wEalQ5A7RDT4gjet5e16eHxrhOTAbXaZWZ7XLFriI4g=;
 b=ceKs5unZCcO0/GghIP5v9FYYc0NAru1ywVs9WQsMEJ3mF1F+zq1WEortdoGoN7tS9M6uJGitJ39oN6U8C4J9/xf0I9DFKa3pdrCxLPKTGj85eExlZApMGhyUMrRSLrvp4I7B3wDh+WnSLydGlslkbxFeUqBlknGp01QvnhO9naU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB8411.eurprd04.prod.outlook.com (2603:10a6:10:24c::9)
 by DBBPR04MB7739.eurprd04.prod.outlook.com (2603:10a6:10:1eb::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Thu, 25 Nov
 2021 01:46:33 +0000
Received: from DB9PR04MB8411.eurprd04.prod.outlook.com
 ([fe80::199a:adba:b7de:cf8d]) by DB9PR04MB8411.eurprd04.prod.outlook.com
 ([fe80::199a:adba:b7de:cf8d%5]) with mapi id 15.20.4713.027; Thu, 25 Nov 2021
 01:46:33 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        u.kleine-koenig@pengutronix.de
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH V3] tty: serial: imx: clear the RTSD status before enable the RTSD irq
Date:   Thu, 25 Nov 2021 09:43:06 +0800
Message-Id: <20211125014306.4432-1-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR06CA0015.apcprd06.prod.outlook.com
 (2603:1096:4:186::7) To DB9PR04MB8411.eurprd04.prod.outlook.com
 (2603:10a6:10:24c::9)
MIME-Version: 1.0
Received: from localhost.localdomain (119.31.174.71) by SI2PR06CA0015.apcprd06.prod.outlook.com (2603:1096:4:186::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22 via Frontend Transport; Thu, 25 Nov 2021 01:46:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5c5db142-f312-41b6-7318-08d9afb568dd
X-MS-TrafficTypeDiagnostic: DBBPR04MB7739:
X-Microsoft-Antispam-PRVS: <DBBPR04MB7739BCF2A3535BAAED01235792629@DBBPR04MB7739.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:513;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QF+TmjcGmXZ43/U/cyOTnfbZviG6Tki80sn0kg5UnLet6mPGjo8YF7NqAbTwZXMov3Rta78ggxoH3K3EN6zG7jwVadIPcYWVMW1kj1SEYPUbSvCJ7MCWOE81rreB3G4BLwSRO+utxwAUbxqLzPZlwVjwueLh7jL+K4AqPmgUsn/xWYCtuXrIPx0m0jM097HNjDjFzsdaI4G57s0VCWa/Iom5TXkTAVQi6Nru7EzDBi3PkMVgx1T09bta2t7zUP31Xu/TqiFZ1lcAMuU3exh16AFErMQ22lH7JfLTWBuUCX8ywK3I6hFKG2l8CGg9mrOsNWDnLChovv6iN16V+9bZG2yvDcKYQUTBqmZWRgYPShE0isTzBdHZunJ27j74Wxl7B0Uu9QW8dFc8HJMampMaOE88VZUDYmE3x1K4QeX4woQOuhs0PWMgJbrDLfAvlDkzXrCSsZOBaIykDbJbuQznrqDsBQD8qDRYplNAE/zJwWgx2VYuY6aXLi/KZYLDAfRe5rrbnVNZ2OlPAdgeQwmCXZqJq1kKX6OAVs3Iqael9nXXPjDfnRVkH8yOkTcvsrsTBTFQ5RsOqt7M/8gvVw70p5rdkhIoW9GSBNrUwLCRcdySiX7L2s9LekU5dGs0lzS7LPrLiRNkPHb9OvjnfaYyzcVYDzQZc/N33zS8dgxDpb0jOZ8hAmkui5+SNS0aCHIxSTFvSOzPah7rORjlvx4hTg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8411.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38350700002)(36756003)(38100700002)(66476007)(66556008)(186003)(66946007)(66574015)(4326008)(44832011)(956004)(83380400001)(8936002)(6486002)(6666004)(2616005)(316002)(5660300002)(6506007)(52116002)(26005)(8676002)(86362001)(1076003)(2906002)(6512007)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QW5QK0JkK3RucFpUNU5WU3k2UVNTU090djQ1R0JmbERlbm04Qmd4cG8xaUgw?=
 =?utf-8?B?MXpBQjJNUXljMjk3VW5lTjlJU05KakhGTmUzUXVTeHJRUTIwVk5UVlJha1Fm?=
 =?utf-8?B?TVpRUVFYcy9PNnFPR3lZVEdzdkRXNmtseWRRV3M1L29iaW1FRlJUcUpLNlZW?=
 =?utf-8?B?YS9UaXVqT2hNRnFxSUdxSUFFOGk5Z09zWkhsNytiMEhhVytZY29hdUg5T3dk?=
 =?utf-8?B?MGFobW1sMVJGOHpPR1Q1WWREMVdYOUFrYlpNWmhSMWZQcFRjcTd2SG9BdTc5?=
 =?utf-8?B?YWdsalFwMElNVGtYV1IwR2FYR0hPbWE1blJybTlTOVVzOHJvQm5aRVliOUlF?=
 =?utf-8?B?SkNrQVpyaTlmcEFGNHZhdkFyR0hyZkV4ekdXT2tGeTdMdkRTVnp3Q2E5REFz?=
 =?utf-8?B?dE1VakJCQnQyMHFMbFpQRHR5b0QvcG5aclBhNmltL3BnWjFwSEZrN3lJMGlZ?=
 =?utf-8?B?WG9XSGZ5eDJJMHFnN09pcVlBTzcxalE0U1VycVZ6VXlVc2ZyVHZDVXU5ZmlI?=
 =?utf-8?B?U2hmaEYyUjNOTFNjQjhZRHRMcE1iYkliUU1SbWtsTjBvblViODAwMms2TUpN?=
 =?utf-8?B?WmwwcnJudmM2QjJXUnNxWXlIMThaK0FBU013WUVabFpuVjNzYmlXTXkvNEJ5?=
 =?utf-8?B?UGxRY1MvWjBQZ0cwclVJT3hHMWZOeXVZYkpwd0NheGFiNUl5QmxiYW1JWFRH?=
 =?utf-8?B?VENYQzdxR0EyZTNrRmlib0tKbkxvNi9oUWFPQTFUVlQ4cXVlZFBGYWFlUUJk?=
 =?utf-8?B?dTdYMVU2c1JUK1pVYWY5UWU1TktPZkFEWXRGZGVZRERJZzR1QTlTMEtSQzJ4?=
 =?utf-8?B?VUhWejBQYWZmdHZXQ0JXNjZxaG81dTlXYWtNYkw1am01V2p4dVJJOStJMWU1?=
 =?utf-8?B?NnJIV2tKa29YT2JFUk10eE05WnlUYlBXdTVaK2l5UngyOUJQWlluOFFBK2M0?=
 =?utf-8?B?TjhtN2tNbFpKMmdvVnhKNDNDZjM1b0JlZENIRWNoUGN5NnVNTkhOVENQT3RN?=
 =?utf-8?B?YnRHUkpMRWFBQmFlYXpHNmJsdGdUcE4rZEJNNUVDZ3BENEgwS28xL2pnSysv?=
 =?utf-8?B?MkRURm1LZnBWSE00L0VOZklrWlhkRlFKVEl0bm9vNkdWR1RnRVVTeEVyc0kw?=
 =?utf-8?B?RnN0STBiREVsUXNZV0lUWldrems5Nlg4cmlqNmM2K1FiTDBSc3dsU2NvOHlS?=
 =?utf-8?B?NzR5ZFJ1ekNHNldiOFVWYlNnRkhLWFBLT2gwbzRWZHRSUHBlL3B2enBZVEpH?=
 =?utf-8?B?cEl0ck9CVVU5K2ZNdy9yMnVQK2Nid3dpR1JHdGNVdG5QN1VLZkx5RW5RSGpu?=
 =?utf-8?B?SUJBUEQ3cUF5YmdzSGRPRCs4V3cySVpjOFBtUTVoK2lISExKR0g4dUwrV29K?=
 =?utf-8?B?RzlpNVJhZEVVUFVRa0ppWm9vRFNLZnZjUFlaYjNoalo4UWpMSENNYy9HNG05?=
 =?utf-8?B?ajNQdzYyR1o1OXBOb1dZbVVMOG1GS0R0WVUrTW1JSHdSbXI0aUxkc0NuMTZW?=
 =?utf-8?B?VHB6cFlFUjVlbVlIT1crTDBGdnYxR3B0NllsSHFLeStKdS9yNS9qL0RLaVRw?=
 =?utf-8?B?Q0l5V0ZKYS9vN0RFYklWVEkrcVVSYmh0QTVlOFh0QzE4VFAweVBtRW5sdVA5?=
 =?utf-8?B?dW9kNGZKSnpFWVNGYW8xUFFwUU85TUtxVGFtZDJRMmJWN1NxN29GWmhZV1M2?=
 =?utf-8?B?Q0s2eE02T3ZSdGgzMy9PNkR3V1pWbTBXWE5tNkp6bFJmbjRtbUtGanp0bmFE?=
 =?utf-8?B?cno2VWpUVytVc3FvTU1CcFhqdG9JVWUrQWVIZERlbUJmcTBaaWk0WXRmdG1B?=
 =?utf-8?B?cDVjcXcxdkxpNnF4amlZcDZwV2huWHQ2NXlSQjNXcjVCR0JSWDJVRUp0Z1VI?=
 =?utf-8?B?MllFVWpXN3JwZUZSSWwxOXJGbk9UTng0MVFDNmdYWWorZDRUcUtYZ011Um9P?=
 =?utf-8?B?K0F1U0pUT2YyaDlmbXhmV2V0b1NUWDF0Zm0zQVdMSlVlSzcwQmxuUnFTei9B?=
 =?utf-8?B?MnNTbzZpdDBOMDZnNUEySzM3WGx0SzBNSmlQQzRQUW5Lck1BUlBNY1BsWldK?=
 =?utf-8?B?TXVkVktwRWtEM2s5QUtLd3JiK3I1Q1lETzE3em93aG1wVGRlSC9MbkpNTXB5?=
 =?utf-8?B?MEZoSXI5cm84WklhTHFNenFvR1dDWHYzWlo3aDlUQlJDQ0dHK1hrbEoxeEoz?=
 =?utf-8?Q?j+Sfre5ptHYQi+kEpiQxMD4=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c5db142-f312-41b6-7318-08d9afb568dd
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8411.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2021 01:46:33.6952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UNLdP4s+xxItYbhWESUVOdjMoz+Xm9BuDzjqYkMieyMkiaKujiJ77m4Pza4koi7VwVhuYY2uGQiXLp1r3A2ObQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7739
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Fugang Duan <fugang.duan@nxp.com>

Clear RTSD status before enabling the irq event for RTSD in
imx_uart_enable_wakeup function.
Since RTSD can be set as the wakeup source, this can avoid any risk of
false triggering of a wake-up interrupts.

Signed-off-by: Fugang Duan <fugang.duan@nxp.com>
Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
changes in V3:
 - Add the Acked-by tag.

changes in V2:
 - Change the subject and the commit message as suggested by Uwe.
---
 drivers/tty/serial/imx.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 90f82e6c54e4..fb75e3e0d828 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -2482,10 +2482,12 @@ static void imx_uart_enable_wakeup(struct imx_port *sport, bool on)
 
 	if (sport->have_rtscts) {
 		u32 ucr1 = imx_uart_readl(sport, UCR1);
-		if (on)
+		if (on) {
+			imx_uart_writel(sport, USR1_RTSD, USR1);
 			ucr1 |= UCR1_RTSDEN;
-		else
+		} else {
 			ucr1 &= ~UCR1_RTSDEN;
+		}
 		imx_uart_writel(sport, ucr1, UCR1);
 	}
 }
-- 
2.17.1

