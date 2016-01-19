From: Peter Hung <hpeter@gmail.com>
Subject: [PATCH 3/3] 8250_fintek_pci: Add GPIOLIB support
Date: Tue, 19 Jan 2016 10:41:06 +0800
Message-ID: <1453171266-15874-4-git-send-email-hpeter+linux_kernel@gmail.com>
References: <1453171266-15874-1-git-send-email-hpeter+linux_kernel@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1453171266-15874-1-git-send-email-hpeter+linux_kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.com
Cc: andriy.shevchenko@linux.intel.com, heikki.krogerus@linux.intel.com, peter@hurleysoftware.com, soeren.grunewald@desy.de, udknight@gmail.com, adam.lee@canonical.com, arnd@arndb.de, yamada.masahiro@socionext.com, mans@mansr.com, scottwood@freescale.com, paul.burton@imgtec.com, paul.gortmaker@windriver.com, matthias.bgg@gmail.com, manabian@gmail.com, peter.ujfalusi@ti.com, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, peter_hong@fintek.com.tw, Peter Hung <hpeter+linux_kernel@gmail.com>
List-Id: linux-serial@vger.kernel.org

Add GPIOLIB support for F81504/508/512 Multi-Functional PCIE device

F81504: Max 2x8 GPIOs and max 4 serial port
        port2/3 are multi-function
F81508: Max 6x8 GPIOs and max 8 serial port
        port2/3 are multi-function, port8/9/10/11 are gpio only
F81512: Max 6x8 GPIOs and max 12 serial port
        port2/3/8/9/10/11 are multi-function

The mode is controlled via PCI configuration space F0h & F3h. Customers
can use EEPROM or BIOS to override register value. The driver will save
and configurate in f81504_port_init().

Signed-off-by: Peter Hung <hpeter+linux_kernel@gmail.com>
---
 drivers/tty/serial/8250/8250_fintek_pci.c | 361 +++++++++++++++++++++++++++++-
 1 file changed, 359 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_fintek_pci.c b/drivers/tty/serial/8250/8250_fintek_pci.c
index 5d9ea01a..08c320c 100644
--- a/drivers/tty/serial/8250/8250_fintek_pci.c
+++ b/drivers/tty/serial/8250/8250_fintek_pci.c
@@ -4,6 +4,7 @@
  */
 #include <linux/pci.h>
 #include <linux/serial_8250.h>
+#include <linux/gpio.h>
 #include <linux/module.h>
 #include "8250.h"
 
@@ -13,8 +14,11 @@
 #define FINTEK_F81512		0x1112
 
 #define FINTEK_MAX_PORT		12
+#define FINTEK_MAX_GPIO_SET	6
+#define FINTEK_GPIO_MAX_NAME	32
 #define DRIVER_NAME		"f81504_serial"
 #define DEV_DESC		"Fintek F81504/508/512 PCIE-to-UART"
+#define GPIO_DISPLAY_NAME	"GPIO"
 
 #define UART_START_ADDR		0x40
 #define UART_MODE_OFFSET	0x07
@@ -25,6 +29,16 @@
 /* only worked with FINTEK_RTS_CONTROL_BY_HW on */
 #define RTS_INVERT		BIT(5)
 
+#define GPIO_ENABLE_REG		0xf0
+#define GPIO_IO_LSB_REG		0xf1
+#define GPIO_IO_MSB_REG		0xf2
+#define PIN_SET_MODE_REG	0xf3
+
+#define GPIO_START_ADDR		0xf8
+#define GPIO_OUT_EN_OFFSET	0x00
+#define GPIO_DRIVE_EN_OFFSET	0x01
+#define GPIO_SET_OFFSET		0x08
+
 #define CLOCK_RATE_MASK		0xc0
 #define CLKSEL_1DOT846_MHZ	0x00
 #define CLKSEL_18DOT46_MHZ	0x40
@@ -36,12 +50,261 @@
 static u32 baudrate_table[] = { 1500000, 1152000, 921600 };
 static u8 clock_table[] = { CLKSEL_24_MHZ, CLKSEL_18DOT46_MHZ,
 		CLKSEL_14DOT77_MHZ };
+static u8 fintek_gpio_mapping[FINTEK_MAX_GPIO_SET] = { 2, 3, 8, 9, 10, 11 };
 
 struct f81504_pci_private {
 	int line[FINTEK_MAX_PORT];
 	u32 uart_count;
+	u32 gpio_count;
+	u16 gpio_ioaddr;
+	u8 f0_gpio_flag;
+	struct mutex locker;
+#ifdef CONFIG_GPIOLIB
+	struct f81504_gpio_set {
+		struct gpio_chip chip;
+		u8 idx;
+		u8 save_out_en;
+		u8 save_drive_en;
+		u8 save_value;
+	} gpio_set[FINTEK_MAX_GPIO_SET];
+#endif
 };
 
+#ifdef CONFIG_GPIOLIB
+static struct f81504_gpio_set *gpio_to_f81504_chip(struct gpio_chip *gc)
+{
+	return container_of(gc, struct f81504_gpio_set, chip);
+}
+
+static int f81504_gpio_get(struct gpio_chip *chip, unsigned gpio_num)
+{
+	int tmp;
+	struct pci_dev *dev = container_of(chip->dev, struct pci_dev, dev);
+	struct f81504_pci_private *priv = pci_get_drvdata(dev);
+	struct f81504_gpio_set *set = gpio_to_f81504_chip(chip);
+
+	mutex_lock(&priv->locker);
+	tmp = inb(priv->gpio_ioaddr + set->idx);
+	mutex_unlock(&priv->locker);
+
+	return !!(tmp & BIT(gpio_num));
+}
+
+static int f81504_gpio_direction_in(struct gpio_chip *chip, unsigned gpio_num)
+{
+	u8 tmp;
+	struct pci_dev *dev = container_of(chip->dev, struct pci_dev, dev);
+	struct f81504_pci_private *priv = pci_get_drvdata(dev);
+	struct f81504_gpio_set *set = gpio_to_f81504_chip(chip);
+
+	mutex_lock(&priv->locker);
+
+	/* set input mode */
+	pci_read_config_byte(dev, GPIO_START_ADDR + set->idx *
+			GPIO_SET_OFFSET + GPIO_OUT_EN_OFFSET, &tmp);
+	pci_write_config_byte(dev, GPIO_START_ADDR + set->idx *
+			GPIO_SET_OFFSET + GPIO_OUT_EN_OFFSET,
+			tmp & ~BIT(gpio_num));
+
+	mutex_unlock(&priv->locker);
+	return 0;
+}
+
+static int f81504_gpio_direction_out(struct gpio_chip *chip,
+				     unsigned gpio_num, int val)
+{
+	u8 tmp;
+	struct pci_dev *dev = container_of(chip->dev, struct pci_dev, dev);
+	struct f81504_pci_private *priv = pci_get_drvdata(dev);
+	struct f81504_gpio_set *set = gpio_to_f81504_chip(chip);
+
+	mutex_lock(&priv->locker);
+
+	/* set output mode */
+	pci_read_config_byte(dev, GPIO_START_ADDR + set->idx *
+			GPIO_SET_OFFSET + GPIO_OUT_EN_OFFSET, &tmp);
+	pci_write_config_byte(dev, GPIO_START_ADDR + set->idx *
+			GPIO_SET_OFFSET + GPIO_OUT_EN_OFFSET,
+			tmp | BIT(gpio_num));
+
+	/*
+	 * The GPIO default driven mode for this device is open-drain. The
+	 * GPIOLIB had no change GPIO mode API currently. So we leave the
+	 * Push-Pull code below.
+	 *
+	 * pci_read_config_byte(dev, GPIO_START_ADDR + idx * GPIO_SET_OFFSET +
+	 *			GPIO_DRIVE_EN_OFFSET, &tmp);
+	 * pci_write_config_byte(dev, GPIO_START_ADDR + idx * GPIO_SET_OFFSET +
+	 *			GPIO_DRIVE_EN_OFFSET, tmp | BIT(gpio_num));
+	 */
+
+	/* set output data */
+	tmp = inb(priv->gpio_ioaddr + set->idx);
+
+	if (val)
+		outb(tmp | BIT(gpio_num), priv->gpio_ioaddr + set->idx);
+	else
+		outb(tmp & ~BIT(gpio_num), priv->gpio_ioaddr + set->idx);
+
+	mutex_unlock(&priv->locker);
+
+	return 0;
+}
+
+static void f81504_gpio_set(struct gpio_chip *chip, unsigned gpio_num, int val)
+{
+	f81504_gpio_direction_out(chip, gpio_num, val);
+}
+
+static int f81504_gpio_get_direction(struct gpio_chip *chip, unsigned offset)
+{
+	u8 tmp;
+	struct pci_dev *dev = container_of(chip->dev, struct pci_dev, dev);
+	struct f81504_pci_private *priv = pci_get_drvdata(dev);
+	struct f81504_gpio_set *set = gpio_to_f81504_chip(chip);
+
+	mutex_lock(&priv->locker);
+	pci_read_config_byte(dev, GPIO_START_ADDR + set->idx * GPIO_SET_OFFSET,
+				&tmp);
+	mutex_unlock(&priv->locker);
+
+	if (tmp & BIT(offset))
+		return GPIOF_DIR_OUT;
+
+	return GPIOF_DIR_IN;
+}
+
+static void f81504_save_gpio_config(struct pci_dev *dev)
+{
+	size_t i;
+	struct f81504_pci_private *priv = pci_get_drvdata(dev);
+	struct f81504_gpio_set *set;
+
+	mutex_lock(&priv->locker);
+
+	for (i = 0; i < priv->gpio_count; ++i) {
+		set = &priv->gpio_set[i];
+
+		pci_read_config_byte(dev, GPIO_START_ADDR + set->idx *
+				GPIO_SET_OFFSET + GPIO_OUT_EN_OFFSET,
+				&set->save_out_en);
+
+		pci_read_config_byte(dev, GPIO_START_ADDR + set->idx *
+				GPIO_SET_OFFSET + GPIO_DRIVE_EN_OFFSET,
+				&set->save_drive_en);
+
+		set->save_value = inb(priv->gpio_ioaddr + set->idx);
+	}
+
+	mutex_unlock(&priv->locker);
+}
+
+static void f81504_restore_gpio_config(struct pci_dev *dev)
+{
+	size_t i;
+	struct f81504_pci_private *priv = pci_get_drvdata(dev);
+	struct f81504_gpio_set *set;
+
+	mutex_lock(&priv->locker);
+
+	for (i = 0; i < priv->gpio_count; ++i) {
+		set = &priv->gpio_set[i];
+
+		pci_write_config_byte(dev, GPIO_START_ADDR + set->idx *
+				GPIO_SET_OFFSET + GPIO_OUT_EN_OFFSET,
+				set->save_out_en);
+
+		pci_write_config_byte(dev, GPIO_START_ADDR + set->idx *
+				GPIO_SET_OFFSET + GPIO_DRIVE_EN_OFFSET,
+				set->save_drive_en);
+
+		outb(set->save_value, priv->gpio_ioaddr + set->idx);
+	}
+
+	mutex_unlock(&priv->locker);
+}
+
+static int f81504_prepage_gpiolib(struct pci_dev *dev)
+{
+	size_t i;
+	int status;
+	struct f81504_pci_private *priv = pci_get_drvdata(dev);
+	struct f81504_gpio_set *set;
+	char *name;
+
+	for (i = 0; i < FINTEK_MAX_GPIO_SET; ++i) {
+		if (!(priv->f0_gpio_flag & BIT(i)))
+			continue;
+
+		/* F81504 had max 2 sets GPIO */
+		if (dev->device == FINTEK_F81504 && i >= 2)
+			break;
+
+		name = devm_kzalloc(&dev->dev, FINTEK_GPIO_MAX_NAME,
+					GFP_KERNEL);
+		if (!name) {
+			status = -ENOMEM;
+			goto failed;
+		}
+
+		sprintf(name, "%s-%zu", GPIO_DISPLAY_NAME, i);
+		set = &priv->gpio_set[priv->gpio_count];
+
+		set->chip.owner = THIS_MODULE;
+		set->chip.label = name;
+		set->chip.ngpio = 8;
+		set->chip.dev = &dev->dev;
+		set->chip.get = f81504_gpio_get;
+		set->chip.set = f81504_gpio_set;
+		set->chip.direction_input = f81504_gpio_direction_in;
+		set->chip.direction_output = f81504_gpio_direction_out;
+		set->chip.get_direction = f81504_gpio_get_direction;
+		set->chip.base = -1;
+		set->idx = i;
+
+		status = gpiochip_add(&set->chip);
+		if (status)
+			goto failed;
+
+		++priv->gpio_count;
+	}
+
+	return 0;
+
+failed:
+	for (i = 0; i < priv->gpio_count; ++i)
+		gpiochip_remove(&priv->gpio_set[i].chip);
+
+	return status;
+}
+
+static void f81504_remove_gpiolib(struct pci_dev *dev)
+{
+	size_t i;
+	struct f81504_pci_private *priv = pci_get_drvdata(dev);
+
+	for (i = 0; i < priv->gpio_count; ++i)
+		gpiochip_remove(&priv->gpio_set[i].chip);
+}
+#else
+static int f81504_prepage_gpiolib(struct pci_dev *dev)
+{
+	return 0;
+}
+
+static void f81504_remove_gpiolib(struct pci_dev *dev)
+{
+}
+
+static void f81504_save_gpio_config(struct pci_dev *dev)
+{
+}
+
+static void f81504_restore_gpio_config(struct pci_dev *dev)
+{
+}
+#endif
+
 /* We should do proper H/W transceiver setting before change to RS485 mode */
 static int f81504_rs485_config(struct uart_port *port,
 			       struct serial_rs485 *rs485)
@@ -205,14 +468,53 @@ static int f81504_register_port(struct pci_dev *dev, unsigned long address,
 
 static int f81504_port_init(struct pci_dev *dev)
 {
-	size_t i;
+	size_t i, j;
 	u32 max_port, iobase;
 	u32 bar_data[3];
 	u16 tmp;
-	u8 config_base;
+	u8 config_base, gpio_en, f0h_data, f3h_data;
+	bool is_gpio;
 	struct f81504_pci_private *priv = pci_get_drvdata(dev);
 	struct uart_8250_port *port;
 
+	/*
+	 * The PCI board is multi-function, some serial port can converts to
+	 * GPIO function. Customers could changes the F0/F3h values in EEPROM
+	 *
+	 * F0h bit0~5: Enable GPIO0~5
+	 *     bit6~7: Reserve
+	 *
+	 * F3h bit0~5: Multi-Functional Flag (0:GPIO/1:UART)
+	 *              bit0: UART2 pin out for UART2 / GPIO0
+	 *              bit1: UART3 pin out for UART3 / GPIO1
+	 *              bit2: UART8 pin out for UART8 / GPIO2
+	 *              bit3: UART9 pin out for UART9 / GPIO3
+	 *              bit4: UART10 pin out for UART10 / GPIO4
+	 *              bit5: UART11 pin out for UART11 / GPIO5
+	 *     bit6~7: Reserve
+	 */
+	if (priv) {
+		/* Reinit from resume(), read the previous value from priv */
+		gpio_en = priv->f0_gpio_flag;
+	} else {
+		/* Driver first init */
+		pci_read_config_byte(dev, GPIO_ENABLE_REG, &f0h_data);
+		pci_read_config_byte(dev, PIN_SET_MODE_REG, &f3h_data);
+
+		/* find the max set of GPIOs */
+		gpio_en = f0h_data | ~f3h_data;
+	}
+
+	/* rewrite GPIO setting */
+	pci_write_config_byte(dev, GPIO_ENABLE_REG, gpio_en & 0x3f);
+	pci_write_config_byte(dev, PIN_SET_MODE_REG, ~gpio_en & 0x3f);
+
+	/* Init GPIO IO Address */
+	pci_read_config_dword(dev, 0x18, &iobase);
+	iobase &= 0xffffffe0;
+	pci_write_config_byte(dev, GPIO_IO_LSB_REG, (iobase >> 0) & 0xff);
+	pci_write_config_byte(dev, GPIO_IO_MSB_REG, (iobase >> 8) & 0xff);
+
 	switch (dev->device) {
 	case FINTEK_F81504: /* 4 ports */
 	case FINTEK_F81508: /* 8 ports */
@@ -238,6 +540,31 @@ static int f81504_port_init(struct pci_dev *dev)
 	for (i = 0; i < max_port; ++i) {
 		/* UART0 configuration offset start from 0x40 */
 		config_base = UART_START_ADDR + UART_OFFSET * i;
+		is_gpio = false;
+
+		/* find every port to check is multi-function port? */
+		for (j = 0; j < ARRAY_SIZE(fintek_gpio_mapping); ++j) {
+			if (fintek_gpio_mapping[j] != i || !(gpio_en & BIT(j)))
+				continue;
+
+			/*
+			 * This port is multi-function and enabled as gpio
+			 * mode. So we'll not configure it as serial port.
+			 */
+			is_gpio = true;
+			break;
+		}
+
+		/*
+		 * If the serial port is setting to gpio mode, don't init it.
+		 * Disable the serial port for user-space application to
+		 * control.
+		 */
+		if (is_gpio) {
+			/* Disable current serial port */
+			pci_write_config_byte(dev, config_base + 0x00, 0x00);
+			continue;
+		}
 
 		/* Calculate Real IO Port */
 		iobase = (bar_data[i / 4] & 0xffffffe0) + (i % 4) * 8;
@@ -298,6 +625,16 @@ static int f81504_probe(struct pci_dev *dev, const struct pci_device_id
 		return -ENOMEM;
 
 	pci_set_drvdata(dev, priv);
+	mutex_init(&priv->locker);
+
+	/* Save the GPIO_ENABLE_REG after f81504_port_init() for future use */
+	pci_read_config_byte(dev, GPIO_ENABLE_REG, &priv->f0_gpio_flag);
+
+	/* Save GPIO IO Addr to private data */
+	pci_read_config_byte(dev, GPIO_IO_MSB_REG, &tmp);
+	priv->gpio_ioaddr = tmp << 8;
+	pci_read_config_byte(dev, GPIO_IO_LSB_REG, &tmp);
+	priv->gpio_ioaddr |= tmp;
 
 	/* Generate UART Ports */
 	for (i = 0; i < dev_id->driver_data; ++i) {
@@ -317,7 +654,23 @@ static int f81504_probe(struct pci_dev *dev, const struct pci_device_id
 		++priv->uart_count;
 	}
 
+	/* Generate GPIO Sets */
+	status = f81504_prepage_gpiolib(dev);
+	if (status)
+		goto fail;
+
 	return 0;
+
+fail:
+	for (i = 0; i < priv->uart_count; ++i) {
+		if (priv->line[i] < 0)
+			continue;
+
+		serial8250_unregister_port(priv->line[i]);
+	}
+
+	pci_disable_device(dev);
+	return status;
 }
 
 static void f81504_remove(struct pci_dev *dev)
@@ -332,6 +685,7 @@ static void f81504_remove(struct pci_dev *dev)
 		serial8250_unregister_port(priv->line[i]);
 	}
 
+	f81504_remove_gpiolib(dev);
 	pci_disable_device(dev);
 }
 
@@ -342,6 +696,8 @@ static int f81504_suspend(struct pci_dev *dev, pm_message_t state)
 	int status;
 	struct f81504_pci_private *priv = pci_get_drvdata(dev);
 
+	f81504_save_gpio_config(dev);
+
 	status = pci_save_state(dev);
 	if (status)
 		return status;
@@ -384,6 +740,7 @@ static int f81504_resume(struct pci_dev *dev)
 		serial8250_resume_port(priv->line[i]);
 	}
 
+	f81504_restore_gpio_config(dev);
 	return 0;
 }
 #else
-- 
1.9.1
