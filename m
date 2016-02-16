From: Peter Hung <hpeter@gmail.com>
Subject: [PATCH V3 1/4] mfd: f81504-core: Add Fintek F81504/508/512 PCIE-to-UART/GPIO core support
Date: Tue, 16 Feb 2016 14:55:07 +0800
Message-ID: <1455605710-3724-2-git-send-email-hpeter+linux_kernel@gmail.com>
References: <1455605710-3724-1-git-send-email-hpeter+linux_kernel@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1455605710-3724-1-git-send-email-hpeter+linux_kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linus.walleij@linaro.org, gnurou@gmail.com, gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com, paul.gortmaker@windriver.com, lee.jones@linaro.org, jslaby@suse.com, gnomes@lxorguk.ukuu.org.uk, peter_hong@fintek.com.tw
Cc: heikki.krogerus@linux.intel.com, peter@hurleysoftware.com, soeren.grunewald@desy.de, udknight@gmail.com, adam.lee@canonical.com, arnd@arndb.de, manabian@gmail.com, scottwood@freescale.com, yamada.masahiro@socionext.com, paul.burton@imgtec.com, mans@mansr.com, matthias.bgg@gmail.com, ralf@linux-mips.org, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, tom_tsai@fintek.com.tw, Peter Hung <hpeter+linux_kernel@gmail.com>
List-Id: linux-serial@vger.kernel.org

The Fintek F81504/508/512 had implemented the basic serial port function in
8250_pci.c. We try to implement high baudrate & GPIOLIB with a spilt file
8250_f81504.c, but it seems too complex to add GPIOLIB.

Alan & Andy recommend us to rewrite and spilt our driver with MFD
architecture.
https://lkml.org/lkml/2016/1/19/288

This driver is core driver for F81504/508/512, it'll handle the generation
of UART/GPIO platform device and initialize PCIE configuration space when
probe()/resume().

IC function list:
    F81504: Max 2x8 GPIOs and max 4 serial ports
        port2/3 are multi-function
    F81508: Max 6x8 GPIOs and max 8 serial ports
        port2/3 are multi-function, port8/9/10/11 are gpio only
    F81512: Max 6x8 GPIOs and max 12 serial ports
        port2/3/8/9/10/11 are multi-function

H/W provider could changes the PCI configure space F0/F3h
values in EEPROM or ASL code to change mode.

    F0h bit0~5: Enable GPIO0~5
        bit6~7: Reserve

    F3h bit0~5: Multi-Functional Flag (0:GPIO/1:UART)
        bit0: UART2 pin out for UART2 / GPIO0
        bit1: UART3 pin out for UART3 / GPIO1
        bit2: UART8 pin out for UART8 / GPIO2
        bit3: UART9 pin out for UART9 / GPIO3
        bit4: UART10 pin out for UART10 / GPIO4
        bit5: UART11 pin out for UART11 / GPIO5
        bit6~7: Reserve

Suggested-by: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Peter Hung <hpeter+linux_kernel@gmail.com>
---
 drivers/mfd/Kconfig        |  12 ++
 drivers/mfd/Makefile       |   2 +
 drivers/mfd/f81504-core.c  | 336 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/mfd/f81504.h |  52 +++++++
 4 files changed, 402 insertions(+)
 create mode 100644 drivers/mfd/f81504-core.c
 create mode 100644 include/linux/mfd/f81504.h

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index aa21dc5..775761f 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -345,6 +345,18 @@ config HTC_I2CPLD
 	  This device provides input and output GPIOs through an I2C
 	  interface to one or more sub-chips.
 
+config MFD_FINTEK_F81504_CORE
+        tristate "Fintek F81504/508/512 PCIE-to-UART/GPIO MFD support"
+        depends on PCI
+        select MFD_CORE
+        default SERIAL_8250
+        help
+          This driver provides the F81504/508/512 UART & GPIO platform
+          devices. You should enable CONFIG_GPIO_F81504 to get GPIOLIB
+          support and CONFIG_8250_F81504 to get serial port support.
+          This driver needs to be built into the kernel to use early
+          console support.
+
 config MFD_INTEL_QUARK_I2C_GPIO
 	tristate "Intel Quark MFD I2C GPIO"
 	depends on PCI
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 5eaa6465d..8e581ad 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -22,6 +22,8 @@ obj-$(CONFIG_HTC_EGPIO)		+= htc-egpio.o
 obj-$(CONFIG_HTC_PASIC3)	+= htc-pasic3.o
 obj-$(CONFIG_HTC_I2CPLD)	+= htc-i2cpld.o
 
+obj-$(CONFIG_MFD_FINTEK_F81504_CORE)	+= f81504-core.o
+
 obj-$(CONFIG_MFD_DAVINCI_VOICECODEC)	+= davinci_voicecodec.o
 obj-$(CONFIG_MFD_DM355EVM_MSP)	+= dm355evm_msp.o
 obj-$(CONFIG_MFD_TI_AM335X_TSCADC)	+= ti_am335x_tscadc.o
diff --git a/drivers/mfd/f81504-core.c b/drivers/mfd/f81504-core.c
new file mode 100644
index 0000000..12a5f7f
--- /dev/null
+++ b/drivers/mfd/f81504-core.c
@@ -0,0 +1,336 @@
+/*
+ * Core operations for Fintek F81504/508/512 PCIE-to-UART/GPIO device
+ */
+#include <linux/platform_device.h>
+#include <linux/pci.h>
+#include <linux/gpio.h>
+#include <linux/module.h>
+#include <linux/version.h>
+#include <linux/mfd/core.h>
+#include <linux/mfd/f81504.h>
+
+#define F81504_IO_REGION	8
+
+const u8 fintek_gpio_mapping[F81504_MAX_GPIO_CNT] = { 2, 3, 8, 9, 10, 11 };
+EXPORT_SYMBOL(fintek_gpio_mapping);
+
+static bool f81504_is_gpio(unsigned int idx, u8 gpio_en)
+{
+	unsigned int i;
+
+	/* find every port to check is multi-function port? */
+	for (i = 0; i < ARRAY_SIZE(fintek_gpio_mapping); i++) {
+		if (fintek_gpio_mapping[i] != idx || !(gpio_en & BIT(i)))
+			continue;
+
+		/*
+		 * This port is multi-function and enabled as gpio
+		 * mode. So we'll not configure it as serial port.
+		 */
+		return true;
+	}
+
+	return false;
+}
+
+static int f81504_port_init(struct pci_dev *pdev)
+{
+	struct f81504_pci_private *priv = pci_get_drvdata(pdev);
+	unsigned int i;
+	u32 gpio_addr;
+	u8 gpio_en, f0h_data, f3h_data;
+	u32 max_port, iobase;
+	u32 bar_data[3];
+	u16 tmp;
+	u8 config_base;
+
+	/* Init GPIO IO Address */
+	gpio_addr = pci_resource_start(pdev, 2);
+
+	/*
+	 * Write GPIO IO Address LSB/MSB to corresponding register. Due to we
+	 * can't write once with pci_write_config_word() on x86 platform, we'll
+	 * write it with pci_write_config_byte().
+	 */
+	pci_write_config_byte(pdev, F81504_GPIO_IO_LSB_REG, gpio_addr & 0xff);
+	pci_write_config_byte(pdev, F81504_GPIO_IO_MSB_REG, (gpio_addr >> 8) &
+			      0xff);
+
+	/*
+	 * The PCI board is multi-function, some serial port can converts to
+	 * GPIO function. Customers could changes the F0/F3h values in EEPROM
+	 *
+	 * F0h bit0~5: Enable GPIO0~5
+	 *     bit6~7: Reserve
+	 *
+	 * F3h bit0~5: Multi-Functional Flag (0:GPIO/1:UART)
+	 *		bit0: UART2 pin out for UART2 / GPIO0
+	 *		bit1: UART3 pin out for UART3 / GPIO1
+	 *		bit2: UART8 pin out for UART8 / GPIO2
+	 *		bit3: UART9 pin out for UART9 / GPIO3
+	 *		bit4: UART10 pin out for UART10 / GPIO4
+	 *		bit5: UART11 pin out for UART11 / GPIO5
+	 *     bit6~7: Reserve
+	 */
+	if (priv) {
+		/* Re-save GPIO IO address for called by resume() */
+		priv->gpio_ioaddr = gpio_addr;
+
+		/* Reinit from resume(), read the previous value from priv */
+		gpio_en = priv->gpio_en;
+	} else {
+		/* Driver first init */
+		pci_read_config_byte(pdev, F81504_GPIO_ENABLE_REG, &f0h_data);
+		pci_read_config_byte(pdev, F81504_GPIO_MODE_REG, &f3h_data);
+
+		/* Find the max set of GPIOs */
+		gpio_en = f0h_data | ~f3h_data;
+	}
+
+	/*
+	 * We'll determinate the max count of serial port by IC Product ID.
+	 * Product ID list: F81504 pid = 0x1104
+	 *                  F81508 pid = 0x1108
+	 *                  F81512 pid = 0x1112
+	 *
+	 * In F81504/508, we can use pid & 0xff to get max serial port count,
+	 * but F81512 can't use this. So we should direct set F81512 to 12.
+	 */
+	switch (pdev->device) {
+	case FINTEK_F81504: /* 4 ports */
+		/* F81504 max 2 sets of GPIO, others are max 6 sets */
+		gpio_en &= 0x03;
+	case FINTEK_F81508: /* 8 ports */
+		max_port = pdev->device & 0xff;
+		break;
+	case FINTEK_F81512: /* 12 ports */
+		max_port = 12;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* Rewrite GPIO Mode setting */
+	pci_write_config_byte(pdev, F81504_GPIO_ENABLE_REG, gpio_en & 0x3f);
+	pci_write_config_byte(pdev, F81504_GPIO_MODE_REG, ~gpio_en & 0x3f);
+
+	/* Get the UART IO address dispatch from the BIOS */
+	for (i = 0; i < 3; i++)
+		bar_data[i] = pci_resource_start(pdev, 3 + i);
+
+	/* Compatible bit for newer step IC */
+	pci_read_config_word(pdev, F81504_IRQSEL_REG, &tmp);
+	tmp |= BIT(8);
+	pci_write_config_word(pdev, F81504_IRQSEL_REG, tmp);
+
+	for (i = 0; i < max_port; i++) {
+		/* UART0 configuration offset start from 0x40 */
+		config_base = F81504_UART_START_ADDR + F81504_UART_OFFSET * i;
+
+		/*
+		 * If the serial port is setting to gpio mode, don't init it.
+		 * Disable the serial port for user-space application to
+		 * control.
+		 */
+		if (f81504_is_gpio(i, gpio_en)) {
+			/* Disable current serial port */
+			pci_write_config_byte(pdev, config_base + 0x00, 0x00);
+			continue;
+		}
+
+		/* Calculate Real IO Port */
+		iobase = (bar_data[i / 4] & 0xffffffe0) + (i % 4) * 8;
+
+		/* Enable UART I/O port */
+		pci_write_config_byte(pdev, config_base + 0x00, 0x01);
+
+		/* Select 128-byte FIFO and 8x FIFO threshold */
+		pci_write_config_byte(pdev, config_base + 0x01, 0x33);
+
+		/* Write UART IO address */
+		pci_write_config_word(pdev, config_base + 0x04, iobase);
+
+		pci_write_config_byte(pdev, config_base + 0x06, pdev->irq);
+
+		/*
+		 * Force init to RS232 / Share Mode, recovery previous mode
+		 * will done in F81504 8250 platform driver resume().
+		 */
+		pci_write_config_byte(pdev, config_base + 0x07, 0x01);
+	}
+
+	return 0;
+}
+
+static int f81504_prepage_serial_port(struct pci_dev *pdev, int max_port)
+{
+	struct resource	resources = DEFINE_RES_IO(0, 0);
+	struct mfd_cell f81504_serial_cell = {
+		.name = F81504_SERIAL_NAME,
+		.num_resources	= 1,
+		.pdata_size = sizeof(unsigned int),
+	};
+	unsigned int i;
+	u8 tmp;
+	u16 iobase;
+	int status;
+
+	for (i = 0; i < max_port; i++) {
+		/* Check UART is enabled */
+		pci_read_config_byte(pdev, F81504_UART_START_ADDR + i *
+				     F81504_UART_OFFSET, &tmp);
+		if (!tmp)
+			continue;
+
+		/* Get UART IO Address */
+		pci_read_config_word(pdev, F81504_UART_START_ADDR + i *
+				     F81504_UART_OFFSET + 4, &iobase);
+
+		resources.start = iobase;
+		resources.end = iobase + F81504_IO_REGION - 1;
+
+		f81504_serial_cell.resources = &resources;
+		f81504_serial_cell.platform_data = &i;
+
+		status = mfd_add_devices(&pdev->dev, PLATFORM_DEVID_AUTO,
+					 &f81504_serial_cell, 1, NULL,
+					 pdev->irq, NULL);
+		if (status) {
+			dev_warn(&pdev->dev, "%s: add device failed: %d\n",
+				 __func__, status);
+			return status;
+		}
+	}
+
+	return 0;
+}
+
+static int f81504_prepage_gpiolib(struct pci_dev *pdev)
+{
+	struct f81504_pci_private *priv = pci_get_drvdata(pdev);
+	struct mfd_cell f81504_gpio_cell = {
+		.name = F81504_GPIO_NAME,
+		.pdata_size = sizeof(unsigned int),
+	};
+	unsigned int i;
+	int status;
+
+	for (i = 0; i < ARRAY_SIZE(fintek_gpio_mapping); i++) {
+		if (!(priv->gpio_en & BIT(i)))
+			continue;
+
+		f81504_gpio_cell.platform_data = &i;
+		status = mfd_add_devices(&pdev->dev, PLATFORM_DEVID_AUTO,
+					 &f81504_gpio_cell, 1, NULL, pdev->irq,
+					 NULL);
+		if (status) {
+			dev_warn(&pdev->dev, "%s: add device failed: %d\n",
+				 __func__, status);
+			return status;
+		}
+	}
+
+	return 0;
+}
+
+static int f81504_probe(struct pci_dev *pdev, const struct pci_device_id
+			*dev_id)
+{
+	struct f81504_pci_private *priv;
+	u8 tmp;
+	int status;
+
+	status = pcim_enable_device(pdev);
+	if (status)
+		return status;
+
+	/* Init PCI Configuration Space */
+	status = f81504_port_init(pdev);
+	if (status)
+		return status;
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(struct f81504_pci_private),
+			    GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	/* Save the GPIO_ENABLE_REG after f81504_port_init() for future use */
+	pci_read_config_byte(pdev, F81504_GPIO_ENABLE_REG, &priv->gpio_en);
+
+	/*
+	 * Save GPIO IO Addr to private data. Due to we can't read once with
+	 * pci_read_config_word() on x86 platform, we'll read it with
+	 * pci_read_config_byte().
+	 */
+	pci_read_config_byte(pdev, F81504_GPIO_IO_MSB_REG, &tmp);
+	priv->gpio_ioaddr = tmp << 8;
+	pci_read_config_byte(pdev, F81504_GPIO_IO_LSB_REG, &tmp);
+	priv->gpio_ioaddr |= tmp;
+
+	pci_set_drvdata(pdev, priv);
+
+	/* Generate UART Ports */
+	status = f81504_prepage_serial_port(pdev, dev_id->driver_data);
+	if (status)
+		return status;
+
+	/* Generate GPIO Sets */
+	status = f81504_prepage_gpiolib(pdev);
+	if (status)
+		return status;
+
+	return 0;
+}
+
+static void f81504_remove(struct pci_dev *pdev)
+{
+	mfd_remove_devices(&pdev->dev);
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int f81504_suspend(struct device *dev)
+{
+	return 0;
+}
+
+static int f81504_resume(struct device *dev)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	int status;
+
+	/* Re-init PCI Configuration Space */
+	status = f81504_port_init(pdev);
+	if (status)
+		return status;
+
+	return 0;
+}
+#endif
+
+static const struct pci_device_id f81504_dev_table[] = {
+	/* Fintek PCI serial cards */
+	{PCI_DEVICE(FINTEK_VID, FINTEK_F81504), .driver_data = 4},
+	{PCI_DEVICE(FINTEK_VID, FINTEK_F81508), .driver_data = 8},
+	{PCI_DEVICE(FINTEK_VID, FINTEK_F81512), .driver_data = 12},
+	{}
+};
+
+static SIMPLE_DEV_PM_OPS(f81504_pm_ops, f81504_suspend, f81504_resume);
+
+static struct pci_driver f81504_driver = {
+	.name = "f81504_core",
+	.probe = f81504_probe,
+	.remove = f81504_remove,
+	.driver		= {
+		.pm	= &f81504_pm_ops,
+		.owner	= THIS_MODULE,
+	},
+	.id_table = f81504_dev_table,
+};
+
+module_pci_driver(f81504_driver);
+
+MODULE_DEVICE_TABLE(pci, f81504_dev_table);
+MODULE_DESCRIPTION("Fintek F81504/508/512 PCIE-to-UART core");
+MODULE_AUTHOR("Peter Hong <Peter_Hong@fintek.com.tw>");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/mfd/f81504.h b/include/linux/mfd/f81504.h
new file mode 100644
index 0000000..820d4e0
--- /dev/null
+++ b/include/linux/mfd/f81504.h
@@ -0,0 +1,52 @@
+#ifndef __MFD_F81504_H__
+#define __MFD_F81504_H__
+
+#define FINTEK_VID			0x1c29
+#define FINTEK_F81504			0x1104
+#define FINTEK_F81508			0x1108
+#define FINTEK_F81512			0x1112
+
+#define FINTEK_MAX_PORT			12
+#define FINTEK_GPIO_NAME_LEN		32
+#define FINTEK_GPIO_DISPLAY		"GPIO"
+
+#define F81504_UART_START_ADDR		0x40
+#define F81504_UART_MODE_OFFSET		0x07
+#define F81504_UART_OFFSET		0x08
+
+/* RTS will control by MCR if this bit is 0 */
+#define F81504_RTS_CONTROL_BY_HW	BIT(4)
+/* only worked with FINTEK_RTS_CONTROL_BY_HW on */
+#define F81504_RTS_INVERT		BIT(5)
+
+#define F81504_CLOCK_RATE_MASK		0xc0
+#define F81504_CLKSEL_1DOT846_MHZ	0x00
+#define F81504_CLKSEL_18DOT46_MHZ	0x40
+#define F81504_CLKSEL_24_MHZ		0x80
+#define F81504_CLKSEL_14DOT77_MHZ	0xc0
+
+#define F81504_IRQSEL_REG		0xb8
+
+#define F81504_GPIO_ENABLE_REG		0xf0
+#define F81504_GPIO_IO_LSB_REG		0xf1
+#define F81504_GPIO_IO_MSB_REG		0xf2
+#define F81504_GPIO_MODE_REG		0xf3
+
+#define F81504_GPIO_START_ADDR		0xf8
+#define F81504_GPIO_OUT_EN_OFFSET	0x00
+#define F81504_GPIO_DRIVE_EN_OFFSET	0x01
+#define F81504_GPIO_SET_OFFSET		0x08
+
+#define F81504_GPIO_NAME		"f81504_gpio"
+#define F81504_SERIAL_NAME		"f81504_serial"
+#define F81504_MAX_GPIO_CNT		6
+
+extern const u8 fintek_gpio_mapping[F81504_MAX_GPIO_CNT];
+
+struct f81504_pci_private {
+	int line[FINTEK_MAX_PORT];
+	u8 gpio_en;
+	u16 gpio_ioaddr;
+	u32 uart_count, gpio_count;
+};
+#endif
-- 
1.9.1
