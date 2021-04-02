Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5D33C433ED
	for <linux-serial@archiver.kernel.org>; Fri,  2 Apr 2021 11:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99920610D2
	for <linux-serial@archiver.kernel.org>; Fri,  2 Apr 2021 11:39:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234161AbhDBLjq (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 2 Apr 2021 07:39:46 -0400
Received: from outbound-ip24a.ess.barracuda.com ([209.222.82.206]:46370 "EHLO
        outbound-ip24a.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229932AbhDBLjq (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 2 Apr 2021 07:39:46 -0400
X-Greylist: delayed 2012 seconds by postgrey-1.27 at vger.kernel.org; Fri, 02 Apr 2021 07:39:45 EDT
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101]) by mx-outbound42-236.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Fri, 02 Apr 2021 11:39:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XAhh2FXI3h2z4CRVXCocTwqIzT4szR5Oabq5uaVTQJ6ROE1GXMicG9lYokll3KjAZb7CVC0thP9L8vKSaxL7ynhcCz4arXWZiY8IHslxGoomnJT6qa/MrQZxmukgeOpq6SttoK9Upuh0BFK+AjQmpe7DqWhN7X9SZPT0XIx8Bqy7w2zv4NTERiQ4bagiuCaHY2N2RcVNDTMbUTSwnJJvnVaDG9Fvbrk4xmP5e69oPQsZHdu3+kmrfGAbc1mEc5FEg3NbXH9vLXmZzwFUNBETbSAdzQC2qRj/g3PGPek+56yuGanaapdPgKOURDt0HaNHlYDdsrz5QPFCzN8xedFVUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9BuLSz2LXRH2n3SoW0IbL6g37qbPQMLY+NpeSSOH64E=;
 b=jmha2iLKNzdNyb6TS5NpDbD7ma/sFM0IXjObk1571ajyqW8t7bOUHvFT9wUMNeC4bXaUqJEMjLzG4HyNK/cYFj0FQETasJghgi1ZZL3PgihgC8+3CK3yaSBq6+ZOuWlZMLDIvfKOaP4jZMg4XdGtRKfbmO4Naq6Fhy215W0Kx3/UOXS7GqYL19QQidXx0TY/hS5MoeXD1MyXJ0JpmuuldOmHASzCbB6ljT2P4CmnLbRHA3TX7LbRvCWO5JrMlkOWD8lPaYvlR64ARDdlVpjs6wjcdA0ggeTFWCQc/rEZeY2+WKPDxAtHlluczUOknPPr0WL0tgN7BFIus15ocUTBVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=digi.com; dmarc=pass action=none header.from=digi.com;
 dkim=pass header.d=digi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digi.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9BuLSz2LXRH2n3SoW0IbL6g37qbPQMLY+NpeSSOH64E=;
 b=tojarMsbZrdvsXz2oiEQTh/xjNyphVelmkaxYoOBWjVKdKeD2Rd+qd4VF0y536Q0F6N6vdNzVsDqVYkVKLCXZBdTmP4Dd0yn2IzTZ3GjoPLsv3695J3mGHK7Hq0nOGR0+F961hP7ljb8q6BWk/4SeHVN2HVLZjej9KNWJKolnEo=
Authentication-Results: digi.com; dkim=none (message not signed)
 header.d=none;digi.com; dmarc=none action=none header.from=digi.com;
Received: from CO1PR10MB4561.namprd10.prod.outlook.com (2603:10b6:303:9d::15)
 by CO6PR10MB5476.namprd10.prod.outlook.com (2603:10b6:5:35b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Fri, 2 Apr
 2021 11:06:06 +0000
Received: from CO1PR10MB4561.namprd10.prod.outlook.com
 ([fe80::75d6:e217:6181:f5a5]) by CO1PR10MB4561.namprd10.prod.outlook.com
 ([fe80::75d6:e217:6181:f5a5%5]) with mapi id 15.20.3977.036; Fri, 2 Apr 2021
 11:06:06 +0000
From:   Robert Hodaszi <robert.hodaszi@digi.com>
Subject: [PATCH] serial: imx: fix TX stop function not setting state to OFF in
 RS232-mode
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-serial@vger.kernel.org,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        "Hodaszi, Robert" <Robert.Hodaszi@digi.com>
Message-ID: <ac5aa181-eca3-040a-302a-4992022d39f1@digi.com>
Date:   Fri, 2 Apr 2021 13:05:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: hu
X-Originating-IP: [81.182.229.244]
X-ClientProxiedBy: VI1PR07CA0190.eurprd07.prod.outlook.com
 (2603:10a6:802:3f::14) To CO1PR10MB4561.namprd10.prod.outlook.com
 (2603:10b6:303:9d::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.157] (81.182.229.244) by VI1PR07CA0190.eurprd07.prod.outlook.com (2603:10a6:802:3f::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.8 via Frontend Transport; Fri, 2 Apr 2021 11:06:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c6743bdd-4fd0-49c6-6770-08d8f5c74fa6
X-MS-TrafficTypeDiagnostic: CO6PR10MB5476:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR10MB54765C199BB4691131E2A7C9E67A9@CO6PR10MB5476.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: se8k7SdoN8MDv2g1Mu30j1ybT3n+EMJBouJTBUtSXgJJgPDYOcy3+f3dtr4mx1IKANN1xARdlOylKibNaiKqJbESOIHF76uPxO1HQF/GNKMG85JvVYgjRbyr+SYvgNMA08AaHsSqlBb6JbDR3vZ6bz3CX0Hbfg2JHfDBtbsZ853MSUdeIhJaFcQpJxyFNbXpmEjASBNe6S9FOxR4pHwRr53O6uKUoVi2QsSzXhk6g+Cu/TvLyQhCbjbSNNJNVO+ZJ5b58aRlgH4A7TueufCMl3ADFEwOCCek9AsrAhg7M0aI9MstT8ZOcby+J2dZckwfJgnlep3xyTrh6ofQmeRcdvVfeI9sWuChHFt7bQ1yJVeUC6mC0sg7p72TzpzTNjvZmXN21tSWARqyNUlhOdJt976uAH3nhGjT+jdlno0RQ9r8zB/nmyVqD+Wh29Yuz/jYE4dBdxFbQVpxvEUacbkTuD21zgLE+6uZ2hSIftaIRvCo2VNuIzTwQoQzxEtUED3Iwf7BOyDe6+Ov9lU2TNBCJoJACkK6bH/ok2O2x490hjvxNPdvj66dENusY1Cy9LgEpWJUJ6JdJFwV0usG+/AvIgzHibod0x5MfqrrOJ/swXQxavAg8L9D4AKgZZGh/TTcHgX04vYYzMcxbwFOs6OqpsSCHEEapW9x6ZmVb6lriMP9yNjch4KbhHJyEPjfPGXfGSw/UNjA83CHPet8YAgASQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4561.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(366004)(346002)(376002)(396003)(136003)(316002)(83380400001)(54906003)(16576012)(4326008)(66946007)(36756003)(66556008)(66476007)(478600001)(31686004)(5660300002)(8676002)(31696002)(6486002)(26005)(16526019)(186003)(2906002)(6666004)(8936002)(107886003)(44832011)(956004)(6916009)(86362001)(2616005)(38100700001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?iso-8859-2?Q?D6N19bVm8a1snH24NQ1vugRhBN2h8HRk2uxSo6K0FUTYDPBxmkYLxPbWVY?=
 =?iso-8859-2?Q?ePN7zXQ4lxGLuyk1uGZEVXpPyMEFD7xtdbP+R0zTgIfhwuR1AzdHOsEPe7?=
 =?iso-8859-2?Q?dP8enchwon0aVW0t0h8L6zDTFJ7tsO98s9WJP7WevYaruNv2r5158EPFeI?=
 =?iso-8859-2?Q?f+TvJoSi1eN+l/wzI7IBFFZwt1HsXzBXiCV4lyDX3wbE/vpr+XW2FpdNQw?=
 =?iso-8859-2?Q?Vl5SD3PahH8cLunsHxhrrFnvL67qwbnUb+6Sd/4MD6H6xsrZq/QHnplG2l?=
 =?iso-8859-2?Q?raK9A/azsHa6xcoOXOC250ZbY9mmjX+7pZmCNOa+i71svidGYvXV6tnodg?=
 =?iso-8859-2?Q?6MG7XbEY6wnk27Obh1hK396OCHwxHqylCRA8AJmQu6tEqVhTMqr2+/CXIz?=
 =?iso-8859-2?Q?9AG6C933BwqZlmH0VwTYJZQT4yhxyHwSAAH53gKtP/35L9FN8jRBohb++F?=
 =?iso-8859-2?Q?rk/9xF38FDfb54K9YFsCO9Kk7msG9R74K1ELFmOC9dPHqDVLwBr04L0mNa?=
 =?iso-8859-2?Q?ZeOJ7YPS5UBZHKum5Snb0B2NpqidFLANvLhivetdFyWqCinlCnXxcB5Ta6?=
 =?iso-8859-2?Q?VCpfArSKmb0fqk3LyWpgzIIhdqiwNaxMtCWlFP9q1xmilY0d/EKNPuAITn?=
 =?iso-8859-2?Q?j5nDQXDxxdR4eBXzMtJzYU5Qx2LySOdrm6yH8/WijjaDapNdLCndV3N+jB?=
 =?iso-8859-2?Q?bIYmXIPHff+KxDfEpbuSdCtKisX7LH+BoIlt+7DJmiY0oz1oCHSiQMGb/S?=
 =?iso-8859-2?Q?iG4FUYqfPZyPKcQhNpDlweSeqIT4RsSsOZriDLLlCN+HPOg1JO1LzfZK/E?=
 =?iso-8859-2?Q?hAkKvw9r7LLXt3mT2pmyxeoRpoV5An42cdHn6ocynHU192QDwzY5KAdD/k?=
 =?iso-8859-2?Q?vke1bRsMoxuRlVNTrvGbTXbIebwTVTlTP41QIY9YS5F4ZkA1VTc+6dRkFR?=
 =?iso-8859-2?Q?Mb3XeQiZ+HAQCmYB6KJPDGms8xj7c39D4qSZFui75JoDlfHTSo75q7Kmwp?=
 =?iso-8859-2?Q?3CuobOiPdQKK8d7mkf9kbF67RXhHXOYJtZqV2M5E3yBE+0R0afrX9tszYh?=
 =?iso-8859-2?Q?zkNHAFz7anrR89JbtY4HBHJXsIIWm1FendownncqbU095VYsKJkmQktffx?=
 =?iso-8859-2?Q?nXnr4PWhF/ne2QmxQf5aj9bCYDyxo6nU4dlddjdBY4Z0OLUCRdaN/00Ovm?=
 =?iso-8859-2?Q?NE21F5SuoJDAbaKoVKqbpa6u/QikVC+otVzz3ovVMIK0mTYPkbFdVcRTjx?=
 =?iso-8859-2?Q?7RvlaTFieOlNpw86fUaBEeCUC/OTI8PdfhrcCVfoRH+lITKMVHXs6DAPdn?=
 =?iso-8859-2?Q?MgFFW8KdvU9iLq0CImRc0OpKosGVBnKDP3KaGCQi7WxNp0yxwS8Ul44eA8?=
 =?iso-8859-2?Q?NNXbhBQMRd?=
X-OriginatorOrg: digi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6743bdd-4fd0-49c6-6770-08d8f5c74fa6
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4561.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2021 11:06:05.9036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: abb4cdb7-1b7e-483e-a143-7ebfd1184b9e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RVsk/eiX3ZlVfZrxVO5onpve2fnZPNCAnX1wN/6DRluQarddOMKpqLhR+kseCA5AWHNlF8ddxALpTVFj3AWmiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5476
X-BESS-ID: 1617363583-110988-5494-4105-1
X-BESS-VER: 2019.1_20210330.2011
X-BESS-Apparent-Source-IP: 104.47.55.101
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.231269 [from 
        cloudscan13-203.us-east-2a.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
        0.00 MSGID_FROM_MTA_HEADER  META: Message-Id was added by a relay 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS112744 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND, MSGID_FROM_MTA_HEADER
X-BESS-BRTS-Status: 1
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Robert Hodaszi <robert.hodaszi@digi.com>

If the mode had been changed to RS-485 after at least one character had
been sent in RS-232 mode, the RS-485 transmission was not working.

Commit cb1a609236096c278ecbfb7be678a693a70283f1 ("serial: imx: implement
rts delaying for rs485") added a TX state variable to keep track, when
it needs to enable / disable the RS-485 transmitter.

In RS-232 mode, the start TX function just sets the state to SEND, and
the stop function supposed to set it to OFF.

In RS-485 mode, the start TX function expects the state to be either
OFF, WAIT_AFTER_SEND, or WAIT_AFTER RTS. It cannot do anything if the
state is set to SEND, expects a stop first.

But stop TX function in RS-232 mode usually didn't set the state to OFF,
as it first checked if the shifter is empty, and if not, it just
returned, waiting for a TransmitComplete interrupt, which is only
enabled in RS-485 mode. So the stop function was never called again.

That check, and the subsequent code part is not needed for RS-232, it
just have to set the TX state to OFF.

Signed-off-by: Robert Hodaszi <robert.hodaszi@digi.com>
---
  drivers/tty/serial/imx.c | 46 +++++++++++++++++++++-------------------
  1 file changed, 24 insertions(+), 22 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 8257597d034d..511badce3edd 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -443,6 +443,12 @@ static void imx_uart_stop_tx(struct uart_port *port)
      ucr1 = imx_uart_readl(sport, UCR1);
      imx_uart_writel(sport, ucr1 & ~UCR1_TRDYEN, UCR1);

+    if (!(port->rs485.flags & SER_RS485_ENABLED)) {
+        /* Set the TX state in non-RS485 mode, nothing else to do */
+        sport->tx_state = OFF;
+        return;
+    }
+
      usr2 = imx_uart_readl(sport, USR2);
      if (!(usr2 & USR2_TXDC)) {
          /* The shifter is still busy, so retry once TC triggers */
@@ -453,33 +459,29 @@ static void imx_uart_stop_tx(struct uart_port *port)
      ucr4 &= ~UCR4_TCEN;
      imx_uart_writel(sport, ucr4, UCR4);

-    /* in rs485 mode disable transmitter */
-    if (port->rs485.flags & SER_RS485_ENABLED) {
-        if (sport->tx_state == SEND) {
-            sport->tx_state = WAIT_AFTER_SEND;
-            start_hrtimer_ms(&sport->trigger_stop_tx,
-                     port->rs485.delay_rts_after_send);
-            return;
-        }
+    if (sport->tx_state == SEND) {
+        sport->tx_state = WAIT_AFTER_SEND;
+        start_hrtimer_ms(&sport->trigger_stop_tx,
+                    port->rs485.delay_rts_after_send);
+        return;
+    }

-        if (sport->tx_state == WAIT_AFTER_RTS ||
-            sport->tx_state == WAIT_AFTER_SEND) {
-            u32 ucr2;
+    if (sport->tx_state == WAIT_AFTER_RTS ||
+        sport->tx_state == WAIT_AFTER_SEND) {
+        /* in rs485 mode disable transmitter */
+        u32 ucr2;

- hrtimer_try_to_cancel(&sport->trigger_start_tx);
+        hrtimer_try_to_cancel(&sport->trigger_start_tx);

-            ucr2 = imx_uart_readl(sport, UCR2);
-            if (port->rs485.flags & SER_RS485_RTS_AFTER_SEND)
-                imx_uart_rts_active(sport, &ucr2);
-            else
-                imx_uart_rts_inactive(sport, &ucr2);
-            imx_uart_writel(sport, ucr2, UCR2);
+        ucr2 = imx_uart_readl(sport, UCR2);
+        if (port->rs485.flags & SER_RS485_RTS_AFTER_SEND)
+            imx_uart_rts_active(sport, &ucr2);
+        else
+            imx_uart_rts_inactive(sport, &ucr2);
+        imx_uart_writel(sport, ucr2, UCR2);

-            imx_uart_start_rx(port);
+        imx_uart_start_rx(port);

-            sport->tx_state = OFF;
-        }
-    } else {
          sport->tx_state = OFF;
      }
  }
-- 
2.27.0


