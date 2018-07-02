From: Mikko Perttunen <mperttunen@nvidia.com>
Subject: [PATCH v3 3/8] mailbox: Add transmit done by blocking option
Date: Mon, 2 Jul 2018 14:40:28 +0300
Message-ID: <20180702114033.15654-4-mperttunen@nvidia.com>
References: <20180702114033.15654-1-mperttunen@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180702114033.15654-1-mperttunen@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jassisinghbrar@gmail.com, gregkh@linuxfoundation.org, thierry.reding@gmail.com, jonathanh@nvidia.com
Cc: devicetree@vger.kernel.org, linux-serial@vger.kernel.org, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Mikko Perttunen <mperttunen@nvidia.com>
List-Id: linux-serial@vger.kernel.org

Add a new TXDONE option, TXDONE_BY_BLOCK. With this option, the
send_data function of the mailbox driver is expected to block until
the message has been sent. The new option is used with the Tegra
Combined UART driver to minimize unnecessary overhead when transmitting
data.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/mailbox/mailbox.c | 30 +++++++++++++++++++++---------
 drivers/mailbox/mailbox.h |  1 +
 2 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
index 674b35f402f5..5c76b70e673c 100644
--- a/drivers/mailbox/mailbox.c
+++ b/drivers/mailbox/mailbox.c
@@ -53,6 +53,8 @@ static int add_to_rbuf(struct mbox_chan *chan, void *mssg)
 	return idx;
 }
 
+static void tx_tick(struct mbox_chan *chan, int r, bool submit_next);
+
 static void msg_submit(struct mbox_chan *chan)
 {
 	unsigned count, idx;
@@ -60,10 +62,13 @@ static void msg_submit(struct mbox_chan *chan)
 	void *data;
 	int err = -EBUSY;
 
+next:
 	spin_lock_irqsave(&chan->lock, flags);
 
-	if (!chan->msg_count || chan->active_req)
-		goto exit;
+	if (!chan->msg_count || chan->active_req) {
+		spin_unlock_irqrestore(&chan->lock, flags);
+		return;
+	}
 
 	count = chan->msg_count;
 	idx = chan->msg_free;
@@ -82,15 +87,21 @@ static void msg_submit(struct mbox_chan *chan)
 		chan->active_req = data;
 		chan->msg_count--;
 	}
-exit:
+
 	spin_unlock_irqrestore(&chan->lock, flags);
 
 	if (!err && (chan->txdone_method & TXDONE_BY_POLL))
 		/* kick start the timer immediately to avoid delays */
 		hrtimer_start(&chan->mbox->poll_hrt, 0, HRTIMER_MODE_REL);
+
+	if (chan->txdone_method & TXDONE_BY_BLOCK) {
+		tx_tick(chan, err, false);
+		if (!err)
+			goto next;
+	}
 }
 
-static void tx_tick(struct mbox_chan *chan, int r)
+static void tx_tick(struct mbox_chan *chan, int r, bool submit_next)
 {
 	unsigned long flags;
 	void *mssg;
@@ -101,7 +112,8 @@ static void tx_tick(struct mbox_chan *chan, int r)
 	spin_unlock_irqrestore(&chan->lock, flags);
 
 	/* Submit next message */
-	msg_submit(chan);
+	if (submit_next)
+		msg_submit(chan);
 
 	if (!mssg)
 		return;
@@ -127,7 +139,7 @@ static enum hrtimer_restart txdone_hrtimer(struct hrtimer *hrtimer)
 		if (chan->active_req && chan->cl) {
 			txdone = chan->mbox->ops->last_tx_done(chan);
 			if (txdone)
-				tx_tick(chan, 0);
+				tx_tick(chan, 0, true);
 			else
 				resched = true;
 		}
@@ -176,7 +188,7 @@ void mbox_chan_txdone(struct mbox_chan *chan, int r)
 		return;
 	}
 
-	tx_tick(chan, r);
+	tx_tick(chan, r, true);
 }
 EXPORT_SYMBOL_GPL(mbox_chan_txdone);
 
@@ -196,7 +208,7 @@ void mbox_client_txdone(struct mbox_chan *chan, int r)
 		return;
 	}
 
-	tx_tick(chan, r);
+	tx_tick(chan, r, true);
 }
 EXPORT_SYMBOL_GPL(mbox_client_txdone);
 
@@ -275,7 +287,7 @@ int mbox_send_message(struct mbox_chan *chan, void *mssg)
 		ret = wait_for_completion_timeout(&chan->tx_complete, wait);
 		if (ret == 0) {
 			t = -ETIME;
-			tx_tick(chan, t);
+			tx_tick(chan, t, true);
 		}
 	}
 
diff --git a/drivers/mailbox/mailbox.h b/drivers/mailbox/mailbox.h
index 456ba68513bb..ec68e2e28cd6 100644
--- a/drivers/mailbox/mailbox.h
+++ b/drivers/mailbox/mailbox.h
@@ -10,5 +10,6 @@
 #define TXDONE_BY_IRQ	BIT(0) /* controller has remote RTR irq */
 #define TXDONE_BY_POLL	BIT(1) /* controller can read status of last TX */
 #define TXDONE_BY_ACK	BIT(2) /* S/W ACK recevied by Client ticks the TX */
+#define TXDONE_BY_BLOCK	BIT(3) /* mailbox driver send_data blocks until done */
 
 #endif /* __MAILBOX_H */
-- 
2.16.1
