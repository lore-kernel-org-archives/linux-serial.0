From: Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH v2 01/10] mailbox: Support blocking transfers in atomic context
Date: Mon, 12 Nov 2018 16:18:44 +0100
Message-ID: <20181112151853.29289-2-thierry.reding@gmail.com>
References: <20181112151853.29289-1-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20181112151853.29289-1-thierry.reding@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Thierry Reding <thierry.reding@gmail.com>, Jassi Brar <jassisinghbrar@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: devicetree@vger.kernel.org, Mika Liljeberg <mliljeberg@nvidia.com>, Mikko Perttunen <mperttunen@nvidia.com>, Timo Alho <talho@nvidia.com>, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, linux-tegra@vger.kernel.org, Pekka Pessi <ppessi@nvidia.com>, Jon Hunter <jonathanh@nvidia.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

The mailbox framework supports blocking transfers via completions for
clients that can sleep. In order to support blocking transfers in cases
where the transmission is not permitted to sleep, add a new ->flush()
callback that controller drivers can implement to busy loop until the
transmission has been completed. This will automatically be called when
available and interrupts are disabled for clients that request blocking
transfers.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/mailbox/mailbox.c          | 8 ++++++++
 include/linux/mailbox_controller.h | 4 ++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
index 674b35f402f5..0eaf21259874 100644
--- a/drivers/mailbox/mailbox.c
+++ b/drivers/mailbox/mailbox.c
@@ -267,6 +267,14 @@ int mbox_send_message(struct mbox_chan *chan, void *mssg)
 		unsigned long wait;
 		int ret;
 
+		if (irqs_disabled() && chan->mbox->ops->flush) {
+			ret = chan->mbox->ops->flush(chan, chan->cl->tx_tout);
+			if (ret < 0)
+				tx_tick(chan, ret);
+
+			return ret;
+		}
+
 		if (!chan->cl->tx_tout) /* wait forever */
 			wait = msecs_to_jiffies(3600000);
 		else
diff --git a/include/linux/mailbox_controller.h b/include/linux/mailbox_controller.h
index 74deadb42d76..2a07d93f781a 100644
--- a/include/linux/mailbox_controller.h
+++ b/include/linux/mailbox_controller.h
@@ -24,6 +24,9 @@ struct mbox_chan;
  *		transmission of data is reported by the controller via
  *		mbox_chan_txdone (if it has some TX ACK irq). It must not
  *		sleep.
+ * @flush:	Called when a client requests transmissions to be blocking but
+ *		the context doesn't allow sleeping. Typically the controller
+ *		will implement a busy loop waiting for the data to flush out.
  * @startup:	Called when a client requests the chan. The controller
  *		could ask clients for additional parameters of communication
  *		to be provided via client's chan_data. This call may
@@ -46,6 +49,7 @@ struct mbox_chan;
  */
 struct mbox_chan_ops {
 	int (*send_data)(struct mbox_chan *chan, void *data);
+	int (*flush)(struct mbox_chan *chan, unsigned long timeout);
 	int (*startup)(struct mbox_chan *chan);
 	void (*shutdown)(struct mbox_chan *chan);
 	bool (*last_tx_done)(struct mbox_chan *chan);
-- 
2.19.1
