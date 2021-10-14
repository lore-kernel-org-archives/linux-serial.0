Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7BEBC433F5
	for <linux-serial@archiver.kernel.org>; Thu, 14 Oct 2021 07:11:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9C9F60FE8
	for <linux-serial@archiver.kernel.org>; Thu, 14 Oct 2021 07:11:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbhJNHNO (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 14 Oct 2021 03:13:14 -0400
Received: from mail-eopbgr70118.outbound.protection.outlook.com ([40.107.7.118]:50863
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229551AbhJNHNN (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 14 Oct 2021 03:13:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eHDE4pUbxSOAaIFDKq0iKifWx5+f8FJxKS0eoXbwrFBe8yQ7stVPhJhdIlJuJTunJLqAzxVAHlg6UPPf+hWH99QsqhJ4+u0D4PsfAYGFZxY1X7f/6IjAkziEnMyKpfSp6AdbhyPdBkIG+heb8ZqUp9W+BHj0ROBG1KR0q0HqYbkgfu+XmWNc6dO8SNKnrwLm1qlEPgvDq9ZeTEmCFokc1RgAfwd4vkHF+xQF9CcAF8M/tiu002JLoOqUgmJV03VmEuk0jGSSkmZCMF0KQED/1Kb0RrtMmR79zs5qM69cC+f7xcwEHenh+0kUC4BZFLKDNaymi8XbpdYQC/o3c/UrjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p4ETRBHsx5i4D/K6K7sLiad91vJHjBv9R3XWa+PcHcw=;
 b=nScIugaJL5q11Ql3/jPXmrWjkKblX6b2VdZHwiDjTHlIEq4zAJ07PoK1yadPBtYeN2YAiVuAG0P3jesB9iOTg8JlRiNa3mhP0YpeFmSt0uor9PBXPuMmQk4mSgKeU4HljYiM8fS7XjkL1chGkvkvonXrI3v1tirKxLBLvZDWWYkUkXBUcX1C9jJzHuvR84mu0LniXXVnPpvgwZtvSXAa9Qt0T71/pv8L9JqdYYo/nbn8uAdHkWHZ+L2KYCrpzIqzAtAns5IzobGfFrDvMeBj6mIh/YG3jp1FlXbDVErYCymw5UuJzvztqsrq1QWhKh45xYfuzdzXYu5cF/eSKMOQYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p4ETRBHsx5i4D/K6K7sLiad91vJHjBv9R3XWa+PcHcw=;
 b=l1bAYHmf0bv5b6OYsJzQAKmTeLRr8OAEghV2sNE3tcOh9Gl9nQIvuZS0uy+un4dW/oSREfdVAtozBd0b7BM8kMpvtUOSaYX25EA8Yhlv3+6dgWlFYm2sUQ1aPzhbU/TCFNMvlqSf/ic8Wm2ms/uNwMBm6BzvOSeLXE9vXLYnAbE=
Authentication-Results: agner.ch; dkim=none (message not signed)
 header.d=none;agner.ch; dmarc=none action=none header.from=toradex.com;
Received: from HE1PR0501MB2602.eurprd05.prod.outlook.com (2603:10a6:3:6d::13)
 by HE1PR0501MB2780.eurprd05.prod.outlook.com (2603:10a6:3:ca::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.21; Thu, 14 Oct
 2021 07:11:03 +0000
Received: from HE1PR0501MB2602.eurprd05.prod.outlook.com
 ([fe80::8463:d3:5cb2:152c]) by HE1PR0501MB2602.eurprd05.prod.outlook.com
 ([fe80::8463:d3:5cb2:152c%4]) with mapi id 15.20.4587.026; Thu, 14 Oct 2021
 07:11:03 +0000
From:   Francesco Dolcini <francesco.dolcini@toradex.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Stefan Agner <stefan@agner.ch>
Cc:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] serial: imx: disable console clocks on unregister
Date:   Thu, 14 Oct 2021 09:10:53 +0200
Message-Id: <20211014071053.568598-3-francesco.dolcini@toradex.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211014071053.568598-1-francesco.dolcini@toradex.com>
References: <20211014071053.568598-1-francesco.dolcini@toradex.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0130.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:40::9) To HE1PR0501MB2602.eurprd05.prod.outlook.com
 (2603:10a6:3:6d::13)
MIME-Version: 1.0
Received: from francesco-nb.toradex.int (31.10.206.124) by ZR0P278CA0130.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:40::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16 via Frontend Transport; Thu, 14 Oct 2021 07:11:01 +0000
Received: by francesco-nb.toradex.int (Postfix, from userid 1000)       id 8170C10A3844; Thu, 14 Oct 2021 09:11:00 +0200 (CEST)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7b9d0c85-6f66-4792-10da-08d98ee1c77f
X-MS-TrafficTypeDiagnostic: HE1PR0501MB2780:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0501MB27800695FB41561F16469191E2B89@HE1PR0501MB2780.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hgnqZqVtvzQSAj0EFePTavyJ4eUz9LSzS82CwjSMRmArDgA4Rev2BvNEsKcAJRhqfMO5WMKHDI7KPVULjLkImLs8LKRR0kdmXN1tg+IviPe+sx01XDjk5DNBkHD4jZzNV93wkophrWAq8Vc7hxqfXKVtE/roAlUaDnRQ63HFL4OBcmY6jlBSQacEyWenydy0F3msQLJL8MqHazzxUCnhhjCAgYeIK1rq1fKA7T7zvNyqmtKxNCwYQ+y7nrhQRpMdwBar6cP4qSZVJSOP5q00kmABYBCoLJ15ql14RRx1tdV92Wut170t/+qj197Cdej1+QGF7MD4raTL1bjouE5Z19xxNNRPK+Qfz7sXbmnkaIey+StpSeqiE9L1z2Y1te+GA1POuVCgZBxPgWyxXBnbkLCjqGjzEoBMFa8jL3jcgbU6g9ndZyx8Q0ticjdzohV396ddIng7xGGymwiFf6PxbmJerNr1UgrCYTL9aYJS9fVMvFYR8PPlNDd3fLE8YME2DKxsJIMELTQQPnN+T/Gm+k4s1i4NipYrQOaWxTbowt0b5XujL0UhvAXm0Mc+UF3+FupQpvoSNdh/H7ucl06nbT9Y16zU/n6//skrDJa4AxSYzFZ+Iem2S1W1Wn3IOe/uHCm/fQAq7nA60wcBKhdYehuDhyUBMEXVr1ntMUqKSAg3PmpSTn/kTxnV53STUPXqH4RR0QXI+MgHJ1VkTTauXQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0501MB2602.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(36756003)(186003)(52116002)(26005)(316002)(86362001)(6266002)(110136005)(1076003)(508600001)(2616005)(38350700002)(8676002)(66556008)(83380400001)(66946007)(66476007)(5660300002)(8936002)(6666004)(42186006)(7416002)(38100700002)(4326008)(2906002)(44832011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?00aakVHYGAx2K8YV1UF0taBhy23TnzliXc8fsQax+dnNvXIMjwpofKgBgMZv?=
 =?us-ascii?Q?SpCCBGWsdwZquxXbVGBV6lO4Gh2owymCfT5DSyRtnBcOM61s9YJ0asYr9ODD?=
 =?us-ascii?Q?xoswdXjZF0RSXZcJ0bKteB4681aQHe6OdQ8koZHcxTNtsdBHIP2AuYBGBkey?=
 =?us-ascii?Q?fQbtGpvCGZ6DJatKVeu56jVUo8nu7jHRghDqHwkzw7scwuajaQyOU3vNZCcF?=
 =?us-ascii?Q?RHGO9J/jw8NkYynPtZ0sWIMmS8ZKdLo8BP7de/ShNTbFGTlgmXY9XBIJVYSI?=
 =?us-ascii?Q?GWNa8tcu9+NGT8RvsI9NcwjwtieSH6xqRhCqa5GKxAW6Gy+Rqy8nmFVTiB8+?=
 =?us-ascii?Q?/k5yVea0wepjTrisvagtJ3rx7AHOKW3kHM6ryeHjcgLM5ahudY5DK47BOu5G?=
 =?us-ascii?Q?YA4i0b3JSdbCiu23g5elKDIdBtwL4Z9TKnTzqHrPw2Iu+laHWxrq4s4TfNEG?=
 =?us-ascii?Q?LguIzADq2mqwnSKTA8YJa2TtqD4+mb1BdEWq5jmM3xC11IBeBKhXdxaIpXNU?=
 =?us-ascii?Q?JduWmwOgckrJPLvlhFRL3NNMr+/+O8gk3Mmq3SIU7lRY6AmvOAMk1WEl6sjU?=
 =?us-ascii?Q?t+aP450OlgIc/3TSq8zStwhTe9oM4mEpSt1cHCpcK11w2VbBAA5H3JKoDHRo?=
 =?us-ascii?Q?N/GFjO966dyHjJTvqAOu5pJONn28DD3qrn2CKy/qIKpDGk8sRjUqa0rY07cW?=
 =?us-ascii?Q?+g8lD1jqQ0NLEweE6BkqMiYwxIGNZQCvHbFkOIrJWVjwhC2IIyCV+fK4em7E?=
 =?us-ascii?Q?p/jfAzC49HVttkODMAId2BFyA3d90MgnJzKAr/yu0rB9sspiiHlz4iMGeZlu?=
 =?us-ascii?Q?jRs9rxQMTFEy7PIVPIqMCl3ytdguq53eDmgsas5to5s28/NHZr5w6HSsmJs4?=
 =?us-ascii?Q?AMgM8d+kzVs3lIUbTEufRyrZG6hVwZ7xTH2j+LUon9bDhiTx5frpvGLF7LbO?=
 =?us-ascii?Q?SSeWeKdOca/3BBtPDa5iojClzrVEgl87CLsNuNFCGexma25kyRbmdU6ZihVc?=
 =?us-ascii?Q?9ri+PDBPbDXu1cUgLJWw9ankIdCpYEGYmQaFQ5Vx21T8Cmx+Uzn+JZQ6xL+x?=
 =?us-ascii?Q?sY/MY6FQAgWLtxejMzbIgXHp0TgMhgSllwDp1uaV2hjxrWPfCLU0JOWEnUfl?=
 =?us-ascii?Q?CaJenA5IMt+/PsH6zhZ3/eUNWhWx6YLS8sNhcLvPxiGm3ts0AmhVk+QLP+Ns?=
 =?us-ascii?Q?jvlvxdGqjkULdP0bSBp7CzUETl1ejEE5Zv8RE0EulXRQRtZJnHhuZgTNbK/f?=
 =?us-ascii?Q?w+CHd0jK1+JC4SnLAQp5dGJPHdywd3QVhr34tJ2c9TddseShude41Mc3FRlD?=
 =?us-ascii?Q?r7qrD/6VuC05vFWUoFMLB4Of?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b9d0c85-6f66-4792-10da-08d98ee1c77f
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0501MB2602.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2021 07:11:01.8123
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o/3zzgl7j+iiVn/DBUF94ywEg/p6qkuhuHUy/wht+8kRRBZfzNFNwGFXrvdogFPi80zz1ZBzHY0BF6LJSipRQ9cSwq4sekCidIGyIQ9fpKo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0501MB2780
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

During console setup imx_uart_console_setup() enables clocks, but they
are never disabled when the console is unregistered, this leads to
clk_prepare_enable() being called multiple times without a matching
clk_disable_unprepare() in case of unbind/bind.

Ensure that clock enable/disable are balanced adding
clk_disable_unprepare() in the console exit callback.

Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 drivers/tty/serial/imx.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 51a9f9423b1a..90f82e6c54e4 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -2124,12 +2124,24 @@ imx_uart_console_setup(struct console *co, char *options)
 	return retval;
 }
 
+static int
+imx_uart_console_exit(struct console *co)
+{
+	struct imx_port *sport = imx_uart_ports[co->index];
+
+	clk_disable_unprepare(sport->clk_per);
+	clk_disable_unprepare(sport->clk_ipg);
+
+	return 0;
+}
+
 static struct uart_driver imx_uart_uart_driver;
 static struct console imx_uart_console = {
 	.name		= DEV_NAME,
 	.write		= imx_uart_console_write,
 	.device		= uart_console_device,
 	.setup		= imx_uart_console_setup,
+	.exit		= imx_uart_console_exit,
 	.flags		= CON_PRINTBUFFER,
 	.index		= -1,
 	.data		= &imx_uart_uart_driver,
-- 
2.25.1

