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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1946DC4338F
	for <linux-serial@archiver.kernel.org>; Tue, 17 Aug 2021 10:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED05460F41
	for <linux-serial@archiver.kernel.org>; Tue, 17 Aug 2021 10:03:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235558AbhHQKED (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 17 Aug 2021 06:04:03 -0400
Received: from mail-vi1eur05on2041.outbound.protection.outlook.com ([40.107.21.41]:15585
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235611AbhHQKEC (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 17 Aug 2021 06:04:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nwrYixqh6lRQoAGRVHN7PFUYsw5ylAx3UsWI1C04ltzDR5BznG4c6C/FQG9JjRaAJkItOIYF7JrgtTlDki0kPehKPyn46+3jHTWgvpb219hW3KrVw8uR8XOsqcY2VziCKACzbWz98RomD9ieay3c70TWroJP8i3W2lgeQ1PfubKOfnVWa6IHAdsQWvp6ZXpke8lCUk32UGnew8rwLOFywg6NDRY7bBds/ylGalQj0Ivmlw+kJ2vv5ArLOqbwJz10TsjHKOJSwm+01FhZ9ArUMKsxkxB3EYxExmrJfR2x3yjDI3jolytWgyVz+UcBajjqShaYi//LNUsHQSXFTFJddA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r5Jar816pC5yYhLXG9dfXeRnTZHYrdLP/2Xz6oPibm8=;
 b=LTRhFpMEuU5RO27NuK2VpqMgM7W8uEVftFvFmKetAoWqrvBGd3jdN0KX7ce3aN1+Edf0hLd2SKxH0UuObEzmeBeYM8EI2r/pr+f/iHi8gj1o20McWSDf85+pnOvlKcHv5O2eCj4YvOEURGGDLFhxkYI6evIVQc4Fx/pORxB9XsvRrWrtvtscw2/1qwf5YMqfVa2ZsbuFem04QFEsygLENktu3LrulIrTMQNsJKRAFR4dfjVubZ1GaqIJdUfH1NJO6VF5vKqbnOiravW75UhSDMRlKGbxYYsnJxEzkOCmQatpe0411BtUNZiS4KSDA/xtZhqVC31a9t9e8Gd8DPtoJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r5Jar816pC5yYhLXG9dfXeRnTZHYrdLP/2Xz6oPibm8=;
 b=POLu701DJyyustH9UXxwKvpXM2jng4LAa+XPvhJVIa5bDDa1sGhlC7d/OPao3tCBe2y6a5z3LNfrngKyUouvUhQBOnzwg6zaUvHOJ9QZUwD3D2aM3GV/5pxjkr2BZc+INlZEpFOAxlfM0/BJV0qZY5GBphWbLNLNbUHP3Ys+UM8=
Authentication-Results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=nxp.com;
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by AS8PR04MB8055.eurprd04.prod.outlook.com (2603:10a6:20b:2a4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.15; Tue, 17 Aug
 2021 10:03:24 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::91c1:5ce4:cc:ddcd]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::91c1:5ce4:cc:ddcd%6]) with mapi id 15.20.4415.024; Tue, 17 Aug 2021
 10:03:24 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH] tty: serial: fsl_lpuart: check dma_tx_in_progress in tx dma callback
Date:   Tue, 17 Aug 2021 18:02:03 +0800
Message-Id: <20210817100203.21300-1-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SG2PR0302CA0008.apcprd03.prod.outlook.com
 (2603:1096:3:2::18) To AS8PR04MB8404.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f8::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.71) by SG2PR0302CA0008.apcprd03.prod.outlook.com (2603:1096:3:2::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.9 via Frontend Transport; Tue, 17 Aug 2021 10:03:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 585a1d78-6d25-4f1f-8765-08d961664052
X-MS-TrafficTypeDiagnostic: AS8PR04MB8055:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AS8PR04MB80554F16B1EA5BBF6A9C15F192FE9@AS8PR04MB8055.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xO9UL3rFqXdDGs/jJ57xPWQpU4pZgyfCHsAn/DBROzWb7sQ2jADosqoB9eN4zqnFbg31BQr1rAuoX2cXbOXk2uStm2tAYKuN99OVLkN2Leegm/e01+9eGqcWYq4leKtsJFWkOBIE0uIEcFLW5Nun9FRAbx95G5kbPHL43tc3b/12JbRfPH6AoWNoFs9goNOJmKK7DGQTKDn/EHRN/A2TFwbslCykXFwC3tKPjaodTFKpdG2QSjNOwK8A9hOh4XrQlKddy+5lmmr3Skqt3ICT+p8kPXx0l0rUZqP01zF3y6hD3HuxvKHkTrpE3mD8n4Wlhe74VpNdp9RHefz3S2/0JM2foKn1g4FOo8WYxoryBidJCz2Q2MfanKNnvy/o4M8a+W3vHiPVrmVwB3A7g4dcs5Ig33xEMdHShlF6qjcUGXBoj3ohZD52V+Z7+zaxD1t7FmeouhJva9pMz3Nv8uOvONOpssReakg3gcenBEeziKySVdGebVMXbiH3oPfMVrhPmV22nROOknambm8IzXVCvMLz9PHV1BHbv7OqNYevWf0qNWaQJXRGrXusMhKQqANWH7IgNNcjL6LXcGw1U1jFqclhwjWs9P26lNm+Rbg2HR3RakMQwt58phrsjjq1wrkKzHZC/nQnMPx96iM0r/I7OZwXyIRNY6xo6eXl4E0oRQTLV7Ykz4K6DS37c/HpTBWh8WTlxZb/udtrGCOYhlPadw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(346002)(136003)(376002)(396003)(52116002)(66946007)(38100700002)(83380400001)(2906002)(66476007)(6666004)(4744005)(66556008)(6486002)(4326008)(186003)(956004)(36756003)(6506007)(86362001)(316002)(26005)(1076003)(38350700002)(6512007)(478600001)(8936002)(8676002)(5660300002)(2616005)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Dzuy3Or1b/FFmlGXFMJ6U8MIluRs35FF6J1vR1sYHH9l5+/TSVBo3SyRbixA?=
 =?us-ascii?Q?/P2/HQ46QaCv9m4FOyjUi7aRXLjXaruSMSRcgw52Faa4XBn5zWPZnv2+soc9?=
 =?us-ascii?Q?RkFY5nFyvsgeFCyPAFHIM+tUbjv4WO9HujenVzGD3wxfBs66DozjB+dAhaGV?=
 =?us-ascii?Q?HsQX45g/wluRSvDFGopz/vgeH4qYH7T7dwBAOGMpYHEUaAmafghLZdeK185I?=
 =?us-ascii?Q?FWwDbcSpz2+n1OMEZEplJ3PDOYLj8bD695BUbczvnGo5+uhG6BGP1a/hA+oc?=
 =?us-ascii?Q?mBfZyq3bpbKpRBUVzAJSfF8+Xe3yLAuaFMI/ex+iPYmxe9OuUIcKmExwTctK?=
 =?us-ascii?Q?zBSXRVCZqNzpcdOrCDqf6VT5rWXG32hm44kh8qZHsHzWBRWme8/vlavJOHJm?=
 =?us-ascii?Q?lOwt6WPgurISu0O5GEWOqsR8mqLYQ6q3u+fYvWkeVXVr7PVGsOr72qPJ1cch?=
 =?us-ascii?Q?p2r7ihUZb86pV6tvJ7xYo2YKYSoFkqMtoJf8/Flu77XjYl4aOMkit2wzlYuv?=
 =?us-ascii?Q?zEA+G1XFMcDNNJ/VdIXrk9rwqZ1l3x6ZAlXcpKxQiNAfsG5P7cJhIxB/dzAm?=
 =?us-ascii?Q?DGOMqdZL0PUy9MaPQQsNLN7ub+iHo799YMSwg9YTlKKVYqgXLBBIyyT7bV2X?=
 =?us-ascii?Q?PQN0zrlYPvULrxOFdZLHGx+rfbmZBjSlGcPA6vQSIHa+bk2NNNZfNlCagN39?=
 =?us-ascii?Q?kqX6ZNpA14X6pE+8dk0Fe4Wqvl/OmkzD8zApcK7xeSA+/jJPhiKplGhwluKD?=
 =?us-ascii?Q?ZseMZ/JK/NZoktKN+6D4G763DnvhgvHCkZ3fwugAgSiRCDcnRE8I71YmO2y8?=
 =?us-ascii?Q?7ILig2sgiJQ7higdIOTIpOdpT1JkACYbEQKrdO10uHzsIz5CZc5mKBLM/hL4?=
 =?us-ascii?Q?cmW/plNeQ+OxEtzRCOoZJi/BTnOdkn6f3mCyWFROY//JofrxMuJv/hqjL+9i?=
 =?us-ascii?Q?45ZuQs+oXCWSjrsDD6m9ug1twzmqI5TG3KNOXzH6lUF70vYgcu4n72AHjnNW?=
 =?us-ascii?Q?NkqIegAvoKAGtlrZJ8vtw2IE+jhnpXFIwq1fjyHZXfwE90MwCa15P7nKCVP9?=
 =?us-ascii?Q?rimyEdBkLkLICvRklUNo9kKyxqM9b6G0REZlGWThKQVNsm1YnbTijEjItAbl?=
 =?us-ascii?Q?djuMe6ZYyXbXv3nMb3JWTyRhvMUEb+uQeqy0MeQ1eCyZv3HkQg3MXU2ncR3D?=
 =?us-ascii?Q?hpkFLaPaKUY8iw+WMKXtfcdwEnAgZBlsRBsT6wu+S5PbM1vkmEfs27XpKZdH?=
 =?us-ascii?Q?U4KKGB7p9ND8jGdjE1f2SnjJoe94k074Ts/1264sl5Bl9hB2mQUAG6I0Hy1B?=
 =?us-ascii?Q?4gw8ENCit9NyMb4ukqOAux28?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 585a1d78-6d25-4f1f-8765-08d961664052
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2021 10:03:24.6122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l28z1BXTu0XsE1hycMYst+2SGKTaMKNVe+ry8MYFIMC3XOFkz3HAFXxF6iiroQ2zrdYtvgNlMz2PNFALPApxwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8055
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Fugang Duan <fugang.duan@nxp.com>

There have a corner case that tx DMA .callback() is coming after
.flush_buffer(), then .callback() should check dma_tx_in_progress
flag and return in directly.

Signed-off-by: Fugang Duan <fugang.duan@nxp.com>
Signed-off-by: Vipul Kumar <vipul_kumar@mentor.com>
Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/tty/serial/fsl_lpuart.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 460e428b7592..117e011aff5f 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -479,6 +479,10 @@ static void lpuart_dma_tx_complete(void *arg)
 	unsigned long flags;
 
 	spin_lock_irqsave(&sport->port.lock, flags);
+	if (!sport->dma_tx_in_progress) {
+		spin_unlock_irqrestore(&sport->port.lock, flags);
+		return;
+	}
 
 	dma_unmap_sg(chan->device->dev, sgl, sport->dma_tx_nents,
 		     DMA_TO_DEVICE);
-- 
2.17.1

