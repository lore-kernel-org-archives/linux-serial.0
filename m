Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B495BC4338F
	for <linux-serial@archiver.kernel.org>; Thu, 29 Jul 2021 08:33:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91E6F61040
	for <linux-serial@archiver.kernel.org>; Thu, 29 Jul 2021 08:33:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234880AbhG2Idl (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 29 Jul 2021 04:33:41 -0400
Received: from mail-eopbgr70051.outbound.protection.outlook.com ([40.107.7.51]:9039
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234256AbhG2Idl (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 29 Jul 2021 04:33:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YHp2YcM/uisuaS6/Cg6XSSAxR12hz4B5l5e4kwnBajWvXQRZp/w9CUkfo6wMvrPSR83l/QlD2C5QRreCzFn30d/sb6qBRhHkxDMcKmH7VEkvx3Q2RCIz1N76HkHQVK9uqnn5toDxRtKwBna0j+3/eKfOMtrxkrFJss/nIWL2MSjpdizK8OoXkzR4xxOMywvgasd9uBVpqOuspykwVOpf7zOXODcafTF9bKG8afrp6JfwBUhUtCgZ9g1T83ulPGwHAMRQ2BoBHBTW8s0J8Mi05LsHBMI5bg/kRcRbS66BHhA7ieeb/w75h5X/K8TSyYPE/dvCiAL3i9GxnMCvrTuy6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lbUanyjN4rZuiGDfJUwl8HsV7Cqwpb6yZ4ybKyw06A4=;
 b=jwj3q8de6vtEgzNAR6+6gU8gTyqYqNAYRqFxnqX8XGcDNqVLHMeDwX9ppjUBlwK2ePA7ofM+XSNqP7DtkW8wnxLfQFODdfqGaj0J1xzXVzQWbRkPi5Bg2GaHJ21fcwZv+nbxDb2+cXXCvJahnEujMXC8czSaQd7IxUf/Tu8fZ1SwXuTeukXrOAfYl59FGIxt/COo9lRXZTnT49KtFXQ2cWouH6o5v+bod1gJvikZXhBoxddH8ZxfzApmt6Hb9YiePF7i18u5PuRGaHrPX/oA9nExaRC3vOITNKZbu+1HpCCEH3NFlGKhK3sn+XT0J8p+FFebfGtExzadzdTdlUrWXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lbUanyjN4rZuiGDfJUwl8HsV7Cqwpb6yZ4ybKyw06A4=;
 b=dSLsdLsYq31hTrzU2wpSCtKxZ58C4Kyd1jVS6lWQUl8jV5RENj4UwdxbIbNnd5l5tjzTae24m1dQDoiilTZiofl23EvmiHw1GJzQMV97UipQVdSOQryvx9ugzlfNvHF0DoKPhmSjVfhXWRECy15c7kyDBpu6X5iLQXSbNhbB3K0=
Authentication-Results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=nxp.com;
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by AM6PR04MB6535.eurprd04.prod.outlook.com (2603:10a6:20b:d8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.19; Thu, 29 Jul
 2021 08:33:36 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::90de:ffdb:198:1474]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::90de:ffdb:198:1474%9]) with mapi id 15.20.4373.021; Thu, 29 Jul 2021
 08:33:36 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH] tty: serial: fsl_lpuart: fix the wrong return value in lpuart32_get_mctrl
Date:   Thu, 29 Jul 2021 16:31:09 +0800
Message-Id: <20210729083109.31541-1-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0085.apcprd01.prod.exchangelabs.com
 (2603:1096:3:15::11) To AS8PR04MB8404.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f8::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.71) by SG2PR01CA0085.apcprd01.prod.exchangelabs.com (2603:1096:3:15::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend Transport; Thu, 29 Jul 2021 08:33:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3da048cb-86d3-47ae-fc46-08d9526b8eb6
X-MS-TrafficTypeDiagnostic: AM6PR04MB6535:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB6535A85ECF6C4445DFF3235892EB9@AM6PR04MB6535.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EZkNCVWoUwBkxTKghUKCMPu+9QAIgpa1BmDtH/RHql0TZ12bF5QvgcCf0IOnjS5s2rsa+XzqO99ETd0PaWesXCjEE5jNTHvqHJyteWLrO/rRN8btffBfqtTZAXZie+lYLeP0ddnmiNTzKIHZSh3wZmqQQ0Y9gyn6xhCYZUGfxYIRQCVz8flLmhAaFNxFGeCRM+ATFHX8/T/EeTORdDxen7CaQi8C/YAGngcCofmg8EYawcN+Zi/PZOXq8qKA1nXdo16fXBbAnG/Zrjmye3vgEZhCmiKh02X5g+yOzqvyUvpeoQ8bOEFRrnIlYf65CRNw+MQTbQqdBf7l/fOXkpH8fqioIvU/k9PzLtpw+gekmrzXA2jvNzDtYTKx4dQ+sPtzF/cZOPhj6EqUXZjv+gbdZhEyOqIA/OyZd7jCSnE4fOmMmtUTBMutX6DkZqdAuxs8HrPoJL9jEwJFQZ4k+7yB3TBCQgDoepKH6hgCyNjRBU/vIY5ceECyL9wP89xjQWWySp59wvuSqIzeiq50ipU2OUkqx9A0p3CuN3rY0qAZ1yWrNQGcVz3WnxkDCglrs8/uU1jvZKAfePdaxuL7Bjsl12iWyIWIOTKokqjnlnRyjuXJCXIVyLgCAeReoSLKnfCXMOFkkT2GU2WWda5F3FdJJdeZ71a6QwHD0GOpIKHDFuCsLOrKyOCi/uwppxf2gM6LSdDL61D7BcV1wYCB3U8DNQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(44832011)(1076003)(8936002)(66556008)(86362001)(4326008)(6486002)(2616005)(5660300002)(956004)(36756003)(6506007)(38100700002)(66946007)(52116002)(26005)(83380400001)(186003)(508600001)(66476007)(6666004)(6512007)(8676002)(316002)(38350700002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4LtNg6f8ggR00UQA6lEqe54EvmroWEy8g/3mjuRSPu4+bvBbxhbBxTsya52L?=
 =?us-ascii?Q?tGSD4xusbiotx/O1yvukBpR4hKF5jh7JDZhyY2k05YRPNCEmcObe7niFwA3t?=
 =?us-ascii?Q?J63JeULzUIaKGxrbkQgYZxpmf1QDCESxHRkV8pmMvn4qaaU4M4RKomBEHwr3?=
 =?us-ascii?Q?fAQNifUgGUvbrUU2pgxegurfJZlhOzofknTir4ZkKKm1cANDeWu8RhPdFdEX?=
 =?us-ascii?Q?1Oa98Jq/YVEvgL3GxAgJxEVDgFYtpDhL5JIp2ojua0QI24avoIlrOqblS5ta?=
 =?us-ascii?Q?4qjylibjjLK6n5g7SBDjktSmWLumj3lcJ8QPv22+8+rLmXlF/cnUQ4ec+RzV?=
 =?us-ascii?Q?9kG6HDparNj+EF3/CTnW26P19e/KsqX063LL12ydIg3IIDOTL+Oadq1pX/nb?=
 =?us-ascii?Q?oKxTSAXIqxVsy7iAAd0ktMlgnuEgqqCzTrqSB9Zh/Y5kUP8jxXnI2txR5SeQ?=
 =?us-ascii?Q?mqkLzN83olCM0V2UgJ9hVmuTHgdorqudnoLWY/PsE9JYXBytZBFVpY9U6QBc?=
 =?us-ascii?Q?IfjMq61bj/dilww8zl9ykfgRzz+27jvcGBuss3xx38Pjpdz3MwtYnffbfi77?=
 =?us-ascii?Q?VnvEt7fyTRIIxM2gr3H3F5WDT1Wu+O4C5Si/3Yc8u4wQOMzlGYcfOI9GxXzY?=
 =?us-ascii?Q?20IktGO2WBZec93XSfemaqclHkl0M8Q3jA+C1bTO9u14QLWsfupTNIOlHijI?=
 =?us-ascii?Q?hWyYXbBz78A0LvAOgfPWA/d6td8ADLx2l/Ud2FBtpw8eA/eHLHDFUT/jV0Tt?=
 =?us-ascii?Q?QeMWjr2nq97dv9V3PE21p42biiSUEUIHXjkIFTwRIQEEu9oxYuuijQaY1nG9?=
 =?us-ascii?Q?VWx4XN3/AmVgPZoNsXswFPxIMwYvFQgz3CMpnXfhLfzH6iN3Tuozx6V9LhBF?=
 =?us-ascii?Q?fhFU4NkZOjO9kZBXnW8PzIymcSwWGKM2I2qRCDiQcKIEDf1msBxlo0YSE2dw?=
 =?us-ascii?Q?sz8hr22FKQ1MY10na6/3djWoHFiRpI17++0HeAXHuDE4UXNdr5l8KkDDRteT?=
 =?us-ascii?Q?kMJS7Ad+r+t/Aof1ftCHUu3LHLMZrVdgJydVOMmYRqYeeV4KFP7NNdBDpyAS?=
 =?us-ascii?Q?mVFUfPtfJRtC186a32CAAwPoFurEVVv6U5yWTxNTR6etRxubk7hIilvZQ1b9?=
 =?us-ascii?Q?FXxD1BxwLybaTQN9VnwHIGYJ2y3AHWE6pNKoCq8Tk0qNpCNf5e1enJZjWbZz?=
 =?us-ascii?Q?otWljK4uBqteS8gJz5b0Uu+ORL53cc/r9ujJB41HsGa8EbWKhBz39URK56Pv?=
 =?us-ascii?Q?cT+uOfGVXT/NTjB7oXrFu2MV2IAwJaxeQAP7hNf6vaoT8xLX75lfjQk/HF1m?=
 =?us-ascii?Q?PlYNEj74oXzPRBa6nXiVwvJt?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3da048cb-86d3-47ae-fc46-08d9526b8eb6
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2021 08:33:36.1987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QJLlLiV4hs0t0wO1VmME+PMG8V0I+eysn7V4iBAbe0AIiLwqUrmV/k74pJkh8IBNkUI0aelh6iYLXc9+ZC0oAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6535
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Patch e60c2991f18b make the lpuart32_get_mctrl always return 0, actually
this will break the functions of device which use flow control such as
Bluetooth.
For lpuart32 plaform, the hardware can handle the CTS automatically.
So we should set TIOCM_CTS active. Also need to set CAR and DSR active.

Fixes: e60c2991f18b ("serial: fsl_lpuart: remove RTSCTS handling from get_mctrl()")

Patch has been tested on lpuart32 platforms such as imx8qm and imx8ulp.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/tty/serial/fsl_lpuart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 508128ddfa01..f0e5da77ed6d 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1415,7 +1415,7 @@ static unsigned int lpuart_get_mctrl(struct uart_port *port)
 
 static unsigned int lpuart32_get_mctrl(struct uart_port *port)
 {
-	unsigned int mctrl = 0;
+	unsigned int mctrl = TIOCM_CAR | TIOCM_DSR | TIOCM_CTS;
 	u32 reg;
 
 	reg = lpuart32_read(port, UARTCTRL);
-- 
2.17.1

