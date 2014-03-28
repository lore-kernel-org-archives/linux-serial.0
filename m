From: Daniel Thompson <daniel.thompson@linaro.org>
Subject: [PATCH] serial: st-asc: Fix SysRq char handling
Date: Fri, 28 Mar 2014 10:51:12 +0000
Message-ID: <1396003872-30188-1-git-send-email-daniel.thompson@linaro.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-wg0-f46.google.com ([74.125.82.46]:62871 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751992AbaC1KvQ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 28 Mar 2014 06:51:16 -0400
Received: by mail-wg0-f46.google.com with SMTP id b13so3464289wgh.29
        for <linux-serial@vger.kernel.org>; Fri, 28 Mar 2014 03:51:15 -0700 (PDT)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: daniel.thompson@linaro.org, linux-serial@vger.kernel.org
Cc: patches@linaro.org, linaro-kernel@lists.linaro.org

This driver, like several others, uses the upper bits of the character
to track both real and dummy state. Unfortunately it neglects to mask
these bits properly when passing the character data around. This means
neither break detection nor sysrq character handling work correctly.

This patch adds the requires masking and has been tested to confirm
that it correctly handles magic sysrq sequences on ST's B2020 board.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 drivers/tty/serial/st-asc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/st-asc.c b/drivers/tty/serial/st-asc.c
index 21e6e84..dd3a96e 100644
--- a/drivers/tty/serial/st-asc.c
+++ b/drivers/tty/serial/st-asc.c
@@ -295,7 +295,7 @@ static void asc_receive_chars(struct uart_port *port)
 			status & ASC_STA_OE) {
 
 			if (c & ASC_RXBUF_FE) {
-				if (c == ASC_RXBUF_FE) {
+				if (c == (ASC_RXBUF_FE | ASC_RXBUF_DUMMY_RX)) {
 					port->icount.brk++;
 					if (uart_handle_break(port))
 						continue;
@@ -325,7 +325,7 @@ static void asc_receive_chars(struct uart_port *port)
 				flag = TTY_FRAME;
 		}
 
-		if (uart_handle_sysrq_char(port, c))
+		if (uart_handle_sysrq_char(port, c & 0xff))
 			continue;
 
 		uart_insert_char(port, c, ASC_RXBUF_DUMMY_OE, c & 0xff, flag);
-- 
1.9.0

