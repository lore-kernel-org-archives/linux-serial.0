Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C84C4C433EF
	for <linux-serial@archiver.kernel.org>; Wed, 20 Oct 2021 19:27:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A508860ED3
	for <linux-serial@archiver.kernel.org>; Wed, 20 Oct 2021 19:27:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231622AbhJTT31 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 20 Oct 2021 15:29:27 -0400
Received: from mail-eopbgr80120.outbound.protection.outlook.com ([40.107.8.120]:1212
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231612AbhJTT30 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 20 Oct 2021 15:29:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K1reiMRBXuS9Iwp485VuPgtmoQ+kIdx3Tixqd6LxNPXJDlGXXB44FBlEwJyKDavjjV9r1Xub2aDgW3OwjXdqinTZQoA3IdRin2t2ziY9j1AKUdJQWWxWYVTs3ahiCbTbOhXwAd1E9ejQ1WhTXnLVNZqpqjHIK0QHunrpXEhud9MENmC+o2MYMfB3f9BPGoPaQ50KzjlJXWFPhNRQvfPyemY44Ih6PVtilnpQWjk/E7r8niAMfp5eBYwh989OrbwlikQX5EJ0CG2sKEYgb2cHDnFn1fpCR1c082yOU6WUpPOJxsYC59sypa8BRx2Fvofl+KoyMC5GFTT2w/hC0qE8Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uk4Aq+3imqvr/LIjNMIF8PPZuSEipaDzcqXRp6mLp00=;
 b=Q4Oq0dW9vGYSiOtd883hgbv42fPhnZIxdugUyPCL8fVYCIiHJ5rs3PNShP+wC2KG49l06bu1pbea2khSpZua4/ZjKQW/z1uWqhr2OZnK2qkhDxWFXTtUH77jt2JUTl7SlsAQ9CZM5EOHtPVgVxr3y+kUm0mbMlFN7uvtN7+En1Ic3r2YyToKnWhyVGZYYS+yLBGEwCA7sRH++1zSAvaDN5ObUQSTmMgt1pkkYGPYzy1Iwgv5/Qyd8pZWTp5QngWqmHeOeWAjncrvBP/zEcJ7Vqv0iYdV7+So/YOnDsZYVdWhKf+gXyTMIe3xJLzh/d+mrPjCbPXjHXBf7f92WdYAIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uk4Aq+3imqvr/LIjNMIF8PPZuSEipaDzcqXRp6mLp00=;
 b=hF1n65pSIOzKcByyLpF9wZkJ2Z2arVIPVjJVUOE9pOSG7xA4nMPM/mz5RJnAX43+UL1B4tWopKpu+kTREJgW6OWEK8d97kldYL1GOmAYROSJwpfDuRj7EH+qxeqSwpsE1yhz4/d+b/9U22F7FJ4PU35seiHcEkFwhJESyCOXnBg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toradex.com;
Received: from DBAPR05MB7445.eurprd05.prod.outlook.com (2603:10a6:10:1a0::8)
 by DB7PR05MB5338.eurprd05.prod.outlook.com (2603:10a6:10:64::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15; Wed, 20 Oct
 2021 19:27:07 +0000
Received: from DBAPR05MB7445.eurprd05.prod.outlook.com
 ([fe80::98f8:53ac:8110:c783]) by DBAPR05MB7445.eurprd05.prod.outlook.com
 ([fe80::98f8:53ac:8110:c783%3]) with mapi id 15.20.4628.016; Wed, 20 Oct 2021
 19:27:07 +0000
From:   Francesco Dolcini <francesco.dolcini@toradex.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] serial: imx: disable console clocks on unregister
Date:   Wed, 20 Oct 2021 21:26:43 +0200
Message-Id: <20211020192643.476895-3-francesco.dolcini@toradex.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211020192643.476895-1-francesco.dolcini@toradex.com>
References: <20211020192643.476895-1-francesco.dolcini@toradex.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV0P278CA0062.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:2a::13) To DBAPR05MB7445.eurprd05.prod.outlook.com
 (2603:10a6:10:1a0::8)
MIME-Version: 1.0
Received: from francesco-nb.toradex.int (93.49.2.63) by GV0P278CA0062.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:2a::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18 via Frontend Transport; Wed, 20 Oct 2021 19:27:07 +0000
Received: by francesco-nb.toradex.int (Postfix, from userid 1000)       id 069B410A3948; Wed, 20 Oct 2021 21:27:06 +0200 (CEST)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aed2924a-e91c-438a-4dac-08d993ff9ad1
X-MS-TrafficTypeDiagnostic: DB7PR05MB5338:
X-Microsoft-Antispam-PRVS: <DB7PR05MB5338F4168EEF95DE36137221E2BE9@DB7PR05MB5338.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mORYzimFQMJ4l3L52JsjHnHzDCEm9w3oNht+ltGIMYNn7uW4huTvJn2gBDXQEBrUzHmddlvMcyiLOBM2DaINPZqDgJt3a3EHnmsing6ppBXHvUFPaSM/w2t4iUmVjRz7HdbP6omt96ET7l/zAjQUW08MOAaPNKhrNVB5DESHTp/2T+lxRY2a9m/PQ+Bo5Uto78awI3YyP6+1LJepbjRcKYIFlf2p7j5UT8LUN3a/Z3yQjCPDlG1IhZafriJ41qaBwpEM37ml/e/BiEO/Ux+2p0+nOatdmx/Lgfntubdve8H87waX1bK1uBir4ZwHs3xdwpX2Qh/p0oKn3sD44POVWHS9PgbRXBJ2wawywpTPWjAy6BO6wdOBvjMbuT5vURa16p02jpOJT5DybgpKaBNn7SVaHF30Tc0pn6NHEsvU3k84aKZNV2bc7PdX3fTf7NtgumE9WOWnPAHoelBx9qbpWCoBEjqvM+g2SShFagy9UJqoYdAoeuoFnrgu6u0WdCpO+lk0Y+Tb943ZYnwpCO84P12qR3wwFCbFOZ4KZNUcDzM+L05b+E8gFa3QcSJdGCmKh9JbTyzYCbZbOXvhO+P4le/QjbClj/1QGEx42guWafJq4p9591ED6Hf5jkTxmu5VlZah3bAYR9wCDzlKYbtFQJpQJsCEfTLSOwxlZmIPRGoGwfaoqK8zG0f9/GWQh9S8e3y1LWEMEezFJurROKnM3w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBAPR05MB7445.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39850400004)(346002)(136003)(366004)(396003)(38100700002)(38350700002)(86362001)(66556008)(66946007)(7416002)(6666004)(186003)(66476007)(1076003)(83380400001)(508600001)(2906002)(44832011)(42186006)(316002)(36756003)(6266002)(52116002)(8936002)(5660300002)(4326008)(26005)(110136005)(8676002)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UdWyOD67mEi3ZChrlf8Mfc5da8b3wN77ZeRqwC/lMy5Hkz4QJEaFqKEfxqIc?=
 =?us-ascii?Q?x6AZqL3YdiXewaKO0nm7tfo0RyXT82+LSobJku3MSMRdFWVNbacie18rWMr1?=
 =?us-ascii?Q?hdzLEdX4vhIptN4iOx1UGPlsVVscIZFh/YQ5Ut6TIxfmR/kg5ZNbRtZcv0N3?=
 =?us-ascii?Q?+7vXg6jFuPSHtcQt4kkeFVCVXSIBVOI3BrBEhDWEtGegoFMlmKwpTfR32UjD?=
 =?us-ascii?Q?LIapCyQgQVVLbdvvFLIl+gv28dlYFkCfloDmcnMUF+CthdcTwiqfGzs7CBCx?=
 =?us-ascii?Q?hch9gFtTfNW0ZDR4J7QfOZQBv52Cz3RjGlGpRn1sYbVLsBhsNukzf42VQgJZ?=
 =?us-ascii?Q?ZqyywrTQpg2fyP50DGlo46ihSXUS8WAru/Nvi2ILL4KsrgaCA14KpizdbRPW?=
 =?us-ascii?Q?EyGZMcMCx9busc31F7hC/eRX04nOu0vbrZqYs3i/dHnx9sK+SkkNPnqEBZvP?=
 =?us-ascii?Q?fSgkzCqz+L8wNw2mVLXVmfWAwfANjg+sWBu92jewbrgjH9Dgg4pgbIvuKS5/?=
 =?us-ascii?Q?L1QNyzQsplGGkO7zcpJ5symq2gXzlBs+f6zblXYzYo2YpgcknIK7kcSaj9sA?=
 =?us-ascii?Q?hyYWQkSkSkXSlOxzJizThx3U6mK9Y+y2nG4sqbCHXMLUbUI/6LOeE+qz0llk?=
 =?us-ascii?Q?Qk/I07a0zpjqdeOeM88clBled9zcTqEic4iCMvf8/BZdP5yspZAa4ClwAlOC?=
 =?us-ascii?Q?ZvdH3C/rxwJlHLVK+xss51HqboC2N66msmCbkzZKA032qHxLcZKZxLqPNUgk?=
 =?us-ascii?Q?aBCxe81U7Qs9HN+GCnY1EikqrqgxNniZ4nN7Z0swNcybiLcO9xO7Pa2ySkPH?=
 =?us-ascii?Q?1ZedqbgDur9+FLRqTTQQr6ngHbPURL51jIBG2CGc5hSx3ZXkK8e9zMw0Fzmg?=
 =?us-ascii?Q?kwPto9FdjJo68k04v+mkww1GZmKZy1LuJ2qwkZq3qClsg6ZTKhE5etyMTaCW?=
 =?us-ascii?Q?wi+gCHbbUkR+rGV8gX/YyvA6ZluHPJfxDcV+U9zP2tNZFuERpBXx+MuA0OE8?=
 =?us-ascii?Q?a1+r37bxn8efATOthiblPiCgBKK+EXt7wzaTkyEJUKywld89CvumgJqvByXj?=
 =?us-ascii?Q?1D9mDVXWflA3d8ndeBQeJnIL94Hb8m+Z5pr6hNrujgOIcGeJ8Ze0wEKrYTT7?=
 =?us-ascii?Q?5hfAned2AW+ja1cGvJhOqBjDiqoEffrGSld5H3oHrxMCkFZSb6I2Gy/Y3mvc?=
 =?us-ascii?Q?GJY5LS8HbaXocpXQ5zNqjvGSSakXdYz8ZF5Kc1DtZy0Qmf/iscVarZZZeaFZ?=
 =?us-ascii?Q?JMV29vc1UfV3QbSUBzNbfe83BlVF5K4xtFbgbWNJwPqxfEJTuW3AD9m1CXtz?=
 =?us-ascii?Q?N5xInCB04MxOTANu9MHpn7FDFNcTnxfpjU8TDm6DCmQi2Wt+kqKMjuGc+d7o?=
 =?us-ascii?Q?3RL757USJxAXN7VpWhZkIXjJ8WxIK0qQugJTuj0siNNIZvScEPLRfMgdl5Km?=
 =?us-ascii?Q?1SvnpkgSVYL7q1M+Ov85nRZTG8tIEci8AgXzfGkSASBmy2u94arDu4QavgQm?=
 =?us-ascii?Q?sfhtH0l+qHjc5AGSW7Xcd9PVTm86G97fpLjWekWCwzUDcZfO6PgJLL1Su5zR?=
 =?us-ascii?Q?9dJT8SOXjKANSH/bM5hlpNTEw48DpDpDySP+ghQNOSBb6l5Ad9cE7nlfNjaO?=
 =?us-ascii?Q?p2ZKN8H0o9DsRvqq5B/HkT8uNyAXlirbPS8TdHbTM3c/afDBXlBc7IPASid4?=
 =?us-ascii?Q?9VvZoQ=3D=3D?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aed2924a-e91c-438a-4dac-08d993ff9ad1
X-MS-Exchange-CrossTenant-AuthSource: DBAPR05MB7445.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2021 19:27:07.3704
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WA7vn/lht/mTi8MZorIF2nBzJwkPJAnIXUA5ATW6Q/liGj9roII6EdFIkqOh3v04N7+uSaaDpWUcx038zh7ybpXqpwViKCBGJHNfESr6Kpg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR05MB5338
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

During console setup imx_uart_console_setup() enables clocks, but they
are never disabled when the console is unregistered, this leads to
clk_prepare_enable() being called multiple times without a matching
clk_disable_unprepare() in case of console unregister.

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

