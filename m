From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH 1/3] serial: Fix upstat_t sparse warnings
Date: Thu, 16 Oct 2014 14:19:47 -0400
Message-ID: <1413483589-6490-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout32.mail01.mtsvc.net ([216.70.64.70]:36176 "EHLO
	n23.mail01.mtsvc.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751309AbaJPSUP (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 16 Oct 2014 14:20:15 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, Peter Hurley <peter@hurleysoftware.com>

Commit 299245a145b2ad4cfb4c5432eb1264299f55e7e0,
serial: core: Privatize modem status enable flags, introduced
the upstat_t type and matching bit definitions. The purpose is to
produce sparse warnings if the wrong bit definitions are used
(by warning of implicit integer conversions).

Fix implicit conversion to integer return type from uart_cts_enabled()
and uart_dcd_enabled().

Fixes the following sparse warnings:
drivers/tty/serial/serial_core.c:63:30: warning: incorrect type in return expression (different base types)
drivers/tty/serial/serial_core.c:63:30:    expected int
drivers/tty/serial/serial_core.c:63:30:    got restricted upstat_t
include/linux/serial_core.h:364:30: warning: incorrect type in return expression (different base types)
include/linux/serial_core.h:364:30:    expected bool
include/linux/serial_core.h:364:30:    got restricted upstat_t
include/linux/serial_core.h:364:30: warning: incorrect type in return expression (different base types)
include/linux/serial_core.h:364:30:    expected bool
include/linux/serial_core.h:364:30:    got restricted upstat_t

Reported-by: Fengguang Wu <fengguang.wu@intel.com>
Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/serial/serial_core.c | 2 +-
 include/linux/serial_core.h      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index c4cc2f2..d777579 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -61,7 +61,7 @@ static void uart_port_shutdown(struct tty_port *port);
 
 static int uart_dcd_enabled(struct uart_port *uport)
 {
-	return uport->status & UPSTAT_DCD_ENABLE;
+	return !!(uport->status & UPSTAT_DCD_ENABLE);
 }
 
 /*
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 222d2e0..bb828a5 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -363,7 +363,7 @@ static inline int uart_tx_stopped(struct uart_port *port)
 
 static inline bool uart_cts_enabled(struct uart_port *uport)
 {
-	return uport->status & UPSTAT_CTS_ENABLE;
+	return !!(uport->status & UPSTAT_CTS_ENABLE);
 }
 
 /*
-- 
2.1.1

