Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A141EC433F5
	for <linux-serial@archiver.kernel.org>; Thu, 14 Oct 2021 07:11:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D7F96117A
	for <linux-serial@archiver.kernel.org>; Thu, 14 Oct 2021 07:11:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbhJNHNM (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 14 Oct 2021 03:13:12 -0400
Received: from mail-eopbgr70118.outbound.protection.outlook.com ([40.107.7.118]:50863
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229551AbhJNHNL (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 14 Oct 2021 03:13:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eof60p1kOucMntIZnIgUmp9pcWatDMvvENRy2Oz4pDzeXX9//tWS3ixJcEDtQcFUxw/CiHJjZtJ4aGkZ4bLdLVZRdL2OmXvcoUQkHrZ0jtJqVFNgT0tIHvSHWJ4tW0CY0n7B0GWfq+p+bcfeo8RhDs9Qgf3h7tuHyOoImWWSOMVkk+fadoDA3m/fLLoLvrCIhnOVwNeEwu1AJ5wFRQThjyoj+WQ7BFvDSWDuljABS+ZYZrkJL/1DnD0c4lusj3dtZ1c+oVHiJA6yDFqXe2g8dO7QrSA2GrceMMmPsLq62nW9VqNNBowrw43hWV7/p5rbYCos482yrMJ0Gjr+Ima8Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5DD5YtlIWcNrmvMMKAqkG4Ke4CitufBNgV8CcNK410k=;
 b=kIqQLq7S4ll4IMyal6MeBpFPt00kjuVMWXjvUlAPVkzP8ZwyHmq2bgfkIiSDoiUWfU4HkwNLwTXHait/AHJS5JVBFMhLPhtKasCS0dbaLnd95gOpRms3Ys6r2WraAmIy/w9+hlJ84ww+abWNjs06r7Vmm4KdQSqxPAALdR2cIIlyiR/dGbltrZKizGwu1LlekN0WZQJmBnm9H8ahvpLAowJUYmkuhT8giTzd+ZERIpPNBcMLTWnUorkMBCZUjqkXE9YB8ho9OtKxeD+7ufgvFJrWQDGt1Gaiq1G9hSys7gVUxlpnJd3PraUqROilshhmA9hGYMYPi8Bc+/w5TQ0HFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5DD5YtlIWcNrmvMMKAqkG4Ke4CitufBNgV8CcNK410k=;
 b=UurgyzkAvQNstWuHzvKTfEECCgYyxIwZiMrPUti8BxU4MQN5yH8UcRYurHN3hWj5ZYvrNbHO8d6kkPQoJEqZudeiYirD1YY+4MrXIalqstVIOaYxKR10f7+wGJTvNkrJW5/Q8SVjptuwAnI1Xvcdp8qqQJHVSq269O+PBuVvqTQ=
Authentication-Results: agner.ch; dkim=none (message not signed)
 header.d=none;agner.ch; dmarc=none action=none header.from=toradex.com;
Received: from HE1PR0501MB2602.eurprd05.prod.outlook.com (2603:10a6:3:6d::13)
 by HE1PR0501MB2780.eurprd05.prod.outlook.com (2603:10a6:3:ca::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.21; Thu, 14 Oct
 2021 07:11:04 +0000
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
Subject: [PATCH 1/2] serial: imx: fix crash when un/re-binding console
Date:   Thu, 14 Oct 2021 09:10:52 +0200
Message-Id: <20211014071053.568598-2-francesco.dolcini@toradex.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211014071053.568598-1-francesco.dolcini@toradex.com>
References: <20211014071053.568598-1-francesco.dolcini@toradex.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0001.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::11) To HE1PR0501MB2602.eurprd05.prod.outlook.com
 (2603:10a6:3:6d::13)
MIME-Version: 1.0
Received: from francesco-nb.toradex.int (31.10.206.124) by ZR0P278CA0001.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:16::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.25 via Frontend Transport; Thu, 14 Oct 2021 07:11:01 +0000
Received: by francesco-nb.toradex.int (Postfix, from userid 1000)       id 7F05410A3843; Thu, 14 Oct 2021 09:11:00 +0200 (CEST)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7b2959d3-1183-4e82-1dc8-08d98ee1c782
X-MS-TrafficTypeDiagnostic: HE1PR0501MB2780:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0501MB2780B6B0ACF7069D74397516E2B89@HE1PR0501MB2780.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O1NO+aUEUc+O0M6AssisFzzJNmeAR5thC+9Vu4bK2W2CUMsA+Ps3YiBXHVCyQEeIu8Wk7aNTbx5njlGcR6XOBksNIM99LVA8C/c7M9O81jo6Jju6ZdHg7GiF/56a523AmHBXILH37dexH1eEKKUsKX3K4NTtbybfVK/5zMtuv0QZAX8FGKxqQ1HR1iUHB4bWqBaFrAj+khHE54g/AByBDTxPuJ34aj/2yKi2Y82bNFiEJzIZ183VzvcLExkEHU0TSt8Wk4qmjX1fDAR9bEKpnlGHyFXw1CJYORQhci2mVeHhaevxxf28uFy1OpT4D5ysG9JdR7al8vDAUVPmUlhsNQlWHfxbGxBnSmv/wRrrOl/3mxCZopBLrdr+Xko4zvUVk+aLMK1uGFyhNGkYWxUozfbe40R+8UnZhqfH3jtlDAsYYnDZwhcO8XU8MnHUWEVx4XB1V3Du2aK2nBWv0zWohZNBh5a72dZZqUF+NQJSB0mUkRPEdSV9Dy5kVNjgkwZB1fT/0wqwQTMsonqyDtTOh3Fd7S+aeNq8bax8kVgp4yZbcLeDMCfEEZASvkzkZRBjT7f4L0hMemCAuMAzDWbZODYNA3+i8YWaOcCStSCz5LU0YqSNvCSDkjKJ6G+HJRPhfIndgtZPPrVjU8e8ezlVIPR6Ti36FJ87zTjE1Y6vgnAvg6z0j6HLE5MCf2qRtq8Oq8OpG/TXFt8wSxBLzU9wvw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0501MB2602.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(366004)(376002)(346002)(396003)(136003)(36756003)(186003)(52116002)(26005)(316002)(86362001)(6266002)(110136005)(1076003)(508600001)(2616005)(38350700002)(8676002)(66556008)(83380400001)(66946007)(66476007)(5660300002)(8936002)(6666004)(42186006)(7416002)(38100700002)(4326008)(2906002)(44832011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AYPhq6kdRK7YE5kgsgWQOXq6zgmBLKSbSGIif5vb8hP8OzbtYYu7UFhMnYIr?=
 =?us-ascii?Q?S8TCRJh9dth1e7IP91X1dB5qt4RYkjQAtZ2pJVpI9ItfSHv/ILCHCnoM7ufM?=
 =?us-ascii?Q?KScCbH39enNAqJwQ+7IQ4+paTdHfW6E1R0d/XNSxLG8h+07eg5Xkt0BjZ1er?=
 =?us-ascii?Q?yRhpMA/CKCeqYsZSDX72l63ENMGrwNnu9nK8Twkw0kajDA383n8mGXLqSrhR?=
 =?us-ascii?Q?PgQGTUAJ6r+bH+VZ7mKjN3X1y1o+RrhnNM4r9prdH0iRNKVxkfBbXbys+gWi?=
 =?us-ascii?Q?iXdTLV204QxCLzXmdy5U/WSlPrjOSjR6m5csFNbflriljsKGX52IKVFOtq40?=
 =?us-ascii?Q?gd7KBIeaiO6Erczm3ySSQlpn8BKOfvdJauzAwWf1GmxV2XoHpNlwfQ3oY9PV?=
 =?us-ascii?Q?hD2vtR/aydEZ3ASnKjiHe+XspHC/+6uIevQTG/IUTDBvllvWCxHNqMXW/t4z?=
 =?us-ascii?Q?1qHDqYtNwoEpLWRXHFSMokgQuMa4ZWSGFfc4NcF/QhN98+Ax+pdwLerdhW7T?=
 =?us-ascii?Q?jmTV9hePPT72k845YUq9z4gWHEmFMkOT3mRF4nVc8wfKFDHfWrMBnynXHn5b?=
 =?us-ascii?Q?2aaNIK9Tm+mey6xA+W2OpVqDDDRB5qqjdOQbKDwQAfs6mMmroGOqwcKTRE3C?=
 =?us-ascii?Q?rkpiI5c96ZNQF8FcSVKeXuu3LLff4zICgnu5UjQgtTWLNDBW/DlHBRd1qx58?=
 =?us-ascii?Q?fiF4fxU93j04fNp87wZQfUNm4eRLEz6pKQGTjcuFZs5Wni4g1ntikyeoiakR?=
 =?us-ascii?Q?zGyihBBmPeRhYq3kVgs4Aa8BLFLbn2Vg6+Gm8gbzbNtScwxDHTd130utkzfH?=
 =?us-ascii?Q?riye9p95FK/BBmEgC47PVX9l5Rdty0FVd8Oz8jk1lLOscpJ66bOeY+bB+5A6?=
 =?us-ascii?Q?7hD29aPsmUDhnEjXA752kZg7vS4sgmMN+BVGwxtg3yGK3zUvzGm+p7fTs5f8?=
 =?us-ascii?Q?/21X5+lc5gN4hrTwCoan0AiKmuK+2PruVNmWUjixyDtLmGoR/m7zfuUatyKr?=
 =?us-ascii?Q?VQ5QirJ7HIuYsrT1sRqzLokJn9Di8uH6RkZmOnAe3YEraDG8HRMRtROaqMhW?=
 =?us-ascii?Q?NbPuQX5hoLoZeQniHlIrCo05oFyLKrkwWD7NCuyPsRspnlN3OVf6PctSCyvR?=
 =?us-ascii?Q?Vg+NBkA2K0Z/HnJurWTcshwwYVEqZaLbPvUdFE3Myw//ncSiEty9fkEtFRDg?=
 =?us-ascii?Q?pvKQZovQQ6/UZiy//kW4xdzd3JTyyIiQo+DfWw7NQ339GYN9AR7jVLGqqi8R?=
 =?us-ascii?Q?0ExnvalfB23ygV8sscN4kwEtyFh2iGnDajPnvx82jbGqVZ3IYkwiLB1nt9OU?=
 =?us-ascii?Q?C3plEvOpN6T7bndfvRqvHMko?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b2959d3-1183-4e82-1dc8-08d98ee1c782
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0501MB2602.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2021 07:11:01.8213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: izAoPUl+dzyqcBN//agLTa1nE+oUnnxAbRavpOawxlI0XzmHPTn4JY6hQ8ep5AASEM+IqkTkYn5hCpO1OilmK7Kqv4dl7xQNby6BlfOQZRk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0501MB2780
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Stefan Agner <stefan@agner.ch>

If the device used as a serial console gets un/re-binded, then
register_console() will call imx_uart_setup_console() again.
Drop __init so that imx_uart_setup_console() can be safely called
at runtime.

Signed-off-by: Stefan Agner <stefan@agner.ch>
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 drivers/tty/serial/imx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 8b121cd869e9..51a9f9423b1a 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -2017,7 +2017,7 @@ imx_uart_console_write(struct console *co, const char *s, unsigned int count)
  * If the port was already initialised (eg, by a boot loader),
  * try to determine the current setup.
  */
-static void __init
+static void
 imx_uart_console_get_options(struct imx_port *sport, int *baud,
 			     int *parity, int *bits)
 {
@@ -2076,7 +2076,7 @@ imx_uart_console_get_options(struct imx_port *sport, int *baud,
 	}
 }
 
-static int __init
+static int
 imx_uart_console_setup(struct console *co, char *options)
 {
 	struct imx_port *sport;
-- 
2.25.1

