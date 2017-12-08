From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 3/3] serial: max3100: Improve unlocking of a mutex in
 max3100_probe()
Date: Fri, 8 Dec 2017 21:13:43 +0100
Message-ID: <c8e2234e-5b34-79bf-cb71-f9821ea0eefe@users.sourceforge.net>
References: <82c37f92-b4ee-8bea-bd10-de3b6691151d@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <82c37f92-b4ee-8bea-bd10-de3b6691151d@users.sourceforge.net>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 8 Dec 2017 20:52:37 +0100

* Add a jump target so that a call of the function "mutex_unlock" is stored
  only once in this function implementation.

* Replace three calls by goto statements.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/tty/serial/max3100.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/max3100.c b/drivers/tty/serial/max3100.c
index 00c0e650537d..e4908410565c 100644
--- a/drivers/tty/serial/max3100.c
+++ b/drivers/tty/serial/max3100.c
@@ -747,8 +747,7 @@ static int max3100_probe(struct spi_device *spi)
 		retval = uart_register_driver(&max3100_uart_driver);
 		if (retval) {
 			printk(KERN_ERR "Couldn't register max3100 uart driver\n");
-			mutex_unlock(&max3100s_lock);
-			return retval;
+			goto unlock;
 		}
 	}
 
@@ -757,14 +756,14 @@ static int max3100_probe(struct spi_device *spi)
 			break;
 	if (i == MAX_MAX3100) {
 		dev_warn(&spi->dev, "too many MAX3100 chips\n");
-		mutex_unlock(&max3100s_lock);
-		return -ENOMEM;
+		retval = -ENOMEM;
+		goto unlock;
 	}
 
 	max3100s[i] = kzalloc(sizeof(*max3100s[i]), GFP_KERNEL);
 	if (!max3100s[i]) {
-		mutex_unlock(&max3100s_lock);
-		return -ENOMEM;
+		retval = -ENOMEM;
+		goto unlock;
 	}
 	max3100s[i]->spi = spi;
 	max3100s[i]->irq = spi->irq;
@@ -803,8 +802,11 @@ static int max3100_probe(struct spi_device *spi)
 		tx = MAX3100_WC | MAX3100_SHDN;
 		max3100_sr(max3100s[i], tx, &rx);
 	}
+
+	retval = 0;
+unlock:
 	mutex_unlock(&max3100s_lock);
-	return 0;
+	return retval;
 }
 
 static int max3100_remove(struct spi_device *spi)
-- 
2.15.1
