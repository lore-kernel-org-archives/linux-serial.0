From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] max3100: Fix error case
Date: Mon, 17 Sep 2012 12:00:44 +0100
Message-ID: <20120917110041.30391.30504.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:32937 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753804Ab2IQKmQ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 17 Sep 2012 06:42:16 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: greg@kroah.com, linux-serial@vger.kernel.org

From: Alan Cox <alan@linux.intel.com>

We don't want to free a random address if the entry is wrong, cover
this and WARN if it ever happens.

Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/tty/serial/max3100.c |   14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/max3100.c b/drivers/tty/serial/max3100.c
index 46043c2..0f24486 100644
--- a/drivers/tty/serial/max3100.c
+++ b/drivers/tty/serial/max3100.c
@@ -827,14 +827,16 @@ static int __devexit max3100_remove(struct spi_device *spi)
 
 	/* find out the index for the chip we are removing */
 	for (i = 0; i < MAX_MAX3100; i++)
-		if (max3100s[i] == s)
+		if (max3100s[i] == s) {
+			dev_dbg(&spi->dev, "%s: removing port %d\n", __func__, i);
+			uart_remove_one_port(&max3100_uart_driver, &max3100s[i]->port);
+			kfree(max3100s[i]);
+			max3100s[i] = NULL;
 			break;
+		}
 
-	dev_dbg(&spi->dev, "%s: removing port %d\n", __func__, i);
-	uart_remove_one_port(&max3100_uart_driver, &max3100s[i]->port);
-	kfree(max3100s[i]);
-	max3100s[i] = NULL;
-
+	WARN_ON(i == MAX_MAX3100);
+	
 	/* check if this is the last chip we have */
 	for (i = 0; i < MAX_MAX3100; i++)
 		if (max3100s[i]) {

