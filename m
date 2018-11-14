From: Johan Hovold <johan@kernel.org>
Subject: [PATCH 1/4] serdev: use zero to indicate infinite write timeout
Date: Wed, 14 Nov 2018 16:09:01 +0100
Message-ID: <20181114150904.19653-2-johan@kernel.org>
References: <20181114150904.19653-1-johan@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181114150904.19653-1-johan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Johan Hovold <johan@kernel.org>, Andrey Smirnov <andrew.smirnov@gmail.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Use zero to indicate infinite timeout for the synchronous
serdev_device_write() helper.

This allows drivers to specify an infinite timeout without knowing about
serdev implementation details, while also allowing the same timeout
argument to be used for both serdev_device_write() and
serdev_device_wait_until_sent().

Note that passing zero to the current helper makes no sense; just call
the asynchronous serdev_device_write_buf() directly instead.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/tty/serdev/core.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
index 9db93f500b4e..c7d637d2bc56 100644
--- a/drivers/tty/serdev/core.c
+++ b/drivers/tty/serdev/core.c
@@ -15,6 +15,7 @@
 #include <linux/of_device.h>
 #include <linux/pm_domain.h>
 #include <linux/pm_runtime.h>
+#include <linux/sched.h>
 #include <linux/serdev.h>
 #include <linux/slab.h>
 
@@ -235,10 +236,12 @@ int serdev_device_write(struct serdev_device *serdev,
 	struct serdev_controller *ctrl = serdev->ctrl;
 	int ret;
 
-	if (!ctrl || !ctrl->ops->write_buf ||
-	    (timeout && !serdev->ops->write_wakeup))
+	if (!ctrl || !ctrl->ops->write_buf || !serdev->ops->write_wakeup)
 		return -EINVAL;
 
+	if (timeout == 0)
+		timeout = MAX_SCHEDULE_TIMEOUT;
+
 	mutex_lock(&serdev->write_lock);
 	do {
 		reinit_completion(&serdev->write_comp);
-- 
2.19.1
