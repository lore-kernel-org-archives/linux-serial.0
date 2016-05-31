From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH v2 2/2] serial: samsung: Fix possible out of bounds access on
 non-DT platform
Date: Tue, 31 May 2016 16:00:06 +0200
Message-ID: <1464703206-1615-2-git-send-email-k.kozlowski@samsung.com>
References: <1464703206-1615-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1464703206-1615-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>
List-Id: linux-serial@vger.kernel.org

On non-DeviceTree platforms, the index of serial device is a static
variable incremented on each probe.  It is incremented even if deferred
probe happens when getting the clock in s3c24xx_serial_init_port().

This index is used for referencing elements of statically allocated
s3c24xx_serial_ports array.  In case of re-probe, the index will point
outside of this array leading to memory corruption.

Increment the index only on successful probe.

Reported-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Fixes: b497549a035c ("[ARM] S3C24XX: Split serial driver into core and per-cpu drivers")
Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

---

Not cc-ing stable because:
1. It is just a possibility, not really reproduced (I don't have non-DT
   platform).
2. I am not sure whether deferred probe may happen on non-DT platform.

Changes since v1:
1. New patch.
---
 drivers/tty/serial/samsung.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
index f0bd2ec0db59..4d2924f61e0b 100644
--- a/drivers/tty/serial/samsung.c
+++ b/drivers/tty/serial/samsung.c
@@ -1844,8 +1844,6 @@ static int s3c24xx_serial_probe(struct platform_device *pdev)
 	ourport->min_dma_size = max_t(int, ourport->port.fifosize,
 				    dma_get_cache_alignment());
 
-	probe_index++;
-
 	dbg("%s: initialising port %p...\n", __func__, ourport);
 
 	ret = s3c24xx_serial_init_port(ourport, pdev);
@@ -1875,6 +1873,8 @@ static int s3c24xx_serial_probe(struct platform_device *pdev)
 	if (ret < 0)
 		dev_err(&pdev->dev, "failed to add cpufreq notifier\n");
 
+	probe_index++;
+
 	return 0;
 }
 
-- 
1.9.1
