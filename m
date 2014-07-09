From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH v2] serial: core: Preserve termios c_cflag for console resume
Date: Wed,  9 Jul 2014 09:21:14 -0400
Message-ID: <1404912074-9729-2-git-send-email-peter@hurleysoftware.com>
References: <1404912074-9729-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout32.mail01.mtsvc.net ([216.70.64.70]:48585 "EHLO
	n23.mail01.mtsvc.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755550AbaGINV3 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 9 Jul 2014 09:21:29 -0400
In-Reply-To: <1404912074-9729-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>

When a tty is opened for the serial console, the termios c_cflag
settings are inherited from the console line settings.
However, if the tty is subsequently closed, the termios settings
are lost. This results in a garbled console if the console is later
suspended and resumed.

Preserve the termios c_cflag for the serial console when the tty
is shutdown; this reflects the most recent line settings.

Fixes: Bugzilla #69751, 'serial console does not wake from S3'
Reported-by: Valerio Vanni <valerio.vanni@inwind.it>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/serial/serial_core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index b68550d..aab7190 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -239,6 +239,9 @@ static void uart_shutdown(struct tty_struct *tty, struct uart_state *state)
 		/*
 		 * Turn off DTR and RTS early.
 		 */
+		if (uart_console(uport) && tty)
+			uport->cons->cflag = tty->termios.c_cflag;
+
 		if (!tty || (tty->termios.c_cflag & HUPCL))
 			uart_clear_mctrl(uport, TIOCM_DTR | TIOCM_RTS);
 
-- 
2.0.0

