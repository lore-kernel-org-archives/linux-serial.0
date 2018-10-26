From: Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH 5/9] mailbox: tegra-hsp: Add suspend/resume support
Date: Fri, 26 Oct 2018 13:16:34 +0200
Message-ID: <20181026111638.10759-6-thierry.reding@gmail.com>
References: <20181026111638.10759-1-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181026111638.10759-1-thierry.reding@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Jassi Brar <jassisinghbrar@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>, Mikko Perttunen <mperttunen@nvidia.com>, Jon Hunter <jonathanh@nvidia.com>, Timo Alho <talho@nvidia.com>, Pekka Pessi <ppessi@nvidia.com>, Mika Liljeberg <mliljeberg@nvidia.com>, linux-tegra@vger.kernel.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Upon resuming from a system sleep state, the interrupts for all active
shared mailboxes need to be reenabled, otherwise they will not work.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/mailbox/tegra-hsp.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/mailbox/tegra-hsp.c b/drivers/mailbox/tegra-hsp.c
index d070c8e38375..043f7173af8f 100644
--- a/drivers/mailbox/tegra-hsp.c
+++ b/drivers/mailbox/tegra-hsp.c
@@ -18,6 +18,7 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
+#include <linux/pm.h>
 #include <linux/slab.h>
 
 #include <dt-bindings/mailbox/tegra186-hsp.h>
@@ -802,6 +803,23 @@ static int tegra_hsp_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static int tegra_hsp_resume(struct device *dev)
+{
+	struct tegra_hsp *hsp = dev_get_drvdata(dev);
+	unsigned int i;
+
+	for (i = 0; i < hsp->num_sm; i++) {
+		struct tegra_hsp_mailbox *mb = &hsp->mailboxes[i];
+
+		if (mb->channel.chan->cl)
+			tegra_hsp_mailbox_startup(mb->channel.chan);
+	}
+
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(tegra_hsp_pm_ops, NULL, tegra_hsp_resume);
+
 static const struct tegra_hsp_db_map tegra186_hsp_db_map[] = {
 	{ "ccplex", TEGRA_HSP_DB_MASTER_CCPLEX, HSP_DB_CCPLEX, },
 	{ "bpmp",   TEGRA_HSP_DB_MASTER_BPMP,   HSP_DB_BPMP,   },
@@ -821,6 +839,7 @@ static struct platform_driver tegra_hsp_driver = {
 	.driver = {
 		.name = "tegra-hsp",
 		.of_match_table = tegra_hsp_match,
+		.pm = &tegra_hsp_pm_ops,
 	},
 	.probe = tegra_hsp_probe,
 	.remove = tegra_hsp_remove,
-- 
2.19.1
