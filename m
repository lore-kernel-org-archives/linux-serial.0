From: Janusz Uzycki <j.uzycki@elproma.com.pl>
Subject: [PATCH v3 1/4] tty: serial_mctrl_gpio: Add irqs helpers for input lines
Date: Fri,  6 Feb 2015 17:55:32 +0100
Message-ID: <1423241735-30387-1-git-send-email-j.uzycki@elproma.com.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-gpio-owner@vger.kernel.org>
Sender: linux-gpio-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, =?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?= <shc_work@mail.ru>
Cc: fabio.estevam@freescale.com, Richard Genoud <richard.genoud@gmail.com>, Fabio Estevam <festevam@gmail.com>, linux-serial@vger.kernel.org, linux-gpio@vger.kernel.org, Alexandre Courbot <gnurou@gmail.com>, linux-arm-kernel@lists.infradead.org, Janusz Uzycki <j.uzycki@elproma.com.pl>
List-Id: linux-serial@vger.kernel.org

A driver using mctrl_gpio called gpiod_get_direction() to check if
gpio is input line. However .get_direction callback is not available
for all platforms. The patch allows to avoid the function.
The patch introduces the following helpers:
- mctrl_gpio_request_irqs
- mctrl_gpio_free_irqs
- mctrl_gpio_enable_ms
- mctrl_gpio_disable_ms
They allow to:
- simplify drivers which use mctrl_gpio
- hide irq table in mctrl_gpio
- use default irq handler for gpios
- better separate code for gpio modem lines from uart's code
In addition mctrl_gpio_init() has been renamed to mctrl_gpio_init_dt()
to focus DT usage. Also mctrl_gpio_init_dt() initializes irq table for
gpios now and passes struct uart_port into struct mctrl_gpios.
This resulted in changed mctrl_gpio_init_dt() parameter.
It also requires port->dev is set before the function is called.

There were also fixed:
- irq =3D 0 means invalid/unused (-EINVAL no more used)
- mctrl_gpio_request_irqs() doesn't use negative enum value
  if request_irq() failed.

The mctrl_gpio_is_gpio() inline function is under discussion
and likely it can replace exported mctrl_gpio_to_gpiod() function.

Signed-off-by: Janusz Uzycki <j.uzycki@elproma.com.pl>
---

The patch requires to update the drivers which use mctrl_gpio:
- atmel_serial
- mxs-auart
- clps711x

Please test it again on the platforms above.
Compile tests (next-20150204) and a test on mxs (i.mx28)
hardware were done only.

Changes since RFC v2:
 - fixed mctrl_gpio_request_irqs(): just calling mctrl_gpio_free_irqs()
   on failure was wrong idea because free_irq() would be called for not
   requested irqs yet and kernel/irq/manage.c: free_irq(): __free_irq()=
:
   WARN: "Trying to free already-free IRQ %d" would appear
 - fixed mctrl_gpio_is_gpio() inline function:
   1. allow to compile when CONFIG_GPIOLIB is not defined
      (inline is not broken, reported by Richard Genoud),
   2. now a serial driver also can be a module
      (exported function used),
   3. gpios can be NULL (protected in mctrl_gpio_to_gpiod())
   It calls mctrl_gpio_to_gpiod() which likely can be removed and
   replaced by simpler mctrl_gpio_is_gpio()
 - IRQ_NOAUTOEN setting and request_irq() atomic issue commented in the
   code (thanks to Uwe Kleine-K=C3=B6nig) despite other drivers do the =
same
 - removed (clean up) useless comment "return -ENOTSUP" from
   mctrl_gpio_request_irqs() inline function, it shouldn't return any
   error if serial_mctrl_gpio.h is just a stub, ie. CONFIG_GPIOLIB not =
defined
 - fixed mctrl_gpio_request_irqs(), mctrl_gpio_free_irqs(),
   mctrl_gpio_enable_ms(), mctrl_gpio_disable_ms:
   if "gpios" is NULL just return without any error. Serial drivers don=
't fail
   on probe(), just warns, if mctrl_gpio_init_dt() returns NULL or an e=
rror.
 - updated the documentation on mctrl_ helpers: Documentation/serial/dr=
iver

---
 Documentation/serial/driver            |  22 +++++-
 drivers/tty/serial/serial_mctrl_gpio.c | 132 +++++++++++++++++++++++++=
+++++++-
 drivers/tty/serial/serial_mctrl_gpio.h |  61 ++++++++++++++-
 3 files changed, 209 insertions(+), 6 deletions(-)

diff --git a/Documentation/serial/driver b/Documentation/serial/driver
index c415b0e..7a0811c 100644
--- a/Documentation/serial/driver
+++ b/Documentation/serial/driver
@@ -439,7 +439,7 @@ Modem control lines via GPIO
=20
 Some helpers are provided in order to set/get modem control lines via =
GPIO.
=20
-mctrl_gpio_init(dev, idx):
+mctrl_gpio_init_dt(port, idx)
 	This will get the {cts,rts,...}-gpios from device tree if they are
 	present and request them, set direction etc, and return an
 	allocated structure. devm_* functions are used, so there's no need
@@ -453,8 +453,28 @@ mctrl_gpio_free(dev, gpios):
 mctrl_gpio_to_gpiod(gpios, gidx)
 	This returns the gpio structure associated to the modem line index.
=20
+mctrl_gpio_is_gpio(gpios, gidx)
+	This returns true if the given modem line index is initialized and
+	handled by mtrl_gpio, ie. the line is a gpio line.
+
 mctrl_gpio_set(gpios, mctrl):
 	This will sets the gpios according to the mctrl state.
=20
 mctrl_gpio_get(gpios, mctrl):
 	This will update mctrl with the gpios values.
+
+mctrl_gpio_request_irqs(gpios)
+	This requests an interrupt of each input gpio line. The interupts
+	are set disabled and triggered on both edges.
+	It returns an error code or zero if success.
+
+mctrl_gpio_free_irqs(gpios)
+	This will free the requested interrupts of gpio lines.
+
+mctrl_gpio_enable_ms(gpios)
+	This enables modem status interrupts assigned to gpio lines.
+	It should be called by enable_ms() of an uart driver.
+
+mctrl_gpio_disable_ms(gpios)
+	This disables modem status interrupts assigned to gpio lines.
+	It should be called by disable_ms() of an uart driver.
diff --git a/drivers/tty/serial/serial_mctrl_gpio.c b/drivers/tty/seria=
l/serial_mctrl_gpio.c
index a38596c..7c43d15 100644
--- a/drivers/tty/serial/serial_mctrl_gpio.c
+++ b/drivers/tty/serial/serial_mctrl_gpio.c
@@ -19,11 +19,15 @@
 #include <linux/device.h>
 #include <linux/gpio/consumer.h>
 #include <linux/termios.h>
+#include <linux/irq.h>
=20
 #include "serial_mctrl_gpio.h"
=20
 struct mctrl_gpios {
+	struct uart_port *port;
 	struct gpio_desc *gpio[UART_GPIO_MAX];
+	int irq[UART_GPIO_MAX];
+	unsigned int mctrl_prev;
 };
=20
 static const struct {
@@ -96,8 +100,9 @@ unsigned int mctrl_gpio_get(struct mctrl_gpios *gpio=
s, unsigned int *mctrl)
 }
 EXPORT_SYMBOL_GPL(mctrl_gpio_get);
=20
-struct mctrl_gpios *mctrl_gpio_init(struct device *dev, unsigned int i=
dx)
+struct mctrl_gpios *mctrl_gpio_init_dt(struct uart_port *port, unsigne=
d int idx)
 {
+	struct device *dev =3D port->dev;
 	struct mctrl_gpios *gpios;
 	enum mctrl_gpio_idx i;
 	int err;
@@ -106,6 +111,7 @@ struct mctrl_gpios *mctrl_gpio_init(struct device *=
dev, unsigned int idx)
 	if (!gpios)
 		return ERR_PTR(-ENOMEM);
=20
+	gpios->port =3D port;
 	for (i =3D 0; i < UART_GPIO_MAX; i++) {
 		gpios->gpio[i] =3D devm_gpiod_get_index(dev,
 						      mctrl_gpios_desc[i].name,
@@ -128,11 +134,13 @@ struct mctrl_gpios *mctrl_gpio_init(struct device=
 *dev, unsigned int idx)
 			devm_gpiod_put(dev, gpios->gpio[i]);
 			gpios->gpio[i] =3D NULL;
 		}
+		if (gpios->gpio[i] && !mctrl_gpios_desc[i].dir_out)
+			gpios->irq[i] =3D gpiod_to_irq(gpios->gpio[i]);
 	}
=20
 	return gpios;
 }
-EXPORT_SYMBOL_GPL(mctrl_gpio_init);
+EXPORT_SYMBOL_GPL(mctrl_gpio_init_dt);
=20
 void mctrl_gpio_free(struct device *dev, struct mctrl_gpios *gpios)
 {
@@ -147,3 +155,123 @@ void mctrl_gpio_free(struct device *dev, struct m=
ctrl_gpios *gpios)
 	devm_kfree(dev, gpios);
 }
 EXPORT_SYMBOL_GPL(mctrl_gpio_free);
+
+/*
+ * Dealing with GPIO interrupt
+ */
+#define MCTRL_ANY_DELTA        (TIOCM_RI | TIOCM_DSR | TIOCM_CD | TIOC=
M_CTS)
+static irqreturn_t mctrl_gpio_irq_handle(int irq, void *context)
+{
+	struct mctrl_gpios *gpios =3D context;
+	struct uart_port *port =3D gpios->port;
+	u32 mctrl =3D gpios->mctrl_prev;
+	u32 mctrl_diff;
+
+	mctrl_gpio_get(gpios, &mctrl);
+
+	mctrl_diff =3D mctrl ^ gpios->mctrl_prev;
+	gpios->mctrl_prev =3D mctrl;
+	if (mctrl_diff & MCTRL_ANY_DELTA && port->state !=3D NULL) {
+		if (mctrl_diff & TIOCM_RI)
+			port->icount.rng++;
+		if (mctrl_diff & TIOCM_DSR)
+			port->icount.dsr++;
+		if (mctrl_diff & TIOCM_CD)
+			uart_handle_dcd_change(port, mctrl & TIOCM_CD);
+		if (mctrl_diff & TIOCM_CTS)
+			uart_handle_cts_change(port, mctrl & TIOCM_CTS);
+
+		wake_up_interruptible(&port->state->port.delta_msr_wait);
+	}
+
+	return IRQ_HANDLED;
+}
+
+int mctrl_gpio_request_irqs(struct mctrl_gpios *gpios)
+{
+	struct uart_port *port =3D gpios->port;
+	int *irq =3D gpios->irq;
+	enum mctrl_gpio_idx i;
+	int err =3D 0;
+
+	/* When gpios is NULL just gpio irqs are also never set
+	 * so return without any error */
+	if (IS_ERR_OR_NULL(gpios))
+		return err;
+
+	for (i =3D 0; i < UART_GPIO_MAX; i++) {
+		if (irq[i] <=3D 0)
+			continue;
+
+		/*
+		 * FIXME IRQ_NOAUTOEN:
+		 * This is not undone in the error path. To be fixed
+		 * properly this needs to be set atomically together with
+		 * request_irq.
+		 */
+		irq_set_status_flags(irq[i], IRQ_NOAUTOEN);
+		err =3D request_irq(irq[i], mctrl_gpio_irq_handle,
+				  IRQ_TYPE_EDGE_BOTH,
+				  dev_name(port->dev), gpios);
+		if (err) {
+			dev_err(port->dev, "%s: Can't get %d irq\n",
+				__func__, irq[i]);
+			break;
+		}
+	}
+
+	/*
+	 * If something went wrong, rollback avoiding
+	 * negative enum values.
+	 */
+	while (err && i > 0) {
+		i--;
+		if (irq[i] > 0)
+			free_irq(irq[i], gpios);
+	}
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(mctrl_gpio_request_irqs);
+
+void mctrl_gpio_free_irqs(struct mctrl_gpios *gpios)
+{
+	enum mctrl_gpio_idx i;
+
+	if (IS_ERR_OR_NULL(gpios))
+		return;
+
+	for (i =3D 0; i < UART_GPIO_MAX; i++)
+		if (gpios->irq[i] > 0)
+			free_irq(gpios->irq[i], gpios);
+}
+EXPORT_SYMBOL_GPL(mctrl_gpio_free_irqs);
+
+void mctrl_gpio_enable_ms(struct mctrl_gpios *gpios)
+{
+	enum mctrl_gpio_idx i;
+
+	if (IS_ERR_OR_NULL(gpios))
+		return;
+
+	/* get initial status of modem lines GPIOs */
+	mctrl_gpio_get(gpios, &gpios->mctrl_prev);
+
+	for (i =3D 0; i < UART_GPIO_MAX; i++)
+		if (gpios->irq[i] > 0)
+			enable_irq(gpios->irq[i]);
+}
+EXPORT_SYMBOL_GPL(mctrl_gpio_enable_ms);
+
+void mctrl_gpio_disable_ms(struct mctrl_gpios *gpios)
+{
+	enum mctrl_gpio_idx i;
+
+	if (IS_ERR_OR_NULL(gpios))
+		return;
+
+	for (i =3D 0; i < UART_GPIO_MAX; i++)
+		if (gpios->irq[i] > 0)
+			disable_irq(gpios->irq[i]);
+}
+EXPORT_SYMBOL_GPL(mctrl_gpio_disable_ms);
diff --git a/drivers/tty/serial/serial_mctrl_gpio.h b/drivers/tty/seria=
l/serial_mctrl_gpio.h
index 400ba04..1f79be3 100644
--- a/drivers/tty/serial/serial_mctrl_gpio.h
+++ b/drivers/tty/serial/serial_mctrl_gpio.h
@@ -21,6 +21,7 @@
 #include <linux/err.h>
 #include <linux/device.h>
 #include <linux/gpio/consumer.h>
+#include <linux/serial_core.h>
=20
 enum mctrl_gpio_idx {
 	UART_GPIO_CTS,
@@ -40,6 +41,7 @@ enum mctrl_gpio_idx {
  */
 struct mctrl_gpios;
=20
+
 #ifdef CONFIG_GPIOLIB
=20
 /*
@@ -60,12 +62,13 @@ struct gpio_desc *mctrl_gpio_to_gpiod(struct mctrl_=
gpios *gpios,
 				      enum mctrl_gpio_idx gidx);
=20
 /*
- * Request and set direction of modem control lines GPIOs.
+ * Request and set direction of modem control lines GPIOs. DT is used.
+ * Initialize irq table for GPIOs.
  * devm_* functions are used, so there's no need to call mctrl_gpio_fr=
ee().
  * Returns a pointer to the allocated mctrl structure if ok, -ENOMEM o=
n
  * allocation error.
  */
-struct mctrl_gpios *mctrl_gpio_init(struct device *dev, unsigned int i=
dx);
+struct mctrl_gpios *mctrl_gpio_init_dt(struct uart_port *port, unsigne=
d int idx);
=20
 /*
  * Free the mctrl_gpios structure.
@@ -74,6 +77,28 @@ struct mctrl_gpios *mctrl_gpio_init(struct device *d=
ev, unsigned int idx);
  */
 void mctrl_gpio_free(struct device *dev, struct mctrl_gpios *gpios);
=20
+/*
+ * Request irqs for input lines GPIOs. The irqs are set disabled
+ * and triggered on both edges.
+ * Returns zero if OK, otherwise an error code.
+ */
+int mctrl_gpio_request_irqs(struct mctrl_gpios *gpios);
+
+/*
+ * Free irqs for input lines GPIOs.
+ */
+void mctrl_gpio_free_irqs(struct mctrl_gpios *gpios);
+
+/*
+ * Disable modem status interrupts assigned to GPIOs
+ */
+void mctrl_gpio_enable_ms(struct mctrl_gpios *gpios);
+
+/*
+ * Enable modem status interrupts assigned to GPIOs
+ */
+void mctrl_gpio_disable_ms(struct mctrl_gpios *gpios);
+
 #else /* GPIOLIB */
=20
 static inline
@@ -95,7 +120,7 @@ struct gpio_desc *mctrl_gpio_to_gpiod(struct mctrl_g=
pios *gpios,
 }
=20
 static inline
-struct mctrl_gpios *mctrl_gpio_init(struct device *dev, unsigned int i=
dx)
+struct mctrl_gpios *mctrl_gpio_init_dt(struct uart_port *port, unsigne=
d int idx)
 {
 	return ERR_PTR(-ENOSYS);
 }
@@ -105,6 +130,36 @@ void mctrl_gpio_free(struct device *dev, struct mc=
trl_gpios *gpios)
 {
 }
=20
+static inline
+int mctrl_gpio_request_irqs(struct mctrl_gpios *gpios)
+{
+	return 0;
+}
+
+static inline
+void mctrl_gpio_free_irqs(struct mctrl_gpios *gpios)
+{
+}
+
+static inline
+void mctrl_gpio_enable_ms(struct mctrl_gpios *gpios)
+{
+}
+
+static inline
+void mctrl_gpio_disable_ms(struct mctrl_gpios *gpios)
+{
+}
+
 #endif /* GPIOLIB */
=20
+/*
+ * Return true if gidx is GPIO line, otherwise false.
+ */
+static inline
+bool mctrl_gpio_is_gpio(struct mctrl_gpios *gpios, enum mctrl_gpio_idx=
 gidx)
+{
+	return !IS_ERR_OR_NULL(mctrl_gpio_to_gpiod(gpios, gidx));
+}
+
 #endif
--=20
1.7.11.3

--
To unsubscribe from this list: send the line "unsubscribe linux-gpio" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
