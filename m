From: Johan Hovold <johan@kernel.org>
Subject: [PATCH 3/4] serdev: make synchronous write helper interruptible
Date: Wed, 14 Nov 2018 16:09:03 +0100
Message-ID: <20181114150904.19653-4-johan@kernel.org>
References: <20181114150904.19653-1-johan@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181114150904.19653-1-johan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Johan Hovold <johan@kernel.org>, Andrey Smirnov <andrew.smirnov@gmail.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Allow the synchronous serdev_device_write() helper to be interrupted.

This is useful for cases where I/O is performed on behalf of user space
and we don't want to block indefinitely when using flow control.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/tty/serdev/core.c | 20 ++++++++++++++------
 include/linux/serdev.h    |  2 +-
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
index ee4c40336633..c7006bbb793a 100644
--- a/drivers/tty/serdev/core.c
+++ b/drivers/tty/serdev/core.c
@@ -231,7 +231,7 @@ EXPORT_SYMBOL_GPL(serdev_device_write_buf);
 
 int serdev_device_write(struct serdev_device *serdev,
 			const unsigned char *buf, size_t count,
-			unsigned long timeout)
+			long timeout)
 {
 	struct serdev_controller *ctrl = serdev->ctrl;
 	int written = 0;
@@ -254,16 +254,24 @@ int serdev_device_write(struct serdev_device *serdev,
 		written += ret;
 		buf += ret;
 		count -= ret;
-	} while (count &&
-		 (timeout = wait_for_completion_timeout(&serdev->write_comp,
-							timeout)));
+
+		if (count == 0)
+			break;
+
+		timeout = wait_for_completion_interruptible_timeout(&serdev->write_comp,
+								    timeout);
+	} while (timeout > 0);
 	mutex_unlock(&serdev->write_lock);
 
 	if (ret < 0)
 		return ret;
 
-	if (timeout == 0 && written == 0)
-		return -ETIMEDOUT;
+	if (timeout <= 0 && written == 0) {
+		if (timeout == -ERESTARTSYS)
+			return -ERESTARTSYS;
+		else
+			return -ETIMEDOUT;
+	}
 
 	return written;
 }
diff --git a/include/linux/serdev.h b/include/linux/serdev.h
index f153b2c7f0cd..070bf4e92df7 100644
--- a/include/linux/serdev.h
+++ b/include/linux/serdev.h
@@ -210,7 +210,7 @@ void serdev_device_wait_until_sent(struct serdev_device *, long);
 int serdev_device_get_tiocm(struct serdev_device *);
 int serdev_device_set_tiocm(struct serdev_device *, int, int);
 void serdev_device_write_wakeup(struct serdev_device *);
-int serdev_device_write(struct serdev_device *, const unsigned char *, size_t, unsigned long);
+int serdev_device_write(struct serdev_device *, const unsigned char *, size_t, long);
 void serdev_device_write_flush(struct serdev_device *);
 int serdev_device_write_room(struct serdev_device *);
 
-- 
2.19.1
