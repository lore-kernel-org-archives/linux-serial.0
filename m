Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 902B5C636D4
	for <linux-serial@archiver.kernel.org>; Tue,  7 Feb 2023 16:25:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbjBGQZZ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 7 Feb 2023 11:25:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbjBGQZX (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 7 Feb 2023 11:25:23 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2052.outbound.protection.outlook.com [40.107.6.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 485A85599
        for <linux-serial@vger.kernel.org>; Tue,  7 Feb 2023 08:25:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dqvFLjNu+I4Lc33kanz2IqAgnSdEi/DyF6kMT14HNX1CVqGNm1buGQZrgiHu2naQMySpZ/YBQnSrPI0R/Z2nIx9nKWo6n2v4Qjqs8je9z7bqJBiTcJ5NLQhSHnhTpW376uzsDjZf+M9PchAFAe5i4Y/4X/wS8wLHK/Qup6a0Q2qGBsnkeIfkpmb5nsHPcSa9cMz6xtgruRs6i1bCwMZj2UKNLTq0uch19MTldSIrV/0qOK5WmxepuYCR9miHJB6/kzK+runOlvfRbm4G+f+l3xW/kUwvxMLGEnTCuf0AAu9RhUIOB6fJU6mZ21bshK8TpJPep2gmCbu62R8Z+n8M3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S9GZXle15rALtqmFeGl7uT7f2kUOGLulSuaNwcBmsBI=;
 b=hYb6NzW3p5GVSuAkMRziZ4Cx6rPc2zSqJm7W4CVywnf5kht4nbxBvVSWVPaIDK2BC6yT4On7GfxNogcC194xGqH5TlfA9wlHh4LDzkfbALPHbeNuL0fRoFmfFNd8A3Q48bsqLBgSjklus6aRSiLoBA7KhGsU5huxxc68amPL8lrmV0rUC5xqLM+QuHO8nPO9u89FqKJnFH8vdk1jkFmVgJ5Rgx65ctSRpn/SJJfnLeClXjodOwuhvb60KJ3DggV+7R5ZAHaN07EYAIZIVhtq5M3jdWsvyLd6VIcuYSomnOw/fDe4tdRdWW0FlKqPr0IGqOaBRzljzDl3hf+8K0VkIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S9GZXle15rALtqmFeGl7uT7f2kUOGLulSuaNwcBmsBI=;
 b=BKeMHWckoo3oRZZIn7uQzt7ek/j79bn0ZTphYTzOP2ccQqlrYXGcocpWn2x35AinWP1raQXDmXrJZOkbDZ+XN1iv/addYy+avDkPQ4quqZsJSWXtGyje5PS9l8k6nDiU6fnSX/lwGDGlr1W8b86h9+v17e+t3vIoDdmYzbP9Ueo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by DBBPR04MB7626.eurprd04.prod.outlook.com (2603:10a6:10:201::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Tue, 7 Feb
 2023 16:25:20 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::31d:b51c:db92:cb15]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::31d:b51c:db92:cb15%7]) with mapi id 15.20.6043.032; Tue, 7 Feb 2023
 16:25:20 +0000
From:   Shenwei Wang <shenwei.wang@nxp.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>,
        linux-serial@vger.kernel.org, imx@lists.linux.dev,
        Shenwei Wang <shenwei.wang@nxp.com>,
        Sherry Sun <sherry.sun@nxp.com>
Subject: [PATCH 1/1] serial: fsl_lpuart: fix RS485 RTS polariy inverse issue
Date:   Tue,  7 Feb 2023 10:24:20 -0600
Message-Id: <20230207162420.3647904-1-shenwei.wang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0066.namprd11.prod.outlook.com
 (2603:10b6:a03:80::43) To PAXPR04MB9185.eurprd04.prod.outlook.com
 (2603:10a6:102:231::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9185:EE_|DBBPR04MB7626:EE_
X-MS-Office365-Filtering-Correlation-Id: 11206a24-468a-4e85-b0fb-08db0927e6fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MK4D0xacsQLTCBpG4opcmuysA1KPrToamWrRoYWsN5DX5x6/toXqMxDND/HamAjX4tTN942oYEN22h3qJcttjqUdhfFEfV0Wo7HodqvFbZinUTrzjDYidUKfdCnnEvgMriYxoF9x5GcM/xbE7pVd2fDjK2yP0RXkS+ivH+OKxYl4Cb4IyBuasxYF8yKZWVgF0ZptHsTh8nRVnh3RcsPaVYp5WenSwBVtYPnTBzlsHCGx5rMZmnDCPeatOpbbV6u3fBByHnxz5w+N5fpvdZ/UMfiiSSlPIVFkZf78yYE1L2p0dVeyUx5JueUR14fUQQbk/Va8cp+FL6joBHLppoK7U+uMCFF2NPcc8AvkUpsVfRknKOvOPqGpYjZ/a3sBwufABr8pbKNR4bL2U3gbWu5LkpZJOvc/s+mCVlgb1mG/aoJMl2/KuuCF6o1+1xNtZy+FdTune+Tbs18cezs2ej0uithDbEfNvUXK32BWipI6extztWP5ugM4cW+wtaFc7j6sVwZHGsWQuxANJyWivVidlgD7Uld/1LY+MC5VDaoShIcoeuKuKSdYVtBIJ0kAUS932XFrnRZh9+8sTDFWCT9HzsuC/zeDCWDVrXBis9fC4J5U7MzNT4x84rE0uecRTux3MFw8EowuTqX9/J6pFdsYkWioTGtEoOpmMOtFODvqYyZxxnr0/ZWA5q2vU8o+3a7outpX1W1IC+p1rRlRVzDtHg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(396003)(39860400002)(366004)(376002)(451199018)(6916009)(66476007)(2616005)(1076003)(478600001)(6486002)(6506007)(55236004)(52116002)(8676002)(26005)(36756003)(6512007)(4326008)(66556008)(66946007)(316002)(186003)(54906003)(38350700002)(86362001)(38100700002)(83380400001)(44832011)(5660300002)(8936002)(41300700001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vkmCbEM3egp/QGrmO4SdfyFSrf4yyIm5nTnT4W+lPaEHxtftzU0+d6ghrpit?=
 =?us-ascii?Q?ip7ODh9bQ8EjnEax1eegVpjpi0yZ22uEBu1PYICpbLk6fEHgttWazFSDL1ou?=
 =?us-ascii?Q?0j+7R/agIh6VfoN+05idQofT1QrtMfqYUh15hSYS9v7WOavacBSMFc4lG/NS?=
 =?us-ascii?Q?suO08qO/xamuzwDK7XTqfxZQgwpSZzKfk5skF694dV+LNP7tlU9Gsz78xBqw?=
 =?us-ascii?Q?i9iAJRgQIcrLZaqnulqf1rUVvYtybQ38sYRlyIkgXNC/06to2smTIlc5mdA3?=
 =?us-ascii?Q?p7hEL6ER2AgYBCaob7WZZdNmROfo3o4febjbE4imGqJXUYA52mc2FMImA/s+?=
 =?us-ascii?Q?L8fortBfJjikvwcQhsPJ5AqDRrCnfTO5UuVt6kXhYHA7CR8qmsVMFqkwfBJc?=
 =?us-ascii?Q?thM/UvSTx8MBNjAfk35fg+aCJlZ0ngUsabfh5xlG8B8RX1cY40NjnmqJrUKx?=
 =?us-ascii?Q?ZbK4rZxHJCDHgT5HCN5a8gr3aUSKphJUpJNyjZlUdKTYULx19rWLkHHYSXMS?=
 =?us-ascii?Q?Cz0T1DVE2tOmqOdSQuNYffwb37qhgoh9G7HgyLFrFMufENKNwL7evK8SDitK?=
 =?us-ascii?Q?JhSkxIOyn1jRWwdQpM6DzmZiKt7H5UgSEs8h9qKrKfrh56+AEb/UB1bKbC8X?=
 =?us-ascii?Q?PyNte3euoXKZVZu1UreNqFsIb3wGTI3F3KPfypKX4SskNnosVgDLo3jKhUKR?=
 =?us-ascii?Q?Qd4DUTdwp8QzsN8YO6ScsEI485lT7W0OoeXqJkT+CVRzlUqVwqFb8il/wlEQ?=
 =?us-ascii?Q?Jsh5aJ5VpF1XxW9WE/4FlEljhFoOme3Tzhdt8T7M1v6DVlHy610YqqQ3BObl?=
 =?us-ascii?Q?FzsfjmSixJC/pNCY3j1WqvhYjSjA0jyDS1/aImtdHbtCwW+2Y/dq0Atz5dsU?=
 =?us-ascii?Q?pglpL5tgabVbcUccvmfHenzM/OyU4l1lun7F5a0uZf1WzkKAzoQYeqMuRSow?=
 =?us-ascii?Q?E6KP78YHKTKwmlSLMUbt+ibnJX0aBmdaxvtx+ieM1tamRe45qzm86L0t8z8p?=
 =?us-ascii?Q?lt9j9h9+7mjguIrClS9+wjKCelr2S8MSLAKJIz0Rclq+O5Yog9hMnL/OzP57?=
 =?us-ascii?Q?ZlFL++1y8kmnBFqMlCOr5WAB6BYAJfeJG7HRJD+LVpdJOs3CGsnmHkAbnl0b?=
 =?us-ascii?Q?pDGCXJYksGd/kRIB57TDkLKX2FcW8OOJcLpbQztTeMa9gIB0N1DnDYppd0C4?=
 =?us-ascii?Q?eAMeCFDWWEKdXqVTQw6X54jjDWbmqHGwhRjZ1p3esDFy7cm1oc5NiltnJvl4?=
 =?us-ascii?Q?9rtaeDNyXVb8kHKnOia6BBUfS1SlLZPVcin+HvmWgql0hWWn3l7mcUPqo2W/?=
 =?us-ascii?Q?xGQBXXqhANU7vCx/NcSRp4ZBLwZ4aEhN201zFEgJI9MWJgl6dKsJEk4+TTvo?=
 =?us-ascii?Q?5F8L1//rRsfnHKo0qF8BVOXRb17/c8WD+VRxvEVwJkMkna6oIJ5oxaf4XEjO?=
 =?us-ascii?Q?zkiM7EENnKmHopttoiPy6L4BOUw+aWYbf4MpuPEQJ41pC4ssVH9SWGl/xwyh?=
 =?us-ascii?Q?8obeqBqRxhyqFIarRaL1P+NwSW3bUECjl1rOL4vF5whZ0ZXgtgRKUWncjL3R?=
 =?us-ascii?Q?f98hOAoGXT/CsUGBixpbEejliakNrgz9fK3PLBkp?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11206a24-468a-4e85-b0fb-08db0927e6fd
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2023 16:25:19.9002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3CfYBOoDKDt79OgUx8hK75dOgIS0R57HmOJs107yard7jViUh+3EKj34x9h+PFl95rgTaBknDBTR8aO5sn49+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7626
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The previous 'commit 846651eca073 ("serial: fsl_lpuart: RS485 RTS
polariy is inverse")' only fixed the inverse issue on lpuart 8bit
platforms.

This is a follow-up patch to fix the RS485 polarity inverse
issue on lpuart 32bit platforms.

Fixes: 03895cf41d18 ("tty: serial: fsl_lpuart: Add support for RS-485")
Reported-by: Sherry Sun <sherry.sun@nxp.com>
Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
---
 drivers/tty/serial/fsl_lpuart.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 5e69fb73f570..de606af200a8 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1387,9 +1387,9 @@ static int lpuart32_config_rs485(struct uart_port *port, struct ktermios *termio
 		 * Note: UART is assumed to be active high.
 		 */
 		if (rs485->flags & SER_RS485_RTS_ON_SEND)
-			modem &= ~UARTMODEM_TXRTSPOL;
-		else if (rs485->flags & SER_RS485_RTS_AFTER_SEND)
 			modem |= UARTMODEM_TXRTSPOL;
+		else if (rs485->flags & SER_RS485_RTS_AFTER_SEND)
+			modem &= ~UARTMODEM_TXRTSPOL;
 	}
 
 	lpuart32_write(&sport->port, modem, UARTMODIR);
-- 
2.34.1

