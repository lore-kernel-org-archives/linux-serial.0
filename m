Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE98AC43460
	for <linux-serial@archiver.kernel.org>; Mon, 26 Apr 2021 07:53:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB06E61164
	for <linux-serial@archiver.kernel.org>; Mon, 26 Apr 2021 07:53:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233708AbhDZHxl (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 26 Apr 2021 03:53:41 -0400
Received: from mail-eopbgr60042.outbound.protection.outlook.com ([40.107.6.42]:6018
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233533AbhDZHwV (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 26 Apr 2021 03:52:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J99gWnU827ikAzSwn/txfZ3gOjDCkjal193A5DqU9QJCJDSs5cbXUf0ZZ4TwKw7CWYZdolMXsAsTIjo7nQT10nI7jp+DuDICSAzR4RW1axSjV+WTGWmzzODCwnZuSaOJicoAUObxU8OkvACvumHzx/Jz/hiQi5E6aTkSFhjzPcMGyJuJByD3dFpQO1k+roKI5HnJFrhrgM4iYk+VVdh9IyidxXP4GIuTZ0hNNJCSf8K0cP4vc7e0Ru9W1B12oxr4l1KMfkLdqlReMpAVhF668t2MHosoCve88QkPBStEWCUfYD/SB/VZeU0VGxFOO3n+CtV3iMNNlIQ4kt9dJ4QuBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JJSaOvQJ0hX0MInm7juAMSK5c+PhzMpwzlNQz2oS9vo=;
 b=Dh6H0/Tezn47UgjiveLsrTwKpVh7n2JsXX0x0gzH08ug15wCYgtl7utcYHBIdQ2/HubE6VQV1WRtQOVmb5lGBEDs5+t+U1BUefB4UV6LQGQuaLAjsrZlIQndUIOMkxUFJw5gWepFlokpBFY+49JMy+6W/Tr4ku8ry0wvI94O+d/qAKKBydPIBifb0w0DDXQePeBl6ZUvfqa6o0iYqkVqtcdXs7HDjnrrNZ1DZequsxrNDw+/PLhZIV0pnO07HwVRGqENVnJhjcyEyy6agkrPwiRBPOGc36mkbTTE3Gw6V0yI7Vns74umeEEvNE4N55oGKCTwv+XLegNqacnyv6S54g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JJSaOvQJ0hX0MInm7juAMSK5c+PhzMpwzlNQz2oS9vo=;
 b=GyDI40e2gQRi8IKjIFMZzvi6DB3P99zbFGDcwCfdoCasHmbHO0CHVQYARRYESVts52p+ESaI9IZIcLKkVAk52uITuUgSCyRAUqcr+imeoLNsknksLdLYqwOb4AnudBTa9UgSj94E4I+egCjtKOmj2ijwlWq7gmaX3f/YuqO3+HY=
Authentication-Results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=nxp.com;
Received: from AM0PR04MB4947.eurprd04.prod.outlook.com (2603:10a6:208:c8::16)
 by AM8PR04MB7762.eurprd04.prod.outlook.com (2603:10a6:20b:241::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Mon, 26 Apr
 2021 07:51:05 +0000
Received: from AM0PR04MB4947.eurprd04.prod.outlook.com
 ([fe80::c9b0:c412:80f0:4645]) by AM0PR04MB4947.eurprd04.prod.outlook.com
 ([fe80::c9b0:c412:80f0:4645%6]) with mapi id 15.20.4065.027; Mon, 26 Apr 2021
 07:51:05 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH 1/2] tty: serial: fsl_lpuart: fix the potential bug of division or modulo by zero
Date:   Mon, 26 Apr 2021 15:49:34 +0800
Message-Id: <20210426074935.11131-2-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210426074935.11131-1-sherry.sun@nxp.com>
References: <20210426074935.11131-1-sherry.sun@nxp.com>
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: HKAPR03CA0011.apcprd03.prod.outlook.com
 (2603:1096:203:c8::16) To AM0PR04MB4947.eurprd04.prod.outlook.com
 (2603:10a6:208:c8::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.71) by HKAPR03CA0011.apcprd03.prod.outlook.com (2603:1096:203:c8::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.19 via Frontend Transport; Mon, 26 Apr 2021 07:51:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8186e6d4-9fdd-4a04-70db-08d908880b36
X-MS-TrafficTypeDiagnostic: AM8PR04MB7762:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM8PR04MB7762D6AA1E6CF94DF1ECE7B292429@AM8PR04MB7762.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1060;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: elBSlMqwpcXqd/x0/K5rFEHMnntT/t1KaCdubFbFqWA2b7z2cM4p3Fwfd5G5V0Olce1z0QPA/EAOmJejoW+QEI/iQJS2OiSxhfZ85QIEfqC7+gVbr6d9s/EZX9C+thJChzSN8tptVfa7LWMPGHVz0GwzK7v+8DnxigRDbEgKs92axwcWyPWZdFSQBKIt2RXAWk9KJnwp0PkxIsrfDj//hGup4yL57xPNT8ZJ2GvPn+GhIIcQvN8zlsSHY976gY57L0uejhnuZcxJzVnf0O+dcyWHo98Zc+ctrznSyYNFp/PJWkNqifuQAqtAtQrt99K2n6Wg254JatXFCb6Z+4L3pmG6gp0B23Ya9bQQhfvPi8ztdJUnTghxH8FgKEotAubWPgiW7tNauvUkTQsheI1CIhXHh30BCbeIQ6jnoVDV4L6A/jPMneJhYHI8LCNwuBZbiyZIPDYWBawZ208HZGCq08hWJp9bmkLocoJHIvea6X+cDInLEQhcxk/bNg+Bl14ALi95PZipe29NDyWotQTWHSD6WVGZlQy9ZEqTCFc04GJJMCWU5qKtX9YTZlbUuDCRDXxjja/p0Gebje2jhCYa+bbizeb7/hULdJYsXFeL8uEIj/RW4WV2ipElJnrmRlLg3QzcR20KPJ1gpQA4HsGShld1ZyjAgAtbN/CwJQf/lT8ypw81D71dTrpR2VJfcus2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB4947.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(346002)(136003)(39860400002)(366004)(8676002)(316002)(2906002)(66476007)(4744005)(4326008)(26005)(186003)(1076003)(16526019)(38100700002)(38350700002)(36756003)(6512007)(44832011)(52116002)(6666004)(86362001)(2616005)(6506007)(478600001)(5660300002)(956004)(6486002)(8936002)(66946007)(66556008)(69590400013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?WJL3X7VbyIdb/G+QtsEelXLOXv4XVDC9KQZQiyfdiSZrwdjxqf4G2eT9a1zY?=
 =?us-ascii?Q?T1R+dk1o68g9bb0ihijWn7hN93iU/NrlwC3CJAT1I/Ldh3CBB/v7eQ14DTyf?=
 =?us-ascii?Q?WXXpJBI+4JMzpQR/gD2YlH+dyaWYE4p6rf9Sj25LZ+DdYQB8CdLcWs/a+/lG?=
 =?us-ascii?Q?maOZVjyKcaw9bD7s3FvOV20oaszovKhaGf8+XuwxYunMSi7nQu3BxGdmFsgL?=
 =?us-ascii?Q?sgZqz0NzUEIulyl3XEOIK4m/s3likm4tcxOA+O0PSJ53LJ/mDQoJcvAomAHJ?=
 =?us-ascii?Q?S2X4fQIqbRawUZptzwlIZccH8gzzSdMgyl1wW6VKv8f+aJgHc5TFokNwSSBh?=
 =?us-ascii?Q?/WPR341fJ2+Sj4GwUI2zYJj1GEZ2u/PwNcnJBNVLHsQbiOhiNnJ8xC9exULP?=
 =?us-ascii?Q?XzUz/wkOXKWvZuqWxrEZJ+7Zppfw7RF6QqKDc38BoKJ7G1Ddxv6gVB1q6nAP?=
 =?us-ascii?Q?+JzzeFg4JZtISti3GcAMEehBfHilkfGDeWGq46/Teq8chWQ1sdp22bkTj8zt?=
 =?us-ascii?Q?HMyAWiNmJvjztHsWZ4Bu1ufmaxV3N1qQOGq1Z6uwYzm2wZsOi1JQH1xZR+AF?=
 =?us-ascii?Q?OSOUjwOhLORvKeiceajwvZI7RBz3tTEwPZZfwDVcFlpK/tK2XxdgyvQKRMPh?=
 =?us-ascii?Q?V6f8xKYLMFJ+hYzVIsR6v3Ydtfajzm29p4STOh9N5ut5o5NyWUTSqbM6ssLv?=
 =?us-ascii?Q?k425JOdY9bk9q3yuyhD+GbF/WOUgzoLHW95s0QCxmKuyJTZHBKYXpwmSZJeg?=
 =?us-ascii?Q?LxBFrQlbN+2UG4E5Z/NmmFDSNaP48nXWVM/2GSYHf1cYMRAjKm3RhG2SkhaZ?=
 =?us-ascii?Q?1jSzdPF3P1y6+b8rNPUHtUqQpvgSgDoMD7tax8V33V9KxOmN7hAm+dBZWDve?=
 =?us-ascii?Q?YWThostxfG0U8zctmjU+aXusWY/vD6O/91rCxE7oOmEvYA35bJypbQ85gtUm?=
 =?us-ascii?Q?UqO0v92sM9hs8MZit9sjwDT2t9zLCU4eXRc1mbq8QTZmUf5eH9JoxnH0eJ3b?=
 =?us-ascii?Q?Gyly5tvNXE0Ob0TXl1jN4ZL/vbvhO5H/Xqmj0HNTQIFv2W2CJ3fFpsSWfTO/?=
 =?us-ascii?Q?fMYmW2I+N5pEwPcAXt58Yhb39NqRoPEq4CVJRqRU/tz8ov0ngeaah4AkPZ2a?=
 =?us-ascii?Q?s0+ySvbtQw2KQgrZQX7IvlTfVJGZ6dmQRpriNo3Zp3RoPUnWEt/6p7EEAljk?=
 =?us-ascii?Q?ahIYhKngoThBAkq+NSWEmuQMrIPnzW+ET3ifUSGrPTquB4VcioRmf4ttDLf7?=
 =?us-ascii?Q?+KLxE76jFVk9VJ8Ozo34Z93/aeXR0CuFFFuIVIibgFhJ1Dtl5oDhJye0fOH4?=
 =?us-ascii?Q?vnoSTarls0i+EMszfSFQLZI6?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8186e6d4-9fdd-4a04-70db-08d908880b36
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4947.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2021 07:51:04.9715
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YQTfJl1lrD4GyGnuVT4HWxHkc6FQyQeBHlmPCUvVMlLN7IlheC1CntzoRyx/k+mPF3K40NU2ta3ooVx+3gXJWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7762
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This issue is reported by Coverity Check.
In lpuart32_console_get_options, division or modulo by zero may results
in undefined behavior.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/tty/serial/fsl_lpuart.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 794035041744..777d54b593f8 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -2414,6 +2414,9 @@ lpuart32_console_get_options(struct lpuart_port *sport, int *baud,
 
 	bd = lpuart32_read(&sport->port, UARTBAUD);
 	bd &= UARTBAUD_SBR_MASK;
+	if (!bd)
+		return;
+
 	sbr = bd;
 	uartclk = lpuart_get_baud_clk_rate(sport);
 	/*
-- 
2.17.1

