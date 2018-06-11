From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: [PATCH v2 22/24] serdev: Replace IDA functions with IDR
Date: Mon, 11 Jun 2018 13:52:38 +0200
Message-ID: <20180611115240.32606-23-ricardo.ribalda@gmail.com>
References: <20180611115240.32606-1-ricardo.ribalda@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180611115240.32606-1-ricardo.ribalda@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>, Rob Herring <robh@kernel.org>, Johan Hovold <johan@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
List-Id: linux-serial@vger.kernel.org

IDR functions support associating an ID with a pointer. This is required
if we need to access the controllers based on their ID.

Cc: Rob Herring <robh@kernel.org>
Cc: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 drivers/tty/serdev/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
index 3084b6d10179..6b24b0a74fbf 100644
--- a/drivers/tty/serdev/core.c
+++ b/drivers/tty/serdev/core.c
@@ -17,7 +17,7 @@
 #include <linux/slab.h>
 
 static bool is_registered;
-static DEFINE_IDA(ctrl_ida);
+static DEFINE_IDR(ctrl_idr);
 
 static ssize_t modalias_show(struct device *dev,
 			     struct device_attribute *attr, char *buf)
@@ -81,7 +81,7 @@ static bool is_serdev_device(const struct device *dev)
 static void serdev_ctrl_release(struct device *dev)
 {
 	struct serdev_controller *ctrl = to_serdev_controller(dev);
-	ida_simple_remove(&ctrl_ida, ctrl->nr);
+	idr_remove(&ctrl_idr, ctrl->nr);
 	kfree(ctrl);
 }
 
@@ -500,7 +500,7 @@ struct serdev_controller *serdev_controller_alloc(struct device *parent,
 	if (!ctrl)
 		return NULL;
 
-	id = ida_simple_get(&ctrl_ida, 0, 0, GFP_KERNEL);
+	id = idr_alloc(&ctrl_idr, ctrl, 0, 0, GFP_KERNEL);
 	if (id < 0) {
 		dev_err(parent,
 			"unable to allocate serdev controller identifier.\n");
-- 
2.17.1
