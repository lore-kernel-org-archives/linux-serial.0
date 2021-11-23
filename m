Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99562C433EF
	for <linux-serial@archiver.kernel.org>; Tue, 23 Nov 2021 10:49:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbhKWKxD (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 23 Nov 2021 05:53:03 -0500
Received: from mail-eopbgr50072.outbound.protection.outlook.com ([40.107.5.72]:10743
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231764AbhKWKxD (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 23 Nov 2021 05:53:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e+pkmX7jIL19NVc7fCS/aJUh4/B9YnYuTX3nOglksG5RbEGKUvsPhdcja4qfitNx/bP1UMXRPZB/iVdby8LQyF/kEjhsYM9gVMrsgw78pzqKNtvWUhJ4UAHYjN+jRwe96vxUVr+24asDpJ2YtsLE8gv+b6kl3ELysGFzON2nR0b9215LuAqZwwgskahH5r3xlSze+cjOfXdrFO/qEwyIqX1A1HOcv0oXAAQB/+PBiBU4sQU55TJWQ+3b0+HvbvsT7k6gyZkRgHpvfVj+X9b8o9huv8uBJhwhKKWQVAwydVLRC9sacZLE7+yieB30RwseldnX+zVWN1GS3FUoeW2pbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uxGMSISmw9xpTGhO9Yvu0fqVPq8379Ib2AF/TgWZ65Q=;
 b=lH1pEpn3mbfNJk76tHuqFeaN/ScvAjJRVkwtpEPsWPv7i+lMSDjgC78YhQMYGbXu16tKevxlgdnDF2u9eTZLk5NaLoVCAUI5RWTtxy/5PmvojPux4AAI4+ksx2afy5zW6ve6OVLuHwArOX1RMQvVmnFVM6gQD8ITp1DCkEiZp6uneQamjCLsgJW/ZrA0yjtyWWJbqirRqxtcqiwhlBe18BRsEY81k6r9om6q1SptBKobywuHX962zSwota7bFeum73doQ5QuWGxBAGfX2fzSNnFjIfOLZwWqOgZo6XPUIrj5sU3mARTJ7f0NRkdnEnk1aRQQFWD66kTObfZqjIHvDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uxGMSISmw9xpTGhO9Yvu0fqVPq8379Ib2AF/TgWZ65Q=;
 b=fLnFitD7mWXe3sAXCwMa3BcdekfVG+4g69KYnNIjn7LiTw8hizsg93J73BNYNJj2hqKs28scIgBZDMn40QujYwlFhHhxnYmQojBkbsJVKrx2C5rveldWD9JhMgv4jGDit0tKQHkNA9gF7o5d5n3IGgu3tebhoNn5cLysmw3pw2w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by AM5PR04MB3058.eurprd04.prod.outlook.com (2603:10a6:206:6::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Tue, 23 Nov
 2021 10:49:53 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::c9fe:7982:c657:b423]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::c9fe:7982:c657:b423%9]) with mapi id 15.20.4713.025; Tue, 23 Nov 2021
 10:49:52 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        u.kleine-koenig@pengutronix.de
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH V2] tty: serial: imx: clear the RTSD status before enable the RTSD irq
Date:   Tue, 23 Nov 2021 18:45:28 +0800
Message-Id: <20211123104528.7781-1-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0145.apcprd06.prod.outlook.com
 (2603:1096:1:1f::23) To AS8PR04MB8404.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f8::7)
MIME-Version: 1.0
Received: from localhost.localdomain (119.31.174.71) by SG2PR06CA0145.apcprd06.prod.outlook.com (2603:1096:1:1f::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend Transport; Tue, 23 Nov 2021 10:49:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c7fd2b10-7d2d-4d5c-abb6-08d9ae6efab5
X-MS-TrafficTypeDiagnostic: AM5PR04MB3058:
X-Microsoft-Antispam-PRVS: <AM5PR04MB3058A6A2B14ABFF31F2951D092609@AM5PR04MB3058.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1OdRyCE/XVyF5M3I0dpcOynsWxTgVuq9tFEZk0LGnV+VVEGiNJ9PRX3wmmemz6EeVbsQF8Jo6MgCAcHbnt4ezV1DSrLEq4xiNlBlPFlWcSC3oRjt2SRjLQwo4weXFC9lBeaQnHf/PlskQgf3q2RmwEkhWfhJ8CJUs/W/226EsssKd9zKqEJpFWMpukfI/iJ6R/KolSlfmPRbYOHcNfhDs9+argA3aLODw+7+HOacM/DgsKHOwUpAHqyj+k13v3PnV7Z5KZk2X5c6nyacSGhpVp+q7ev9LKRChgMf3PxPgBFmSluRFRnIvMKNr4m6D+xpHtA41KO2gkYsuLsWQ6fhhUKgZmwSi3UnPlvqsBgms64Q9tOG96W6h8lWajiWkatxQXiDs7dK46D0hcb4AsLArWC7o2rTBLdd5TIkJoOqUftwlZG5lW7W2tkiMrNV8GdDQVGNz5mjj7c31kUP166FhGpraz9a3wDLbPJXx6bFPlgL/LtdSo4wR2qExBVQ3E/jTxXs94/OyXhFn/ufqFDbJdOZXZbdMLVS8PeFIhvL0gmtruiVVVw/0IlaR8qs2aMaiedN7HviZMEO3Yzyv1I+IL4bW53JkSikgb4U3jEhFdx+TCHO7Um+HFdoa5rOZN5zgqYz9kaNy1vJ/hoYZa0eCpZH4ThikXa9ngXjo9qCg0nnl6BFOIFzfKnMAll9Pgc/Z6tjmAskd7uKvShE3drZ7g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(316002)(83380400001)(8936002)(6486002)(44832011)(66946007)(6506007)(26005)(4326008)(6666004)(186003)(66476007)(2906002)(6512007)(66556008)(36756003)(38350700002)(5660300002)(508600001)(8676002)(1076003)(52116002)(956004)(38100700002)(2616005)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GZAV0GNffWWhYz/eni3vf9kkGQujcejL3L061DE4ytwAlR/A1PimgXKmpoUZ?=
 =?us-ascii?Q?oWb/KmXAE6a+w1MJmI19RqYizxO9y0cGJiyJPUYU/iTVfxzJDQEzBCRBo11o?=
 =?us-ascii?Q?6R81j4G4LMoe/lQbAEQtntXhRml6IYhZVvpcQ+Es1OvY9vRFltXKmQ4sb6Fd?=
 =?us-ascii?Q?EkxivtPw7LbvCBXuELN8io77RvOhSTU68qGjBZYpfR0bMX35989E+jiEcUCK?=
 =?us-ascii?Q?GVgSMfOhepyJJiJj1+L2V38aNIj/yjgBPCSxCs7PYNagi+9g3njHyVbcCrDv?=
 =?us-ascii?Q?wo1ynUot2O/NTiMQyVbzTqh+g9qRMa49IzK38s+Kb9xgdkBqcwa1ggYywjVX?=
 =?us-ascii?Q?qPbLMCH3eg5BvZqUhD/M5D3dZxkjchRrlIzMhZkQEAdVuTp7x5rICaMJ5OwG?=
 =?us-ascii?Q?/iYokXtyyzplEvkLscE0MLZOVH0nQpMoQtO0gCJviS1BTFpk3nWJlzsJbPp6?=
 =?us-ascii?Q?ieMOWMUiwxVmpNHzKJnIjd2d4qErRGnoGruyXZNXUiFsc8idsQv7pFhjOKzo?=
 =?us-ascii?Q?KYOmc1YEt7FqWlzXwPLsWaod2vaSzS9Zc8POcGQX/lvOJPh/xWrPeDPlEEKj?=
 =?us-ascii?Q?4LPdzKW0I4EreAqowCDJO7dWXAIR4lJCg8p3tgBOvFZ68YDWQpbvp8hXOx06?=
 =?us-ascii?Q?DNVzkxY7fEnUsgh9zDXburXL+XrkoHK+JfpVxmKs5+We4vbK4H/fwl+VXzo9?=
 =?us-ascii?Q?czVOpW2Lcjre7blfOypEznX/Up0l9mzpsINWPs48caGOdNQ+Qxtut0YnI4y8?=
 =?us-ascii?Q?G6OqtKXdYp5Koouz8R1L+y+HAOqa+nixv/g52fqrgdbQ9mcJf9l8zAQFvJNi?=
 =?us-ascii?Q?hF2Ig8uiRZilXZq67IK9RFOL+iWzxlhhbr7HObIONv8Vd+fcqY0BdfpRrZ9d?=
 =?us-ascii?Q?tv7ad0vWmrLzHZdsE1xZBZzFl3sRAzDeXjiMZsgoLsXkrEimoUjnJKWix52F?=
 =?us-ascii?Q?Jl0r+RlPGCxVeq7RTQ4j0rEtZoEcDr26F58LfXwD6JZTe+g/wx62P8A6WbeE?=
 =?us-ascii?Q?yjjQAGKnDt4hQM+RTeRBfXVHux9rICjUZ6mb2iQaOyIjzOzFN3L7NJFzTckF?=
 =?us-ascii?Q?vhtTPB4mzsodWbR/GhOVcfquGrq4A3h3xne09vVBDAdiZojS4afobdQhMQac?=
 =?us-ascii?Q?5d9Jbn7m2ht++gBydpcEmkk9b/CcPQB8w6KvgbacrB0dSuX2msRLF2oQCaJd?=
 =?us-ascii?Q?9vQqjl7sJs1PdPaLtFWKZJI+gtJ3ZaUpc7f/iUSKb69b8lb76bD81Pifm4YM?=
 =?us-ascii?Q?sm9obiqCp8JbOCyH9ZOKF46f3Htgueq1+iYME39JkYAqLfJvIBhUScFaOe4t?=
 =?us-ascii?Q?ugJBDuGxJs3mADRJySJM8UqzRkrsCmH6iOEPJJSdQ8NNsaAC8wL7VZFLahi+?=
 =?us-ascii?Q?3+AspbTTsMHsr7wxLFMQKgJ/6Hfr6zSyETjUDckmKiEg3Z0acR2oiZP31gJE?=
 =?us-ascii?Q?O9SddZTXFpzzDmi1ZWw+Ygyigk8ta+Dl9F8f+pD6mmwlTTWFe3c49e6GFHXr?=
 =?us-ascii?Q?1Ul2ZYsUYyrYVRmzpF+JoWvWoW9xh+gj9o1vTdfwIckUw4AbDfcTw9bw2K9L?=
 =?us-ascii?Q?jEBTxpuPW9D6pGyhsED9XeyzUm87LnxKXaKTO0IFXxk7AeZvviEWI0qzb6rJ?=
 =?us-ascii?Q?d3tir5aC64/H4ekLufHZSQk=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7fd2b10-7d2d-4d5c-abb6-08d9ae6efab5
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2021 10:49:52.7990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5antFN4MuDYjc2xPLLmPcVDNHOgws5LoIA+KmG5/Osfs2ItR/DPw2iYJa/KzjLirNixsLWXqVvoAavjHXJf8VA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB3058
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Fugang Duan <fugang.duan@nxp.com>

Clear RTSD status before enabling the irq event for RTSD in
imx_uart_enable_wakeup function.
Since RTSD can be set as the wakeup source, this can avoid any risk of
false triggering of a wake-up interrupts.

Signed-off-by: Fugang Duan <fugang.duan@nxp.com>
Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
changes in V2:
 - change the subject and the commit message as suggested by Uwe.
---
 drivers/tty/serial/imx.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 90f82e6c54e4..fb75e3e0d828 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -2482,10 +2482,12 @@ static void imx_uart_enable_wakeup(struct imx_port *sport, bool on)
 
 	if (sport->have_rtscts) {
 		u32 ucr1 = imx_uart_readl(sport, UCR1);
-		if (on)
+		if (on) {
+			imx_uart_writel(sport, USR1_RTSD, USR1);
 			ucr1 |= UCR1_RTSDEN;
-		else
+		} else {
 			ucr1 &= ~UCR1_RTSDEN;
+		}
 		imx_uart_writel(sport, ucr1, UCR1);
 	}
 }
-- 
2.17.1

