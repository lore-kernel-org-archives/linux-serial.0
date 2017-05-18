From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH v2 3/6] gpio: exar: Fix iomap request
Date: Thu, 18 May 2017 16:59:06 +0200
Message-ID: <336687b99a6606e41890cdf6b7ed74e94f12ae62.1495119548.git.jan.kiszka@siemens.com>
References: <cover.1495119548.git.jan.kiszka@siemens.com>
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <cover.1495119548.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1495119548.git.jan.kiszka@siemens.com>
References: <cover.1495119548.git.jan.kiszka@siemens.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org, linux-gpio@vger.kernel.org, Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>, Andy Shevchenko <andy.shevchenko@gmail.com>, Sascha Weisenberger <sascha.weisenberger@siemens.com>
List-Id: linux-serial@vger.kernel.org

The UART driver already maps the resource for us. Trying to do this here
only fails and leaves us with a non-working device.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/gpio/gpio-exar.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/gpio/gpio-exar.c b/drivers/gpio/gpio-exar.c
index b1dc5fff21ad..4ed1f8bdeda7 100644
--- a/drivers/gpio/gpio-exar.c
+++ b/drivers/gpio/gpio-exar.c
@@ -130,14 +130,10 @@ static int gpio_exar_probe(struct platform_device *pdev)
 		return -ENODEV;
 
 	/*
-	 * Map the pci device to get the register addresses.
-	 * We will need to read and write those registers to control
-	 * the GPIO pins.
-	 * Using managed functions will save us from unmaping on exit.
-	 * As the device is enabled using managed functions by the
-	 * UART driver we can also use managed functions here.
+	 * The UART driver must have mapped region 0 prior to registering this
+	 * device - use it.
 	 */
-	p = pcim_iomap(pcidev, 0, 0);
+	p = pcim_iomap_table(pcidev)[0];
 	if (!p)
 		return -ENOMEM;
 
-- 
2.12.0

