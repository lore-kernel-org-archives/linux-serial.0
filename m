From: Sean Nyekjaer <sean.nyekjaer@prevas.dk>
Subject: [PATCH] tty: serial: sc16is7xx: implemented our own oneshot-like handling
Date: Fri, 11 Mar 2016 11:34:36 +0100
Message-ID: <1457692476-19082-1-git-send-email-sean.nyekjaer@prevas.dk>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-rt-users-owner@vger.kernel.org>
In-Reply-To: 56E01140.70407@linutronix.de
Sender: linux-rt-users-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Sean Nyekjaer <sean.nyekjaer@prevas.dk>, Josh Cartwright <joshc@ni.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-rt-users@vger.kernel.org, Jon Ringle <jringle@gridpoint.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-serial@vger.kernel.org

Signed-off-by: Sean Nyekjaer <sean.nyekjaer@prevas.dk>
---
This patch depends on patch "sc16is7xx: drop bogus use of IRQF_ONESHOT" 

 drivers/tty/serial/sc16is7xx.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 73d46e2..96d1f3e 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -706,13 +706,20 @@ static void sc16is7xx_ist(struct kthread_work *ws)
 	struct sc16is7xx_port *s = to_sc16is7xx_port(ws, irq_work);
 	int i;
 
-	for (i = 0; i < s->devtype->nr_uart; ++i)
+	for (i = 0; i < s->devtype->nr_uart; ++i) {
 		sc16is7xx_port_irq(s, i);
+		enable_irq(s->p[i].port.irq);
+	}
+
 }
 
 static irqreturn_t sc16is7xx_irq(int irq, void *dev_id)
 {
 	struct sc16is7xx_port *s = (struct sc16is7xx_port *)dev_id;
+	int i;
+
+	for (i = 0; i < s->devtype->nr_uart; ++i)
+		disable_irq_nosync(s->p[i].port.irq);
 
 	queue_kthread_work(&s->kworker, &s->irq_work);
 
-- 
2.7.2

