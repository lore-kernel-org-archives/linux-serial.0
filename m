From: Johan Hovold <johan@kernel.org>
Subject: [PATCH 3/8] serdev: document driver callbacks
Date: Fri,  3 Nov 2017 15:30:54 +0100
Message-ID: <20171103143059.20749-4-johan@kernel.org>
References: <20171103143059.20749-1-johan@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171103143059.20749-1-johan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
List-Id: linux-serial@vger.kernel.org

Amend the driver-callback kerneldoc with calling context and expected
return values.

Note that this is based on the requirements and characteristics of the
tty-port controller implementation which receives data in workqueue
context and whose write_wakeup callback must not sleep.

Also note that while the receive_buf callback returns an integer, the
returned value is still expected to be non-negative (and no greater than
the buffer-size argument).

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 include/linux/serdev.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/serdev.h b/include/linux/serdev.h
index d609e6dc5bad..98b5f7978dac 100644
--- a/include/linux/serdev.h
+++ b/include/linux/serdev.h
@@ -27,8 +27,10 @@ struct serdev_device;
 
 /**
  * struct serdev_device_ops - Callback operations for a serdev device
- * @receive_buf:	Function called with data received from device.
- * @write_wakeup:	Function called when ready to transmit more data.
+ * @receive_buf:	Function called with data received from device;
+ *			returns number of bytes accepted; may sleep.
+ * @write_wakeup:	Function called when ready to transmit more data; must
+ *			not sleep.
  */
 struct serdev_device_ops {
 	int (*receive_buf)(struct serdev_device *, const unsigned char *, size_t);
-- 
2.15.0
