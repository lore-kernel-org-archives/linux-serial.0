Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8982C4338F
	for <linux-serial@archiver.kernel.org>; Thu, 19 Aug 2021 02:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADF69610FD
	for <linux-serial@archiver.kernel.org>; Thu, 19 Aug 2021 02:11:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235558AbhHSCMZ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 18 Aug 2021 22:12:25 -0400
Received: from mail-db8eur05on2082.outbound.protection.outlook.com ([40.107.20.82]:23521
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235384AbhHSCMY (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 18 Aug 2021 22:12:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eye0bf5YZndkOVeCBiM9p2Qtk81LcdQZk7dcoMaZYwWk1/EaxqKIBKG3nIQUCjEF6RLHQAfu5oyWmHkOBOjmaIijLuDSbpkf9+saWIPmsBcYYG1yOHSpiGGYglNOp14bROBzh7CVbbHfJpwTaNbCiOHnZiU6Z2uj3LDNxMhGPd+ypR22L4ECu2g8OOumU1Vvjm+gBQYfkzvMfY6lOfyPZx6omOx49OMBltg+PZN3hVtQdsPWvDLPS+9b53tSWPAsDpg5ZXMgwq8u5qX3YxE2z9puTgO+pdieac86GyUYEw+mL8qDVxB/p/Jl4uWmzmwBMuZY6FDPsfQdgB4Wv3ZQbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cd3CrGWKXNbJ0lFlUToA2eZ7qsaZRo1E/cTkjc6D/wE=;
 b=LO+QMqL6caFmKwGQGZWN8We+s8nOdDmx8XT9cxCCGTy5rfBXPB5+snbmKWxQLJunDOFvzbXquLKjq7XNIo1XwPe8f2wa6eOGmp7uKCVjee19UPIrMs80fhbAPTDsL6LZznuCj/DOqGZCPyHplbbmoRcuIfC/mlEsY9rIqfF09mQUqnsPgbAEwv1Qqn8y0JF5M3nD/wpqTHlQJ5FuAdxGJmpHVIwzpNPnR70lntUTMDtc3S2NqwCxiGB+6jAy1mak9NQuaJCv2Jdiy6vbQkQfTzUNT9dFKVsyXGRxsWP83RVqrAl+0rufKeZxBaFzOuU8UVUuv8dy4fRJ4FDwgX9FVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cd3CrGWKXNbJ0lFlUToA2eZ7qsaZRo1E/cTkjc6D/wE=;
 b=N7xZko4UuGJm3ujmh0tOfOVabwWklQJb8e+x6EPoCHQUrsNu28gqetdPSM64s4NuEBmbiLL2X5+rTvlUrln+XHzGOShzYHZnxWw2+dlqe1Onb82rAPXWN8eUsG5dcXehLKY3j2CyNc37tzxg2e9rQFjehpllqeyiMMclcWMHeIE=
Authentication-Results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=nxp.com;
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by AM6PR04MB5830.eurprd04.prod.outlook.com (2603:10a6:20b:ac::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.19; Thu, 19 Aug
 2021 02:11:47 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::91c1:5ce4:cc:ddcd]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::91c1:5ce4:cc:ddcd%8]) with mapi id 15.20.4436.019; Thu, 19 Aug 2021
 02:11:47 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, festevam@gmail.com
Subject: [PATCH V3] tty: serial: fsl_lpuart: fix the wrong mapbase value
Date:   Thu, 19 Aug 2021 10:10:33 +0800
Message-Id: <20210819021033.32606-1-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0201.apcprd06.prod.outlook.com (2603:1096:4:1::33)
 To AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.71) by SG2PR06CA0201.apcprd06.prod.outlook.com (2603:1096:4:1::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Thu, 19 Aug 2021 02:11:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5aeda286-fb24-4304-ae0f-08d962b6b272
X-MS-TrafficTypeDiagnostic: AM6PR04MB5830:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB5830803D92BCB6CA3E2C50BC92C09@AM6PR04MB5830.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fNoXFOH8ODmP06Zh1MaXzE1hQqTFKITuws+8lJf0/6Z1Lgv7Wd8zlcAGxJF5bSeopSt57v63bs/fyENObxHKIBx9CUobwukkoPDzv5taQrtxz81zX1txfZW41ZmyoIwmahpiNRTaYEni1AWK6bsve5FexfddXaTwGMaMOm+YY+wM5yZWWOUZbrBisT7n1QX4cMCSigZMahhj7FoClS8lAOA5Iq/ueXv00CqSDlWl8h51Q+0edXnHx43Bebtp+kGLv4Pc9Qwh+K7b2Q2MpHejyeOLaoTScGWuXhlYtEbM5sBbPvx5AElt2FyqfGczH1iJ8XHoY2tWLzVxc6FVc3M/y/trI+6JZvJOYy9T81vul9qhY38/JXLmnl798I5nfW6tWHryK/p1SLWQ7soZvgpGiQQoMpn2xA0W+RoIk9fON1WYWwHUxCdCikuC9Pr4OUBqz1xNhym9EnR2UvEPC+fsfM0dinAQkTeCUa3kGzSV0ouDMmU5iACViPybcgTEUJNQ9HLECP0YfE/o8iDkoEHnOSTQOVNChYvL5dailEhMMJxuPgyRLe6HYgew4Mc2ytMgRD3UwIxN5Z6HwWaFX16JgvXjoLpAhngD7LYdCF8pDvKkStei27JtJoz5PH8/161Kaf8yH/WGbXa+KvV3PxqZ8kaVgoYy5r2PcQ7vJblnl0qMjfgYoKA6dSxd+Dvb8JFrdkR9bfu7fy6onPxQWH8hiw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(396003)(39860400002)(376002)(346002)(8936002)(1076003)(6512007)(478600001)(4326008)(38100700002)(8676002)(66556008)(26005)(66476007)(38350700002)(316002)(6506007)(2906002)(2616005)(6486002)(186003)(66946007)(52116002)(956004)(5660300002)(36756003)(6666004)(44832011)(83380400001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fkln1J5vlbFgNpK63BtsPPKkco52LBrVnEHMnCz1cZEdaOh+tZVPVq1pJEIx?=
 =?us-ascii?Q?SKLTzzV2K725y67Zzw0SrWNOWvsEXa5glTT1Fcf+XCgMDSSy569oHhVsjjj9?=
 =?us-ascii?Q?ftrmfiXVQ6i3qfO/+VPOqKT80VWMnviCqPDtWa776P/e8Ngc36Oxyb+ZDhzu?=
 =?us-ascii?Q?GxC+s2j9lc1xl9ouJRt9L1QYC9/5wU+ybkOy6PAAOaTvPbm2pSFRnSaOS4L4?=
 =?us-ascii?Q?2ZAKN+bo5VuaMeFufm3vVfpYt87k/COt6n0imJ+BRXEkPKj0ilRxppPNw62Z?=
 =?us-ascii?Q?umUIxgGocaTmJj+4uOWDfuhg8i/Zwb/E0Sp91eynj7ZeJzTRQrnZdZsi1Z0A?=
 =?us-ascii?Q?OOrWobsl225d34LkX+YctUwA30sOThojviOnhGzrHEP9kJirhyhTY4Es11pz?=
 =?us-ascii?Q?USKPnpjFWooQCPxfOoW5bs5aCvIBbZVl1ZLMmfigJGjwATrmkVqNOQRp4FFb?=
 =?us-ascii?Q?DvN3TVGtU9UNRdE2fPAnK4JMCi/r2E9W5pwdAnO/zfAMbK69fSFPr0DayOrA?=
 =?us-ascii?Q?Tz5W3d+mrhi+a3fOrLSdcbSOLeR+PIzwrHRNapy16zJIU6gAKeEZKiS+2d61?=
 =?us-ascii?Q?bpDGzWuD9FN+bBc0TWWbbA0bdRySGQHCY93sLiz3Xjb2tMNeMU/9fCiWKJrW?=
 =?us-ascii?Q?G/Q3Etn7/Uywsk8cwSr6P/POsFxXsNc8oGy3gvQzeMn5j4BrwYFcTx78ic6U?=
 =?us-ascii?Q?9effIGIECIn3M/Z1ZA2xN2KHsNZ1pB1fkLYT9295gWuLUS7HEeAdfNSjsPbO?=
 =?us-ascii?Q?f4SL5TG35CvbxocNLc3NHZ/TzucRfZp1g7csiiaeD/OjIdKGreMmsZj31ues?=
 =?us-ascii?Q?KdFVK0HxZsDP9kyblFbQ4O3PmJgb7usmXyhKmnFQHCEOBwqqD4bZJ8woEl0d?=
 =?us-ascii?Q?lPW8sTArt8wNQWeQt/hsyvWqmdZXrYj8QsENtB8tklFdAKyL5tw8JMSHVkw4?=
 =?us-ascii?Q?81q568HBaolZsjVWUV7Aj7ULF3UwnLSlvAOnQPgEsJfQVR6JtqHGft7yY5my?=
 =?us-ascii?Q?qD1Jlu7MdCuCJ5mwcF3nZzQJ0hrJm44JwuS5zdu1rRZBJsQjyqJu6qNcCOUg?=
 =?us-ascii?Q?2oeu5iKKxSZ0xDMooWg+uzHJ5EUYQQIfQ6wdhnn4Oth1l3zywkeoShx/0jyH?=
 =?us-ascii?Q?rSb8Xu7HN48Lx9CDupmsZrStqHwyfLFD/Uti4RQK7qAwCypDA0R5qoxa7IBA?=
 =?us-ascii?Q?SH1KvTNsHC4aFDV5bzPLwG886518hUBHdM1GfuvfbnAWSkDFocNZsGGyjevS?=
 =?us-ascii?Q?ad0hh9GuLdbUoFiTEMpReGLM5JEyM22oidJMwaOzP7DJL0qHy4oXIVajd6Et?=
 =?us-ascii?Q?Dy+2OMRFmAEQJ2veCOwTC4yo?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aeda286-fb24-4304-ae0f-08d962b6b272
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2021 02:11:46.9883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7nwHNrpvx4XvHxlEflGBJfQAFTkxJ32j21qQuETmyFchm4cNMfdPxm2bHJTbNij9FUeYeVse6Vt9il9g/mYesg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5830
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Andy Duan <fugang.duan@nxp.com>

Register offset needs to be applied on mapbase also.
dma_tx/rx_request use the physical address of UARTDATA.
Register offset is currently only applied to membase (the
corresponding virtual addr) but not on mapbase.

Fixes: 24b1e5f0e83c ("tty: serial: lpuart: add imx7ulp support")
Reviewed-by: Leonard Crestez <leonard.crestez@nxp.com>
Signed-off-by: Adriana Reus <adriana.reus@nxp.com>
Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
Signed-off-by: Andy Duan <fugang.duan@nxp.com>
---
changes in V3:
  Add the Fixes tag suggested by Fabio.
changes in V2:
  Add author signed-off-by tag suggested by Greg.
---
 drivers/tty/serial/fsl_lpuart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 31d715c4787a..117e011aff5f 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -2615,7 +2615,7 @@ static int lpuart_probe(struct platform_device *pdev)
 		return PTR_ERR(sport->port.membase);
 
 	sport->port.membase += sdata->reg_off;
-	sport->port.mapbase = res->start;
+	sport->port.mapbase = res->start + sdata->reg_off;
 	sport->port.dev = &pdev->dev;
 	sport->port.type = PORT_LPUART;
 	sport->devtype = sdata->devtype;
-- 
2.17.1

