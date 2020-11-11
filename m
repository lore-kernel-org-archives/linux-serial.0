Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFE2CC388F7
	for <linux-serial@archiver.kernel.org>; Wed, 11 Nov 2020 03:01:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 881BC2168B
	for <linux-serial@archiver.kernel.org>; Wed, 11 Nov 2020 03:01:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="U1B7Hfp4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725897AbgKKDBb (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 10 Nov 2020 22:01:31 -0500
Received: from mail-am6eur05on2045.outbound.protection.outlook.com ([40.107.22.45]:38368
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725839AbgKKDBa (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 10 Nov 2020 22:01:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g5Z7cTBWaZnlHGTABTu9gQ4oBocLQGZUB1r3jXt4mEDdJ+V0YxO3Nctat3nQJplLy5YRXtfRQmOwHp8+jo2Q7+8ytcIlO+HLpvM+kptlqzxw9/V8Hraqo9nIwrN9aRr6rysPQPRaEbj4YIl+9HTosAS88ZzSgL1L1tr8tkdAw/nrnMGIaJqmwZn/3aHiepd+PUibm5BHDYb0wLCbY7BEY0vL8TzhOAtz/qS98DQJyjsgULKaj2Rw6YYF6WDc8O7L8/PHVVgFyJJnH1Q/Azcv3/wsYWXjfVrmr1teobWgkC5nO1Gw3G32ra6Wko/N8AH5LKGYGPCR3m0/wRsFYZ1l7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LLUBSAtNeX+D1agxe36zUiz/1+8ZDH5GqAM8OuUsr3I=;
 b=PbbZ4/mKPrRfYkcO1fc+SKSOA8kQZAC650YrYoHAW6lwvE2AHBFrN3TjWmBYxEMgNMVhRqN/vVgMCOzr9I0AHR2nhcPOa6ygG78H5mv3pQsSBOcIlSrXb2hANoEblbxknKKca2lNA2W71kjX60Cu6F5CfXkd77/QZ7y44svdZSv4/T+Sy0NHCSV1QZQ4MC1nPj2wkG5av9pHq6UT4y7/SSdZJXRCXWScMwkSacnto/mZ3hSTMJL9adQKh6hwk88FGo4GBsrhZtRLO48+nBdGn+WDroe87BokbNx5V0PQBrG9MY+p3E85SHi3mNQhw4EWGod3A1rqDKabUXAejAT4+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LLUBSAtNeX+D1agxe36zUiz/1+8ZDH5GqAM8OuUsr3I=;
 b=U1B7Hfp4L/PaJjZO0BgHlnVkTx1gA2tUdm7mfyhZYdt3k8XleASVoGbkiS0jToddLPnNRoOveOXFb0Tr4Nt66Io9xuk3S/RLHM4QTJ0zWcnuAgsjHWH20zFs8LoOuqv4IlCZlk/hMZVm+hug7pjq2vJV9QaGaPPZG1b77qW78ig=
Authentication-Results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=nxp.com;
Received: from AM8PR04MB7315.eurprd04.prod.outlook.com (2603:10a6:20b:1d4::7)
 by AM0PR04MB6132.eurprd04.prod.outlook.com (2603:10a6:208:13c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Wed, 11 Nov
 2020 03:01:27 +0000
Received: from AM8PR04MB7315.eurprd04.prod.outlook.com
 ([fe80::11e6:d413:2d3d:d271]) by AM8PR04MB7315.eurprd04.prod.outlook.com
 ([fe80::11e6:d413:2d3d:d271%6]) with mapi id 15.20.3541.025; Wed, 11 Nov 2020
 03:01:27 +0000
From:   Fugang Duan <fugang.duan@nxp.com>
To:     gregkh@linuxfoundation.org, u.kleine-koenig@pengutronix.de
Cc:     linux-serial@vger.kernel.org, lukas@wunner.de, fugang.duan@nxp.com
Subject: [PATCH v2 tty/serial 1/1] tty: serial: imx: keep console clocks always on
Date:   Wed, 11 Nov 2020 10:51:36 +0800
Message-Id: <20201111025136.29818-1-fugang.duan@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: SG2PR06CA0093.apcprd06.prod.outlook.com
 (2603:1096:3:14::19) To AM8PR04MB7315.eurprd04.prod.outlook.com
 (2603:10a6:20b:1d4::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from b38611-OptiPlex-7040.ap.freescale.net (119.31.174.66) by SG2PR06CA0093.apcprd06.prod.outlook.com (2603:1096:3:14::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend Transport; Wed, 11 Nov 2020 03:01:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0733edb4-28a1-4040-7c69-08d885ee14df
X-MS-TrafficTypeDiagnostic: AM0PR04MB6132:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB61328492625225882C216054FFE80@AM0PR04MB6132.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:127;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XeoTE47CUfhMr60inQ6+uwoAk4/R7h5ViWP1C4tvBLw1/XRbacLqLuaI+KfhaJcex2J55ZhR+L/uD89E0msDouWaqvUzGjfpZlj0ksVG2nNWD3D9RfJv08sdfxZcGiaTmy3ko63poeDcLsg5KAs0R3NO+o5GLTqoBuUyayil92DiHjHwfnjbMY4+4b8/8SW9fhzW4+ubBZ4OEXK56IoF5qpsAbYlXKhrZJ9AtzqMBCDomuO/fFh77hSljD++M2kfdtyWRHrWyTpr971Orq4eMFPJ91DTzp9hwn3Gm7PzrTSlgzflxEcNfx7eaPtG9SpO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7315.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(346002)(396003)(376002)(39860400002)(8676002)(6512007)(1076003)(26005)(44832011)(186003)(16526019)(478600001)(86362001)(2906002)(6666004)(5660300002)(6506007)(956004)(2616005)(83380400001)(6486002)(8936002)(4326008)(66946007)(52116002)(66476007)(316002)(66556008)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 5isug1Fl3eOno8ImzsnoQ5igptSui1Z0HiAQNsNUxy5DLNiYbWU9EmzCBxEKWAERAC2UwtsPEqQdLjh+1SjEamwxJVP5evw3KVW0yfp11LHrXSosVMbRFNGOn4RuhsITcFWnSpibSIPB4r0s4PUSnmGYbX8/y0r3dkHZW1mLO/gResNl5otBfv3/O3t0+HgLkS60F3rJPxoicECeqdtWB4mnUzSFfsVninGs92xJBVUFAatQzurUhPD3+OzYlDBJwUD74xXCEdhakNJ6k4nrtpgnDcQod+uAZZqNBOK9CV5jIYtOg9cyh85pwp87pE+1n06GMLBeG/bGCQJWnXX8LVoeSooisN/gWG9hdO/mWZQi2LlZTxZ8InVIFsN+LrrH40FyRQteBUZaGlThJccfVxXXatVQY8zx7YJ64azT9uUe0JCDsKj+xalwVePVfg00vEtOoFOCGa/FR2tu3aZALck4g6+gD0u3NEOFpa7LFvgA3pSabI16HP8trBw9O7oswr42XmYQx9AuLPiX9bXdBkd/CS+09vln11NJ6oPp6tE6+Dc8uvrksrQfm5dIx+1JZ0zxnILE6D4LeP4AHwu/5CJTKt9LL9agm8CGxDQCmNkxpTpdl6yoMEhjbiMXcsO/bSN3C/dGYUHmi9AH57IAYg==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0733edb4-28a1-4040-7c69-08d885ee14df
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7315.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2020 03:01:27.3817
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jExmlWjfxnWG8Yj9a3ZsZEVvdPhJT+P/XsrlI3I/FnUyh1vxsIyZzc5p8MJBztR8RF4GLkcOOxsEBRl7K4qYNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6132
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

For below code, there has chance to cause deadlock in SMP system:
Thread 1:
clk_enable_lock();
pr_info("debug message");
clk_enable_unlock();

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

Fixes: 1cf93e0d5488 ("serial: imx: remove the uart_console() check")
Signed-off-by: Fugang Duan <fugang.duan@nxp.com>
---
v2: Add fixes tag in commit message.
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

