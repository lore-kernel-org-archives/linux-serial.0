From: Daniel Drake <dsd@laptop.org>
Subject: [PATCH] serial8250: ratelimit "too much work" error
Date: Sat,  2 Oct 2010 12:04:38 +0100 (BST)
Message-ID: <20101002110438.801F49D401B@zog.reactivated.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Running a serial console, if too many kernel messages are generated within
a short time causing a lot of serial I/O, the 8250 driver will generate
another kernel message reporting this, which just adds to the I/O. It has
a cascading effect and quickly results the system being brought to its knees
by a flood of "too much work" messages.

Ratelimit the error message to avoid this.

Signed-off-by: Daniel Drake <dsd@laptop.org>
---
 drivers/serial/8250.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
index 24110f6..d3c5855 100644
--- a/drivers/serial/8250.c
+++ b/drivers/serial/8250.c
@@ -1606,8 +1606,9 @@ static irqreturn_t serial8250_interrupt(int irq, void *dev_id)
 
 		if (l == i->head && pass_counter++ > PASS_LIMIT) {
 			/* If we hit this, we're dead. */
-			printk(KERN_ERR "serial8250: too much work for "
-				"irq%d\n", irq);
+			if (printk_ratelimit())
+				printk(KERN_ERR "serial8250: too much work for "
+					"irq%d\n", irq);
 			break;
 		}
 	} while (l != end);
-- 
1.7.2.3
