From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] serial: sh-sci: Use platform_get_irq_optional() for optional interrupts
Date: Tue,  1 Oct 2019 20:07:43 +0200
Message-ID: <20191001180743.1041-1-geert+renesas@glider.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Stephen Boyd <swboyd@chromium.org>, linux-renesas-soc@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

As platform_get_irq() now prints an error when the interrupt does not
exist, scary warnings may be printed for optional interrupts:

    sh-sci e6550000.serial: IRQ index 1 not found
    sh-sci e6550000.serial: IRQ index 2 not found
    sh-sci e6550000.serial: IRQ index 3 not found
    sh-sci e6550000.serial: IRQ index 4 not found
    sh-sci e6550000.serial: IRQ index 5 not found

Fix this by calling platform_get_irq_optional() instead for all but the
first interrupts, which are optional.

Fixes: 7723f4c5ecdb8d83 ("driver core: platform: Add an error message to platform_get_irq*()")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
This is a fix for v5.4-rc1.
---
 drivers/tty/serial/sh-sci.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 4e754a4850e6db63..22e5d4e13714e863 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -2894,8 +2894,12 @@ static int sci_init_single(struct platform_device *dev,
 	port->mapbase = res->start;
 	sci_port->reg_size = resource_size(res);
 
-	for (i = 0; i < ARRAY_SIZE(sci_port->irqs); ++i)
-		sci_port->irqs[i] = platform_get_irq(dev, i);
+	for (i = 0; i < ARRAY_SIZE(sci_port->irqs); ++i) {
+		if (i)
+			sci_port->irqs[i] = platform_get_irq_optional(dev, i);
+		else
+			sci_port->irqs[i] = platform_get_irq(dev, i);
+	}
 
 	/* The SCI generates several interrupts. They can be muxed together or
 	 * connected to different interrupt lines. In the muxed case only one
-- 
2.17.1
