From: Matt Schulte <matts@commtech-fastcom.com>
Subject: [PATCH 2/2] tty/8250 Add XR17D15x devices to the exar_handle_irq override
Date: Tue, 20 Nov 2012 10:42:00 -0600
Message-ID: <CAJp1Oe5hxCSzLy3JRWJjOOiyoYjoiheTUriYaZNCmzDN-aYj=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:41876 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751804Ab2KTQmW (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 20 Nov 2012 11:42:22 -0500
Received: by mail-vb0-f46.google.com with SMTP id ff1so712331vbb.19
        for <linux-serial@vger.kernel.org>; Tue, 20 Nov 2012 08:42:21 -0800 (PST)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Greg Kroah-Hartman <greg@kroah.com>

Add XR17D15x devices to the exar_handle_irq override: they have the
same extra interrupt register that could fire and never be serviced by
the standard handle_irq.

Signed-off-by: Matt Schulte <matts@commtech-fastcom.com>
---
Built against tty-next commit: 1e619a1bf9ac878e6a984e4e279ccf712a65bc23

This depends on my previous patch submission:
[PATCH v3] Add support for new devices: Exar's XR17V35x family of
multi-port PCIe UARTs

 drivers/tty/serial/8250/8250.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250.c b/drivers/tty/serial/8250/8250.c
index 44be636..1cda869 100644
--- a/drivers/tty/serial/8250/8250.c
+++ b/drivers/tty/serial/8250/8250.c
@@ -1578,7 +1578,8 @@ static int exar_handle_irq(struct uart_port *port)

 	ret = serial8250_handle_irq(port, iir);

-	if (port->type == PORT_XR17V35X) {
+	if ((port->type == PORT_XR17V35X) ||
+	   (port->type == PORT_XR17D15X)) {
 		int0 = serial_port_in(port, 0x80);
 		int1 = serial_port_in(port, 0x81);
 		int2 = serial_port_in(port, 0x82);
@@ -2689,7 +2690,8 @@ static void serial8250_config_port(struct
uart_port *port, int flags)
 		serial8250_release_std_resource(up);

 	/* Fixme: probably not the best place for this */
-	if (port->type == PORT_XR17V35X)
+	if ((port->type == PORT_XR17V35X) ||
+	   (port->type == PORT_XR17D15X))
 		port->handle_irq = exar_handle_irq;
 }

-- 
1.7.2.5
