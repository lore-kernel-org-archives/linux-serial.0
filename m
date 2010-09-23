From: Darius Augulis <augulis.darius@gmail.com>
Subject: [RESEND PATCH] serial: samsung: fix device name
Date: Thu, 23 Sep 2010 22:15:31 +0300
Message-ID: <20100923190212.18863.25678.stgit@darius-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:49215 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752066Ab0IWTPi (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 23 Sep 2010 15:15:38 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: kgene.kim@samsung.com, paulius.zaleckas@gmail.com, linux-kernel@vger.kernel.org, ben-linux@fluff.org, linux-serial@vger.kernel.org

Swap device and driver names in serial/samsung.c

Signed-off-by: Darius Augulis <augulis.darius@gmail.com>
---

This patch was submitted about 3 months ago, but still not merged.
There was another similar patch from Joonyoung Shim
<jy0922.shim@samsung.com> and was discussed here:
http://marc.info/?l=linux-serial&m=127416101222281&w=2.
Joonyoung Shim acked my patch and other people on ARM mailing list
acked it. The maintainer, Ben Dooks, still not responding for
a long time. Another maintainer, Kukjin Kim, refused to merge
it without Ben's review.
I would like to ask somebody pick up this bugfix.

 drivers/serial/samsung.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/serial/samsung.c b/drivers/serial/samsung.c
index b1156ba..25c0d0f 100644
--- a/drivers/serial/samsung.c
+++ b/drivers/serial/samsung.c
@@ -883,10 +883,10 @@ static struct uart_ops s3c24xx_serial_ops = {
 
 static struct uart_driver s3c24xx_uart_drv = {
 	.owner		= THIS_MODULE,
-	.dev_name	= "s3c2410_serial",
+	.driver_name    = "s3c2410_serial",
 	.nr		= CONFIG_SERIAL_SAMSUNG_UARTS,
 	.cons		= S3C24XX_SERIAL_CONSOLE,
-	.driver_name	= S3C24XX_SERIAL_NAME,
+	.dev_name       = S3C24XX_SERIAL_NAME,
 	.major		= S3C24XX_SERIAL_MAJOR,
 	.minor		= S3C24XX_SERIAL_MINOR,
 };

