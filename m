From: Tomas Hlavacek <tmshlvck@gmail.com>
Subject: RFC: exposing uartclk value to sysfs
Date: Sat, 11 Aug 2012 00:28:43 +0200
Message-ID: <CAEB7QLAJXkK6NDPVDi36n_U_X_DGh5niHJhH6FpqBUZFmXQ2Xg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:60088 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758879Ab2HJW2o convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 10 Aug 2012 18:28:44 -0400
Received: by yhmm54 with SMTP id m54so2172075yhm.19
        for <linux-serial@vger.kernel.org>; Fri, 10 Aug 2012 15:28:43 -0700 (PDT)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <alan@linux.intel.com>

Hello!

I have encountered quite a lot PCI cards with many different
oscillator speeds while having no differences in PCI IDs (i.e. vendor
and subsystem IDs were chip-dafault). Namely I own several no-name
cards with OX16PCI954 and various speeds. These cards need different
baud_base (=3D uartclk*16) settings but it can not be
autodetected/pre-set because there is no way to distinguish them.
Although there is a way to set baud_base via setserial(8) I was
wandering whether it would be possible to expose uartclk in sysfs for
read/write. I have created a following proof-of-concept experimental
patch:

=46rom 12c7e940c978da6cca9a6d51f499e7c5b53ec4b1 Mon Sep 17 00:00:00 200=
1
=46rom: Tomas Hlavacek <tmshlvck@gmail.com>
Date: Fri, 10 Aug 2012 23:43:17 +0200
Subject: [PATCH 1/1] [RFC] [experimental]: uartclk exposed to sysfs.

TODO:

* Get opinions on the whole idea of exposing uartclk to sysfs.

* Get opinions on getting struct uart_port pointer in
the get_attr_uart routine by changing driver data of the tty device.

* Correct removal of the file (problem: How to get the device
handle?)

* Synchronization.

* Add write routine.

Signed-off-by: Tomas Hlavacek <tmshlvck@gmail.com>
---
 drivers/tty/serial/serial_core.c |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/seri=
al_core.c
index a21dc8e..2cb6ed5 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -2293,6 +2293,17 @@ struct tty_driver *uart_console_device(struct
console *co, int *index)
 	return p->tty_driver;
 }

+static ssize_t get_attr_uartclk(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct uart_port *port =3D (struct uart_port *)(dev_get_drvdata(dev))=
;
+	return snprintf(buf, PAGE_SIZE, "%d\n", port->uartclk);
+}
+
+static DEVICE_ATTR(uartclk, S_IRUGO, get_attr_uartclk, NULL);
+
 /**
  *	uart_add_one_port - attach a driver-defined port structure
  *	@drv: pointer to the uart low level driver structure for this port
@@ -2354,6 +2365,12 @@ int uart_add_one_port(struct uart_driver *drv,
struct uart_port *uport)
 		       uport->line);
 	}

+	dev_set_drvdata(tty_dev, uport);
+	int sret =3D device_create_file(tty_dev, &dev_attr_uartclk);
+	if (sret < 0)
+		dev_err(tty_dev, "failed to add uartclk attr.\n");
+
 	/*
 	 * Ensure UPF_DEAD is not set.
 	 */
--=20
1.7.10.4

Tomas

--=20
Tom=C3=A1=C5=A1 Hlav=C3=A1=C4=8Dek <tmshlvck@gmail.com>
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
