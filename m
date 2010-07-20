From: akpm@linux-foundation.org
Subject: [patch 3/7] serial: general fixes in the serial_rs485 structure
Date: Tue, 20 Jul 2010 15:26:47 -0700
Message-ID: <201007202226.o6KMQl2n021527@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:43095 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932831Ab0GTW1l (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 20 Jul 2010 18:27:41 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: greg@kroah.com
Cc: linux-serial@vger.kernel.org, akpm@linux-foundation.org, claudio@evidence.eu.com, alan@lxorguk.ukuu.org.uk, br@pwrnet.de, phdm@macqel.be

From: Claudio Scordino <claudio@evidence.eu.com>

Fix several issues related to the RS485 interface:

 - It adds the flag SER_RS485_RTS_BEFORE_SEND that was missing from the
   serial_rs485 structure (even if "delay_rts_before_send" was existing)

 - It adds a further "delay_rts_after_send" field for those drivers that
   can have a delay after send (e.g., atmel_serial)

 - It fixes the usage of the structure in the atmel_serial driver (where
   "delay_rts_before_send" should be used instead of "delay_rts_after_send").

Signed-off-by: Claudio Scordino <claudio@evidence.eu.com>
Signed-off-by: Bernhard Roth <br@pwrnet.de>
Cc: Philippe De Muyter <phdm@macqel.be>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Greg KH <greg@kroah.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/serial/atmel_serial.c |   11 ++++++++---
 include/linux/serial.h        |    4 +++-
 2 files changed, 11 insertions(+), 4 deletions(-)

diff -puN drivers/serial/atmel_serial.c~serial-general-fixes-in-the-serial_rs485-structure drivers/serial/atmel_serial.c
--- a/drivers/serial/atmel_serial.c~serial-general-fixes-in-the-serial_rs485-structure
+++ a/drivers/serial/atmel_serial.c
@@ -217,7 +217,8 @@ void atmel_config_rs485(struct uart_port
 	if (rs485conf->flags & SER_RS485_ENABLED) {
 		dev_dbg(port->dev, "Setting UART to RS485\n");
 		atmel_port->tx_done_mask = ATMEL_US_TXEMPTY;
-		UART_PUT_TTGR(port, rs485conf->delay_rts_before_send);
+		if (rs485conf->flags & SER_RS485_RTS_AFTER_SEND)
+			UART_PUT_TTGR(port, rs485conf->delay_rts_after_send);
 		mode |= ATMEL_US_USMODE_RS485;
 	} else {
 		dev_dbg(port->dev, "Setting UART to RS232\n");
@@ -292,7 +293,9 @@ static void atmel_set_mctrl(struct uart_
 
 	if (atmel_port->rs485.flags & SER_RS485_ENABLED) {
 		dev_dbg(port->dev, "Setting UART to RS485\n");
-		UART_PUT_TTGR(port, atmel_port->rs485.delay_rts_before_send);
+		if (atmel_port->rs485.flags & SER_RS485_RTS_AFTER_SEND)
+			UART_PUT_TTGR(port,
+					atmel_port->rs485.delay_rts_after_send);
 		mode |= ATMEL_US_USMODE_RS485;
 	} else {
 		dev_dbg(port->dev, "Setting UART to RS232\n");
@@ -1211,7 +1214,9 @@ static void atmel_set_termios(struct uar
 
 	if (atmel_port->rs485.flags & SER_RS485_ENABLED) {
 		dev_dbg(port->dev, "Setting UART to RS485\n");
-		UART_PUT_TTGR(port, atmel_port->rs485.delay_rts_before_send);
+		if (atmel_port->rs485.flags & SER_RS485_RTS_AFTER_SEND)
+			UART_PUT_TTGR(port,
+					atmel_port->rs485.delay_rts_after_send);
 		mode |= ATMEL_US_USMODE_RS485;
 	} else {
 		dev_dbg(port->dev, "Setting UART to RS232\n");
diff -puN include/linux/serial.h~serial-general-fixes-in-the-serial_rs485-structure include/linux/serial.h
--- a/include/linux/serial.h~serial-general-fixes-in-the-serial_rs485-structure
+++ a/include/linux/serial.h
@@ -210,8 +210,10 @@ struct serial_rs485 {
 #define SER_RS485_ENABLED		(1 << 0)
 #define SER_RS485_RTS_ON_SEND		(1 << 1)
 #define SER_RS485_RTS_AFTER_SEND	(1 << 2)
+#define SER_RS485_RTS_BEFORE_SEND	(1 << 3)
 	__u32	delay_rts_before_send;	/* Milliseconds */
-	__u32	padding[6];		/* Memory is cheap, new structs
+	__u32	delay_rts_after_send;	/* Milliseconds */
+	__u32	padding[5];		/* Memory is cheap, new structs
 					   are a royal PITA .. */
 };
 
_
