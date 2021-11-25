Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBEAEC433EF
	for <linux-serial@archiver.kernel.org>; Thu, 25 Nov 2021 02:09:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbhKYCMl (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 24 Nov 2021 21:12:41 -0500
Received: from mail-vi1eur05on2044.outbound.protection.outlook.com ([40.107.21.44]:21524
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229696AbhKYCKl (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 24 Nov 2021 21:10:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lsASSsFx06x52+dEuXCeZ+g4donkMMPkApHVocZv+c2/V1OYI2WSuDQFtIurVncVr33wIc2DlvdmMPL8rhr3nnxrrdG6dVBqHEvtPApkdm+JwHlG8puc0h6piBKtO9dyU74arZvtxZRHr45pIqF/mmmn+D72HYG3tI+o5HQIDXJKxNmc5M0DIyJp7c1StPaIUAnwuWaOBt9a63oP5tDDjIEQW4USOvFuZVz6CVPLFi0h6c71qbXtbb3rEVangJY/FVJ8OLnJxVm+NW2vj786rPcAxehLe0Boo8xZDcAxYnnZ4XADwiAQIYkAlsxKcvsghkgNM5PpEQMSCDeQl/K5ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uSY45j/VyN83wXAQt196kfBkOPziYMSD4aQZroREOhY=;
 b=HGwNaUgxULkm1aNSUN/nvTuvcV4CUNy6t/atcfOqycjGp6ZG93xUKuiSjiQq1E1m5wOXD+gxLfKvn0r0Xu5djUqomyC28BPyxFdQFVsbzOIh3hELBPv2/KuMZrVc/Nlg7obPQFHQCmHE2edTPga5318zFfiMsnBN3uM/JjtYGWNwWcEJaAdef2WimSzQkXkpCpc3Mtm/atYF4sQVl/cdSuUPsf/Cr9TxL0L8drQgns+c1oqjBqlyR70qQZTG76hWu9p7JvnutsUp/zb9r5TF1IhC0Cg72N2kNM2sTdDq4wcR7VrLQJKJHG9nHLsYX0WfYEJKU+kt3ASqSoqLubCHFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uSY45j/VyN83wXAQt196kfBkOPziYMSD4aQZroREOhY=;
 b=p57csr0Ht6ptPBOrSQknQsGbJ+Tr3Mhu46OS+EYzvNMKtFypHf8o5gRtL4ogandFP4YKZm4XsjvTsa1LtwPrisBSPFP7vwPRQajnVCCMEbM32oPmkaowJdg1d4KQk2LDBypZEOA0bWJokyE9fMdTxGa2pFW95eF8JpzPGZ8+Ins=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB8411.eurprd04.prod.outlook.com (2603:10a6:10:24c::9)
 by DB7PR04MB4347.eurprd04.prod.outlook.com (2603:10a6:5:27::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Thu, 25 Nov
 2021 02:07:28 +0000
Received: from DB9PR04MB8411.eurprd04.prod.outlook.com
 ([fe80::199a:adba:b7de:cf8d]) by DB9PR04MB8411.eurprd04.prod.outlook.com
 ([fe80::199a:adba:b7de:cf8d%5]) with mapi id 15.20.4713.027; Thu, 25 Nov 2021
 02:07:22 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        u.kleine-koenig@pengutronix.de
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH V3] tty: serial: imx: disable UCR4_OREN in .stop_rx() instead of .shutdown()
Date:   Thu, 25 Nov 2021 10:03:49 +0800
Message-Id: <20211125020349.4980-1-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SG2PR0302CA0022.apcprd03.prod.outlook.com
 (2603:1096:3:2::32) To DB9PR04MB8411.eurprd04.prod.outlook.com
 (2603:10a6:10:24c::9)
MIME-Version: 1.0
Received: from localhost.localdomain (119.31.174.71) by SG2PR0302CA0022.apcprd03.prod.outlook.com (2603:1096:3:2::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.7 via Frontend Transport; Thu, 25 Nov 2021 02:07:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a64f3786-f4bf-496d-e909-08d9afb85196
X-MS-TrafficTypeDiagnostic: DB7PR04MB4347:
X-Microsoft-Antispam-PRVS: <DB7PR04MB4347DBB65FEE00D71700E40092629@DB7PR04MB4347.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nOtdIIZIbu4hFt2ndycxqtiwcYNfgop+IXzpm1SNJsCQgt50tV+/J4WeDXxZBRGHXkujTnnUEzI9VDkkNG7TvHs2sTUvYJHJGc+P4mEi3jVmOaBcFXxBZ7vHIH+gHPe5PLfY++AYcfIk85hIRdXhO8B0+DQeIrBr2HBf0d5P54CTy/hOr3P3F3121BC49uPAN2RlFQ2P5CcLvTiP8FWmWQoEZ0lUYF+K3i3mk0DPAzBiYm+IZ6Vho4BbXOSHMQ24RBrlZwV9V9n73VYTN01ZfLDWgIMEH3EQ1YC7qeCBGyE/QLH/btKeI/sQRIc1MSWxOaaSQn1mo0m91/C0DfigfITuO6TTPWabkROFn79kTLK/1FYt+Zwmdxt9DRxiSI+bAr3Trmuh5m1MlcgK2Ab+hfKHi6T6ED6U23+y4J7XuQztE2FzoN5YzmYqovcNZo4t0acMxe5/KYPn5qEk2RwqCbHfQfcmvxlsTPpg/iOkRBCrtwsZyA1Nn9RY4Wx4dG6F67I8wzSNtw6tEHinN2tnqDAk3hCoKsDKykg7mDftTeSpikYa/WfAxYXJnN4JqpRDEiAh1nKMHATiXWH/5FTnBLlzazYRXOCfBdEPEIZzThC6Ydlk4P9e/jcxB8yvoWlyMy9JuigUy13w4+l5OWaJgwLtdK9tjdTpn46OktxsnOsXFHWS7Xy8KlAkwsSRf9abbtsuvtCptYSWaiM/LGFOrIS96Fvv4tcWpILoL0hI7xc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8411.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66556008)(5660300002)(86362001)(38350700002)(66476007)(8676002)(38100700002)(6506007)(2616005)(66946007)(186003)(956004)(4326008)(6666004)(6486002)(2906002)(26005)(8936002)(44832011)(1076003)(36756003)(508600001)(52116002)(316002)(6512007)(83380400001)(142923001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WyjjhtcdzMXjnbv0bRu8w0ZgM66nLDufDFBCTHxLwROhqbcULno2EsdYQmPK?=
 =?us-ascii?Q?bl2NayMIeWhyJxWfqFp3zcN7bHWfx3lW7W6zl2f2K4/l+QlZnMj76I17WlbM?=
 =?us-ascii?Q?Pzs3q2lqorsXH22j2Ft9kP4rhNSCzBeKmubohXOPire+p0CY+sqrdcSa/HEs?=
 =?us-ascii?Q?Luh+g0RRJhqflfPfVZEtL+DzqrLqIlt3L950QsIZuqWUhGMNSIdGGGnfhT8x?=
 =?us-ascii?Q?Ss/mPHF8i3qG1zsbSz79VRsNAZLXHt3Pa4PzjQG+PMnMJvzya+GeVnQ6EHpu?=
 =?us-ascii?Q?YpmNSPp7kpf5UFjTE3eB09045vCONP9gDlQNxjwQ6d0ZsuChBpqeTBo/4a9V?=
 =?us-ascii?Q?cXQU+dvY1xgttke8WcEQQGKrKgwyxKy8ayBLxZcp6RUephrrZfQqWBA1Hj02?=
 =?us-ascii?Q?ul2I2UXcdHXXNaFiPLJpyaSv6g5t9oeUOg+cTaUxaS+vik/VZru2MMGDfr7A?=
 =?us-ascii?Q?bxpaYCW2h7FPv3rQQC9sfCjU9/a/2epVOnglpmIn3uJ3OQQgn58SVuV+9UXN?=
 =?us-ascii?Q?msO9GefB+w2Cx4Dp4b2vJ8MK5vBuIg1F2fzkp0AgnDalDkBM7BfhORfprhzg?=
 =?us-ascii?Q?o9m+NUq5f2KLCJSShR8Glx2Mw2TDW5HgLEHi0EG/lM7+WhdfztBHKt7MtmEm?=
 =?us-ascii?Q?fjsplMXwQfmdcQke/jfw3meVsW0StJSFEu7jjGjs761DRonfJCwnRYTZnQRB?=
 =?us-ascii?Q?JeOtWxFo7agLszUQyq2ByxqmZj3dQ7aFUewfhVWsKT9yKM4F1Ig6GwFHmhkV?=
 =?us-ascii?Q?sQsf2TNcvb1waBoeetJX7i1gFwWBQHbIbC06TOHaqO1Klujz3lxR7CNtk4NC?=
 =?us-ascii?Q?eKuK0KRBMACwzgSlVuaWdxBV7FbecbhqVLowVLY48iTkjFbWeiArJlS5luVk?=
 =?us-ascii?Q?ZkYJK7boNBBdJ7acBo2n1lDo+zWaUV89ouG50LPll6YmX8m0A+lm5VI4JXFr?=
 =?us-ascii?Q?GgHWfu12O36Gi+7uBFXBwp5mCvuEAeMCIwxRTxM/Xw3p10sY4ufHYTNictn0?=
 =?us-ascii?Q?CFC4/we0QTCPwWujSrqz+zgpHKuCOgVTWxzh374O14CpMTJLsiD2JNCbQ/3h?=
 =?us-ascii?Q?E4cf4/SliRTpOLqD/AoD65zcVNSBClq8WQKf5ePkilBr40eJvWXSrpDA6f7B?=
 =?us-ascii?Q?vgPU8yccsUwlGjbBc0DRoNzx5FM3u3hZwTne4xni+T6mqqZEQhW/OFMXCOSf?=
 =?us-ascii?Q?8CHvANYxsrj20l0hrqWwj9lcFV3a5x+4Q6/gJ05GH0HqEq3mWm/Egecy9q8H?=
 =?us-ascii?Q?tgcwfxKmm3pOby7NNDsret/RMLW+WZ1LsCdTQu6qLvdrvXuBh0IDu0Inbsje?=
 =?us-ascii?Q?tZImR6/1CZN49h8uEQ31mZHTSWNcAnwjmUTj0n3Jr9WW8+AJtOac9+46dkQ7?=
 =?us-ascii?Q?s7e11c8krqdiSXn63f/gnsAfqCQZQJm5ezfgNTD05t7aAZ5Bl+0tR4Ywj5p9?=
 =?us-ascii?Q?0t+bvUjp1rJQC4FJQ1EGBeUoIOSpPeaE+50VPiOjQErezLWEvAfEOlsQtB4u?=
 =?us-ascii?Q?ZSqDbKUNHBO2/SN7Sb3tdDNaOPkH3tNE9IXRqZ3AXMFWOKJs/E8Dvi3sFnTG?=
 =?us-ascii?Q?Q+s1gQW1CSbEkdyjJOHZl7YqRu0+asHriGON7LHCygfBZ/Wl+lHTfXObB6E5?=
 =?us-ascii?Q?dwtaFd/Gt2CMzq5ybrhqfuo=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a64f3786-f4bf-496d-e909-08d9afb85196
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8411.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2021 02:07:22.8807
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KXCdLSliVqQjAeT+HfzMk9aqwvs4u2uo1VUG6gVrR80yf1mp+HDJL9zZF5iJTLNn45bTbiJAJUwKV4bqSbWTbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4347
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Fugang Duan <fugang.duan@nxp.com>

The UCR4_OREN should be disabled before disabling the uart receiver in
.stop_rx() instead of in the .shutdown().

Otherwise, if we have the overrun error during the receiver disable
process, the overrun interrupt will keep trigging until we disable the
OREN interrupt in the .shutdown(), because the ORE status can only be
cleared when read the rx FIFO or reset the controller.  Although the
called time between the receiver disable and OREN disable in .shutdown()
is very short, there is still the risk of endless interrupt during this
short period of time. So here change to disable OREN before the receiver
been disabled in .stop_rx().

Signed-off-by: Fugang Duan <fugang.duan@nxp.com>
Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
changes in V3:
 - Add more detailed info in the commit message as suggested by Greg.

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

