From: Alan Cox <alan@linux.intel.com>
Subject: [PATCH 2/2] max3110 sanity check a register
Date: Wed, 16 Jun 2010 14:46:49 +0100
Message-ID: <20100616134616.12686.11518.stgit@localhost.localdomain>
References: <20100616134304.12686.39604.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:58985 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758783Ab0FPOJl (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 16 Jun 2010 10:09:41 -0400
In-Reply-To: <20100616134304.12686.39604.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: greg@kroah.com, linux-serial@vger.kernel.org

From: jianwei.yang <jianwei.yang@intel.com>

MAX3111 is the SPI/UART IC installed on the MRST SPI Port Card as a serial
debug goal, and the SPI Port Card will be frequently mounted and unmounted
from the main board by developers depending whether debug serial is
required or not.

As the MAX3111 has no subvendor or product id registers available, the patch
will try to access one register to decide if this IC is present or not.

Signed-off-by: Alan Cox <alan@linux.intel.com>

---

 drivers/serial/mrst_max3110.c |   13 +++++++++++--
 1 files changed, 11 insertions(+), 2 deletions(-)


diff --git a/drivers/serial/mrst_max3110.c b/drivers/serial/mrst_max3110.c
index 273e7cb..f9c01ae 100644
--- a/drivers/serial/mrst_max3110.c
+++ b/drivers/serial/mrst_max3110.c
@@ -721,7 +721,7 @@ static int serial_m3110_probe(struct spi_device *spi)
 	struct uart_max3110 *max;
 	int ret;
 	unsigned char *buffer;
-
+	u16 res;
 	max = kzalloc(sizeof(*max), GFP_KERNEL);
 	if (!max)
 		return -ENOMEM;
@@ -753,7 +753,16 @@ static int serial_m3110_probe(struct spi_device *spi)
 
 	max->cur_conf = 0;
 	atomic_set(&max->irq_pending, 0);
-
+	/* Check if reading configuration register returns something sane */
+
+	res = RC_TAG;
+	ret = max3110_write_then_read(max, (u8 *)&res, (u8 *)&res, 2, 0);
+	if (ret < 0 || res == 0 || res == 0xffff) {
+		printk(KERN_ERR "MAX3111 deemed not present (conf reg %04x)",
+									res);
+		ret = -ENODEV;
+		goto err_get_page;
+	}
 	buffer = (unsigned char *)__get_free_page(GFP_KERNEL);
 	if (!buffer) {
 		ret = -ENOMEM;

