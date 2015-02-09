From: Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH] tty: max3100: use msecs_to_jiffies for time conversion
Date: Mon,  9 Feb 2015 09:41:49 -0500
Message-ID: <1423492909-24725-1-git-send-email-hofrat@osadl.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Nicholas Mc Guire <hofrat@osadl.org>
List-Id: linux-serial@vger.kernel.org

This is only an API consolidation and should make things more readable
it replaces var * HZ / 1000 by msecs_to_jiffies(var).

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
---

Patch was only compile tested with x86_64_defconfig + CONFIG_SPI=y
CONFIG_SERIAL_MAX3100=m

Patch is against 3.19.0-rc7 (localversion-next is -next-20150209)

 drivers/tty/serial/max3100.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/max3100.c b/drivers/tty/serial/max3100.c
index 79f9a9e..0773772 100644
--- a/drivers/tty/serial/max3100.c
+++ b/drivers/tty/serial/max3100.c
@@ -782,7 +782,7 @@ static int max3100_probe(struct spi_device *spi)
 	pdata = dev_get_platdata(&spi->dev);
 	max3100s[i]->crystal = pdata->crystal;
 	max3100s[i]->loopback = pdata->loopback;
-	max3100s[i]->poll_time = pdata->poll_time * HZ / 1000;
+	max3100s[i]->poll_time = msecs_to_jiffies(pdata->poll_time);
 	if (pdata->poll_time > 0 && max3100s[i]->poll_time == 0)
 		max3100s[i]->poll_time = 1;
 	max3100s[i]->max3100_hw_suspend = pdata->max3100_hw_suspend;
-- 
1.7.10.4
