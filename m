Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9A17C433ED
	for <linux-serial@archiver.kernel.org>; Tue, 27 Apr 2021 02:13:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C900F613AB
	for <linux-serial@archiver.kernel.org>; Tue, 27 Apr 2021 02:13:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232295AbhD0CNu (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 26 Apr 2021 22:13:50 -0400
Received: from mail-eopbgr20080.outbound.protection.outlook.com ([40.107.2.80]:10574
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230371AbhD0CNu (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 26 Apr 2021 22:13:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WOw7C0n+ySKVZIuD/QqEXQnzQwkxNJBq1EexBGIApkA+K+Wtz+MtSbBoQ8Pi2vw5xmub1rBHeF2Y/bX4WId8ptaQaMLz0E2RtCEc8bi9C3PCHsS354KK3xwV+sUDd9rQJOWMaZ8YuBnuPtxoBvHvxA2y8Fgpdg9KoIp3NqaaiNGgFluWO2VAvP+yIB9mBweKo4IrbUwAht42exyDmDVAxjl9s8sUS10Odhadnun3tDFAHlCGIYKwW99P/6ATgCcEyj4vQtpB8YXSD61BsVL2sih3v62I/aaQKr2ONZO11X3TaWA6C4w2RXiSzdeFKu5MnCUhSGLCd7lfhsE5mdNsMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V7a1Wwf4fJI8OuzQjtu2bL47ctavhEJ8XGFI0TUIKM8=;
 b=dpiqBXnrvqE2/0Zp9IbGAKHHaNi0Z4trXNWikxyBPQ6ijnqf2PrtoMqlvP4zGDoTJeL76X+hs4cF8UXyLV5qJvGAPBfAYOrMMzRKPu+wyVlS2W8yRjcYX4CCykiIlw5gCSEHrc1D1zZ5ki7dZ37zkI/X88AnILF9/244E6RlL7LVu/9vOehhAJjSI1j5G5sDF2U1U55RCM1aPWQFxd7ejLM8v4A5lvtJ8YLmDrJmWxrExRaVdrNlKgcHBMogloxLCU0wAU3OXyIXcD7hSlKUROQ7MgHVysUEiOlxEQV95JaOOP32vLHtrtdupXYvjgRyyDLo9mkSqSvYa6XlPafMlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V7a1Wwf4fJI8OuzQjtu2bL47ctavhEJ8XGFI0TUIKM8=;
 b=NbrbxBtnUohkMQjTEEMLtEN8/IBxZNS6U+z9iZSn5SZy34je3Eu13LK9cRno0o3UxlltPphzdf1VVJn8kdWLsdKGi5CdTpG/pNclTqF/TgJZo7TJfqNAyrlLm2Sl3Sjl0gDlPDUj/ehNKvR3/J0kraeZyiYeNQsmTdo25Lwfa3A=
Authentication-Results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=nxp.com;
Received: from AM0PR04MB4947.eurprd04.prod.outlook.com (2603:10a6:208:c8::16)
 by AM4PR0401MB2372.eurprd04.prod.outlook.com (2603:10a6:200:51::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Tue, 27 Apr
 2021 02:13:05 +0000
Received: from AM0PR04MB4947.eurprd04.prod.outlook.com
 ([fe80::c9b0:c412:80f0:4645]) by AM0PR04MB4947.eurprd04.prod.outlook.com
 ([fe80::c9b0:c412:80f0:4645%6]) with mapi id 15.20.4065.027; Tue, 27 Apr 2021
 02:13:05 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH V2] tty: serial: fsl_lpuart: fix the potential risk of division or modulo by zero
Date:   Tue, 27 Apr 2021 10:12:26 +0800
Message-Id: <20210427021226.27468-1-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: HKAPR04CA0014.apcprd04.prod.outlook.com
 (2603:1096:203:d0::24) To AM0PR04MB4947.eurprd04.prod.outlook.com
 (2603:10a6:208:c8::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.71) by HKAPR04CA0014.apcprd04.prod.outlook.com (2603:1096:203:d0::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21 via Frontend Transport; Tue, 27 Apr 2021 02:13:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6addfea3-a988-446c-be1f-08d90921fe3a
X-MS-TrafficTypeDiagnostic: AM4PR0401MB2372:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM4PR0401MB2372E9F0593ACF21951D2AA692419@AM4PR0401MB2372.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1417;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aTgpgidYDoXlV5vY8IV1oieNxnbB+hIh5iJwQfLQOaT13M6u0AoKKZUzplhTfczXQ7u6O7AnzOs4xblsG3fMtTl9lVar/XgopNPLiWWy2YNn+NVeLVeroP1AyBqRJ+0KvGdEii9+CqVthKWNxCJSG9kmDL976n7kJUg9ICYjScYaa8C1gFBjvVH3CFPvs9neODeo0soRs/VlnhbXlPAa4c+rxKIj2DdtiZaYLsoDUzIOxji+EQaQISE1UFNHt/zULqXNgynURc+/itvPKrnNiNfAYDH6ae/7GFqvp1Ry7SLzbBexv0pteBQInudXu5AIS0Nfhy8kw37ushugT1LAw2a4kaYJEpDFrjXbCleZIKIKtvBAgayIwBUzBSGfu98mYL0K2PRxeCSuWdqhIp2M4ftfHne8BBePwO6SiXQA279TTOx9LHi3kfbSQH3RZdmiPiJartW43eIQ4wQd/EgTEB0CgF4RVfyrEOEyO6F2FvhzDlBr1mbwsnuPe8C2e6e5jxnh7mS7gwhjhtzalIVPRF5s79Irkzr0+znQAkZkS2o1sfQ4s9HhlmHrS6wEshsopZN/R+PplCQpaHxKgCR88owt+xHICu3zwgq+AZvRQPG2IRdvvHwIPxuP+HVdEGa2Zu9QPi2cnSy6obnHq8wQjslQJn3xd0cWAce5D2m6gs2UeKjlghh1kW3HQy7E7rTp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB4947.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2616005)(44832011)(5660300002)(956004)(6506007)(6512007)(36756003)(4326008)(16526019)(6666004)(2906002)(498600001)(26005)(6486002)(1076003)(38350700002)(83380400001)(4744005)(186003)(66476007)(66556008)(52116002)(8936002)(8676002)(86362001)(66946007)(38100700002)(69590400013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?C+l1jWV8piGTp8yBQt/g5/9x1gAldVo0oStQqdEbvlJu8/gYmqD5ItLyPVif?=
 =?us-ascii?Q?RwzlTAdYOouAyyBNIG+OoIMo9mNrASa8LI6yfrVXtnODdYQ46vXwGeJtHwUu?=
 =?us-ascii?Q?3/pOplWxOG33vnVwkwEyCJ2Z8WxxN1Dsl/cR8d5NetFtmKfrHLqPQ5ru+7gd?=
 =?us-ascii?Q?fTjzOcTPtX6lkL7GM7KgvcMvpCWQAb1XdQHeKbgDNA3VW1xj6WEbgohyzQGW?=
 =?us-ascii?Q?HQCEq60iCodkS+whPU/DngLZKBxtoI/02eH+jMYwVRdeGwZYKR3cFGuq8MSJ?=
 =?us-ascii?Q?Z+kYXYZDjmZ5xbeaSobL/jgdq44TejQiLQyiSV4PbVaI7lNCGC1AmuZ3kY0F?=
 =?us-ascii?Q?ghcvVzJIKyXlQ7yIuwTRsiVq+yAQFZK/h+4jSOwCq6GeKFLfVRgYrEn5lQTt?=
 =?us-ascii?Q?tpZJP/AkO0qfUTvQlW0VaKvoo7e+GBCq37B2RZWD5TShgcn1p01Jt8DlaQRv?=
 =?us-ascii?Q?RA4+olf0+ND2k6wm67aNGwr8vx7bWVrUYGh0NnrKfhfmiVQZCT7IZxToI8ht?=
 =?us-ascii?Q?uEu5+nWRQnUZ8wA89KtHw69Tzayfo3pepXv0XfUUPzEtngEggr04pLOuEKSo?=
 =?us-ascii?Q?V70quNqOyww8Zs4GJEUxGFwkgFTbyQArbkZBt5CPVHcq0XPiTmfZqPIDqsTk?=
 =?us-ascii?Q?hfV/YcuQ2qgD5ZYYa1Cbr46fXYoczkBuvQKVi7whCtKAtv4gcDr9yajMmHgH?=
 =?us-ascii?Q?GbSdk1z97XMZNmEvwj2KREXKUTt5uFzZx9iYZeJSKGmF8wx/xv4przLHmnsu?=
 =?us-ascii?Q?ZQTtMPXiCYfdp4aAnPAsn8ESXrT0nM+eaapsNWd72CLYxnGwVzBRiGpVBcYo?=
 =?us-ascii?Q?rVLfxLYpISxUx8Ky647YH4NHOq3QjQ2B+yT95B081JTP9NofpGOnD1LLeZ0r?=
 =?us-ascii?Q?HNSU5wSZ0lOEWcsD/ejxHkX6EauiSizo9yCW+ll/kEfUjw6JMUKGX2hVawKG?=
 =?us-ascii?Q?+txI/GmUIGh/ZPW93RfNglhFLVEK6Xg2h1ctEzCmJeKmZPOInFO7V+IPpQ4E?=
 =?us-ascii?Q?a9+eZgCBmDghRsBpQtqOPxpgk1STxrEXbtfdJzOZ8Kc7tAY5ALDTdz7RSeQ1?=
 =?us-ascii?Q?dJQfY+hgBnRfj+vmnuiGCyba3vJGSI0zTBJ4hrw6phPUhISQbA0ox759fh9i?=
 =?us-ascii?Q?PR5Vej969aBaQNxsa+kp4Y0rmLwweqdNWj5VPEks544XNYDgydu0RZ5NeABM?=
 =?us-ascii?Q?cTlx89xExHV6YYMUQn2dnJfmGrX6aBZSclCLZoICBuviaTUauJJ2sUCNHp5j?=
 =?us-ascii?Q?y9LsVGuF1HQCoTuoLC4hIjMG8eUqbJmHir72QbsYt0859FpGu/XqpqmvTYrC?=
 =?us-ascii?Q?TwttXl/hfrXFOT2/cfKypfDR?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6addfea3-a988-446c-be1f-08d90921fe3a
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4947.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2021 02:13:05.6717
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C+HsF90l1GUQtVt/y9ACl+j5z7N1C54xaio+msef769AYjc3Y8wwgz6I9Gjpx3P2NvYUHKGk5hi8gsjpEh5DCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0401MB2372
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

We should be very careful about the register values that will be used
for division or modulo operations, althrough the possibility that the
UARTBAUD register value is zero is very low, but we had better to deal
with the "bad data" of hardware in advance to avoid division or modulo
by zero leading to undefined kernel behavior.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
V2: Amend commit message according to the review suggestions for better
understand the change. 
---
 drivers/tty/serial/fsl_lpuart.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 794035041744..777d54b593f8 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -2414,6 +2414,9 @@ lpuart32_console_get_options(struct lpuart_port *sport, int *baud,
 
 	bd = lpuart32_read(&sport->port, UARTBAUD);
 	bd &= UARTBAUD_SBR_MASK;
+	if (!bd)
+		return;
+
 	sbr = bd;
 	uartclk = lpuart_get_baud_clk_rate(sport);
 	/*
-- 
2.17.1

