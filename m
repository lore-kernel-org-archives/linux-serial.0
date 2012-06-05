From: Randy Dunlap <rdunlap@xenotime.net>
Subject: serial: fix serial_txx9.c build warning/typo
Date: Tue, 05 Jun 2012 09:46:07 -0700
Message-ID: <4FCE37CF.90902@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from oproxy8-pub.bluehost.com ([69.89.22.20]:60422 "HELO
	oproxy8-pub.bluehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753140Ab2FEQqP (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 5 Jun 2012 12:46:15 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org
Cc: Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Geert Uytterhoeven <geert@linux-m68k.org>

From: Randy Dunlap <rdunlap@xenotime.net>

Fix kconfig symbol test to use "defined":

drivers/tty/serial/serial_txx9.c: warning: "CONFIG_CONSOLE_POLL" is not defined [-Wundef]

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 drivers/tty/serial/serial_txx9.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- lnx-35-rc1.orig/drivers/tty/serial/serial_txx9.c
+++ lnx-35-rc1/drivers/tty/serial/serial_txx9.c
@@ -466,7 +466,7 @@ static void serial_txx9_break_ctl(struct
 	spin_unlock_irqrestore(&up->port.lock, flags);
 }
 
-#if defined(CONFIG_SERIAL_TXX9_CONSOLE) || (CONFIG_CONSOLE_POLL)
+#if defined(CONFIG_SERIAL_TXX9_CONSOLE) || defined(CONFIG_CONSOLE_POLL)
 /*
  *	Wait for transmitter & holding register to empty
  */
