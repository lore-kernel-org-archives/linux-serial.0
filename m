From: Johan Hovold <johan@kernel.org>
Subject: [PATCH 2/8] serdev: fix receive_buf return value when no callback
Date: Fri,  3 Nov 2017 15:30:53 +0100
Message-ID: <20171103143059.20749-3-johan@kernel.org>
References: <20171103143059.20749-1-johan@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171103143059.20749-1-johan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
List-Id: linux-serial@vger.kernel.org

The receive_buf callback is supposed to return the number of bytes
processed and should specifically not return a negative errno.

Due to missing sanity checks in the serdev tty-port controller, a driver
not providing a receive_buf callback could cause the flush_to_ldisc()
worker to spin in a tight loop when the tty buffer pointers are
incremented with -EINVAL (-22).

The missing sanity checks have now been added to the tty-port
controller, but let's fix up the serdev-controller helper as well.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 include/linux/serdev.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/serdev.h b/include/linux/serdev.h
index e69402d4a8ae..d609e6dc5bad 100644
--- a/include/linux/serdev.h
+++ b/include/linux/serdev.h
@@ -184,7 +184,7 @@ static inline int serdev_controller_receive_buf(struct serdev_controller *ctrl,
 	struct serdev_device *serdev = ctrl->serdev;
 
 	if (!serdev || !serdev->ops->receive_buf)
-		return -EINVAL;
+		return 0;
 
 	return serdev->ops->receive_buf(serdev, data, count);
 }
-- 
2.15.0
