Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24CA6C4361B
	for <linux-serial@archiver.kernel.org>; Mon, 14 Dec 2020 13:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA412205CB
	for <linux-serial@archiver.kernel.org>; Mon, 14 Dec 2020 13:16:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407818AbgLNNQS (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 14 Dec 2020 08:16:18 -0500
Received: from smtp.asem.it ([151.1.184.197]:63404 "EHLO smtp.asem.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725763AbgLNNQL (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 14 Dec 2020 08:16:11 -0500
Received: from webmail.asem.it
        by asem.it (smtp.asem.it)
        (SecurityGateway 6.5.2)
        with ESMTP id SG000667263.MSG 
        for <linux-serial@vger.kernel.org>; Mon, 14 Dec 2020 14:15:12 +0100S
Received: from ASAS044.asem.intra (172.16.16.44) by ASAS044.asem.intra
 (172.16.16.44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 14
 Dec 2020 14:15:11 +0100
Received: from flavio-x.asem.intra (172.16.17.208) by ASAS044.asem.intra
 (172.16.16.44) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Mon, 14 Dec 2020 14:15:11 +0100
From:   Flavio Suligoi <f.suligoi@asem.it>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Ji-Ze Hong <hpeter@gmail.com>
CC:     <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Flavio Suligoi <f.suligoi@asem.it>
Subject: [PATCH v1] serial: 8250_fintek: Print Fintek chip name
Date:   Mon, 14 Dec 2020 14:14:45 +0100
Message-ID: <20201214131445.954822-1-f.suligoi@asem.it>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-SGHeloLookup-Result: pass smtp.helo=webmail.asem.it (ip=172.16.16.44)
X-SGSPF-Result: none (smtp.asem.it)
X-SGOP-RefID: str=0001.0A782F29.5FD7655F.007E,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0 (_st=1 _vt=0 _iwf=0)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

At the moment, if a Fintek UART is detected, there is no
printed information about this.
The ttyS port is declared as a simple 16550A port, but,
especially when we want to use the RS485 mode, it's
very important understand if the Fintek UART is correctly
detected as expected.

Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
---
 drivers/tty/serial/8250/8250_fintek.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_fintek.c b/drivers/tty/serial/8250/8250_fintek.c
index 31c9e83ea3cb..ef2303cb5176 100644
--- a/drivers/tty/serial/8250/8250_fintek.c
+++ b/drivers/tty/serial/8250/8250_fintek.c
@@ -97,6 +97,7 @@ struct fintek_8250 {
 	u16 base_port;
 	u8 index;
 	u8 key;
+	const char *chip_name;
 };
 
 static u8 sio_read_reg(struct fintek_8250 *pdata, u8 reg)
@@ -140,9 +141,11 @@ static void fintek_8250_exit_key(u16 base_port)
 	release_region(base_port + ADDR_PORT, 2);
 }
 
-static int fintek_8250_check_id(struct fintek_8250 *pdata)
+static int fintek_8250_check_id(struct fintek_8250 *pdata,
+				struct uart_8250_port *uart)
 {
 	u16 chip;
+	const char *chip_name;
 
 	if (sio_read_reg(pdata, VENDOR_ID1) != VENDOR_ID1_VAL)
 		return -ENODEV;
@@ -155,17 +158,35 @@ static int fintek_8250_check_id(struct fintek_8250 *pdata)
 
 	switch (chip) {
 	case CHIP_ID_F81865:
+		chip_name = "F81865";
+		break;
 	case CHIP_ID_F81866:
+		chip_name = "F81866";
+		break;
 	case CHIP_ID_F81966:
+		chip_name = "F81966";
+		break;
 	case CHIP_ID_F81216AD:
+		chip_name = "F81216AD";
+		break;
 	case CHIP_ID_F81216H:
+		chip_name = "F81216H";
+		break;
 	case CHIP_ID_F81216:
+		chip_name = "F81216";
 		break;
 	default:
 		return -ENODEV;
 	}
 
 	pdata->pid = chip;
+
+	pr_info("%s%s%s Fintek %s\n",
+		uart->port.dev ? dev_name(uart->port.dev) : "",
+		uart->port.dev ? ": " : "",
+		uart->port.name,
+		chip_name);
+
 	return 0;
 }
 
@@ -406,7 +427,7 @@ static int probe_setup_port(struct fintek_8250 *pdata,
 
 			if (fintek_8250_enter_key(addr[i], keys[j]))
 				continue;
-			if (fintek_8250_check_id(pdata) ||
+			if (fintek_8250_check_id(pdata, uart) ||
 			    fintek_8250_get_ldn_range(pdata, &min, &max)) {
 				fintek_8250_exit_key(addr[i]);
 				continue;
-- 
2.25.1

