Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ED7CC4338F
	for <linux-serial@archiver.kernel.org>; Tue, 17 Aug 2021 06:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2082160F5E
	for <linux-serial@archiver.kernel.org>; Tue, 17 Aug 2021 06:32:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbhHQGcm (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 17 Aug 2021 02:32:42 -0400
Received: from mail-vi1eur05on2074.outbound.protection.outlook.com ([40.107.21.74]:47916
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229460AbhHQGcm (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 17 Aug 2021 02:32:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qj5SBAywDlzpKTG2DuNFKi9oNKA8UdQtAxHu8oekiunbI/bNI4QK+ObcjUL+HDaXmEVdDi0j4XBT+0ayyPjjHAvbzlWFlG4ndOKhZr/HT/aLZP+S5IPAn23fKbA+JZTsxLU5lvt6IYu24VDd1SZd9jVAvKSwfFO0fhs5guYctMPpUbAAVuLg80y5OEHvygEoaTh8r0/jKCAJzXxOyKg/FnAjjxFu9VDlPGeDs03axzqT0HVXhwVE95bdDsfcZssC3VjHpSTASqrTQLNPIGxrF76n4fRkQr3Zwn4GdKFXWwhbvbI9CyJ2qnfQvx2N4mjaw50xfj3ZgUXGuy/yNmpUng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D58NpB6VxivbPFhWBfpLFFvwLa+FemDz00tGICNWh74=;
 b=Y2BrR3VieAnAZ5Ws9CHVio5ije2ZegHrP8lIC9avyvzr9bIAbJZ9q9aHenjhyTJtpNCfmf0eFMayXeJbdql0pJOoRFpiEyOAAutqZR9luwjvVeFmUDUkMNLhwO1rxcIK8hCFlNSbum4fMKAA0Q0WvJhdd5TgZ1sjXX2DbO+BKQjnTMIMRLzCC5ymDSVuVk+TC5QRahLM31k5lDY/E8tLrdOwxttgB7gpAGzZ79WICttTK2Fvz9r5mGoNC35NBPyksknBK5HaOZGAo7TM8RDzhUecFT37e2SaCY8BY84ykB3+2UTbxUCqWZCit9WSDDnBqFXcXvj12NBDN4rLrSxJDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D58NpB6VxivbPFhWBfpLFFvwLa+FemDz00tGICNWh74=;
 b=hm4kmYXvjG6BWXvIbxNeU1kaXMgV53hODrn++N4d/d4w5ItW5VRfkpQuRcgXHTG9zwdiR3Dw3+smtifurluFoMiiIryyg4HJ2/TIZQu3VhwfnK7HfZjvbzeq6LwI1NPeFmpNxpZjnmsPL6F9fwHtcSFblJvidVII/k4ghSdb+SE=
Authentication-Results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=nxp.com;
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by AM5PR0402MB2913.eurprd04.prod.outlook.com (2603:10a6:203:9a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.15; Tue, 17 Aug
 2021 06:32:07 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::91c1:5ce4:cc:ddcd]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::91c1:5ce4:cc:ddcd%6]) with mapi id 15.20.4415.024; Tue, 17 Aug 2021
 06:32:07 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH] tty: serial: fsl_lpuart: fix the wrong mapbase value
Date:   Tue, 17 Aug 2021 14:30:58 +0800
Message-Id: <20210817063058.4718-1-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0013.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::12) To AS8PR04MB8404.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f8::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.71) by SI2P153CA0013.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.1 via Frontend Transport; Tue, 17 Aug 2021 06:32:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 206474ee-b4e2-4338-9862-08d96148bc25
X-MS-TrafficTypeDiagnostic: AM5PR0402MB2913:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0402MB29132CF00A47B61CB0F3680392FE9@AM5PR0402MB2913.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ps78gNV9RM8ueaOb5lPORXrkvqC9Y4bShUha1yyrjfwY/yrhpVsakSA+9UKKtftcy5iWay6jUHVek8x1F23UmYLZGq0INW6zZRKUlH9vN2BuXuWm06UF78vLNduvgkYCk0HyHbO75ya0c15e4E2b4F7i5u5ZYGYiBNGqn354Pp8eNmYabKnENqoHhbyR3mgJ+/bHAMwZ3Ljy6C9E6VgRJ6MmKJBhlembMlx06O95jwQMrCTHidq2/26vQ35PdCtQea/EFgTU3/6hl8HBszv0Nb0k4+LaUJwjr1mkIF0D1Ief4QTvP7jYXW52g9W2dhGchRBYmJBZvX4lXTQHlIDoKuAAHvFKM++FRuhvKeAE1lFX/5nnaNWP/2Hn19LcrXCu+uFNfZs47E44il8yyDrJHHkanlgXCLrH85erT7XgtrxucNeOxyjS2wVJJf2C8V6zcHlpjk1pOoUkxVIdlexU2XyqSJzXHS/894ILoD0cqP4zp/5E24Xsq0tHqVfJCzSNec5TNZi2vXcaLk2UxZSsDcdlbPkE+BwAPg4bDvXS7q6d9GLMz6qQhnJsDx+Vbq/Y7NAHgTpoTIKP25SBkzgQU27kVXIoLYyPVK0+emKnG2mFEoICkmuqhz6Cqvy3msFl4Ksp/DE+0fFgQqkakyFWWnc4k2cx5yFu+BLJVhFXBwPjqJcezlHAaxSumuu1u/69l5SKG0pXSW+wAnPtKRslXw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39850400004)(136003)(366004)(376002)(346002)(478600001)(44832011)(83380400001)(5660300002)(86362001)(1076003)(36756003)(52116002)(4326008)(6666004)(8936002)(316002)(38350700002)(38100700002)(8676002)(6506007)(956004)(26005)(6512007)(2616005)(2906002)(6486002)(186003)(66556008)(66476007)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7Es1Lhm4GLz7Z7UJzL0gRg66l8uSpSqL8MHA5Crxf0hP9LVY7XQU56/sehaH?=
 =?us-ascii?Q?4QbVGIWt5pgnZLVbEAny0X5w66QOL2jMtLaatngXZ7jM6BL+zd9LXGEvgzMR?=
 =?us-ascii?Q?t7KvUsi1LRlr+c6Q6yWy9wYSKG2AfCxksuTn2WPdrW0oFHS+GAwIOwDGhjYK?=
 =?us-ascii?Q?Q3qPKoA1RXs6BdxHx9KC2cOroIwvqc1tL6nR00qWVUQoooH95XwJUQFXKn0W?=
 =?us-ascii?Q?iGNFOtxJSS1gXR5j4wrkFDHdJAvtddWW/KF2H1E7HUioRo9+vZ6t982W3wZq?=
 =?us-ascii?Q?y1vTyeMbkR8h/NOfLCDYXzmRRM+3p7EdEF/bBzZKH7lrDcXQFIMI6+4AlK9N?=
 =?us-ascii?Q?eUYKeG0020ouyD/h5TOXagP1fHNz7omtOMCXb6ViBzwV97UhK6/O31kN4Tsm?=
 =?us-ascii?Q?p1EVPwo76U9erxD98SQq7eyrGseyoTLaa+8S+MJZpH87L5qTYMOk8b2Kfd8/?=
 =?us-ascii?Q?iRmaqFvCngn/IYGre9AQgmu1x84CWNDSYDngf0eO5wN6rxqgqd+dcw8EI3k5?=
 =?us-ascii?Q?3KzB9bARJLE6cYsdJMBg9Qbl5tD+l2PdbZFzuaT4lS97pNyYMsq/n2ALmL0u?=
 =?us-ascii?Q?WntylKZ9aE5R54OqVVZS4x/XSAYBc5z7zdhY99TtpTFwe4zdOKZTfqYfz9dk?=
 =?us-ascii?Q?Pgw5ODtqHd7z4i2ZBaQWQ6O9W/WEfKqN2avNsG4YlNPQ1NR4EuRbhf5V4AJw?=
 =?us-ascii?Q?wn1W5QhkjqvfpnBphwIBw1E4FFLdd79R1klGBV0IdJLF4ZzoeorEEtYVq5Gd?=
 =?us-ascii?Q?09IKI6Crip+aJfkkJhytewpzBhSoAY1b/tKrdZYKJk+Ll65Fu085xN061SEy?=
 =?us-ascii?Q?EHhg24w1d4E6Hnu/9EQswsA0x/EzfNwiSqPHb3o5trSyJWANQKBnV/5x6xHG?=
 =?us-ascii?Q?B3KN6fuPimY1hljfCdqspLz9djLuBfldyeQR088M8LQM5I84HucPco0hm+0v?=
 =?us-ascii?Q?vtQN6Nu3ZPAH5fxyG/NzcAkaojQKpYkppDnpOEXHAiDVYueEQc4K/K+FQ1o+?=
 =?us-ascii?Q?SiDuOSMfoujTjLjRA7+o0n/8I0PioXGTFDejyhGFn4FlY7vapB6sf65f32R+?=
 =?us-ascii?Q?iE7s7SNgQUwa0Oto7nNxt+jPYRoyFYxPhNx4ASKVX4FafEfwB18jbYwab8vT?=
 =?us-ascii?Q?NcB9uJzYocaOMhM9WFRmOuSiz5Fiq7SKf2ONzAg14G8hIsTMalHUVnI5OCpq?=
 =?us-ascii?Q?piCyf8Ms1TH1+M50pDLITEZpBmDcyx4V70oYkTjvTiLA9Yg5qSaWvT3PF1bF?=
 =?us-ascii?Q?2rk1Lv9pU28xskr5Jtw47niWZJAeHhbL+Z0F0yZV+ASYGy4KeEqY1PbT3Gh8?=
 =?us-ascii?Q?A2gbjhWlZT5gG4BJEXMsc8b7?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 206474ee-b4e2-4338-9862-08d96148bc25
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2021 06:32:07.4643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 62JKfsLEJMQc9EJ0RbHYS4PP1s6tCSslvo9+LP9K7zGMuQIaCmZd6PyrNmIx+oPhbTTDQy35Lvb1mrUJS8OT5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0402MB2913
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Andy Duan <fugang.duan@nxp.com>

Register offset needs to be applied on mapbase also.
dma_tx/rx_request use the physical address of UARTDATA.
Register offset is currently only applied to membase (the
corresponding virtual addr) but not on mapbase.

Reviewed-by: Leonard Crestez <leonard.crestez@nxp.com>
Acked-by: Fugang Duan <fugang.duan@nxp.com>
Signed-off-by: Adriana Reus <adriana.reus@nxp.com>
Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/tty/serial/fsl_lpuart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index f0e5da77ed6d..460e428b7592 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -2611,7 +2611,7 @@ static int lpuart_probe(struct platform_device *pdev)
 		return PTR_ERR(sport->port.membase);
 
 	sport->port.membase += sdata->reg_off;
-	sport->port.mapbase = res->start;
+	sport->port.mapbase = res->start + sdata->reg_off;
 	sport->port.dev = &pdev->dev;
 	sport->port.type = PORT_LPUART;
 	sport->devtype = sdata->devtype;
-- 
2.17.1

