From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] serial: fix kernel-doc warning in comments
Date: Tue, 8 Oct 2019 13:46:53 -0700
Message-ID: <e989641c-224a-1090-e596-e7cc800bed44@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix Sphinx warning in serial_core.c:

../drivers/tty/serial/serial_core.c:1969: WARNING: Definition list ends without a blank line; unexpected unindent.

Fixes: 73abaf87f01b ("serial: earlycon: Refactor parse_options into serial core")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Peter Hurley <peter@hurleysoftware.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/serial_core.c |    2 ++
 1 file changed, 2 insertions(+)

--- linux-next-20191008.orig/drivers/tty/serial/serial_core.c
+++ linux-next-20191008/drivers/tty/serial/serial_core.c
@@ -1964,8 +1964,10 @@ uart_get_console(struct uart_port *ports
  *	   console=<name>,io|mmio|mmio16|mmio32|mmio32be|mmio32native,<addr>,<options>
  *
  *	The optional form
+ *
  *	   earlycon=<name>,0x<addr>,<options>
  *	   console=<name>,0x<addr>,<options>
+ *
  *	is also accepted; the returned @iotype will be UPIO_MEM.
  *
  *	Returns 0 on success or -EINVAL on failure
