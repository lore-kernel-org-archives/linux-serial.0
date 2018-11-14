From: Johan Hovold <johan@kernel.org>
Subject: [PATCH 4/4] serdev: document the write functions using kernel-doc
Date: Wed, 14 Nov 2018 16:09:04 +0100
Message-ID: <20181114150904.19653-5-johan@kernel.org>
References: <20181114150904.19653-1-johan@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181114150904.19653-1-johan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Johan Hovold <johan@kernel.org>, Andrey Smirnov <andrew.smirnov@gmail.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Document the asynchronous serdev_device_write_buf() and synchronous
serdev_device_write() functions using kernel-doc.

Specifically, mention that writing data only means that data has been
buffered by the controller, and that the synchronous helper depends on
serdev_device_write_wakeup() being called in the driver write_wakeup()
callback.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/tty/serdev/core.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
index c7006bbb793a..a0ac16ee6575 100644
--- a/drivers/tty/serdev/core.c
+++ b/drivers/tty/serdev/core.c
@@ -217,6 +217,21 @@ void serdev_device_write_wakeup(struct serdev_device *serdev)
 }
 EXPORT_SYMBOL_GPL(serdev_device_write_wakeup);
 
+/**
+ * serdev_device_write_buf() - write data asynchronously
+ * @serdev:	serdev device
+ * @buf:	data to be written
+ * @count:	number of bytes to write
+ *
+ * Write data to the device asynchronously.
+ *
+ * Note that any accepted data has only been buffered by the controller; use
+ * serdev_device_wait_until_sent() to make sure the controller write buffer
+ * has actually been emptied.
+ *
+ * Return: The number of bytes written (less than count if not enough room in
+ * the write buffer), or a negative errno on errors.
+ */
 int serdev_device_write_buf(struct serdev_device *serdev,
 			    const unsigned char *buf, size_t count)
 {
@@ -229,6 +244,28 @@ int serdev_device_write_buf(struct serdev_device *serdev,
 }
 EXPORT_SYMBOL_GPL(serdev_device_write_buf);
 
+/**
+ * serdev_device_write() - write data synchronously
+ * @serdev:	serdev device
+ * @buf:	data to be written
+ * @count:	number of bytes to write
+ * @timeout:	timeout in jiffies, or 0 to wait indefinitely
+ *
+ * Write data to the device synchronously by repeatedly calling
+ * serdev_device_write() until the controller has accepted all data (unless
+ * interrupted by a timeout or a signal).
+ *
+ * Note that any accepted data has only been buffered by the controller; use
+ * serdev_device_wait_until_sent() to make sure the controller write buffer
+ * has actually been emptied.
+ *
+ * Note that this function depends on serdev_device_write_wakeup() being
+ * called in the serdev driver write_wakeup() callback.
+ *
+ * Return: The number of bytes written (less than count if interrupted),
+ * -ETIMEDOUT or -ERESTARTSYS if interrupted before any bytes were written, or
+ * a negative errno on errors.
+ */
 int serdev_device_write(struct serdev_device *serdev,
 			const unsigned char *buf, size_t count,
 			long timeout)
-- 
2.19.1
