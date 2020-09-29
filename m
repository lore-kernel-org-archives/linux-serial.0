Return-Path: <SRS0=bP+p=DG=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21FF3C4346E
	for <linux-serial@archiver.kernel.org>; Tue, 29 Sep 2020 08:53:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6CCA20848
	for <linux-serial@archiver.kernel.org>; Tue, 29 Sep 2020 08:53:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="MRbswDMU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725774AbgI2IxH (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 29 Sep 2020 04:53:07 -0400
Received: from mail-db8eur05on2071.outbound.protection.outlook.com ([40.107.20.71]:14528
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725372AbgI2IxH (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 29 Sep 2020 04:53:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J3jpRFV3oFRWQRvkemyRUIJ3EV0jYPTZyfiWsaXIyxoB+odtTKfsmBGAQyZYj6laiq7FEw2wV3/4vnt9/UZtxyRtuN411u0qLHONmSLsCdFz1vw+aNBNpnex8R8J1LPMkPDk+h3DxY/mlIUihoclURykGvrB2h31HUi6OsS+wzVXiixz5o34oxLlZkbUMhhtiyjUR+M8lFPeimUfqrF/34HIQjVBapH+62mYOm4TowLmp0fUFCsbamBtAGUFISMbzhHMeJzilOLkET/3QkwrLMyhw0yr1DZX+vb94hoaTSLiP2CBAbRqRdZL4mgVoS0sEGoi17J/ZGdqTK1nXdv9tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cTlxzLI5XFZs7G0Jtb6Tr/BgEu3gcAGqC4Ejj38NE8U=;
 b=bPJWpuNCftCIqXHnr7HB3fX61uTfrqweTxUHqBaVMfqj/w2ad9qc/8ZDB3xS2TjEPzTB/RZA2kgcst76zDGxHh7X9GJT8jjookreC7VXdUarpICxs+uB8BDtvkg25SkixlfPqVbMzoxktBCaToDjwELJYrcEIdK5CMhkmR0Ap6yoIMva66v2y/gBeQBUwzsG4dKctnY4MavpMuYzIz29egh9S3jVRbZbnbjgx6TVa4hSQ78TuUrpAiryynzA1F/DEQKOrK3wbDqKa8fSqAV76jhmVkap5pJUZthDRzkFlzMaPezEb+JJNlqljadoEmLd34cuF01hG2guRd1mXkAveg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cTlxzLI5XFZs7G0Jtb6Tr/BgEu3gcAGqC4Ejj38NE8U=;
 b=MRbswDMUc4Qf1Lw60UabqwmT79T2UbKtW37xhUGnW/dZqkS4VmpPGXmz2vu2het8kGSCa72nu7EUus2kro62IjXbnEmdpeBMsoaSKT6vrSn5bB6kobMpJcHA67rf6vvaoyrHlTNhoziCp3//gMkL7DUJHBd1aXoRBvzLnGcaejE=
Authentication-Results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB7PR04MB4091.eurprd04.prod.outlook.com (2603:10a6:5:1e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32; Tue, 29 Sep
 2020 08:53:02 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::35c5:8c71:91f3:6bc6]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::35c5:8c71:91f3:6bc6%12]) with mapi id 15.20.3412.029; Tue, 29 Sep
 2020 08:53:02 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        andrew.smirnov@gmail.com
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2] tty: serial: lpuart: fix lpuart32_write usage
Date:   Tue, 29 Sep 2020 17:19:20 +0800
Message-Id: <20200929091920.22612-1-peng.fan@nxp.com>
X-Mailer: git-send-email 2.28.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0177.apcprd06.prod.outlook.com
 (2603:1096:1:1e::31) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by SG2PR06CA0177.apcprd06.prod.outlook.com (2603:1096:1:1e::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.21 via Frontend Transport; Tue, 29 Sep 2020 08:52:59 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [119.31.174.71]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0f0a42d2-76ff-4dec-2df1-08d864551277
X-MS-TrafficTypeDiagnostic: DB7PR04MB4091:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB4091352AEC059E3D9771E7BA88320@DB7PR04MB4091.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:462;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DC6VHcoV0r3G6+PNjcm9fTWyp1yn5+Aul2cKNAjORDltjgHQ2OKXNWPz172SeAbvssUVoC6pIdfg6T0YgAAQxKP7MGhUQZh0iA3FpPmWcs/5ysFiQeFbrrIcuEIIBkR1Xm+7UaSbfhycHuZuuIldFTcodLlygjXgtJI5oFQM2fm12u8cKmOfQdyG5VASNecxJPVwukE7cIQIEUph1FXYnTulZvvBw/PR+TTblcIbuEv89d3RSgAC4Th7RPPipK04KfJQQjXWlRE8tAZ7X1rlmERU0NjZHC+9g3gJceu0zt0jBmAPj8aySverXL/TuhmE8HVcWF4CPUWqcHPEK/GIfA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(376002)(136003)(366004)(39860400002)(6512007)(86362001)(66476007)(66556008)(66946007)(5660300002)(8676002)(6486002)(8936002)(26005)(16526019)(186003)(36756003)(4326008)(316002)(44832011)(478600001)(2616005)(52116002)(83380400001)(6506007)(1076003)(956004)(6666004)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: hwAw5kliYRDjHb5KuhTE9flDcDfKi4cpUZ1RWnn61J7PvTpHiruiI5AT9FGRCeNYnoUCQR5BFoBhuzzjB5S3KUZZ6MwI4CGKhjW8vah3JYNlq4Dkxvj3OOqspMSm3BJZEzIq6ZZ5SopDOhoAbgnVuHgqEx3TP3ZJishIMs4VGryZdaz+N6KseE34oAc69btksHLBLEKRfxV7Zu/P8/T7AijyoovHO7oPvNI30ZcUNgAq2vIGfIZ3D6zMwJau/e0b8gArnIjAgSb77V3lI6ZUwP4iYJdeCLtFlzyqh95fqYV039EartrYv4CgSY4qTQAwpMfWMDYwe2a/o1W2QZyny0BTihYqAnM7DWWAv8ynsGoGVQ14qVcUxjSPFS6HhTfgcfOgIHZm6NMZUuGl8HBvYOmVv240jBfMVrt1VUA1Z1CfQI78qNTuRQBCyJhdLYT2QkrJYgtxw+IbjmmYhOe1WND0BNMEPC93Rkm0LPruAoqUMn+6uxN/e5o3OQzRd0UK2xfCUNnemQJgDS5jBJ3FtRV+ohbNlFHb/waoHQghK+5h/qJEtVnE9vT0UUF6AvQbwvATPVjq6f1OEKmxusnicaJRm+qweL0ClWdjj3gI0T2CnBc+XMH0P/AiYl8CIFjaU85Mc5BE+o5ifO8Obf7yLw==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f0a42d2-76ff-4dec-2df1-08d864551277
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2020 08:53:02.2031
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h7+iX+ueM+qijINzdbdtZaAdjZdCv3GWFz9lL/AiH1Xt3DqzibTONvPqVU+OpeuRBD4ZeHI8dro2r1lk+C74UA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4091
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The 2nd and 3rd parameter were wrongly used, and cause kernel abort when
doing kgdb debug.

Fixes: 1da17d7cf8e2c4("tty: serial: fsl_lpuart: Use appropriate lpuart32_* I/O funcs")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V2:
 Fix poll init

 drivers/tty/serial/fsl_lpuart.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 5a5a22d77841..645bbb24b433 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -649,26 +649,24 @@ static int lpuart32_poll_init(struct uart_port *port)
 	spin_lock_irqsave(&sport->port.lock, flags);
 
 	/* Disable Rx & Tx */
-	lpuart32_write(&sport->port, UARTCTRL, 0);
+	lpuart32_write(&sport->port, 0, UARTCTRL);
 
 	temp = lpuart32_read(&sport->port, UARTFIFO);
 
 	/* Enable Rx and Tx FIFO */
-	lpuart32_write(&sport->port, UARTFIFO,
-		       temp | UARTFIFO_RXFE | UARTFIFO_TXFE);
+	lpuart32_write(&sport->port, temp | UARTFIFO_RXFE | UARTFIFO_TXFE, UARTFIFO);
 
 	/* flush Tx and Rx FIFO */
-	lpuart32_write(&sport->port, UARTFIFO,
-		       UARTFIFO_TXFLUSH | UARTFIFO_RXFLUSH);
+	lpuart32_write(&sport->port, UARTFIFO_TXFLUSH | UARTFIFO_RXFLUSH, UARTFIFO);
 
 	/* explicitly clear RDRF */
 	if (lpuart32_read(&sport->port, UARTSTAT) & UARTSTAT_RDRF) {
 		lpuart32_read(&sport->port, UARTDATA);
-		lpuart32_write(&sport->port, UARTFIFO, UARTFIFO_RXUF);
+		lpuart32_write(&sport->port, UARTFIFO_RXUF, UARTFIFO);
 	}
 
 	/* Enable Rx and Tx */
-	lpuart32_write(&sport->port, UARTCTRL, UARTCTRL_RE | UARTCTRL_TE);
+	lpuart32_write(&sport->port, UARTCTRL_RE | UARTCTRL_TE, UARTCTRL);
 	spin_unlock_irqrestore(&sport->port.lock, flags);
 
 	return 0;
@@ -677,7 +675,7 @@ static int lpuart32_poll_init(struct uart_port *port)
 static void lpuart32_poll_put_char(struct uart_port *port, unsigned char c)
 {
 	lpuart32_wait_bit_set(port, UARTSTAT, UARTSTAT_TDRE);
-	lpuart32_write(port, UARTDATA, c);
+	lpuart32_write(port, c, UARTDATA);
 }
 
 static int lpuart32_poll_get_char(struct uart_port *port)
-- 
2.28.0

