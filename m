From: Rob Herring <robh@kernel.org>
Subject: [PATCH] tty: serdev: fix serdev_device_write return value
Date: Mon,  1 May 2017 19:17:14 -0500
Message-ID: <20170502001714.11576-1-robh@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Andrey Smirnov <andrew.smirnov@gmail.com>
List-Id: linux-serial@vger.kernel.org

Commit 6fe729c4bdae ("serdev: Add serdev_device_write subroutine")
provides a compatibility wrapper for the existing
serdev_device_write_buf, but it fails to return the number of bytes
written causing users to timeout.

Fixes: 6fe729c4bdae ("serdev: Add serdev_device_write subroutine")
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/tty/serdev/core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
index 433de5ea9b02..ccfe56355c4f 100644
--- a/drivers/tty/serdev/core.c
+++ b/drivers/tty/serdev/core.c
@@ -127,7 +127,7 @@ int serdev_device_write(struct serdev_device *serdev,
 			unsigned long timeout)
 {
 	struct serdev_controller *ctrl = serdev->ctrl;
-	int ret;
+	int ret, wr_cnt = 0;
 
 	if (!ctrl || !ctrl->ops->write_buf ||
 	    (timeout && !serdev->ops->write_wakeup))
@@ -143,12 +143,13 @@ int serdev_device_write(struct serdev_device *serdev,
 
 		buf += ret;
 		count -= ret;
+		wr_cnt += ret;
 
 	} while (count &&
 		 (timeout = wait_for_completion_timeout(&serdev->write_comp,
 							timeout)));
 	mutex_unlock(&serdev->write_lock);
-	return ret < 0 ? ret : (count ? -ETIMEDOUT : 0);
+	return ret < 0 ? ret : (count ? -ETIMEDOUT : wr_cnt);
 }
 EXPORT_SYMBOL_GPL(serdev_device_write);
 
-- 
2.11.0
