Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E266C43470
	for <linux-serial@archiver.kernel.org>; Tue, 18 May 2021 01:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43B19613BA
	for <linux-serial@archiver.kernel.org>; Tue, 18 May 2021 01:57:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346162AbhERB6p (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 17 May 2021 21:58:45 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4721 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241532AbhERB6o (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 17 May 2021 21:58:44 -0400
Received: from dggems703-chm.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FkfDj6vK0zmhpj;
        Tue, 18 May 2021 09:53:57 +0800 (CST)
Received: from dggeme758-chm.china.huawei.com (10.3.19.104) by
 dggems703-chm.china.huawei.com (10.3.19.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Tue, 18 May 2021 09:57:26 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggeme758-chm.china.huawei.com (10.3.19.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Tue, 18 May 2021 09:57:25 +0800
From:   Jay Fang <f.fangjian@huawei.com>
To:     <gregkh@linuxfoundation.org>
CC:     <linux-serial@vger.kernel.org>, <linuxarm@huawei.com>,
        <huangdaode@huawei.com>, <tangzihao1@hisilicon.com>
Subject: [PATCH 06/11] tty: serial: atmel: Fix some coding style issues
Date:   Tue, 18 May 2021 09:57:13 +0800
Message-ID: <1621303038-12062-7-git-send-email-f.fangjian@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1621303038-12062-1-git-send-email-f.fangjian@huawei.com>
References: <1621303038-12062-1-git-send-email-f.fangjian@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggeme758-chm.china.huawei.com (10.3.19.104)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Zihao Tang <tangzihao1@hisilicon.com>

Fix some coding style warnings reported by checkpatch.pl.

Fix 4 "Block comments use a trailing */ on a separate line" warnings.
Fix 1 "Block comments use * on subsequent lines" warning.
Fix 1 "Block comments use * on subsequent lines" warning.

Signed-off-by: Zihao Tang <tangzihao1@hisilicon.com>
Signed-off-by: Jay Fang <f.fangjian@huawei.com>
---
 drivers/tty/serial/atmel_serial.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 058886d..5d4675f 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -60,7 +60,8 @@ static void atmel_stop_rx(struct uart_port *port);
 
 /* Use device name ttyAT, major 204 and minor 154-169.  This is necessary if we
  * should coexist with the 8250 driver, such as if we have an external 16C550
- * UART. */
+ * UART.
+ */
 #define SERIAL_ATMEL_MAJOR	204
 #define MINOR_START		154
 #define ATMEL_DEVICENAME	"ttyAT"
@@ -68,7 +69,8 @@ static void atmel_stop_rx(struct uart_port *port);
 #else
 
 /* Use device name ttyS, major 4, minor 64-68.  This is the usual serial port
- * name, but it is legally reserved for the 8250 driver. */
+ * name, but it is legally reserved for the 8250 driver.
+ */
 #define SERIAL_ATMEL_MAJOR	TTY_MAJOR
 #define MINOR_START		64
 #define ATMEL_DEVICENAME	"ttyS"
@@ -582,7 +584,8 @@ static void atmel_start_tx(struct uart_port *port)
 	if (atmel_use_pdc_tx(port) && (atmel_uart_readl(port, ATMEL_PDC_PTSR)
 				       & ATMEL_PDC_TXTEN))
 		/* The transmitter is already running.  Yes, we
-		   really need this.*/
+		 * really need this.
+		 */
 		return;
 
 	if (atmel_use_pdc_tx(port) || atmel_use_dma_tx(port))
@@ -2399,6 +2402,7 @@ static void atmel_config_port(struct uart_port *port, int flags)
 static int atmel_verify_port(struct uart_port *port, struct serial_struct *ser)
 {
 	int ret = 0;
+
 	if (ser->type != PORT_UNKNOWN && ser->type != PORT_ATMEL)
 		ret = -EINVAL;
 	if (port->irq != ser->irq)
@@ -2837,7 +2841,8 @@ static int atmel_serial_probe(struct platform_device *pdev)
 	ret = of_alias_get_id(np, "serial");
 	if (ret < 0)
 		/* port id not found in platform data nor device-tree aliases:
-		 * auto-enumerate it */
+		 * auto-enumerate it
+		 */
 		ret = find_first_zero_bit(atmel_ports_in_use, ATMEL_MAX_UART);
 
 	if (ret >= ATMEL_MAX_UART) {
-- 
2.7.4

