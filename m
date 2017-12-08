From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 1/3] serial: max3100: Delete an error message for a failed
 memory allocation in max3100_probe()
Date: Fri, 8 Dec 2017 21:11:43 +0100
Message-ID: <7a876c15-6fea-aa9f-451d-0856c913a59c@users.sourceforge.net>
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
Date: Fri, 8 Dec 2017 20:20:58 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/tty/serial/max3100.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/tty/serial/max3100.c b/drivers/tty/serial/max3100.c
index 27d6049eb6a9..b7b7e6582f3f 100644
--- a/drivers/tty/serial/max3100.c
+++ b/drivers/tty/serial/max3100.c
@@ -763,8 +763,6 @@ static int max3100_probe(struct spi_device *spi)
 
 	max3100s[i] = kzalloc(sizeof(struct max3100_port), GFP_KERNEL);
 	if (!max3100s[i]) {
-		dev_warn(&spi->dev,
-			 "kmalloc for max3100 structure %d failed!\n", i);
 		mutex_unlock(&max3100s_lock);
 		return -ENOMEM;
 	}
-- 
2.15.1
