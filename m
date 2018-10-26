From: Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH 2/9] mailbox: Allow multiple controllers per device
Date: Fri, 26 Oct 2018 13:16:31 +0200
Message-ID: <20181026111638.10759-3-thierry.reding@gmail.com>
References: <20181026111638.10759-1-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181026111638.10759-1-thierry.reding@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Jassi Brar <jassisinghbrar@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>, Mikko Perttunen <mperttunen@nvidia.com>, Jon Hunter <jonathanh@nvidia.com>, Timo Alho <talho@nvidia.com>, Pekka Pessi <ppessi@nvidia.com>, Mika Liljeberg <mliljeberg@nvidia.com>, linux-tegra@vger.kernel.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

From: Mikko Perttunen <mperttunen@nvidia.com>

Look through the whole controller list when mapping device tree
phandles to controllers instead of stopping at the first one.

Each controller is intended to only contain one kind of mailbox,
but some devices (like Tegra HSP) implement multiple kinds and use
the same device tree node for all of them. As such, we need to allow
multiple mbox_controllers per device tree node.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/mailbox/mailbox.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
index 0eaf21259874..f34820bcf33c 100644
--- a/drivers/mailbox/mailbox.c
+++ b/drivers/mailbox/mailbox.c
@@ -335,7 +335,8 @@ struct mbox_chan *mbox_request_channel(struct mbox_client *cl, int index)
 	list_for_each_entry(mbox, &mbox_cons, node)
 		if (mbox->dev->of_node == spec.np) {
 			chan = mbox->of_xlate(mbox, &spec);
-			break;
+			if (!IS_ERR(chan))
+				break;
 		}
 
 	of_node_put(spec.np);
-- 
2.19.1
