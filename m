From: Pan Bian <bianpan2016@163.com>
Subject: [PATCH 1/1] tty: serial: set error code when kasprintf fails
Date: Sat,  3 Dec 2016 18:40:25 +0800
Message-ID: <1480761625-4773-1-git-send-email-bianpan2016@163.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Pan Bian <bianpan2016@163.com>
List-Id: linux-serial@vger.kernel.org

When the call to kasprintf() returns a NULL pointer, function
sci_request_irq() frees the preallocated memory and returns 0 is
returned. Because 0 means no error, the caller of sci_request_irq()
will keep going, and the freed memory may be used or freed again. To
avoid the above issue, this patch assigns "-ENOMEM" to the return
variable ret.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=188691

Signed-off-by: Pan Bian <bianpan2016@163.com>
---
 drivers/tty/serial/sh-sci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 4b26252..69471bf 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1753,8 +1753,10 @@ static int sci_request_irq(struct sci_port *port)
 		desc = sci_irq_desc + i;
 		port->irqstr[j] = kasprintf(GFP_KERNEL, "%s:%s",
 					    dev_name(up->dev), desc->desc);
-		if (!port->irqstr[j])
+		if (!port->irqstr[j]) {
+			ret = -ENOMEM;
 			goto out_nomem;
+		}
 
 		ret = request_irq(irq, desc->handler, up->irqflags,
 				  port->irqstr[j], port);
-- 
1.9.1
