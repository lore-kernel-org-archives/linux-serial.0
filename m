From: Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: [PATCH] linux/serdev.h: Replace 'ctrl->serdev' with 'serdev'
Date: Thu, 16 Mar 2017 08:14:16 -0700
Message-ID: <20170316151416.12114-1-andrew.smirnov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, Rob Herring <robh@kernel.org>, cphealy@gmail.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Replace 'ctrl->serdev' with 'serdev' in serdev_controller_write_wakeup()
and serdev_controller_receive_buf().

Cc: Rob Herring <robh@kernel.org>
Cc: cphealy@gmail.com
Cc: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 include/linux/serdev.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/serdev.h b/include/linux/serdev.h
index 9519da6..5176cdc 100644
--- a/include/linux/serdev.h
+++ b/include/linux/serdev.h
@@ -165,7 +165,7 @@ static inline void serdev_controller_write_wakeup(struct serdev_controller *ctrl
 	if (!serdev || !serdev->ops->write_wakeup)
 		return;
 
-	serdev->ops->write_wakeup(ctrl->serdev);
+	serdev->ops->write_wakeup(serdev);
 }
 
 static inline int serdev_controller_receive_buf(struct serdev_controller *ctrl,
@@ -177,7 +177,7 @@ static inline int serdev_controller_receive_buf(struct serdev_controller *ctrl,
 	if (!serdev || !serdev->ops->receive_buf)
 		return -EINVAL;
 
-	return serdev->ops->receive_buf(ctrl->serdev, data, count);
+	return serdev->ops->receive_buf(serdev, data, count);
 }
 
 #if IS_ENABLED(CONFIG_SERIAL_DEV_BUS)
-- 
2.9.3
