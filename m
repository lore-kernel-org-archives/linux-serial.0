Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05E7BC433EF
	for <linux-serial@archiver.kernel.org>; Tue, 23 Nov 2021 07:07:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbhKWHKQ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 23 Nov 2021 02:10:16 -0500
Received: from mail-eopbgr30088.outbound.protection.outlook.com ([40.107.3.88]:27269
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229722AbhKWHKQ (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 23 Nov 2021 02:10:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DQbqBMNw1lv0FzBJjCZLGKovWqIy4jPqIzaj0baIADwAEU11VliI6SN1Umhc7w2u2QyzIJydeFTbolE8W47r5CRPjRxZX+QrozYdhRFnMBotp+fuE/eKgvJDriF8JRMDViIuJf9jJfaH1zdYwM756xaPsT+XO5uEVHa5PgMBs35R3yQqjPbYqE8X7SlCEUfddZys4Op5zL26XoTGHB+hcYvL0biHCx6Yap7mwtMlEDAXZqq/rjiibzKCXpCwXnNA7d4KH0o7LLWq6jYqI1kmOtMfsV0kFVwAGhK7CVnBINBlBosON6Z7F9Lu3ZF1mMc7eXLic+xfkxQSKVYqvBt+kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j36qv2cTkEheCCn7G3UPdEI6ycDbQ7u8N+VhoZ5rokE=;
 b=b/RT9+6LbhgzMeeAH5j366SYbqVPuRL9xzZOdy0IKjwUExmgf9NdzcwCCb2szk3YPo+XQ7i0NizvS/5Dag3/dixdSOw3zD3SYkbzedJl9z9+61KzVUF6hdquZVm89/C6oAwAMc0MftYxM36BJtFsLukGeU440Rx/mdEpUzakwKXd+brKfsX5jMyp5OPjMgwwO1x03rAsVUoGi2OmSu/EBGilkc7ZOTXK+BEKljXiZdKUq4PR9WWo/GkLd7rgRg5vmjpAGr0HjNvqM5QJawPlr1OBR5xeGvPX8GLvKdLB5/KyV6lf5H1W4VmvR3z9VZbK1wH5RDpkDX2Q+ayOpgLT5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j36qv2cTkEheCCn7G3UPdEI6ycDbQ7u8N+VhoZ5rokE=;
 b=ZtZc2VvG/nWeVWtB/7dNDVr54veFtDME3Q3HtTc2kLi7wtejRDdj00AosReEbognjoIhaPgzGMWXdqUyUtbr7oriKps3HwsLHPhCRBSEpxD3seOeS/8oi1qMoky9M3o14gXa61145Qm4n2B2euDI4ZocQ7fuZTtIw9E46slRqJs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by AM6PR0402MB3352.eurprd04.prod.outlook.com (2603:10a6:209:11::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Tue, 23 Nov
 2021 07:07:06 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::c9fe:7982:c657:b423]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::c9fe:7982:c657:b423%9]) with mapi id 15.20.4713.025; Tue, 23 Nov 2021
 07:07:06 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH] tty: serial: imx: clear RTSD status before suspend
Date:   Tue, 23 Nov 2021 15:03:49 +0800
Message-Id: <20211123070349.20099-1-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0116.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::20) To AS8PR04MB8404.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f8::7)
MIME-Version: 1.0
Received: from localhost.localdomain (119.31.174.71) by SG2PR01CA0116.apcprd01.prod.exchangelabs.com (2603:1096:4:40::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.21 via Frontend Transport; Tue, 23 Nov 2021 07:07:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d9369cda-cd05-4d59-3b4b-08d9ae4fdb89
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3352:
X-Microsoft-Antispam-PRVS: <AM6PR0402MB33525120D595277BEE077F6D92609@AM6PR0402MB3352.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JN0SXOTMUPgspjMV16FsywRFbIcbbqtikk4dc3VJdc1kLBWNslGrqFcqS4d7yDiAV/7SUo4Uy+iZPfPzhDktdcmeNMpCoHP1zY/dolg7b5qrP8tIL5nrpPkRPYp9eKlZ8idMupyE5TQSc7myl1TJI0+bIZy8l83iDwJxo8GONNV29ZUPDUnedtj/oVutQHrVj76XKhtWCYvp2SDyW3G7sOuBWlnFKjA4BbrMfR3opairDj4k0btzZyMqM2cp6YL3f2sXCtNVf06ejoscCarcwCiibneQuhrx7OE6xfPt6Awds+R8+gLAbaPiK5JwPa8Fh1S8WM0FQcNquhp/+hhGPf+fNvTLhMHGPefugzK9A+4c/G3bi+Z2vXG4W1t+HcdxTvg9NibtpkuDkBEHZMt3OZBxxFVi5NWGklw4Faeq7WPNnmNx7BhCJCnWAoXOkFI+qWhVB4wgWvcjrf+VhDKVOSXiLRthTaOeNoAA0R9Z9xyMnqLDY7Oao6V6eVb0u3Z9S/W0DDctEwi6mjucvmRVDjdjx/LyWH58qparw8VMXYWI5s6Qhfo3qiQc0BMz62vuxzvpwbm5WcuOBq66lHy8HESekMRRJp+AmWSXhV250T5dFc9tYg89xRCTsltXMu3EPZ8mf1WpX1fLAC3BfO5Adbl7mhd85GB6/tH0mI+HRiQkjkob8IJYejQS7gmIsGw13iO4pdszb2YlWRueQxanMg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66946007)(66476007)(66556008)(1076003)(86362001)(36756003)(6512007)(5660300002)(6666004)(316002)(6486002)(26005)(6506007)(956004)(83380400001)(186003)(4744005)(8676002)(44832011)(2616005)(38350700002)(2906002)(38100700002)(15650500001)(8936002)(52116002)(508600001)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pn/qbBlIw/Z3Rh5wQj5DZxStFpMtV2EbgKq2GjTeW/i4UBJwq3TtW4EKyVG7?=
 =?us-ascii?Q?szgGna3YOaUFzuyiWAsfL1+2fmiEElHnp0sfM5KG/XneGJPUatIVgmkABgwp?=
 =?us-ascii?Q?peHQDGC/gLPkbfdp7iJuGg5d00EI3JtXpQrkGEWQqXhHcHIr7mZrLFQo6B+D?=
 =?us-ascii?Q?9D4batVQ6PlM2g7W82stf4ELv2goBoY5k+ZR1UAk2pJFRvWlGlwnYwxfcnXx?=
 =?us-ascii?Q?8IJTFM8ui79BJ9s/GZ5ZMr2vaH7ob5fvFNMQMzfTcUI7tr/rUUsNd3X45jPN?=
 =?us-ascii?Q?V7+GVHAP8pprG7Ha71YPY2XC/wmxLQ6KjeTK1EhWytuJiLvnseJkRlF3Mm3f?=
 =?us-ascii?Q?8TofV3cYGhgOjqrtX9efD17Cq3fV0PCDA/mEQaHGbtnwOu+BhCoyk7w2P2hl?=
 =?us-ascii?Q?Q9BrwK4vWmlWaxY3fyjh/saY5doYfejQvA3WtReeoRE4LhP/cUXREm9Qyfkp?=
 =?us-ascii?Q?TIPatkiXkIDd0HgdTddGxZELrdTZmvaNTXHgIiValMdwa8CZIEEAfBEx5o03?=
 =?us-ascii?Q?PP5vhPG+AUTm3TArp/Dtd97yXTtNxtZgw9I7DARAWWhaXxCBrQVd6npDVb4w?=
 =?us-ascii?Q?5g7iJgnhpANzI2iGpn+78ABrWYuD4QE46ONykgWvjL9Eb2ez3h/Garf2niVD?=
 =?us-ascii?Q?a6Q5e2+8RvfblxdBJbj4ovbTrRbC+XtPJ84vY3HB+9ROVBqq5zuUuHxrczV4?=
 =?us-ascii?Q?FWdfKUrxOaEqCeEB1Vn39fkpHNGUOk9O3pMJ7t9FMNPMAGVe69T3OH9bGPfK?=
 =?us-ascii?Q?TL5siry/tjACv3k8YPeYNCZSj/2/sMJfYPvPgm1LlxMYNbAB3+09ow4UpIcO?=
 =?us-ascii?Q?w6uD+mrWKzw9Wz93K3vgaAFuibe4XTK1P1EYQUveOM148RHMfR/t6ETwI8yN?=
 =?us-ascii?Q?RQBbdq2Sem/umfPNVOmlyh6Q0Awijv6TFB8M18HKZ74KzASUEiqD5YW7iVVI?=
 =?us-ascii?Q?+756F5i3koE+8t4+6aUORyPgF2eqc8f8/nMqNq6E27z0eVYU7goicbbNc5aD?=
 =?us-ascii?Q?Du98xXNU3OYKLRTcJ2bAhCV6G9nn2BrCqSs2CI8xNRVawkjNtg1RqAiuvaHT?=
 =?us-ascii?Q?jDk/lP3LWujounQkKDQ6gcVkTsRwM4Qtl8UbWm0A1tWrUODVf58/NRIfZzKC?=
 =?us-ascii?Q?2ypuZFQvnQHTIauagTJLiAaJsj3uXM3/ENgS5AQ1q4eaD3AFSqvH6l0wbCUQ?=
 =?us-ascii?Q?gryZMx0IdoBGCyYiHtcnGt+k+J7ccGsnNzwjirXzxb+MVF6Xati8NfOtQIpv?=
 =?us-ascii?Q?6LqrPRkqnle/NOFmXpwQgei7KPCXW7TDgws32iYZ6RiaeTOeixrBiud2Ts3V?=
 =?us-ascii?Q?kUc/R0dfGDvYt1WKqg9nvW9Dt43DeFXfnFZggyHmQ/U2EYltVlVkJhdCzZQ6?=
 =?us-ascii?Q?4kqv06M2mbrnuDBcZeAbFELyRKN17tE2kbIC2K6cWUT3f+ZMrveKBqeZz51R?=
 =?us-ascii?Q?ZRDEYTNOIUAFZCK25LN3n9dvrYa4fiisMHIn9AYSVI5cAsjk6WXnqRxep5CX?=
 =?us-ascii?Q?cgnOeWMKkgyNyd0HYozg8TaebQ6Pj6BJkOn+YgvacN8t9CpapKDddgigRXoM?=
 =?us-ascii?Q?0Vw0RKLSxScpuwzDToeQ+IbMCqpPdXxe51VvoG8qB/Fwg5H8IdcU7D2irKQJ?=
 =?us-ascii?Q?OQ7OFiziT2tSU357Fs5nBqs=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9369cda-cd05-4d59-3b4b-08d9ae4fdb89
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2021 07:07:06.2252
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DyrOvZZiA4AdWh9dn2fhRZCK/F+fcZDqyOVSrYVfouV8oePGEwGjmB/c6Km59TlPmovSzCzCgFsCkiorK9i8xA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3352
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Fugang Duan <fugang.duan@nxp.com>

Clear RTSD status before suspend due to the port also
use RTS pin as wakeup source, need to clear the flag first.

Signed-off-by: Fugang Duan <fugang.duan@nxp.com>
Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
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

