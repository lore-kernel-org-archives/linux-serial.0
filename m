Return-Path: <SRS0=KjKo=EP=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C722C2D0A3
	for <linux-serial@archiver.kernel.org>; Mon,  9 Nov 2020 09:24:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2C632076E
	for <linux-serial@archiver.kernel.org>; Mon,  9 Nov 2020 09:24:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Vvkkh6Zu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbgKIJYC (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 9 Nov 2020 04:24:02 -0500
Received: from mail-eopbgr50073.outbound.protection.outlook.com ([40.107.5.73]:38307
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725854AbgKIJYC (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 9 Nov 2020 04:24:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UqV6OVhzgyreRZFMBodsv8gweKc0HjEQpGsn0rySPJprPMpTC/Q4wtMoRDNzhC+hFJeENNvk9mwqxBuOPDYPVmLGh43DZhZkvkRRo1ObUBoTI0ey+kpMWzh9417qrKATuGiq+dBbwdZi8vQGXwJI9AW14oumnqEN+WY3S8lx9jQyYpnmtG4RaITvTCKYPl/Q/qhV2WiPlauZYniTNQYzMtL6JpBxYtdXGQUrR7w1LVKv2IWOk0E9yIj2AD1OooSPE05wCuJHQik4ktVUef/PLAY7rfL5lLWCVZpdo/wSDl3fUsMt0jVEbxro5cO51N7D0wu289RS2VaBs8xAbCJQ1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MJa/9lxCSx5mv7j72WQp89lz5bqQ1c36XgodlBXGvTU=;
 b=bo6f2OP3nKlN3gVd3/geZ1Vgu/wg38NQoH80PmtakgYSWJizc9m3J2rA0vgEqNAsJtOIiUhkpR3aHK7wxvJN+rAFqnzCkFa0ArhOXd23WLAW/5GRtB8UssDBH8kgpYos+m4FeJI3kwO4MiXIJyGrBu0EBz1KEHuiGtOVIeLO6q5Zuyyn59fR0l+keWekhmWfxZXn3+reoCq9qZb8HHMhWvrpEZNsIEgrqbHigqmtrHUtqYCE9IjG/t080dZavZyxbvNjbsxl/rFzm9pw/Qetm3Mf1bh7ZY3gsEUw5lPm3/gt6LEda25ej7tdJGXRysZfidKTKB7eyhLikIMZssdwIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MJa/9lxCSx5mv7j72WQp89lz5bqQ1c36XgodlBXGvTU=;
 b=Vvkkh6Zu3cB6sCDfRGhy3orP0p/ouZ1aegQjnE9nFDzY33SmFBlU26C1RecyYdXcdyNkQ8bEu+I+D9xaVIeqAHTSa8xIlvzlmnGGVw7TBTNyChmwMIrQJFAekhDqgXKnGyJ46xStsNxK216mrG7J+NYuCpReElClbk+58e7W43k=
Authentication-Results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=nxp.com;
Received: from AM8PR04MB7315.eurprd04.prod.outlook.com (2603:10a6:20b:1d4::7)
 by AM8PR04MB7315.eurprd04.prod.outlook.com (2603:10a6:20b:1d4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Mon, 9 Nov
 2020 09:23:58 +0000
Received: from AM8PR04MB7315.eurprd04.prod.outlook.com
 ([fe80::11e6:d413:2d3d:d271]) by AM8PR04MB7315.eurprd04.prod.outlook.com
 ([fe80::11e6:d413:2d3d:d271%6]) with mapi id 15.20.3541.025; Mon, 9 Nov 2020
 09:23:58 +0000
From:   Fugang Duan <fugang.duan@nxp.com>
To:     gregkh@linuxfoundation.org, u.kleine-koenig@pengutronix.de
Cc:     linux-serial@vger.kernel.org, lukas@wunner.de, fugang.duan@nxp.com
Subject: [PATCH tty/serial 1/1] tty: serial: imx: keep console clocks always on
Date:   Mon,  9 Nov 2020 17:14:03 +0800
Message-Id: <20201109091403.12515-1-fugang.duan@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: SG2PR06CA0166.apcprd06.prod.outlook.com
 (2603:1096:1:1e::20) To AM8PR04MB7315.eurprd04.prod.outlook.com
 (2603:10a6:20b:1d4::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from b38611-OptiPlex-7040.ap.freescale.net (119.31.174.66) by SG2PR06CA0166.apcprd06.prod.outlook.com (2603:1096:1:1e::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend Transport; Mon, 9 Nov 2020 09:23:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e3967c3f-6243-433e-ac4e-08d884913027
X-MS-TrafficTypeDiagnostic: AM8PR04MB7315:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM8PR04MB7315B23251D2AA7129909483FFEA0@AM8PR04MB7315.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:639;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o4MuJJwdmERx+vpQrxThaBYsVFM+4Fn+rGXZKBfkzMxh2VWPoxBjzffMOCyserBPb2FG2YZg5RxwpmG23wopkafaJd234SodRmbxDgA+O00H640ylfBHHVGQTG/8Az7mkpl6CuWQCEFpsbPS66NXyVLwpxyo9JhrvUzAxhuGePRtwrZtHrwcfxCwOH16ljoTqpR70oDlrCuHb5I89kHNd59cAkrORCAPYYT9PhC5GSveap6GZmAItIHAmJm/O2ZrPyxce09aPRBOk0izKtjuzOMc3hA505uXh7qL8lq38eYrPpXTGAu1CBx2Uo/oZxkO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7315.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(376002)(366004)(136003)(346002)(5660300002)(2906002)(86362001)(36756003)(66476007)(6486002)(83380400001)(66556008)(66946007)(316002)(2616005)(52116002)(6506007)(6666004)(44832011)(956004)(8936002)(8676002)(4326008)(478600001)(26005)(186003)(16526019)(6512007)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: iRvvj/9bcRpZWELmXonRJHGLz4DEQXBi4xpFa3ae3xvruYCXgOxOF2AZvrc8rtjqZmF7caR8Eq6eX/smMUop++Bv49LABgKY51RXRyjVoLPczO3JmVmXFA3TgcbdYwWw+FbruQAODvOcz6R37nypoRV1lg+vZh70aexzukZpqS5W9IANNsF403d8Fb8BXT/ZWBKoalfjOPfyI6tV/cgSc0/khVj7mG0ZUFLPVDPbv6DRBp3WlznIIO8Zdo7HDJVXel0KsnGJpO/tFI5V2FiWlX/rS+WZg9iP4brAX5fN0wvS1tQN2N4urDa7W27CMFjGLjFW970u3TGVg80+DXmwPwCC5o8RRZkSZfBr/OgJfCfFUzauDiSAMRxJ1EfFZh3L0ke0jGfXyiL0vbL7jkfoVY7txSLxunxrNNju6AaWjHOU6frA2Ct0t7dgy8TP/JzelNaJyyHvefuz0A+orJUCL3itk9TotK0J8WUOyYI1AoZwc5HbXeDWKdTyRQLHlLIkSMrEqRH0om9ZRxUsbkguydN+NfcT+xzUBuKfELBltUIYZcSISaELDvAwVXSOF1CQSY9xkU92BU3U3buu/I8tL2Mb1F+S+AlT5Kmd4Rrd1aJyxSKLzR2uLYlV4f4aV6lm8Sy45h8pw3umrmz7a3oq4g==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3967c3f-6243-433e-ac4e-08d884913027
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7315.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2020 09:23:58.7638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wgVfwA+jaO59z0yXRRAlhnnO9yaAclIUbVX57Up/o3d0AoEWL9diy6cmzOUuCt3Y6eEePGNUhMrjJLhHoprpIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7315
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

For below code, there has chance to cause deadlock in SMP system:
Thread 1:
clk_enable_lock();
pr_info("debug message");
clk_enable_unlock(flags);

Thread 2:
imx_uart_console_write()
	clk_enable()
		clk_enable_lock();

Thread 1:
Acuired clk enable_lock -> printk -> console_trylock_spinning
Thread 2:
console_unlock() -> imx_uart_console_write -> clk_disable -> Acquite clk enable_lock

So the patch is to keep console port clocks always on like
other console drivers.

Signed-off-by: Fugang Duan <fugang.duan@nxp.com>
---
 drivers/tty/serial/imx.c | 19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 1731d9728865..4d6c009ddc31 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -2004,15 +2004,6 @@ imx_uart_console_write(struct console *co, const char *s, unsigned int count)
 	int locked = 1;
 	int retval;
 
-	retval = clk_enable(sport->clk_per);
-	if (retval)
-		return;
-	retval = clk_enable(sport->clk_ipg);
-	if (retval) {
-		clk_disable(sport->clk_per);
-		return;
-	}
-
 	if (sport->port.sysrq)
 		locked = 0;
 	else if (oops_in_progress)
@@ -2047,9 +2038,6 @@ imx_uart_console_write(struct console *co, const char *s, unsigned int count)
 
 	if (locked)
 		spin_unlock_irqrestore(&sport->port.lock, flags);
-
-	clk_disable(sport->clk_ipg);
-	clk_disable(sport->clk_per);
 }
 
 /*
@@ -2150,15 +2138,14 @@ imx_uart_console_setup(struct console *co, char *options)
 
 	retval = uart_set_options(&sport->port, co, baud, parity, bits, flow);
 
-	clk_disable(sport->clk_ipg);
 	if (retval) {
-		clk_unprepare(sport->clk_ipg);
+		clk_disable_unprepare(sport->clk_ipg);
 		goto error_console;
 	}
 
-	retval = clk_prepare(sport->clk_per);
+	retval = clk_prepare_enable(sport->clk_per);
 	if (retval)
-		clk_unprepare(sport->clk_ipg);
+		clk_disable_unprepare(sport->clk_ipg);
 
 error_console:
 	return retval;
-- 
2.17.1

