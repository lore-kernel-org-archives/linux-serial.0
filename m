From: Johan Hovold <johan@kernel.org>
Subject: [PATCH 2/4] serdev: make synchronous write return bytes written
Date: Wed, 14 Nov 2018 16:09:02 +0100
Message-ID: <20181114150904.19653-3-johan@kernel.org>
References: <20181114150904.19653-1-johan@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181114150904.19653-1-johan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Johan Hovold <johan@kernel.org>, Andrey Smirnov <andrew.smirnov@gmail.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Make the synchronous serdev_device_write() helper behave analogous to
the asynchronous serdev_device_write_buf() by returning the number of
bytes written (or rather buffered) also on timeout.

This will allow drivers to distinguish the case where data was partially
written from the case where no data was written.

Also update the only two users that checked the return value.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/gnss/serial.c     |  2 +-
 drivers/gnss/sirf.c       |  2 +-
 drivers/tty/serdev/core.c | 12 ++++++++++--
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/gnss/serial.c b/drivers/gnss/serial.c
index 31e891f00175..def64b36d994 100644
--- a/drivers/gnss/serial.c
+++ b/drivers/gnss/serial.c
@@ -65,7 +65,7 @@ static int gnss_serial_write_raw(struct gnss_device *gdev,
 
 	/* write is only buffered synchronously */
 	ret = serdev_device_write(serdev, buf, count, MAX_SCHEDULE_TIMEOUT);
-	if (ret < 0)
+	if (ret < 0 || ret < count)
 		return ret;
 
 	/* FIXME: determine if interrupted? */
diff --git a/drivers/gnss/sirf.c b/drivers/gnss/sirf.c
index 71d014edd167..b3a4c0e91947 100644
--- a/drivers/gnss/sirf.c
+++ b/drivers/gnss/sirf.c
@@ -85,7 +85,7 @@ static int sirf_write_raw(struct gnss_device *gdev, const unsigned char *buf,
 
 	/* write is only buffered synchronously */
 	ret = serdev_device_write(serdev, buf, count, MAX_SCHEDULE_TIMEOUT);
-	if (ret < 0)
+	if (ret < 0 || ret < count)
 		return ret;
 
 	/* FIXME: determine if interrupted? */
diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
index c7d637d2bc56..ee4c40336633 100644
--- a/drivers/tty/serdev/core.c
+++ b/drivers/tty/serdev/core.c
@@ -234,6 +234,7 @@ int serdev_device_write(struct serdev_device *serdev,
 			unsigned long timeout)
 {
 	struct serdev_controller *ctrl = serdev->ctrl;
+	int written = 0;
 	int ret;
 
 	if (!ctrl || !ctrl->ops->write_buf || !serdev->ops->write_wakeup)
@@ -250,14 +251,21 @@ int serdev_device_write(struct serdev_device *serdev,
 		if (ret < 0)
 			break;
 
+		written += ret;
 		buf += ret;
 		count -= ret;
-
 	} while (count &&
 		 (timeout = wait_for_completion_timeout(&serdev->write_comp,
 							timeout)));
 	mutex_unlock(&serdev->write_lock);
-	return ret < 0 ? ret : (count ? -ETIMEDOUT : 0);
+
+	if (ret < 0)
+		return ret;
+
+	if (timeout == 0 && written == 0)
+		return -ETIMEDOUT;
+
+	return written;
 }
 EXPORT_SYMBOL_GPL(serdev_device_write);
 
-- 
2.19.1
