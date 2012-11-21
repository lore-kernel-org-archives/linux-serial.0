From: Matt Schulte <matts@commtech-fastcom.com>
Subject: [PATCH 2/2 Resubmit] tty/8250 Add XR17D15x devices to the
 exar_handle_irq override
Date: Wed, 21 Nov 2012 09:40:49 -0600
Message-ID: <CAJp1Oe6jT3=UdGWQfTbaemAqaf_q8GtW+K8TQ0Rh4LOjXWaFag@mail.gmail.com>
References: <CAJp1Oe5hxCSzLy3JRWJjOOiyoYjoiheTUriYaZNCmzDN-aYj=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:63729 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755106Ab2KUPlM (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 21 Nov 2012 10:41:12 -0500
Received: by mail-vc0-f174.google.com with SMTP id m18so3646526vcm.19
        for <linux-serial@vger.kernel.org>; Wed, 21 Nov 2012 07:41:11 -0800 (PST)
In-Reply-To: <CAJp1Oe5hxCSzLy3JRWJjOOiyoYjoiheTUriYaZNCmzDN-aYj=A@mail.gmail.com>
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
