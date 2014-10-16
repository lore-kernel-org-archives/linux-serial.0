From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH 2/3] serial: Fix sparse warnings in uart_throttle()/uart_unthrottle()
Date: Thu, 16 Oct 2014 14:19:48 -0400
Message-ID: <1413483589-6490-2-git-send-email-peter@hurleysoftware.com>
References: <1413483589-6490-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout32.mail01.mtsvc.net ([216.70.64.70]:48182 "EHLO
	n23.mail01.mtsvc.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751347AbaJPSUQ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 16 Oct 2014 14:20:16 -0400
In-Reply-To: <1413483589-6490-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, Peter Hurley <peter@hurleysoftware.com>

The struct uart_port.flags field is type upf_t, as are the matching
bit definitions. Change local mask variable to type upf_t.

Fixes sparse warnings:
drivers/tty/serial/serial_core.c:620:22: warning: invalid assignment: |=
drivers/tty/serial/serial_core.c:620:22:    left side has type unsigned int
drivers/tty/serial/serial_core.c:620:22:    right side has type restricted upf_t
drivers/tty/serial/serial_core.c:622:22: warning: invalid assignment: |=
drivers/tty/serial/serial_core.c:622:22:    left side has type unsigned int
drivers/tty/serial/serial_core.c:622:22:    right side has type restricted upf_t
drivers/tty/serial/serial_core.c:624:17: warning: restricted upf_t degrades to integer
drivers/tty/serial/serial_core.c:626:22: warning: invalid assignment: &=
drivers/tty/serial/serial_core.c:626:22:    left side has type unsigned int
drivers/tty/serial/serial_core.c:626:22:    right side has type restricted upf_t
drivers/tty/serial/serial_core.c:629:20: warning: restricted upf_t degrades to integer
drivers/tty/serial/serial_core.c:632:20: warning: restricted upf_t degrades to integer
drivers/tty/serial/serial_core.c:643:22: warning: invalid assignment: |=
drivers/tty/serial/serial_core.c:643:22:    left side has type unsigned int
drivers/tty/serial/serial_core.c:643:22:    right side has type restricted upf_t
drivers/tty/serial/serial_core.c:645:22: warning: invalid assignment: |=
drivers/tty/serial/serial_core.c:645:22:    left side has type unsigned int
drivers/tty/serial/serial_core.c:645:22:    right side has type restricted upf_t
drivers/tty/serial/serial_core.c:647:17: warning: restricted upf_t degrades to integer
drivers/tty/serial/serial_core.c:649:22: warning: invalid assignment: &=
drivers/tty/serial/serial_core.c:649:22:    left side has type unsigned int
drivers/tty/serial/serial_core.c:649:22:    right side has type restricted upf_t
drivers/tty/serial/serial_core.c:652:20: warning: restricted upf_t degrades to integer
drivers/tty/serial/serial_core.c:655:20: warning: restricted upf_t degrades to integer

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/serial/serial_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index d777579..221ca6f 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -618,7 +618,7 @@ static void uart_throttle(struct tty_struct *tty)
 {
 	struct uart_state *state = tty->driver_data;
 	struct uart_port *port = state->uart_port;
-	uint32_t mask = 0;
+	upf_t mask = 0;
 
 	if (I_IXOFF(tty))
 		mask |= UPF_SOFT_FLOW;
@@ -641,7 +641,7 @@ static void uart_unthrottle(struct tty_struct *tty)
 {
 	struct uart_state *state = tty->driver_data;
 	struct uart_port *port = state->uart_port;
-	uint32_t mask = 0;
+	upf_t mask = 0;
 
 	if (I_IXOFF(tty))
 		mask |= UPF_SOFT_FLOW;
-- 
2.1.1

