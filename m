Return-Path: <SRS0=BL42=AG=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC3A3C433DF
	for <linux-serial@archiver.kernel.org>; Thu, 25 Jun 2020 09:54:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6FF1206C3
	for <linux-serial@archiver.kernel.org>; Thu, 25 Jun 2020 09:54:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Up7MeRaH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389695AbgFYJyn (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 25 Jun 2020 05:54:43 -0400
Received: from mail-eopbgr150052.outbound.protection.outlook.com ([40.107.15.52]:63094
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388485AbgFYJym (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 25 Jun 2020 05:54:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JPAsUw1TbzAfSIB8fJDvVcRlgJSWAogQpFayKlaSbRaN8irxMhEz6glshZ6s6vPBYKoZ8uB1Zm9OLUMykPAhTTMFz4PUBcRu4OWZChonnYoGXJorFBXLQR43KzNlM+GGr9pLCQAe7JwCspx1XUv0CA9kQkVdaBYj+0FvXWhUHjFIwaeLC9HGTidadSPidzBmybclptkukrNTzWLkGjYcFgbIflrlBIOkpvMNzEAemUpI1weW+bnJ+e8Pz/0+gnyuLZFQY+1GD0RMSicSF0J90Hel6UvPp6ZDMnZoxfeh7ZJFETmAHqSqU5swDS4KG/GWl5X64YLineRIx4HT7pK+Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hhNNNWI2J9biOoYBJt8Fzi+R3bBGpNKRJxRCqM2DaYY=;
 b=kRF1oM7Np9DtzzsxRe3E+ky+uyKPYTtOHn/Lxf6OX46W/WJqjCdNwck081Wehpp082QdzA8WIyzmBwx6zUABcIsqD5OTsl8MZLxP3vUHodOYE/p0ZKKPpM0AOjvTb1smUYffA/jVFm1pg8Z5+HrOromRQ18WqEifXvBfHk6C2vG5N2kX35rg+1ZdC/f0BWdmuHfVbkc4N9Rwyu7evj+67qRWvNFY8ryJ7TA3AmRycKa5FbTbfCk9efzGkqV7V0tZ1NJwzJvVsDDd0e05DNTSyPL/WTNnwIC8pb9SIMrVTblU6Erd8KB8/SZKItfYxUDbeQWO8HkgCZ5xcBfnV81Ewg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hhNNNWI2J9biOoYBJt8Fzi+R3bBGpNKRJxRCqM2DaYY=;
 b=Up7MeRaHK+rrcOsA0DFvyK2e2qFHVbntZVtX/OVmDPBqYEEUbKLUBbZjIZI+XTeUOiAYB6LP7rits3DJ8B9ae6hUphN/FipgFrhWEqJM2gHSCIM91k2DNJYOZY2u8f4Sfg53q7RUToSeiffDqro62QyD5rZh72Um33+H4RNuXVU=
Authentication-Results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=oss.nxp.com;
Received: from VI1PR04MB4800.eurprd04.prod.outlook.com (2603:10a6:803:5a::12)
 by VI1PR0402MB3566.eurprd04.prod.outlook.com (2603:10a6:803:9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20; Thu, 25 Jun
 2020 09:54:38 +0000
Received: from VI1PR04MB4800.eurprd04.prod.outlook.com
 ([fe80::1c58:aed8:bd10:6c9e]) by VI1PR04MB4800.eurprd04.prod.outlook.com
 ([fe80::1c58:aed8:bd10:6c9e%3]) with mapi id 15.20.3131.021; Thu, 25 Jun 2020
 09:54:38 +0000
From:   Vabhav Sharma <vabhav.sharma@oss.nxp.com>
To:     gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     v.sethi@nxp.com, Vabhav Sharma <vabhav.sharma@nxp.com>
Subject: [PATCH] tty: serial: fsl_lpuart: minimum baud rate support
Date:   Thu, 25 Jun 2020 15:19:05 +0530
Message-Id: <1593078545-11272-1-git-send-email-vabhav.sharma@oss.nxp.com>
X-Mailer: git-send-email 1.9.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR0302CA0004.apcprd03.prod.outlook.com
 (2603:1096:3:2::14) To VI1PR04MB4800.eurprd04.prod.outlook.com
 (2603:10a6:803:5a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from uefi-OptiPlex-790.ap.freescale.net (92.120.0.71) by SG2PR0302CA0004.apcprd03.prod.outlook.com (2603:1096:3:2::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3153.11 via Frontend Transport; Thu, 25 Jun 2020 09:54:35 +0000
X-Mailer: git-send-email 1.9.1
X-Originating-IP: [92.120.0.71]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1597d89b-073b-4e7e-4bec-08d818edc5c9
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3566:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0402MB356641988856AC0F8C1C3C6CB2920@VI1PR0402MB3566.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0445A82F82
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mr8DQTUE3ST6zLlK4yluq94zsastSEYg7kEr0Wj8VmYSMI7c4OEDj5a+UkBkVYIGWRE5ZeNNJhgUE1IoQmFRANsW2cQDjkNYvQn2Xn+n6t3KICe+k9o+m0ijd1mpfOPTTUgD4qEBZCjS4KepCeHPqAKs098gyXS+n88a6/QVNN+gAtWOo9G35zK3QOrZ5vVYSAXc/L+vCIOn6kZzvEmQo2T+mtmQwPN2DjN8ZIVXZ9D7TNIbDKbCOUvKO7jHgJpJuuf1PQJbSJOLIDrDQBISvkAACa7sj7yUBUHaqo4QgBMeczNdye+3o69CydA84EIy
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4800.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(376002)(366004)(39860400002)(396003)(136003)(66476007)(66946007)(66556008)(52116002)(4326008)(83380400001)(2616005)(2906002)(956004)(6506007)(316002)(478600001)(8676002)(6512007)(4744005)(6486002)(5660300002)(8936002)(16526019)(186003)(86362001)(26005)(44832011)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: hd6SIeCl7pb/dxKE7nHW6K9pz/nJPjz7rk/L0++fcZirN9ID6sfkDQzay6Ds/9JPAjTkcENab9wF4FiAhhUlm1Cq52zhKE/DcE+hy312qhbiSAv+eENP+vDUASHRmaokduKIBTqkf8roiR/f8Gltbmkrx71P6yY6aVGo4XssmSGd/rQHce1+GX3wwvPSY6E+ky30MNmeWfFZ3NUvPNCO2t+bA0t7pnhFh3GOX51hAA5B7BCHSo60ZufkOUeF6/VYEk6MrGuJgY6L40GBY+AwuRrsMy27syxCCzde0Y2HQ7y27d+0dmxelwU5/OSHRRLDPOMQqJ9UCmiFgMp5SA18S1PHwUTnZM/PqlPUl8kK7sDZsoYTA353Nv+3gHj66qxIA4nr8qJcDkQRw6okAhRDAGrFMarW3XIwr4wMKlmNPhoBVsdRn/3f+Yrx7FG3qtcFGDUo2ZeKtFNNg2Mwy8E0RZX5ojxymFUIJu97de+GYlo=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1597d89b-073b-4e7e-4bec-08d818edc5c9
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4800.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2020 09:54:38.1392
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rw4Ocic91eQqOIglbKdKinHkSpnURfaJ1mUXjbskRjQdiHaP1CZIemZOGHEvoXAw82pZ6Q7uNT6cegwCRGgzbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3566
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Vabhav Sharma <vabhav.sharma@nxp.com>

The formula for the baud rate is
baud rate = "baud clock / ((OSR+1) × SBR)

Algorithm used in function lpuart32_serial_setbrg() only changes
the SBR. Even with maxmum value put in, OSR stays at 0x7 and the
lowest baud rate would be ~ 2600 bps

Update the algorithm to allow driver operation at 1200,2400 or
600 bps

Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
---
 drivers/tty/serial/fsl_lpuart.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 90298c4..0fd0fa5f 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1925,6 +1925,10 @@ static void __lpuart32_serial_setbrg(struct uart_port *port,
 			tmp_sbr++;
 		}
 
+		if (tmp_sbr > UARTBAUD_SBR_MASK) {
+			continue;
+		}
+
 		if (tmp_diff <= baud_diff) {
 			baud_diff = tmp_diff;
 			osr = tmp_osr;
-- 
2.7.4

