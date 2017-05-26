From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH v3 08/10] gpio: exar: Refactor address and bit calculations
Date: Fri, 26 May 2017 18:02:35 +0200
Message-ID: <ee7ffa22693e844c76f30ce2e96123aefe217e3a.1495814557.git.jan.kiszka@siemens.com>
References: <cover.1495814557.git.jan.kiszka@siemens.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1495814557.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1495814557.git.jan.kiszka@siemens.com>
References: <cover.1495814557.git.jan.kiszka@siemens.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org, linux-gpio@vger.kernel.org, Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>, Andy Shevchenko <andy.shevchenko@gmail.com>, Sascha Weisenberger <sascha.weisenberger@siemens.com>
List-Id: linux-serial@vger.kernel.org

Make the address and bit calculation more friendly for introducing a
"first pin" offset later on. The new form is also more compact and
regular.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 drivers/gpio/gpio-exar.c | 38 ++++++++++++++++----------------------
 1 file changed, 16 insertions(+), 22 deletions(-)

diff --git a/drivers/gpio/gpio-exar.c b/drivers/gpio/gpio-exar.c
index 1a629831d45b..d13bf20b8639 100644
--- a/drivers/gpio/gpio-exar.c
+++ b/drivers/gpio/gpio-exar.c
@@ -51,11 +51,11 @@ static void exar_update(struct gpio_chip *chip, unsigned int reg, int val,
 static int exar_set_direction(struct gpio_chip *chip, int direction,
 			      unsigned int offset)
 {
-	unsigned int bank = offset / 8;
-	unsigned int addr;
+	unsigned int addr = offset / 8 ?
+		EXAR_OFFSET_MPIOSEL_HI : EXAR_OFFSET_MPIOSEL_LO;
+	unsigned int bit  = offset % 8;
 
-	addr = bank ? EXAR_OFFSET_MPIOSEL_HI : EXAR_OFFSET_MPIOSEL_LO;
-	exar_update(chip, addr, direction, offset % 8);
+	exar_update(chip, addr, direction, bit);
 	return 0;
 }
 
@@ -73,36 +73,30 @@ static int exar_get(struct gpio_chip *chip, unsigned int reg)
 
 static int exar_get_direction(struct gpio_chip *chip, unsigned int offset)
 {
-	unsigned int bank = offset / 8;
-	unsigned int addr;
-	int val;
+	unsigned int addr = offset / 8 ?
+		EXAR_OFFSET_MPIOSEL_HI : EXAR_OFFSET_MPIOSEL_LO;
+	unsigned int bit  = offset % 8;
 
-	addr = bank ? EXAR_OFFSET_MPIOSEL_HI : EXAR_OFFSET_MPIOSEL_LO;
-	val = exar_get(chip, addr) & BIT(offset % 8);
-
-	return !!val;
+	return !!(exar_get(chip, addr) & BIT(bit));
 }
 
 static int exar_get_value(struct gpio_chip *chip, unsigned int offset)
 {
-	unsigned int bank = offset / 8;
-	unsigned int addr;
-	int val;
-
-	addr = bank ? EXAR_OFFSET_MPIOLVL_HI : EXAR_OFFSET_MPIOLVL_LO;
-	val = exar_get(chip, addr) & BIT(offset % 8);
+	unsigned int addr = offset / 8 ?
+		EXAR_OFFSET_MPIOLVL_HI : EXAR_OFFSET_MPIOLVL_LO;
+	unsigned int bit  = offset % 8;
 
-	return !!val;
+	return !!(exar_get(chip, addr) & BIT(bit));
 }
 
 static void exar_set_value(struct gpio_chip *chip, unsigned int offset,
 			   int value)
 {
-	unsigned int bank = offset / 8;
-	unsigned int addr;
+	unsigned int addr = offset / 8 ?
+		EXAR_OFFSET_MPIOLVL_HI : EXAR_OFFSET_MPIOLVL_LO;
+	unsigned int bit  = offset % 8;
 
-	addr = bank ? EXAR_OFFSET_MPIOLVL_HI : EXAR_OFFSET_MPIOLVL_LO;
-	exar_update(chip, addr, value, offset % 8);
+	exar_update(chip, addr, value, bit);
 }
 
 static int exar_direction_output(struct gpio_chip *chip, unsigned int offset,
-- 
2.12.0
