From: Mikko Perttunen <mperttunen@nvidia.com>
Subject: [PATCH v3 4/8] mailbox: tegra-hsp: Refactor in preparation of
 mailboxes
Date: Mon, 2 Jul 2018 14:40:29 +0300
Message-ID: <20180702114033.15654-5-mperttunen@nvidia.com>
References: <20180702114033.15654-1-mperttunen@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180702114033.15654-1-mperttunen@nvidia.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: jassisinghbrar@gmail.com, gregkh@linuxfoundation.org, thierry.reding@gmail.com, jonathanh@nvidia.com
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Mikko Perttunen <mperttunen@nvidia.com>, linux-serial@vger.kernel.org, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

The HSP driver is currently in many places written with the assumption
of only supporting doorbells. Prepare for the addition of shared
mailbox support by removing these assumptions and cleaning up the code.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
---

Notes:
    v2:
    - Moved fixes for some style and other issues from the next patch
      here, where they belong.
    
    v3:
    - Added Jon's Reviewed-by.

 drivers/mailbox/tegra-hsp.c | 123 +++++++++++++++++++++++++++++---------------
 1 file changed, 81 insertions(+), 42 deletions(-)

diff --git a/drivers/mailbox/tegra-hsp.c b/drivers/mailbox/tegra-hsp.c
index 0cde356c11ab..5dc21a6d01bb 100644
--- a/drivers/mailbox/tegra-hsp.c
+++ b/drivers/mailbox/tegra-hsp.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (c) 2016, NVIDIA CORPORATION.  All rights reserved.
+ * Copyright (c) 2016-2018, NVIDIA CORPORATION.  All rights reserved.
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms and conditions of the GNU General Public License,
@@ -42,6 +42,7 @@ struct tegra_hsp_channel;
 struct tegra_hsp;
 
 struct tegra_hsp_channel {
+	unsigned int type;
 	struct tegra_hsp *hsp;
 	struct mbox_chan *chan;
 	void __iomem *regs;
@@ -55,6 +56,12 @@ struct tegra_hsp_doorbell {
 	unsigned int index;
 };
 
+static inline struct tegra_hsp_doorbell *
+channel_to_doorbell(struct tegra_hsp_channel *channel)
+{
+	return container_of(channel, struct tegra_hsp_doorbell, channel);
+}
+
 struct tegra_hsp_db_map {
 	const char *name;
 	unsigned int master;
@@ -69,7 +76,7 @@ struct tegra_hsp {
 	const struct tegra_hsp_soc *soc;
 	struct mbox_controller mbox;
 	void __iomem *regs;
-	unsigned int irq;
+	unsigned int doorbell_irq;
 	unsigned int num_sm;
 	unsigned int num_as;
 	unsigned int num_ss;
@@ -194,7 +201,7 @@ tegra_hsp_doorbell_create(struct tegra_hsp *hsp, const char *name,
 	if (!db)
 		return ERR_PTR(-ENOMEM);
 
-	offset = (1 + (hsp->num_sm / 2) + hsp->num_ss + hsp->num_as) << 16;
+	offset = (1 + (hsp->num_sm / 2) + hsp->num_ss + hsp->num_as) * SZ_64K;
 	offset += index * 0x100;
 
 	db->channel.regs = hsp->regs + offset;
@@ -218,18 +225,8 @@ static void __tegra_hsp_doorbell_destroy(struct tegra_hsp_doorbell *db)
 	kfree(db);
 }
 
-static int tegra_hsp_doorbell_send_data(struct mbox_chan *chan, void *data)
-{
-	struct tegra_hsp_doorbell *db = chan->con_priv;
-
-	tegra_hsp_channel_writel(&db->channel, 1, HSP_DB_TRIGGER);
-
-	return 0;
-}
-
-static int tegra_hsp_doorbell_startup(struct mbox_chan *chan)
+static int tegra_hsp_doorbell_startup(struct tegra_hsp_doorbell *db)
 {
-	struct tegra_hsp_doorbell *db = chan->con_priv;
 	struct tegra_hsp *hsp = db->channel.hsp;
 	struct tegra_hsp_doorbell *ccplex;
 	unsigned long flags;
@@ -260,9 +257,8 @@ static int tegra_hsp_doorbell_startup(struct mbox_chan *chan)
 	return 0;
 }
 
-static void tegra_hsp_doorbell_shutdown(struct mbox_chan *chan)
+static void tegra_hsp_doorbell_shutdown(struct tegra_hsp_doorbell *db)
 {
-	struct tegra_hsp_doorbell *db = chan->con_priv;
 	struct tegra_hsp *hsp = db->channel.hsp;
 	struct tegra_hsp_doorbell *ccplex;
 	unsigned long flags;
@@ -281,35 +277,60 @@ static void tegra_hsp_doorbell_shutdown(struct mbox_chan *chan)
 	spin_unlock_irqrestore(&hsp->lock, flags);
 }
 
-static const struct mbox_chan_ops tegra_hsp_doorbell_ops = {
-	.send_data = tegra_hsp_doorbell_send_data,
-	.startup = tegra_hsp_doorbell_startup,
-	.shutdown = tegra_hsp_doorbell_shutdown,
+static int tegra_hsp_send_data(struct mbox_chan *chan, void *data)
+{
+	struct tegra_hsp_channel *channel = chan->con_priv;
+
+	switch (channel->type) {
+	case TEGRA_HSP_MBOX_TYPE_DB:
+		tegra_hsp_channel_writel(channel, 1, HSP_DB_TRIGGER);
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+static int tegra_hsp_startup(struct mbox_chan *chan)
+{
+	struct tegra_hsp_channel *channel = chan->con_priv;
+
+	switch (channel->type) {
+	case TEGRA_HSP_MBOX_TYPE_DB:
+		return tegra_hsp_doorbell_startup(channel_to_doorbell(channel));
+	}
+
+	return -EINVAL;
+}
+
+static void tegra_hsp_shutdown(struct mbox_chan *chan)
+{
+	struct tegra_hsp_channel *channel = chan->con_priv;
+
+	switch (channel->type) {
+	case TEGRA_HSP_MBOX_TYPE_DB:
+		tegra_hsp_doorbell_shutdown(channel_to_doorbell(channel));
+		break;
+	}
+}
+
+static const struct mbox_chan_ops tegra_hsp_ops = {
+	.send_data = tegra_hsp_send_data,
+	.startup = tegra_hsp_startup,
+	.shutdown = tegra_hsp_shutdown,
 };
 
-static struct mbox_chan *of_tegra_hsp_xlate(struct mbox_controller *mbox,
-					    const struct of_phandle_args *args)
+static struct mbox_chan *tegra_hsp_doorbell_xlate(struct tegra_hsp *hsp,
+						  unsigned int master)
 {
 	struct tegra_hsp_channel *channel = ERR_PTR(-ENODEV);
-	struct tegra_hsp *hsp = to_tegra_hsp(mbox);
-	unsigned int type = args->args[0];
-	unsigned int master = args->args[1];
 	struct tegra_hsp_doorbell *db;
 	struct mbox_chan *chan;
 	unsigned long flags;
 	unsigned int i;
 
-	switch (type) {
-	case TEGRA_HSP_MBOX_TYPE_DB:
-		db = tegra_hsp_doorbell_get(hsp, master);
-		if (db)
-			channel = &db->channel;
-
-		break;
-
-	default:
-		break;
-	}
+	db = tegra_hsp_doorbell_get(hsp, master);
+	if (db)
+		channel = &db->channel;
 
 	if (IS_ERR(channel))
 		return ERR_CAST(channel);
@@ -321,6 +342,7 @@ static struct mbox_chan *of_tegra_hsp_xlate(struct mbox_controller *mbox,
 		if (!chan->con_priv) {
 			chan->con_priv = channel;
 			channel->chan = chan;
+			channel->type = TEGRA_HSP_MBOX_TYPE_DB;
 			break;
 		}
 
@@ -332,6 +354,22 @@ static struct mbox_chan *of_tegra_hsp_xlate(struct mbox_controller *mbox,
 	return chan ?: ERR_PTR(-EBUSY);
 }
 
+static struct mbox_chan *of_tegra_hsp_xlate(struct mbox_controller *mbox,
+					    const struct of_phandle_args *args)
+{
+	struct tegra_hsp *hsp = to_tegra_hsp(mbox);
+	unsigned int type = args->args[0];
+	unsigned int param = args->args[1];
+
+	switch (type) {
+	case TEGRA_HSP_MBOX_TYPE_DB:
+		return tegra_hsp_doorbell_xlate(hsp, param);
+
+	default:
+		return ERR_PTR(-EINVAL);
+	}
+}
+
 static void tegra_hsp_remove_doorbells(struct tegra_hsp *hsp)
 {
 	struct tegra_hsp_doorbell *db, *tmp;
@@ -397,14 +435,14 @@ static int tegra_hsp_probe(struct platform_device *pdev)
 		return err;
 	}
 
-	hsp->irq = err;
+	hsp->doorbell_irq = err;
 
 	hsp->mbox.of_xlate = of_tegra_hsp_xlate;
 	hsp->mbox.num_chans = 32;
 	hsp->mbox.dev = &pdev->dev;
 	hsp->mbox.txdone_irq = false;
 	hsp->mbox.txdone_poll = false;
-	hsp->mbox.ops = &tegra_hsp_doorbell_ops;
+	hsp->mbox.ops = &tegra_hsp_ops;
 
 	hsp->mbox.chans = devm_kcalloc(&pdev->dev, hsp->mbox.num_chans,
 					sizeof(*hsp->mbox.chans),
@@ -427,11 +465,12 @@ static int tegra_hsp_probe(struct platform_device *pdev)
 		return err;
 	}
 
-	err = devm_request_irq(&pdev->dev, hsp->irq, tegra_hsp_doorbell_irq,
-			       IRQF_NO_SUSPEND, dev_name(&pdev->dev), hsp);
+	err = devm_request_irq(&pdev->dev, hsp->doorbell_irq,
+			       tegra_hsp_doorbell_irq, IRQF_NO_SUSPEND,
+			       dev_name(&pdev->dev), hsp);
 	if (err < 0) {
-		dev_err(&pdev->dev, "failed to request IRQ#%u: %d\n",
-			hsp->irq, err);
+		dev_err(&pdev->dev, "failed to request doorbell IRQ#%u: %d\n",
+			hsp->doorbell_irq, err);
 		return err;
 	}
 
-- 
2.16.1
