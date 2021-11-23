Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E50FAC433EF
	for <linux-serial@archiver.kernel.org>; Tue, 23 Nov 2021 07:08:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231702AbhKWHLh (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 23 Nov 2021 02:11:37 -0500
Received: from mail-eopbgr140088.outbound.protection.outlook.com ([40.107.14.88]:6200
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229722AbhKWHLg (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 23 Nov 2021 02:11:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TqZ/tnMwTP9XEkFWG4Bp0QR7764geyy2y52JzslLpyEtq/lPYBzLmFPihVLDFZr7PDILLUodkUz45c2reiPpvH6Q4uM3+i02M/KqDjaXinaejb4cGKJb3lN6Ud5GY50Mn6fYgczwrklRvW1sadk0OoAuf3u2L48v1QTBR1UeDAaWWYjEiV7ZljvRQjZO0tGTsAUtGNkW1XyQjXx6YyM5gnUh/fDaHGouKcjiIDe8Omo/xQj9CygyDucAuK2k9X1aCMYXK8ap9u0fFGcXMV+GXRrmZjrSP3gtnillz5ySgoWJIo95wephH1CEeuadEuPotrufw+OqLKmriJOGQVDeow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6u4E3mrZAHdW9HpHw+JZOWUuTUNygtq58FTUqRvkKzA=;
 b=FvadCXK7EOFGoqleBi5DZPicvpiqvlG5hO3Y7tsBo80qyrGVyrzqyzGSweQXRWrrUehHyH7C6osHbeQTtLvVXWHu2eQNb7q6WXW62OySf2HGOZbmQaMLH6iXTODJAjH3bkZzAt1TQCLpPNbjrKXKVGB9YTZEft38Re/HWGIYAE9GfEnqWtqGOZvFHAyBO9Eu21sycztWQGsaFERj6h7hAJyoWOTlOftNSh0W1SqYccWVM0pjL82WHjEhual9Kv1Uy4w4MWTladGrC3JTV46SbbJrOt3vLVTNCp0P4mUF9+NK6gVl8KCFwI3ggCzIlAT88e3RYzrCla/ruIMJNzepQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6u4E3mrZAHdW9HpHw+JZOWUuTUNygtq58FTUqRvkKzA=;
 b=fYCniLOmE9Ab6uZixGqoCVvkLOv6sZpy2KZjGDkCGRphVGb6iF3frbMNwPKQgM9z5sUIbH/50zmhJGqFt8IwfoxtUoc9t/jN9o8hIpqWYKc4DR9isEnadv/p3wDI5Xs7DYPGz3OInNDaugRs1UE/nEWmoz+gTiRE8dRObyvTmlg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by AM6PR04MB5847.eurprd04.prod.outlook.com (2603:10a6:20b:ac::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.19; Tue, 23 Nov
 2021 07:08:27 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::c9fe:7982:c657:b423]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::c9fe:7982:c657:b423%9]) with mapi id 15.20.4713.025; Tue, 23 Nov 2021
 07:08:26 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH] tty: serial: imx: disable UCR4_OREN in .stop_rx()
Date:   Tue, 23 Nov 2021 15:04:37 +0800
Message-Id: <20211123070437.20153-1-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0039.apcprd02.prod.outlook.com
 (2603:1096:4:196::9) To AS8PR04MB8404.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f8::7)
MIME-Version: 1.0
Received: from localhost.localdomain (119.31.174.71) by SI2PR02CA0039.apcprd02.prod.outlook.com (2603:1096:4:196::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend Transport; Tue, 23 Nov 2021 07:08:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e0f8f6f3-82ea-4c5f-2ca9-08d9ae500ba1
X-MS-TrafficTypeDiagnostic: AM6PR04MB5847:
X-Microsoft-Antispam-PRVS: <AM6PR04MB5847D2BB962E8CA3DB21897092609@AM6PR04MB5847.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:983;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Woxiz3oKgY6AQSa86NVf3fuNZ7OlvzWPA4iSFmnPiPcQzwkxS1nIzW3+kTf0kX/MMmNyPIXxraC9RuPlwDhpKQoH1+DTyJKrwZC9zHRRUjO9huK6YRf5ZTbpGzDK3Ca9qsoksaSqYIrSvIf9DPsrgEEUnNtLLzU3az8wDYgoQNHpsyLuidiNvq5CRK/OpwKbYnUls9L2G8DNxmLmW65s3Bo58bTcGxGEV4Tiz+NmCCfhkMDf4wT/8Fqi+aVdBKyW3XScKRn5kiPradO6cDckEVoFcJ0aLNjJfOCwu2xRNUVqjSFgP1FZukYp+QT+Jsk6hr/o/kHDw0tfKdm6vPndZ3bCQNczg+DUkr0GkKT04hcKCkOuyxpZTQpJNwYPWkOdeAtldi27s/xuu2uGvEUBlVNm7pXDVBL70zWjciN0AP9KtStiOAH137SyDOvw22tPwEHtekZvX35Xa2MFBUhPvMQxSg+B2QdJiF3Mrxy8kEt+ip87Sd7qYEXqkt6VyWZ6eveCpW58r3QTRNoaa1fMDEZnJLvoHKOIBSBE2gO73fr4m3UGPfrXo0CahPm4m77v+CTEypEzMWQM2mdvnrk/DKYmPvzikSUnNveEQvSLBDRsR4GfspvMcbfvybPYLoeptfJumHyPTHwcm/RNzZi8kjrqrgC5groiV4Q+YyQ3JMmsH0lb3eIvI9Mq60ELzQ8jj3QMtP2T200yPksrkB0SJe01Y8zkrBCTu59yh8aBILI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(186003)(36756003)(5660300002)(86362001)(2616005)(956004)(4326008)(2906002)(38100700002)(38350700002)(6666004)(8936002)(1076003)(6512007)(508600001)(52116002)(26005)(8676002)(66946007)(316002)(6506007)(6486002)(66476007)(66556008)(83380400001)(44832011)(142923001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+ReZTtD+eeD6XCi2c9wibVJXCiR+Xvdbw0GFsGHZwMvKhMwEvlHHmo8QASHK?=
 =?us-ascii?Q?UimeB04z5T0e3cyAXNva7LsdT6KFOhmeUppbgCU0J10RlWKXY+a97YCHqQzf?=
 =?us-ascii?Q?rS/p1pes3GRIizPOkbvvuJH7Mfu4YzsfSshRqJx3KphyU3DFtVx0v8DqeqVe?=
 =?us-ascii?Q?XUCuueQ966PcBOl4ngsv0cYT6Ae0giPYzm0gMteRKcQl8Gv4Dhxr44EZMTme?=
 =?us-ascii?Q?Nt1LgLAWGynFT6XS239106wTWFWCV9oDIHu0Eiw8mX233yM06I7lw9YsY+4T?=
 =?us-ascii?Q?97CmCapaqOsvF1l5OKaExypUtIiuRF7uW95lgvzeEha5FWzV/hK7VVwQSq/4?=
 =?us-ascii?Q?yp24zyeeiEw6/dqq7KV/jbsmSjZe43wHbnyDgtuYHhO9lWUtSy2nzF7cRhlm?=
 =?us-ascii?Q?0o35qJDkM/MNW/rpABeF8/hgmpMjHE/RkIEM83zPR5LSmGMcAKuu9JVFZBdr?=
 =?us-ascii?Q?pxVn1UthbF8at2JhEjE/z22nnLAgO6sGUbyR1kG24VCMhXyBof1MpB89TALz?=
 =?us-ascii?Q?X5w08dJEOvkvKgEq184xljKE9cD+zRLS3HoonniDcQAzY9Qi0C/CWUocUtfe?=
 =?us-ascii?Q?s6gQrlAgVyOr0g1MH6QyZtBOZv2h+rGua2hhibb8fZimpVIvY1KS+gc4LsfX?=
 =?us-ascii?Q?OzmrxISz7ek1Z2SbvYMNXC4/CfjvDFp+2Q2h6sH7auXnF8dohk0pqWEVRL0F?=
 =?us-ascii?Q?zCN0H+RtnXDKleHQ+CwUZODzct4YEUIBM4PUdbkbUF35wvyALFVWWQLKmvXw?=
 =?us-ascii?Q?adBP+Wsjn5YUrt6wTVZQC/O49eil0UpOdcc18Af5MI1t8BQnUMdmNWh/4y+V?=
 =?us-ascii?Q?KoNPPZ6EUlP8hcNBiSZ8awnUT9aO19DAto8E8rHDkVwcIforJSKSNU38SB9f?=
 =?us-ascii?Q?QlrnNXy7xn4ESO5Gc8iN9oJUbYucHoVqo4T7ZXd1o+vF4m/jdIjilUw6PAQ3?=
 =?us-ascii?Q?/7cOy5qeee1kuFEhs4DC4CU/NfrCM85hyWf8dLoNrMzlO4UmV9S6C1S66PD9?=
 =?us-ascii?Q?SF8TMD1Umv6mIQgfaJQ3AoK9nK8psFi+kZHnvVipGFZGSTIHHbTSFVq3R+OG?=
 =?us-ascii?Q?XRredtrsLBLWYECeOXqHs2mOckvwFOISS3iGvCrX6KTpFTpfAH+l0Xkdyez4?=
 =?us-ascii?Q?kZdYv2t9WYr0bJcG7iM7PBwC17KHjwQkg/0HIlepvQMhcf8FrqEaiD+sV7PM?=
 =?us-ascii?Q?qLskuGG6rsgKpH5Qjf1liMc/zp6O7tp3aWph6nIgpwCsWHPeZjLTeWwoV8GG?=
 =?us-ascii?Q?geN6tVB5orKajhlCpom6I1xMsA2bWB2aT6DaAhf4aPHM/lmewmJ+bffbiubo?=
 =?us-ascii?Q?AcwBqzfPT/Fo6+onNRmA6nVVLEli6R1kOdPlSlDsC0g5FKA7tRXEvMUnOnJ5?=
 =?us-ascii?Q?NeNB3R8ndjf8TOvhnYHPxebH8/az3ypLemEPmx32iAflQcURMAWsRc59AAQ6?=
 =?us-ascii?Q?JnyiH54CnRWpIlj6M5zru5VWjbCEo8XNhFJfTAvAwN42BcyIbHOg62wzYpgQ?=
 =?us-ascii?Q?FfHdMRtDBHsS7RMf0qhi96JTiFkgtySIcOTKY4BOIMqocRg7Z5972olbFjR/?=
 =?us-ascii?Q?Dx1FE2suE985LdvRiqb5ECu1iqAbUafOUEQwcsTpsFSYZuJ/qD8oPYoMe03n?=
 =?us-ascii?Q?9fYssHIOQRqKk0uogO5xCac=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0f8f6f3-82ea-4c5f-2ca9-08d9ae500ba1
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2021 07:08:26.8441
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dODfI6sTD9hLRJHBOMrcMxyleE9324cWR0dPJ+O5Y2UQvWCfFI4F/qAAxIKdEEGORALB5M5wL9ZyQSPHqrDZiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5847
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Fugang Duan <fugang.duan@nxp.com>

Disable UCR4_OREN bit in .stop_rx() to avoid endless
interrupt happen while tty port is closing.

Signed-off-by: Fugang Duan <fugang.duan@nxp.com>
Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/tty/serial/imx.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index fb75e3e0d828..9ecaf051249d 100644
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
-- 
2.17.1

