From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH v3 04/10] gpio: exar: Allocate resources on behalf of the platform device
Date: Fri, 26 May 2017 18:02:31 +0200
Message-ID: <be82bb59d303876de7b16aa49cf7cda6b080e0e7.1495814557.git.jan.kiszka@siemens.com>
References: <cover.1495814557.git.jan.kiszka@siemens.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1495814557.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1495814557.git.jan.kiszka@siemens.com>
References: <cover.1495814557.git.jan.kiszka@siemens.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org, linux-gpio@vger.kernel.org, Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>, Andy Shevchenko <andy.shevchenko@gmail.com>, Sascha Weisenberger <sascha.weisenberger@siemens.com>
List-Id: linux-serial@vger.kernel.org

Do not allocate resources on behalf of the parent device but on our own.
Otherwise, cleanup does not properly work if gpio-exar is removed but
not the parent device.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/gpio/gpio-exar.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-exar.c b/drivers/gpio/gpio-exar.c
index da4550bb9939..65126fa1e512 100644
--- a/drivers/gpio/gpio-exar.c
+++ b/drivers/gpio/gpio-exar.c
@@ -136,7 +136,7 @@ static int gpio_exar_probe(struct platform_device *pdev)
 	if (!p)
 		return -ENOMEM;
 
-	exar_gpio = devm_kzalloc(&pcidev->dev, sizeof(*exar_gpio), GFP_KERNEL);
+	exar_gpio = devm_kzalloc(&pdev->dev, sizeof(*exar_gpio), GFP_KERNEL);
 	if (!exar_gpio)
 		return -ENOMEM;
 
@@ -157,7 +157,7 @@ static int gpio_exar_probe(struct platform_device *pdev)
 	exar_gpio->regs = p;
 	exar_gpio->index = index;
 
-	ret = devm_gpiochip_add_data(&pcidev->dev,
+	ret = devm_gpiochip_add_data(&pdev->dev,
 				     &exar_gpio->gpio_chip, exar_gpio);
 	if (ret)
 		goto err_destroy;
-- 
2.12.0
