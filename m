From: Serge Semin <fancer.lancer@gmail.com>
Subject: [PATCH 1/7] tty: max310x: Simplify tx-work item code
Date: Tue, 14 May 2019 13:14:09 +0300
Message-ID: <20190514101415.26754-2-fancer.lancer@gmail.com>
References: <20190514101415.26754-1-fancer.lancer@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190514101415.26754-1-fancer.lancer@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Serge Semin <Sergey.Semin@t-platforms.ru>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Since cmwq introduction in the kernel, workqueues've been turned into
non-reentrant execution contexts [1]. It means any work item is
guaranteed to be executed by at most one worker system-wide at any
given time. Since tx-handler max310x_handle_tx() is called by a
single work item we don't need it to be self-protected by the mutex.
We also don't need to check the tx work item pending state before
scheduling it (which in the first place was racy btw), since cmwq will
make sure to reschedule the item if it wasn't pending at the moment of
schedule_work() call.

[1] Documentation/core-api/workqueue.rst

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/tty/serial/max310x.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 450ba6d7996c..4ee805862b68 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -263,7 +263,6 @@ struct max310x_one {
 struct max310x_port {
 	struct max310x_devtype	*devtype;
 	struct regmap		*regmap;
-	struct mutex		mutex;
 	struct clk		*clk;
 #ifdef CONFIG_GPIOLIB
 	struct gpio_chip	gpio;
@@ -768,8 +767,7 @@ static void max310x_start_tx(struct uart_port *port)
 {
 	struct max310x_one *one = container_of(port, struct max310x_one, port);
 
-	if (!work_pending(&one->tx_work))
-		schedule_work(&one->tx_work);
+	schedule_work(&one->tx_work);
 }
 
 static irqreturn_t max310x_port_irq(struct max310x_port *s, int portno)
@@ -826,14 +824,11 @@ static irqreturn_t max310x_ist(int irq, void *dev_id)
 	return IRQ_RETVAL(handled);
 }
 
-static void max310x_wq_proc(struct work_struct *ws)
+static void max310x_tx_proc(struct work_struct *ws)
 {
 	struct max310x_one *one = container_of(ws, struct max310x_one, tx_work);
-	struct max310x_port *s = dev_get_drvdata(one->port.dev);
 
-	mutex_lock(&s->mutex);
 	max310x_handle_tx(&one->port);
-	mutex_unlock(&s->mutex);
 }
 
 static unsigned int max310x_tx_empty(struct uart_port *port)
@@ -1269,8 +1264,6 @@ static int max310x_probe(struct device *dev, struct max310x_devtype *devtype,
 	uartclk = max310x_set_ref_clk(dev, s, freq, xtal);
 	dev_dbg(dev, "Reference clock set to %i Hz\n", uartclk);
 
-	mutex_init(&s->mutex);
-
 	for (i = 0; i < devtype->nr; i++) {
 		unsigned int line;
 
@@ -1298,7 +1291,7 @@ static int max310x_probe(struct device *dev, struct max310x_devtype *devtype,
 		/* Clear IRQ status register */
 		max310x_port_read(&s->p[i].port, MAX310X_IRQSTS_REG);
 		/* Initialize queue for start TX */
-		INIT_WORK(&s->p[i].tx_work, max310x_wq_proc);
+		INIT_WORK(&s->p[i].tx_work, max310x_tx_proc);
 		/* Initialize queue for changing LOOPBACK mode */
 		INIT_WORK(&s->p[i].md_work, max310x_md_proc);
 		/* Initialize queue for changing RS485 mode */
@@ -1350,8 +1343,6 @@ static int max310x_probe(struct device *dev, struct max310x_devtype *devtype,
 		}
 	}
 
-	mutex_destroy(&s->mutex);
-
 out_clk:
 	clk_disable_unprepare(s->clk);
 
@@ -1372,7 +1363,6 @@ static int max310x_remove(struct device *dev)
 		s->devtype->power(&s->p[i].port, 0);
 	}
 
-	mutex_destroy(&s->mutex);
 	clk_disable_unprepare(s->clk);
 
 	return 0;
-- 
2.21.0
