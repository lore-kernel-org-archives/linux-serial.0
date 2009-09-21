From: Randy Dunlap <rdunlap@xenotime.net>
Subject: [PATCH] serial core: fix new kernel-doc warnings
Date: Mon, 21 Sep 2009 11:12:03 -0700
Message-ID: <20090921111203.03558642.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from xenotime.net ([72.52.64.118]:53658 "HELO xenotime.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751227AbZIUSME (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 21 Sep 2009 14:12:04 -0400
Received: from chimera.site ([96.253.169.185]) by xenotime.net for <linux-serial@vger.kernel.org>; Mon, 21 Sep 2009 11:12:04 -0700
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: gregkh@suse.de, torvalds <torvalds@linux-foundation.org>

From: Randy Dunlap <randy.dunlap@oracle.com>

Fix new kernel-doc warnings in serial_core.[hc] files.

Warning(include/linux/serial_core.h:485): No description found for parameter 'uport'
Warning(include/linux/serial_core.h:485): Excess function parameter 'port' description in 'uart_handle_dcd_change'
Warning(include/linux/serial_core.h:511): No description found for parameter 'uport'
Warning(include/linux/serial_core.h:511): Excess function parameter 'port' description in 'uart_handle_cts_change'
Warning(drivers/serial/serial_core.c:2437): No description found for parameter 'uport'
Warning(drivers/serial/serial_core.c:2437): Excess function parameter 'port' description in 'uart_add_one_port'
Warning(drivers/serial/serial_core.c:2509): No description found for parameter 'uport'
Warning(drivers/serial/serial_core.c:2509): Excess function parameter 'port' description in 'uart_remove_one_port'

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 drivers/serial/serial_core.c |    4 ++--
 include/linux/serial_core.h  |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

--- linux-2.6.31-git10.orig/drivers/serial/serial_core.c
+++ linux-2.6.31-git10/drivers/serial/serial_core.c
@@ -2426,7 +2426,7 @@ struct tty_driver *uart_console_device(s
 /**
  *	uart_add_one_port - attach a driver-defined port structure
  *	@drv: pointer to the uart low level driver structure for this port
- *	@port: uart port structure to use for this port.
+ *	@uport: uart port structure to use for this port.
  *
  *	This allows the driver to register its own uart_port structure
  *	with the core driver.  The main purpose is to allow the low
@@ -2499,7 +2499,7 @@ int uart_add_one_port(struct uart_driver
 /**
  *	uart_remove_one_port - detach a driver defined port structure
  *	@drv: pointer to the uart low level driver structure for this port
- *	@port: uart port structure for this port
+ *	@uport: uart port structure for this port
  *
  *	This unhooks (and hangs up) the specified port structure from the
  *	core driver.  No further calls will be made to the low-level code
--- linux-2.6.31-git10.orig/include/linux/serial_core.h
+++ linux-2.6.31-git10/include/linux/serial_core.h
@@ -477,7 +477,7 @@ static inline int uart_handle_break(stru
 
 /**
  *	uart_handle_dcd_change - handle a change of carrier detect state
- *	@port: uart_port structure for the open port
+ *	@uport: uart_port structure for the open port
  *	@status: new carrier detect status, nonzero if active
  */
 static inline void
@@ -503,7 +503,7 @@ uart_handle_dcd_change(struct uart_port 
 
 /**
  *	uart_handle_cts_change - handle a change of clear-to-send state
- *	@port: uart_port structure for the open port
+ *	@uport: uart_port structure for the open port
  *	@status: new clear to send status, nonzero if active
  */
 static inline void
