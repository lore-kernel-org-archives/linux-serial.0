From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH v6 05/10] gpio: exar: Fix reading of directions and values
Date: Fri,  9 Jun 2017 20:33:13 +0200
Message-ID: <379d9c7235c36ff524e88a056be45622f23bdea9.1497033197.git.jan.kiszka@siemens.com>
References: <cover.1497033197.git.jan.kiszka@siemens.com>
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <cover.1497033197.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1497033197.git.jan.kiszka@siemens.com>
References: <cover.1497033197.git.jan.kiszka@siemens.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org, linux-gpio@vger.kernel.org, Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>, Andy Shevchenko <andy.shevchenko@gmail.com>, Sascha Weisenberger <sascha.weisenberger@siemens.com>
List-Id: linux-serial@vger.kernel.org

First, the logic for translating a register bit to the return code of
exar_get_direction and exar_get_value were wrong. And second, there was
a flip regarding the register bank in exar_get_direction.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpio-exar.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpio-exar.c b/drivers/gpio/gpio-exar.c
index b29890b143ce..f3585a184f39 100644
--- a/drivers/gpio/gpio-exar.c
+++ b/drivers/gpio/gpio-exar.c
@@ -68,7 +68,7 @@ static int exar_get(struct gpio_chip *chip, unsigned int reg)
 	value = readb(exar_gpio->regs + reg);
 	mutex_unlock(&exar_gpio->lock);
 
-	return !!value;
+	return value;
 }
 
 static int exar_get_direction(struct gpio_chip *chip, unsigned int offset)
@@ -78,7 +78,7 @@ static int exar_get_direction(struct gpio_chip *chip, unsigned int offset)
 	int val;
 
 	addr = bank ? EXAR_OFFSET_MPIOSEL_HI : EXAR_OFFSET_MPIOSEL_LO;
-	val = exar_get(chip, addr) >> (offset % 8);
+	val = exar_get(chip, addr) & BIT(offset % 8);
 
 	return !!val;
 }
@@ -89,8 +89,8 @@ static int exar_get_value(struct gpio_chip *chip, unsigned int offset)
 	unsigned int addr;
 	int val;
 
-	addr = bank ? EXAR_OFFSET_MPIOLVL_LO : EXAR_OFFSET_MPIOLVL_HI;
-	val = exar_get(chip, addr) >> (offset % 8);
+	addr = bank ? EXAR_OFFSET_MPIOLVL_HI : EXAR_OFFSET_MPIOLVL_LO;
+	val = exar_get(chip, addr) & BIT(offset % 8);
 
 	return !!val;
 }
-- 
2.12.3

