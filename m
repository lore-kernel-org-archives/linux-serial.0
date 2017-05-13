From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 5/8] gpio: exar: Fix reading of directions and values
Date: Sat, 13 May 2017 09:29:03 +0200
Message-ID: <1891081c09747965173fb03a7305e1c73033dac0.1494660546.git.jan.kiszka@siemens.com>
References: <cover.1494660546.git.jan.kiszka@siemens.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1494660546.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1494660546.git.jan.kiszka@siemens.com>
References: <cover.1494660546.git.jan.kiszka@siemens.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org, linux-gpio@vger.kernel.org, Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>, Andy Shevchenko <andy.shevchenko@gmail.com>, Sascha Weisenberger <sascha.weisenberger@siemens.com>
List-Id: linux-serial@vger.kernel.org

First, the logic for translating a register bit to the return code of
exar_get_direction and exar_get_value were wrong. And second, there was
a flip regarding the register bank in exar_get_direction.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 drivers/gpio/gpio-exar.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpio-exar.c b/drivers/gpio/gpio-exar.c
index d6ffb3d89b9c..98bd3eb1290e 100644
--- a/drivers/gpio/gpio-exar.c
+++ b/drivers/gpio/gpio-exar.c
@@ -68,7 +68,7 @@ static int exar_get(struct gpio_chip *chip, unsigned int reg)
 	value = readb(exar_gpio->regs + reg);
 	mutex_unlock(&exar_gpio->lock);
 
-	return !!value;
+	return value;
 }
 
 static int exar_get_direction(struct gpio_chip *chip, unsigned int offset)
@@ -80,7 +80,7 @@ static int exar_get_direction(struct gpio_chip *chip, unsigned int offset)
 	addr = bank ? EXAR_OFFSET_MPIOSEL_HI : EXAR_OFFSET_MPIOSEL_LO;
 	val = exar_get(chip, addr) >> (offset % 8);
 
-	return !!val;
+	return val & 1;
 }
 
 static int exar_get_value(struct gpio_chip *chip, unsigned int offset)
@@ -89,10 +89,10 @@ static int exar_get_value(struct gpio_chip *chip, unsigned int offset)
 	unsigned int addr;
 	int val;
 
-	addr = bank ? EXAR_OFFSET_MPIOLVL_LO : EXAR_OFFSET_MPIOLVL_HI;
+	addr = bank ? EXAR_OFFSET_MPIOLVL_HI : EXAR_OFFSET_MPIOLVL_LO;
 	val = exar_get(chip, addr) >> (offset % 8);
 
-	return !!val;
+	return val & 1;
 }
 
 static void exar_set_value(struct gpio_chip *chip, unsigned int offset,
-- 
2.12.0
