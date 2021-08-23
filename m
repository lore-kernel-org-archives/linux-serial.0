Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 745FCC4338F
	for <linux-serial@archiver.kernel.org>; Mon, 23 Aug 2021 09:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56DFA613A5
	for <linux-serial@archiver.kernel.org>; Mon, 23 Aug 2021 09:28:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235975AbhHWJ3L (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 23 Aug 2021 05:29:11 -0400
Received: from mail-db8eur05on2040.outbound.protection.outlook.com ([40.107.20.40]:30432
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235818AbhHWJ3J (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 23 Aug 2021 05:29:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NMW/sSZ6ViZG2Rb2D8dcJ0seZNQoOk5pJbujLQCQMtVQHEZ13HzqjxxOSNeUPF6Pk7SCsxbiVd4vlfdJ0Ze9ef1feNqrPpp016ypq6FVs7XJO4EmN0WTCccHn77MRDz3DOKAjJ+ZBPcaAyYxQIZCN3bh0S3Rv6ubVlYZ/qFOgXJeH07hCRrKCfkBJu/u2CcMBIo86I1jYIMGSmQCIXMhlnbTgKVpScpdrUVQ1T7yzuhTXmpJPAXgo7Fy0TjLM/PAsnNSqCgO8/HnhzTrcBFJTY/mdkTMxfd/XoQWMvDhUM0SOD1U/ECypyem3UQPc4HldI76kXN+b0940V+Z2EIUlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1r3k1G8xiIKB1EqP9QvIR/RruCGP0DWkLaboLDNgkAw=;
 b=NP45x2DbnlMMftPPbikfq6U+hjBqgMN/Ph99spFR2NZhy4dJLCngsHrhLUj179ApqwqDFG4lYxnqpAokGgPWkJGPalCB9WvargEyEQzO8lgsiuGK89LkFt+Ae9RfNj1C6iNEGAutG16toqgznT7x8sU8lltjG12Svp0XlPlskXH7U9LIIp9MXhNyO3YkgMvpFuDXYYOtg82+LQH+5sv2KokCS6cMQxjreRxj5CGd53pL7PNtOofyq45sy2tdFMxcs7xnEpnG1q2D4+HB9n8KBxh9Z3OO4hhKcj8PVNfSjrdf30lrKA1uKAtYQaSRv6DFSnw0mw3csi2F5puIx3iVuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1r3k1G8xiIKB1EqP9QvIR/RruCGP0DWkLaboLDNgkAw=;
 b=YJvvpyBMaWbbiqbH3+FptjfE8abPslIi/Es0bHH9pPDHKVC3SF+u1fAHag2/H677C5kwLS/0XXHGdTMfNUYl0/hJeVVSS4Z0hT36lpaIN/yx4TrX3esFfrkBBai+Aa3Cd1zEgZit21jo0Z9n1EnnQwv13/qVM84jpT3uf64d0J4=
Authentication-Results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=nxp.com;
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by AM6PR04MB4774.eurprd04.prod.outlook.com (2603:10a6:20b:5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.24; Mon, 23 Aug
 2021 09:28:24 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::3425:96f2:c80b:1e03]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::3425:96f2:c80b:1e03%8]) with mapi id 15.20.4436.024; Mon, 23 Aug 2021
 09:28:24 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH] tty: serial: fsl_lpuart: do software reset for imx7ulp and imx8qxp
Date:   Mon, 23 Aug 2021 17:18:01 +0800
Message-Id: <20210823091801.17447-1-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0051.apcprd02.prod.outlook.com
 (2603:1096:4:54::15) To AS8PR04MB8404.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f8::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.71) by SG2PR02CA0051.apcprd02.prod.outlook.com (2603:1096:4:54::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Mon, 23 Aug 2021 09:28:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: adfbf047-bf82-4d6d-bbc8-08d966185ae4
X-MS-TrafficTypeDiagnostic: AM6PR04MB4774:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB477409B9CA657E3DA339EE1192C49@AM6PR04MB4774.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1169;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J1J7HguX8oUnm37C1ZpVUC8nbMCayQ9ncbxapn5BShMAID2hYAcP5Cy901oXFxlBdbcbtC1LcuS1I6DX+PtHf60czjWvqMvbiuxeigOtfu4pBV5zxqCeUZPyrQ8BeSoPu5DJrplruRDYqCY5HVGK7bgIChLFBMiaEynvzSO+ebrBw5BDXKsF5oZRpKMXDnP6m0iAvirNozFlfVOrIytiZncsZMSlbxquG/31L7f+Edx31HbkjOUktwzudlK/gexPpnby12BMuq8t+Zp3nIrg6rApF/QsZpFpeLkngK1MKOjXpM5Ky1U325YgndAZqQz0jalzXjmcGOsYzor89MV8j6nf63YoF7Jv7wqFA0INcdJwqrLKxRzZpTjQz90M5du7CCI1uv6RDrY7Yaqu3tjb2p1zfbj/oJ2uiREi5T1LOQLRQI2KtrDysLuBayx+3CdZKcxa+Vi5gYIVOSAqzzJwJVOhGhO1KBe1lOPf2Mw8gd6LiXk4WCJfnBEPODj56Kybzv0+nqG5YKfefSwan+n7GSoxjA2CrzqMTufT5GHUFutCou/SAGpK99OqONt1zDTNmEBEm67heCYxsbhmzZU4UQLHsM3jN3HtFGbs7HMsoksEVNwlRwSveVnBUGZTtay95CSN+9HAPX7A284vBEGFdx8DkmCgdMd8wyOOTCk681ElIRTnucqtrol8rXuP8XpPlPQxDBRSNDVxbM+t4dG5qTmG0oOFCJUdKKQB4fODijQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(44832011)(86362001)(6506007)(956004)(2616005)(6512007)(52116002)(66946007)(26005)(186003)(83380400001)(1076003)(6486002)(508600001)(8936002)(38350700002)(2906002)(4326008)(5660300002)(8676002)(316002)(38100700002)(66556008)(66476007)(36756003)(6666004)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QzV79pCIh1ldzEqITcFQ3L5r4kPsnpwwtO5cc9ApX6/6aeUwwQXTtNyD0ovm?=
 =?us-ascii?Q?aXlt5my8GvDVkybMgiMHXK3CXRG4GZrW1J1FW5dPo1TSco9VHuw51F14qZvg?=
 =?us-ascii?Q?6rBZtG1pWnun3L5XqGf+2l2MvxRKCPNVWlnIAinqVo/F84ZBgxTEjjFz33j1?=
 =?us-ascii?Q?4w1En1KUjyKCqV9XjERDk22lXXT7nfWyfqWEC7bv22nWrafihWOJgBe1T+a4?=
 =?us-ascii?Q?2KEzkzeYIi5LQIPtjsWL49BW92AvQ9S2+TZja3U5e6DfIkjxFGCgLV47aTkm?=
 =?us-ascii?Q?3nT0CIn5SJe3gD5SbsJE/MH3S3x7Kr63t556sfhmtUjPRPN3YI3EmOgM/qlF?=
 =?us-ascii?Q?iufYVVVnGHbwDSmtHPga1KOmMV/NsETOZU+Dr7o4mTeP2eJiYDWDrg7ow0AD?=
 =?us-ascii?Q?RD/6TrCg3KlMiY1CzFgCbn5fdujV1eQickitMAWwntumMv1+PfcaUo66YkKv?=
 =?us-ascii?Q?y+7Q27SehEq5fLqb/VCyCuWJ7dhaJfGqByka/D7oeswLwQCm16kSNu0hPY+x?=
 =?us-ascii?Q?sQ9MvyvxtqnOBf018d9W2bPiiCFiWTXTGIlH4rfRWeTr/MAVzXGK1UjIlNhq?=
 =?us-ascii?Q?Yl1ngQ08ME0pawbg6ln+iWWW7s3OJJaud8Ny4VsUwv/UQ3CPyOXT0Zbccx8x?=
 =?us-ascii?Q?UwaBQ1mU/0GkyqZBbjL5CPJaNLTeWmJKJ8Mz/xr2ir6FdnFHIapGh9rXC/Ot?=
 =?us-ascii?Q?DH/23A3jErHy/U5vR9o9sCnmROM2x6enwZjYan5F9ENw9Xbq8L3+CbyJ2lKN?=
 =?us-ascii?Q?EYbgPtHPR1g7w3n8J+AkMY5aLs40KdaOeIN01ohCK+9QWjIV6dwbgqPnkEku?=
 =?us-ascii?Q?L8J8wf3yqKfVFfuTiJzkhcAtDwsjnVgZETvp/oGz4uqzwrCvULiCTDxIhv3+?=
 =?us-ascii?Q?StJDnePFFSVqU7Dfwd0K//RmB/YWg3DfArFhgrvpDKFEuxcMeD8rdE1Atn0V?=
 =?us-ascii?Q?6ereBc8+mlMFbTIFsrJa9EysJHPagWr0XS6u4QnpQXEoekhJVyFFe4yeQD5w?=
 =?us-ascii?Q?Cnk1ZUcqGrdayilYakmHrFU7Ajhb5tEYVRepZMjepJpjV2jMcv8Q5YlqYBsY?=
 =?us-ascii?Q?3h+b7pPHXVEr+i91lG6ORbq5v+o0u0U7Elp6oxNYoHm9U8HaWXt4lzTU252J?=
 =?us-ascii?Q?RZWegikZo3lljUurV46R/DSOR7XU5IH5be0HLLHvISv4b1zzG116QRsfFLrT?=
 =?us-ascii?Q?fukSoTwWGX/p3UK6pwVAQN4g21UhUNFQAyo6uUOwToDSVsdMydiC2/PdDwQW?=
 =?us-ascii?Q?5SO+RJlGAe2cIzwSjSgTAPh5vYb1rgGRzPu3lON+1OKvI+TFHWZ04A27mGiX?=
 =?us-ascii?Q?Kp3mQ9vTcrKMIvDpEQNC62fM?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adfbf047-bf82-4d6d-bbc8-08d966185ae4
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2021 09:28:24.2731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4y0nTUaqjOPDYO8t0+Fa1uLjBt5h72ImiAgI32RyxrRD+ljWYcANZZ+E9lnYZmC+LmnAnJ/JVAhSlKdBLZMGgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4774
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Fugang Duan <fugang.duan@nxp.com>

Do software reset for communication port on imx7ulp and imx8qxp after
the port is registered if the UART controller support the feature.

Do partition reset with LPUART's power on, LPUART registers will
keep the previous status, like on i.MX8QXP platform, which is not
expected action, so need to set the RST bit of GLOBAL register to reset
all uart internal logic and registers.

Currently, only i.MX7ULP and i.MX8QXP LPUART controllers include
global register that support the software reset.

Signed-off-by: Fugang Duan <fugang.duan@nxp.com>
Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/tty/serial/fsl_lpuart.c | 48 +++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 55097e068908..b1e7190ae483 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -7,6 +7,7 @@
 
 #include <linux/clk.h>
 #include <linux/console.h>
+#include <linux/delay.h>
 #include <linux/dma-mapping.h>
 #include <linux/dmaengine.h>
 #include <linux/dmapool.h>
@@ -109,6 +110,11 @@
 #define UARTSFIFO_TXOF		0x02
 #define UARTSFIFO_RXUF		0x01
 
+/* 32-bit global registers only for i.MX7ULP/i.MX8x
+ * Used to reset all internal logic and registers, except the Global Register.
+ */
+#define UART_GLOBAL		0x8
+
 /* 32-bit register definition */
 #define UARTBAUD		0x00
 #define UARTSTAT		0x04
@@ -219,6 +225,10 @@
 #define UARTWATER_TXWATER_OFF	0
 #define UARTWATER_RXWATER_OFF	16
 
+#define UART_GLOBAL_RST	0x2
+#define GLOBAL_RST_MIN_US	20
+#define GLOBAL_RST_MAX_US	40
+
 /* Rx DMA timeout in ms, which is used to calculate Rx ring buffer size */
 #define DMA_RX_TIMEOUT		(10)
 
@@ -320,6 +330,11 @@ static inline bool is_layerscape_lpuart(struct lpuart_port *sport)
 		sport->devtype == LS1028A_LPUART);
 }
 
+static inline bool is_imx7ulp_lpuart(struct lpuart_port *sport)
+{
+	return sport->devtype == IMX7ULP_LPUART;
+}
+
 static inline bool is_imx8qxp_lpuart(struct lpuart_port *sport)
 {
 	return sport->devtype == IMX8QXP_LPUART;
@@ -383,6 +398,33 @@ static unsigned int lpuart_get_baud_clk_rate(struct lpuart_port *sport)
 #define lpuart_enable_clks(x)	__lpuart_enable_clks(x, true)
 #define lpuart_disable_clks(x)	__lpuart_enable_clks(x, false)
 
+static int lpuart_global_reset(struct lpuart_port *sport)
+{
+	struct uart_port *port = &sport->port;
+	void __iomem *global_addr;
+	int ret;
+
+	if (uart_console(port))
+		return 0;
+
+	ret = clk_prepare_enable(sport->ipg_clk);
+	if (ret) {
+		dev_err(sport->port.dev, "failed to enable uart ipg clk: %d\n", ret);
+		return ret;
+	}
+
+	if (is_imx7ulp_lpuart(sport) || is_imx8qxp_lpuart(sport)) {
+		global_addr = port->membase + UART_GLOBAL - IMX_REG_OFF;
+		writel(UART_GLOBAL_RST, global_addr);
+		usleep_range(GLOBAL_RST_MIN_US, GLOBAL_RST_MAX_US);
+		writel(0, global_addr);
+		usleep_range(GLOBAL_RST_MIN_US, GLOBAL_RST_MAX_US);
+	}
+
+	clk_disable_unprepare(sport->ipg_clk);
+	return 0;
+}
+
 static void lpuart_stop_tx(struct uart_port *port)
 {
 	unsigned char temp;
@@ -2699,6 +2741,10 @@ static int lpuart_probe(struct platform_device *pdev)
 	if (ret)
 		goto failed_attach_port;
 
+	ret = lpuart_global_reset(sport);
+	if (ret)
+		goto failed_reset;
+
 	ret = uart_get_rs485_mode(&sport->port);
 	if (ret)
 		goto failed_get_rs485;
@@ -2715,6 +2761,8 @@ static int lpuart_probe(struct platform_device *pdev)
 	return 0;
 
 failed_get_rs485:
+failed_reset:
+	uart_remove_one_port(&lpuart_reg, &sport->port);
 failed_attach_port:
 failed_irq_request:
 	lpuart_disable_clks(sport);
-- 
2.17.1

