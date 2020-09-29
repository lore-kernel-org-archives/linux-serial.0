Return-Path: <SRS0=bP+p=DG=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF5DC4346E
	for <linux-serial@archiver.kernel.org>; Tue, 29 Sep 2020 09:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BE9F20848
	for <linux-serial@archiver.kernel.org>; Tue, 29 Sep 2020 09:28:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="IcV41K9t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728074AbgI2J27 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 29 Sep 2020 05:28:59 -0400
Received: from mail-db8eur05on2051.outbound.protection.outlook.com ([40.107.20.51]:31489
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727746AbgI2J24 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 29 Sep 2020 05:28:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n825kgmhjwzJ6v2NAvc1onL6eJJN9uGVgK5ZgHK7wUZEy0bMkf5CKOOkHT3PNSdNFWRLwkIXRoeBimbXn0oMScA5+xIY4vcp6gQykL8KQhQfc3C+nxgxJcQhjAIgGSDJApl3gTwQ4KWXPJdKRekS7CTi2zteBhMza3DopF/PFDXqNJp2fT75ZePnCJWC7cKVBeY+9pmUGwXPN3xv2DIOVBC6an5tCevFfYhmjAt1HvtFi6vtd5MnSU9R80mpz06delte4+yDMbE2hKOC5vyQOudemrmnFYtq5+pSt6O/D0UL5eNRLZ/80V4dSDb/9FUxeecip5kvvFtWcbvZ48tsjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kxFf4h6Bda0HiiRWL1zBy3Dnd2jLW4kvNZHM4wsewds=;
 b=Zvyh4aEHTErSko38KGfKyTN2PAaYxuJf0lpuAbc9kFpJ5FNwhuYAwB/n8GeBY/E8ohiGIsu+WoousghbOuKtCHNvhbmt30vmWWZATx6oZfPgNF/0EfqRf+bUr9lUWpINANeasVlDYnOmD6VRsOGGC8hSc4zvjv8BAJKMEXIxiwacjgUp2N4/NtxeAZqKJ0FGlASwiRT6B7ecke+pkJ8fnpC2Gtmdb/JwAsXh4iWnroj4WgXz5odHJokl5pgKOzGv2iVUCu6a2wco6ZSgvFkk6WHKxsmrcJ7QgApZn+7KFwxslJvq5RXMbz4j0d4NKtAFAoPUBlDR+QD9zBxAdn52fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kxFf4h6Bda0HiiRWL1zBy3Dnd2jLW4kvNZHM4wsewds=;
 b=IcV41K9tTkp+ZGL+6hTa2qsBj6urLE0CeGAr/MsD9wrpox4FDXfFXAMFubhR/wseJ+6uLNFV4deFcGmCBQn8qMZWIaGg3/AXVF2c2XuU0IBDCjPHFNzc/CqAjC9wwI5F69h1SPDauQpehodxhxTA1Vjf9bbRX9d/CrEvs5Qcrq0=
Authentication-Results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB6PR0402MB2935.eurprd04.prod.outlook.com (2603:10a6:4:9d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.25; Tue, 29 Sep
 2020 09:28:53 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::35c5:8c71:91f3:6bc6]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::35c5:8c71:91f3:6bc6%12]) with mapi id 15.20.3412.029; Tue, 29 Sep
 2020 09:28:53 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        andrew.smirnov@gmail.com
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, Peng Fan <peng.fan@nxp.com>,
        Fugang Duan <fugang.duan@nxp.com>
Subject: [PATCH] tty: serial: fsl_lpuart: fix lpuart32_poll_get_char
Date:   Tue, 29 Sep 2020 17:55:09 +0800
Message-Id: <20200929095509.21680-1-peng.fan@nxp.com>
X-Mailer: git-send-email 2.28.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0165.apcprd04.prod.outlook.com (2603:1096:4::27)
 To DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by SG2PR04CA0165.apcprd04.prod.outlook.com (2603:1096:4::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.21 via Frontend Transport; Tue, 29 Sep 2020 09:28:50 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [119.31.174.71]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d38cb754-bc4c-457b-36d0-08d8645a146c
X-MS-TrafficTypeDiagnostic: DB6PR0402MB2935:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB6PR0402MB2935EA911B1A20982F6C6AD088320@DB6PR0402MB2935.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4VrN+R6HWq20/H9oLldUlV/Ccj7GZyvH/sivFCS/OrxOgH09mynSttD0gEiETLgcuOYSqVJd4ZGkss5ft4+yBp6hHdTGbeH6kIo3kVyUJcvUWZvgu4p9nl1pZ1Z8jnwPW+FX6VWNQMZWiWe2OPIItVrskNuQnxRTmIZdofEUm36pQGLbmEh/qQs8jFhajVZb1q+tx7JLqEeieBD1A0nzCC/YSzSMeqeDRnSZI1tYtsmAj5RbX0+dMJt9MGIYU70x6LXXtOdEtBVWPbqho1vYW70WUBqJbrBWYL6hgSfbNv3YlOQOfE43xwG29BOu7+17OrvJcSyvi/3Kyx6qkO4tZMFyltO1iKVYwq6WvkhDFNsQYPn/pKXHD2lMTivYKDCJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(376002)(39860400002)(136003)(396003)(6486002)(16526019)(54906003)(6666004)(5660300002)(66556008)(316002)(66476007)(4744005)(8936002)(6506007)(2906002)(186003)(478600001)(86362001)(26005)(44832011)(36756003)(6512007)(52116002)(956004)(2616005)(8676002)(66946007)(1076003)(4326008)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 6bDkTo+9uGRRHrwTbX+lvCltdhlrj4OWcwosoo4W5DGV0k/BICAqI+IQtBeK95OBcCWYrNZkKZ6zp3V5rKsIee0qvnqn0+otSJp+pDvM1iAmjeBImh2lcSYXVsR6irN6gCIb6DtILfuAvMHw8tDP+a+JKOMKMeRvDTUd2MNk6X+bPiCihMwt+cytRLLmlY619GalTpsPguhaMN2Qbg25xyQeffNHz0zoO65ptrsgxHVWsiHiQiqrkqboinjs24tsJVdcSW+gJ87uIT7UnsfJ84vF6hShRpkxXcRNedFmcdWXEgKWfCLSDMTQjLsQIgwXv/Q3/oQUYtiYET/ryskYsFORW1ESHyAXT5ycYvkWmwwXACl92eJYK4v48RX0EaJ+4ToB0gfNk5cbD+g1XUhAS3ykjbZG8FN9xNWvgLftj0Cc/UyJnGSxjsWXzdqRb4DMdxk57CI8on0DGu93T9gYecqDMC1oZMZ5hP/4fjz9mFwbldNFpxXkf0GPW/DjHT56wR9ACoIODYEE9R1pFy/oSH1ZT8+oQX7J3WzgHZhHuzGrrzU4g/kQIexkEDzE55/ae0Prhab3FvS4pmlUG4Nf0UwmDwyVqb/fGDnaWkxFFTe+GGqt+GKK2vgZazIyMbNK8pbNIL8fYO4vKsnjrVXGOw==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d38cb754-bc4c-457b-36d0-08d8645a146c
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2020 09:28:52.9133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3DptnmsAlgISLzSsmqhQHPipoiKyVIHvayymF1u/5RrMqhUQsy7jFBqLXuxSmoBWNBmlD34sKmv7GOSOhFwrew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2935
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The watermark is set to 1, so we need to input two chars to trigger RDRF
using the original logic. With the new logic, we could always get the
char when there is data in FIFO.

Suggested-by: Fugang Duan <fugang.duan@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/tty/serial/fsl_lpuart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 645bbb24b433..1c37280b6c0c 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -680,7 +680,7 @@ static void lpuart32_poll_put_char(struct uart_port *port, unsigned char c)
 
 static int lpuart32_poll_get_char(struct uart_port *port)
 {
-	if (!(lpuart32_read(port, UARTSTAT) & UARTSTAT_RDRF))
+	if (!(lpuart32_read(port, UARTWATER) >>  UARTWATER_RXCNT_OFF))
 		return NO_POLL_CHAR;
 
 	return lpuart32_read(port, UARTDATA);
-- 
2.28.0

