From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH 2/2] serial: of_serial: Handle fifosize property
Date: Thu, 21 Mar 2013 12:48:00 +0200
Message-ID: <1363862880-17295-1-git-send-email-heikki.krogerus@linux.intel.com>
References: <20130321104651.GC2862@xps8300>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:46084 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754214Ab3CUKsH (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 21 Mar 2013 06:48:07 -0400
In-Reply-To: <20130321104651.GC2862@xps8300>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Ley Foon Tan <lftan@altera.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, Rob Landley <rob@landley.net>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

fifosize property is already used with a number of serial
devices. This should reduce the need for extra types in
8250.c just in case the fifosize differs from the standard.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 Documentation/devicetree/bindings/tty/serial/of-serial.txt |    1 +
 drivers/tty/serial/of_serial.c                             |    4 ++++
 2 files changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/tty/serial/of-serial.txt b/Documentation/devicetree/bindings/tty/serial/of-serial.txt
index 8f01cb1..55fe4e7 100644
--- a/Documentation/devicetree/bindings/tty/serial/of-serial.txt
+++ b/Documentation/devicetree/bindings/tty/serial/of-serial.txt
@@ -33,6 +33,7 @@ Optional properties:
   RTAS and should not be registered.
 - no-loopback-test: set to indicate that the port does not implements loopback
   test mode
+- fifosize: the fifo size of the UART.
 
 Example:
 
diff --git a/drivers/tty/serial/of_serial.c b/drivers/tty/serial/of_serial.c
index b025d54..4f89761 100644
--- a/drivers/tty/serial/of_serial.c
+++ b/drivers/tty/serial/of_serial.c
@@ -97,6 +97,10 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
 	if (of_property_read_u32(np, "reg-shift", &prop) == 0)
 		port->regshift = prop;
 
+	/* Check for fifo size */
+	if (of_property_read_u32(np, "fifosize", &prop) == 0)
+		port->fifosize = prop;
+
 	port->irq = irq_of_parse_and_map(np, 0);
 	port->iotype = UPIO_MEM;
 	if (of_property_read_u32(np, "reg-io-width", &prop) == 0) {
-- 
1.7.10.4

