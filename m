From: Thomas Koeller <thomas.koeller@baslerweb.com>
Subject: [PATCH] 8250 driver interrupt sharing
Date: Thu, 28 Oct 2004 13:01:58 +0200
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <200410281301.59584.thomas.koeller@baslerweb.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.baslerweb.com ([145.253.187.130]:7461 "EHLO
	mail.baslerweb.com") by vger.kernel.org with ESMTP id S262961AbUJ1K6P
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 28 Oct 2004 06:58:15 -0400
Received: (from mail@localhost)
	by mail.baslerweb.com (8.12.10/8.12.10) id i9SAw3ls014517
	for <linux-serial@vger.kernel.org>; Thu, 28 Oct 2004 12:58:03 +0200
Content-Disposition: inline
List-Id: linux-serial@vger.kernel.org
To: rmk+serial@arm.linux.org.uk
Cc: linux-serial@vger.kernel.org

Hi,

here is a little patch that causes the driver to no longer pretend having
handled an interrupt if none of the ports actually interrupted. I am currently
doing a port to a platform where I want (actually, have) to share a single
interrupt between serial ports and other devices. The patch is against kernel
version 2.6.9.

tk

Signed-off-by: Thomas Koeller <thomas.koeller@baslerweb.com>

--- linux-2.6.9-old/drivers/serial/8250.c       2004-10-28 12:45:30.103541664 +0200
+++ linux-2.6.9/drivers/serial/8250.c   2004-10-28 12:48:19.009864000 +0200
@@ -1039,6 +1039,7 @@ static irqreturn_t serial8250_interrupt(
        struct irq_info *i = dev_id;
        struct list_head *l, *end = NULL;
        int pass_counter = 0;
+       irqreturn_t ret = IRQ_NONE;

        DEBUG_INTR("serial8250_interrupt(%d)...", irq);

@@ -1056,6 +1057,7 @@ static irqreturn_t serial8250_interrupt(
                        spin_lock(&up->port.lock);
                        serial8250_handle_port(up, regs);
                        spin_unlock(&up->port.lock);
+                       ret = IRQ_HANDLED;

                        end = NULL;
                } else if (end == NULL)
@@ -1074,8 +1076,7 @@ static irqreturn_t serial8250_interrupt(
        spin_unlock(&i->lock);

        DEBUG_INTR("end.\n");
-       /* FIXME! Was it really ours? */
-       return IRQ_HANDLED;
+       return ret;
 }

 /*

-- 
--------------------------------------------------

Thomas Koeller, Software Development
Basler Vision Technologies

thomas dot koeller at baslerweb dot com
http://www.baslerweb.com

==============================

