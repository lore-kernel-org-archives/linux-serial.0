Return-Path: <SRS0=mq3J=B4=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3119C433E3
	for <linux-serial@archiver.kernel.org>; Tue, 18 Aug 2020 08:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA7182075E
	for <linux-serial@archiver.kernel.org>; Tue, 18 Aug 2020 08:58:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbgHRI60 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 18 Aug 2020 04:58:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:37750 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726620AbgHRI5A (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 18 Aug 2020 04:57:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 27C55B036;
        Tue, 18 Aug 2020 08:57:23 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 8/8] tty: serial, fix kernel-doc
Date:   Tue, 18 Aug 2020 10:56:55 +0200
Message-Id: <20200818085655.12071-8-jslaby@suse.cz>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200818085655.12071-1-jslaby@suse.cz>
References: <20200818085655.12071-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

As in the previous patches, fix kernel-doc in serial drivers.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/serial/ifx6x60.c       | 7 +++----
 drivers/tty/serial/men_z135_uart.c | 8 ++++----
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/ifx6x60.c b/drivers/tty/serial/ifx6x60.c
index 7d16fe41932f..095ddd04370f 100644
--- a/drivers/tty/serial/ifx6x60.c
+++ b/drivers/tty/serial/ifx6x60.c
@@ -257,7 +257,7 @@ static void mrdy_assert(struct ifx_spi_device *ifx_dev)
 
 /**
  *	ifx_spi_timeout		-	SPI timeout
- *	@arg: our SPI device
+ *	@t: timer in our SPI device
  *
  *	The SPI has timed out: hang up the tty. Users will then see a hangup
  *	and error events.
@@ -277,7 +277,6 @@ static void ifx_spi_timeout(struct timer_list *t)
 /**
  *	ifx_spi_tiocmget	-	get modem lines
  *	@tty: our tty device
- *	@filp: file handle issuing the request
  *
  *	Map the signal state into Linux modem flags and report the value
  *	in Linux terms
@@ -531,7 +530,7 @@ static int ifx_spi_chars_in_buffer(struct tty_struct *tty)
 
 /**
  *	ifx_port_hangup
- *	@port: our tty port
+ *	@tty: our tty
  *
  *	tty port hang up. Called when tty_hangup processing is invoked either
  *	by loss of carrier, or by software (eg vhangup). Serialized against
@@ -611,7 +610,7 @@ static const struct tty_operations ifx_spi_serial_ops = {
 
 /**
  *	ifx_spi_insert_fip_string	-	queue received data
- *	@ifx_ser: our SPI device
+ *	@ifx_dev: our SPI device
  *	@chars: buffer we have received
  *	@size: number of chars reeived
  *
diff --git a/drivers/tty/serial/men_z135_uart.c b/drivers/tty/serial/men_z135_uart.c
index 4f53a4caabf6..9acae5f8fc32 100644
--- a/drivers/tty/serial/men_z135_uart.c
+++ b/drivers/tty/serial/men_z135_uart.c
@@ -173,7 +173,7 @@ static void men_z135_reg_clr(struct men_z135_port *uart,
 
 /**
  * men_z135_handle_modem_status() - Handle change of modem status
- * @port: The UART port
+ * @uart: The UART port
  *
  * Handle change of modem status register. This is done by reading the "delta"
  * versions of DCD (Data Carrier Detect) and CTS (Clear To Send).
@@ -236,7 +236,7 @@ static u16 get_rx_fifo_content(struct men_z135_port *uart)
 
 /**
  * men_z135_handle_rx() - RX tasklet routine
- * @arg: Pointer to struct men_z135_port
+ * @uart: Pointer to struct men_z135_port
  *
  * Copy from RX FIFO and acknowledge number of bytes copied.
  */
@@ -287,7 +287,7 @@ static void men_z135_handle_rx(struct men_z135_port *uart)
 
 /**
  * men_z135_handle_tx() - TX tasklet routine
- * @arg: Pointer to struct men_z135_port
+ * @uart: Pointer to struct men_z135_port
  *
  */
 static void men_z135_handle_tx(struct men_z135_port *uart)
@@ -596,7 +596,7 @@ static void men_z135_stop_rx(struct uart_port *port)
 
 /**
  * men_z135_enable_ms() - Enable Modem Status
- * port:
+ * @port: the port
  *
  * Enable Modem Status IRQ.
  */
-- 
2.28.0

