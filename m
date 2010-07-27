From: Alan Cox <alan@linux.intel.com>
Subject: [RESEND PATCH] max3107: Fix gpiolib support
Date: Tue, 27 Jul 2010 08:16:05 +0100
Message-ID: <20100727071551.25761.146.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:33990 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753558Ab0G0Hta (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 27 Jul 2010 03:49:30 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, greg@kroah.com

Because of the way gpiolib works we actually need to ifdef this in our
header file

Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/serial/max3107.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)


diff --git a/drivers/serial/max3107.h b/drivers/serial/max3107.h
index 72b3041..7ab6323 100644
--- a/drivers/serial/max3107.h
+++ b/drivers/serial/max3107.h
@@ -368,8 +368,10 @@ struct max3107_port {
 	/* SPI device structure */
 	struct spi_device *spi;
 
+#if defined(CONFIG_GPIOLIB)
 	/* GPIO chip stucture */
 	struct gpio_chip chip;
+#endif
 
 	/* Workqueue that does all the magic */
 	struct workqueue_struct *workqueue;

