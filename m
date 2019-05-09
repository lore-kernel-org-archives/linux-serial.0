From: Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH] tty: amba-pl011: allow shared interrupt
Date: Thu,  9 May 2019 14:11:58 -0700
Message-ID: <20190509211159.29364-1-f.fainelli@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: bcm-kernel-feedback-list@broadcom.com, Doug Berger <opendmb@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, Russell King <linux@armlinux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

From: Doug Berger <opendmb@gmail.com>

The PL011 register space includes all necessary status bits to
determine whether a device instance requires handling in response
to an interrupt. Therefore, multiple instances of the device could
be serviced by a single shared interrupt, which is the case on BCM7211.

Signed-off-by: Doug Berger <opendmb@gmail.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/tty/serial/amba-pl011.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 89ade213a1a9..5921a33b2a07 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -1717,7 +1717,7 @@ static int pl011_allocate_irq(struct uart_amba_port *uap)
 {
 	pl011_write(uap->im, uap, REG_IMSC);
 
-	return request_irq(uap->port.irq, pl011_int, 0, "uart-pl011", uap);
+	return request_irq(uap->port.irq, pl011_int, IRQF_SHARED, "uart-pl011", uap);
 }
 
 /*
-- 
2.17.1
