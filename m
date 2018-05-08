From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: [PATCH v3 3/3] tty: implement led triggers
Date: Tue,  8 May 2018 12:05:43 +0200
Message-ID: <20180508100543.12559-4-u.kleine-koenig@pengutronix.de>
References: <20180508100543.12559-1-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180508100543.12559-1-u.kleine-koenig@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Johan Hovold <johan@kernel.org>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Pavel Machek <pavel@ucw.cz>
Cc: linux-serial@vger.kernel.org, linux-leds@vger.kernel.org, linux-can@vger.kernel.org, kernel@pengutronix.de, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Florian Fainelli <f.fainelli@gmail.com>, Mathieu Poirier <mathieu.poirier@linaro.org>, linux-kernel@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

The rx trigger fires when data is pushed to the ldisc by the driver. This
is a bit later than the actual receiving of data but has the nice benefit
that it doesn't need adaption for each driver and isn't in the hot path.

Similarly the tx trigger fires when data was copied from userspace and is
given to the ldisc.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 arch/arm/boot/dts/imx25-logitech-baby.dts | 192 ++++++++++++++++++++++
 drivers/tty/Kconfig                       |   7 +
 drivers/tty/tty_buffer.c                  |   2 +
 drivers/tty/tty_io.c                      |   3 +
 drivers/tty/tty_port.c                    |  32 +++-
 include/linux/tty.h                       |  22 +++
 6 files changed, 256 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx25-logitech-baby.dts

diff --git a/arch/arm/boot/dts/imx25-logitech-baby.dts b/arch/arm/boot/dts/imx25-logitech-baby.dts
new file mode 100644
index 000000000000..39cf763d228b
--- /dev/null
+++ b/arch/arm/boot/dts/imx25-logitech-baby.dts
@@ -0,0 +1,192 @@
+/dts-v1/;
+#include "imx25.dtsi"
+
+/ {
+	model = "Logitech MX25 Baby";
+	compatible = "logitech,baby", "fsl,imx25";
+
+	chosen {
+		linux,stdout-path = &uart2;
+	};
+};
+
+&i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c1>;
+
+	clock-frequency = <100000>;
+
+	status = "okay";
+
+	codec: tlv320aic3104@18 {
+		compatible = "ti,tlv320aic310x";
+		reg = <0x18>;
+//		HPVDD-supply
+//		SPRVDD-supply
+//		SPLVDD-supply
+//		AVDD-supply
+//		IOVDD-supply
+//		DVDD-supply
+//		?gpio-reset
+//		?ai31xx-micbias-vg
+	};
+};
+
+&i2c2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c2>;
+
+	clock-frequency = <100000>;
+
+	status = "okay";
+
+	msp430@10 {
+		reg = <0x10>;
+	};
+};
+
+&iomuxc {
+	baby {
+		pinctrl_fec: fecgrp {
+			fsl,pins = <
+				MX25_PAD_FEC_MDC__FEC_MDC		0x040
+				MX25_PAD_FEC_MDIO__FEC_MDIO		0x1f0
+				MX25_PAD_FEC_TDATA0__FEC_TDATA0		0x040
+				MX25_PAD_FEC_TDATA1__FEC_TDATA1		0x040
+				MX25_PAD_A22__FEC_TDATA2		0x000
+				MX25_PAD_A23__FEC_TDATA3		0x000
+				MX25_PAD_FEC_TX_EN__FEC_TX_EN		0x040
+				MX25_PAD_FEC_RDATA0__FEC_RDATA0		0x0c0
+				MX25_PAD_FEC_RDATA1__FEC_RDATA1		0x0c0
+				MX25_PAD_A20__FEC_RDATA2		0x000
+				MX25_PAD_A21__FEC_RDATA3		0x000
+				MX25_PAD_FEC_RX_DV__FEC_RX_DV		0x0c0
+				MX25_PAD_FEC_TX_CLK__FEC_TX_CLK		0x1c0
+				MX25_PAD_A17__FEC_TX_ERR		0x080
+				MX25_PAD_A19__FEC_RX_ERR		0x080
+				MX25_PAD_A24__FEC_RX_CLK		0x000
+				MX25_PAD_A18__FEC_COL			0x080
+				MX25_PAD_A25__FEC_CRS			0x080
+
+				/*
+				 * PHY_RESET:
+				 * hwref 1: MX25_PIN_A10
+				 * hwref 2: MX25_PIN_CSI_D7
+				 * hwref 3+: MX25_PIN_PWM
+				 */
+				MX25_PAD_PWM__GPIO_1_26			0x0c0
+			>;
+		};
+
+		pinctrl_i2c1: i2c1grp {
+			fsl,pins = <
+				MX25_PAD_I2C1_CLK__I2C1_CLK		0x0a8
+				MX25_PAD_I2C1_DAT__I2C1_DAT		0x0a8
+			>;
+		};
+
+		pinctrl_i2c2: i2c2grp {
+			fsl,pins = <
+				MX25_PAD_GPIO_C__I2C2_SCL		0x0e8
+				MX25_PAD_GPIO_D__I2C2_SDA		0x0a8
+			>;
+		};
+
+		pinctrl_nfc: nfcgrp {
+			fsl,pins = <
+				MX25_PAD_NFRB__NFRB			0x0
+				MX25_PAD_NFWP_B__NFWP_B			0x0
+				MX25_PAD_NFRE_B__NFRE_B			0x0
+				MX25_PAD_NFWE_B__NFWE_B			0x0
+				MX25_PAD_NFALE__NFALE			0x0
+				MX25_PAD_NFCLE__NFCLE			0x0
+				MX25_PAD_NF_CE0__NF_CE0			0x0
+				MX25_PAD_D0__D0				0x0
+				MX25_PAD_D1__D1				0x0
+				MX25_PAD_D2__D2				0x0
+				MX25_PAD_D3__D3				0x0
+				MX25_PAD_D4__D4				0x0
+				MX25_PAD_D5__D5				0x0
+				MX25_PAD_D6__D6				0x0
+				MX25_PAD_D7__D7				0x0
+			>;
+		};
+
+		pinctrl_uart2: uart2grp {
+			fsl,pins = <
+				MX25_PAD_UART2_RXD__UART2_RXD	0x1e0
+				MX25_PAD_UART2_TXD__UART2_TXD	0x0e0
+				/*
+				 * These are configured in the vendor kernel,
+				 * but the corresponding lines don't seem to be
+				 * available:
+				 * MX25_PAD_UART2_RTS__UART2_RTS	0x1e0
+				 * MX25_PAD_UART2_CTS__UART2_CTS	0x0e0
+				 */
+			>;
+		};
+	};
+};
+
+&fec {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_fec>;
+
+	//phy-reset-gpios = <&gpio1 26 0>;
+	phy-handle = <&ethphy>;
+	phy-mode = "rmii";
+
+	status = "okay";
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ethphy: ethernet-phy@1 {
+			compatible = "ethernet-phy-ieee802.3-c22";
+			reg = <1>;
+			max-speed = <100>;
+		};
+	};
+};
+
+&kpp {
+	linux,keymap = <
+		0x000000cf	/* KEY_PLAY */
+		0x0001004e	/* KEY_KPPLUS */
+		0x00020069	/* KEY_LEFT */
+		0x00030066	/* KEY_HOME */
+		0x0100003b	/* KEY_F1 */
+		0x010100a4	/* KEY_PLAYPAUSE */
+		0x010200a3	/* KEY_NEXTSONG */
+		0x010300a5	/* KEY_PREVIOUSSONG */
+		0x0200003f	/* KEY_F5 */
+		0x0201003e	/* KEY_F4 */
+		0x0202003d	/* KEY_F3 */
+		0x0203003c	/* KEY_F2 */
+		0x03000000	/* KEY_RESERVED */
+		0x03010000	/* KEY_RESERVED */
+		0x0302008e	/* KEY_SLEEP */
+		0x03030040	/* KEY_F6 */
+		>;
+
+	status = "okay";
+};
+
+&nfc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_nfc>;
+
+	nand-on-flash-bbt;
+	nand-bus-width = <8>;
+	nand-ecc-mode = "hw";
+
+	status = "okay";
+};
+
+&uart2 {
+        pinctrl-names = "default";
+        pinctrl-0 = <&pinctrl_uart2>;
+
+        status = "okay";
+};
diff --git a/drivers/tty/Kconfig b/drivers/tty/Kconfig
index 0840d27381ea..b119c0fa1f5a 100644
--- a/drivers/tty/Kconfig
+++ b/drivers/tty/Kconfig
@@ -41,6 +41,13 @@ config VT
 	  If unsure, say Y, or else you won't be able to do much with your new
 	  shiny Linux system :-)
 
+config TTY_LEDS_TRIGGERS
+	bool "Enable support for TTY actions making LEDs blink"
+	depends on LEDS_TRIGGERS
+	---help---
+	  This enable support for tty triggers. It provides two LED triggers
+	  (rx and tx) for each TTY.
+
 config CONSOLE_TRANSLATIONS
 	depends on VT
 	default y
diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
index c996b6859c5e..364080ce8e91 100644
--- a/drivers/tty/tty_buffer.c
+++ b/drivers/tty/tty_buffer.c
@@ -521,6 +521,8 @@ static void flush_to_ldisc(struct work_struct *work)
 			continue;
 		}
 
+		tty_led_trigger_rx(port);
+
 		count = receive_buf(port, head, count);
 		if (!count)
 			break;
diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 7c838b90a31d..8ef597dc0c3d 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -955,6 +955,9 @@ static inline ssize_t do_tty_write(
 		ret = -EFAULT;
 		if (copy_from_user(tty->write_buf, buf, size))
 			break;
+
+		tty_led_trigger_tx(tty->port);
+
 		ret = write(tty, file, tty->write_buf, size);
 		if (ret <= 0)
 			break;
diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
index 25d736880013..d313edfa6315 100644
--- a/drivers/tty/tty_port.c
+++ b/drivers/tty/tty_port.c
@@ -37,6 +37,8 @@ static int tty_port_default_receive_buf(struct tty_port *port,
 
 	ret = tty_ldisc_receive_buf(disc, p, (char *)f, count);
 
+	tty_led_trigger_rx(port);
+
 	tty_ldisc_deref(disc);
 
 	return ret;
@@ -163,8 +165,31 @@ struct device *tty_port_register_device_attr_serdev(struct tty_port *port,
 		return dev;
 	}
 
-	return tty_register_device_attr(driver, index, device, drvdata,
-			attr_grp);
+	if (IS_ENABLED(CONFIG_TTY_LEDS_TRIGGERS)) {
+		int ret;
+
+		ret = led_trigger_register_format(&port->led_trigger_rx,
+						  "%s%d-rx", driver->name, index);
+		if (ret < 0)
+			pr_warn("Failed to register rx trigger for %s%d (%d)\n",
+				driver->name, index, ret);
+
+		ret = led_trigger_register_format(&port->led_trigger_tx,
+						  "%s%d-tx", driver->name, index);
+		if (ret < 0)
+			pr_warn("Failed to register tx trigger for %s%d (%d)\n",
+				driver->name, index, ret);
+	}
+
+	dev = tty_register_device_attr(driver, index,
+				       device, drvdata, attr_grp);
+
+	if (IS_ENABLED(CONFIG_TTY_LEDS_TRIGGERS) && IS_ERR(dev)) {
+		led_trigger_unregister_simple(port->led_trigger_tx);
+		led_trigger_unregister_simple(port->led_trigger_rx);
+	}
+
+	return dev;
 }
 EXPORT_SYMBOL_GPL(tty_port_register_device_attr_serdev);
 
@@ -206,6 +231,9 @@ void tty_port_unregister_device(struct tty_port *port,
 	if (ret == 0)
 		return;
 
+	led_trigger_unregister_simple(port->led_trigger_rx);
+	led_trigger_unregister_simple(port->led_trigger_tx);
+
 	tty_unregister_device(driver, index);
 }
 EXPORT_SYMBOL_GPL(tty_port_unregister_device);
diff --git a/include/linux/tty.h b/include/linux/tty.h
index 1dd587ba6d88..7e48de671bfa 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -13,6 +13,7 @@
 #include <uapi/linux/tty.h>
 #include <linux/rwsem.h>
 #include <linux/llist.h>
+#include <linux/leds.h>
 
 
 /*
@@ -249,8 +250,29 @@ struct tty_port {
 						   set to size of fifo */
 	struct kref		kref;		/* Ref counter */
 	void 			*client_data;
+
+	struct led_trigger	*led_trigger_rx;
+	struct led_trigger	*led_trigger_tx;
 };
 
+static inline void tty_led_trigger(struct led_trigger *trig)
+{
+	unsigned long delay_ms = 50;
+
+	if (IS_ENABLED(CONFIG_TTY_LEDS_TRIGGERS))
+		led_trigger_blink_oneshot(trig, &delay_ms, &delay_ms, 0);
+}
+
+static inline void tty_led_trigger_rx(struct tty_port *port)
+{
+	tty_led_trigger(port->led_trigger_rx);
+}
+
+static inline void tty_led_trigger_tx(struct tty_port *port)
+{
+	tty_led_trigger(port->led_trigger_tx);
+}
+
 /* tty_port::iflags bits -- use atomic bit ops */
 #define TTY_PORT_INITIALIZED	0	/* device is initialized */
 #define TTY_PORT_SUSPENDED	1	/* device is suspended */
-- 
2.17.0
