From: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Subject: Re: [PATCH v3 3/3] misc: Add w2sg0004 gps receiver driver
Date: Fri, 16 Oct 2015 20:15:50 +0200
Message-ID: <85389082-8473-43AB-AB86-7C0E8330E8EE@goldelico.com>
References: <cover.1445018912.git.hns@goldelico.com> <c53ab7a3ca68f8b9f802c1ea799d72e1cb04a1eb.1445018913.git.hns@goldelico.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <c53ab7a3ca68f8b9f802c1ea799d72e1cb04a1eb.1445018913.git.hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jiri Slaby <jslaby-AlSwsSmVLrQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>
Cc: Sergei Zviagintsev <sergei-E844GTqJAzo@public.gmane.org>, Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>, One Thousand Gnomes <gnomes-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, NeilBrown <neil-+NVA1uvv1dVBDLzU/O5InQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marek Belisko <marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org


Am 16.10.2015 um 20:08 schrieb H. Nikolaus Schaller <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>:

> Add driver for Wi2Wi W2SG0004/84 GPS module connected through uart.
> Use uart slave + notification hooks to glue with tty and turn on/off the
> module. Detect if the module is turned on (sends data) but should be off,
> e.g. if already turned on during boot.
> 
> Additionally, rfkill block/unblock can be used to control an external LNA
> (and power down the module if not needed).
> 
> The driver concept is based on code developed by NeilBrown <neilb-l3A5Bk7waGM@public.gmane.org>
> but simplified and adapted to use the serial slave API.
> 
> Signed-off-by: H. Nikolaus Schaller <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
> ---
> .../devicetree/bindings/misc/wi2wi,w2sg0004.txt    |  18 +
> .../devicetree/bindings/vendor-prefixes.txt        |   1 +
> drivers/misc/Kconfig                               |  18 +
> drivers/misc/Makefile                              |   1 +
> drivers/misc/w2sg0004.c                            | 443 +++++++++++++++++++++
> drivers/tty/serial/serial_core.c                   |  25 +-
^^^sorry this change is garbage from patch editing^^^
> include/linux/w2sg0004.h                           |  27 ++
> 7 files changed, 522 insertions(+), 11 deletions(-)
> create mode 100644 Documentation/devicetree/bindings/misc/wi2wi,w2sg0004.txt
> create mode 100644 drivers/misc/w2sg0004.c
> create mode 100644 include/linux/w2sg0004.h
> 
> diff --git a/Documentation/devicetree/bindings/misc/wi2wi,w2sg0004.txt b/Documentation/devicetree/bindings/misc/wi2wi,w2sg0004.txt
> new file mode 100644
> index 0000000..ef0d6d5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/misc/wi2wi,w2sg0004.txt
> @@ -0,0 +1,18 @@
> +Wi2Wi GPS module connected through UART
> +
> +Required properties:
> +- compatible: wi2wi,w2sg0004 or wi2wi,w2sg0084
> +- on-off-gpio: the GPIO that controls the module's on-off toggle input
> +- uart: the uart we are connected to (provides DTR for power control)
> +
> +Optional properties:
> +- lna-suppy: an (optional) LNA regulator that is enabled together with the GPS receiver
> +
> +example:
> +
> +        gps_receiver: w2sg0004 {
> +                compatible = "wi2wi,w2sg0004";
> +                lna-supply = <&vsim>;	/* LNA regulator */
> +                on-off-gpio = <&gpio5 17 0>;	/* GPIO_145: trigger for turning on/off w2sg0004 */
> +                uart = <&uart1>;	/* we are a slave of uart1 */
> +        }
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index 82d2ac9..a778eb5 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -230,6 +230,7 @@ via	VIA Technologies, Inc.
> virtio	Virtual I/O Device Specification, developed by the OASIS consortium
> voipac	Voipac Technologies s.r.o.
> wexler	Wexler
> +wi2wi	Wi2Wi, Inc.
> winbond Winbond Electronics corp.
> wlf	Wolfson Microelectronics
> wm	Wondermedia Technologies, Inc.
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index ccccc29..1279faf 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -537,4 +537,22 @@ source "drivers/misc/mic/Kconfig"
> source "drivers/misc/genwqe/Kconfig"
> source "drivers/misc/echo/Kconfig"
> source "drivers/misc/cxl/Kconfig"
> +
> +menu "GTA04 misc hardware support"
> +
> +config W2SG0004
> +	tristate "W2SG0004 on/off control"
> +	depends on GPIOLIB
> +	help
> +	  Enable on/off control of W2SG0004 GPS to allow powering up/down if
> +	  the /dev/tty$n is opened/closed.
> +	  It also provides a rfkill gps node to control the LNA power.
> +
> +config W2SG0004_DEBUG
> +	bool "W2SG0004 on/off debugging"
> +	depends on W2SG0004
> +	help
> +	  Enable driver debugging mode of W2SG0004 GPS.
> +
> +endmenu
> endmenu
> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> index 537d7f3..a153a89 100644
> --- a/drivers/misc/Makefile
> +++ b/drivers/misc/Makefile
> @@ -54,5 +54,6 @@ obj-$(CONFIG_SRAM)		+= sram.o
> obj-y				+= mic/
> obj-$(CONFIG_GENWQE)		+= genwqe/
> obj-$(CONFIG_ECHO)		+= echo/
> +obj-$(CONFIG_W2SG0004)		+= w2sg0004.o
> obj-$(CONFIG_VEXPRESS_SYSCFG)	+= vexpress-syscfg.o
> obj-$(CONFIG_CXL_BASE)		+= cxl/
> diff --git a/drivers/misc/w2sg0004.c b/drivers/misc/w2sg0004.c
> new file mode 100644
> index 0000000..6aadf44
> --- /dev/null
> +++ b/drivers/misc/w2sg0004.c
> @@ -0,0 +1,443 @@
> +/*
> + * w2sg0004.c
> + * Driver for power controlling the w2sg0004/w2sg0084 GPS receiver.
> + *
> + * This receiver has an ON/OFF pin which must be toggled to
> + * turn the device 'on' of 'off'.  A high->low->high toggle
> + * will switch the device on if it is off, and off if it is on.
> + *
> + * To enable receiving on/off requests we register with the
> + * UART power management notifications.
> + *
> + * It is not possible to directly detect the state of the device.
> + * However when it is on it will send characters on a UART line
> + * regularly.
> + *
> + * To detect that the power state is out of sync (e.g. if GPS
> + * was enabled before a reboot), we register for UART data received
> + * notifications.
> + *
> + * In addition we register as a rfkill client so that we can
> + * control the LNA power.
> + *
> + */
> +
> +#include <linux/module.h>
> +#include <linux/interrupt.h>
> +#include <linux/sched.h>
> +#include <linux/irq.h>
> +#include <linux/slab.h>
> +#include <linux/err.h>
> +#include <linux/delay.h>
> +#include <linux/of.h>
> +#include <linux/of_irq.h>
> +#include <linux/of_gpio.h>
> +#include <linux/platform_device.h>
> +#include <linux/w2sg0004.h>
> +#include <linux/workqueue.h>
> +#include <linux/rfkill.h>
> +#include <linux/serial_core.h>
> +
> +#ifdef CONFIG_W2SG0004_DEBUG
> +#undef pr_debug
> +#define pr_debug printk
> +#endif
> +
> +/*
> + * There seems to be restrictions on how quickly we can toggle the
> + * on/off line.  data sheets says "two rtc ticks", whatever that means.
> + * If we do it too soon it doesn't work.
> + * So we have a state machine which uses the common work queue to ensure
> + * clean transitions.
> + * When a change is requested we record that request and only act on it
> + * once the previous change has completed.
> + * A change involves a 10ms low pulse, and a 990ms raised level, so only
> + * one change per second.
> + */
> +
> +enum w2sg_state {
> +	W2SG_IDLE,	/* is not changing state */
> +	W2SG_PULSE,	/* activate on/off impulse */
> +	W2SG_NOPULSE	/* deactivate on/off impulse */
> +};
> +
> +struct w2sg_data {
> +	struct		rfkill *rf_kill;
> +	struct		regulator *lna_regulator;
> +	int		lna_blocked;	/* rfkill block gps active */
> +	int		lna_is_off;	/* LNA is currently off */
> +	int		is_on;		/* current state (0/1) */
> +	unsigned long	last_toggle;
> +	unsigned long	backoff;	/* time to wait since last_toggle */
> +	int		on_off_gpio;	/* the on-off gpio number */
> +	struct uart_port *uart;		/* the drvdata of the uart or tty */
> +	enum w2sg_state	state;
> +	int		requested;	/* requested state (0/1) */
> +	int		suspended;
> +	spinlock_t	lock;
> +	struct delayed_work work;
> +};
> +
> +static int w2sg_data_set_lna_power(struct w2sg_data *data)
> +{
> +	int ret = 0;
> +	int off = data->suspended || !data->requested || data->lna_blocked;
> +
> +	pr_debug("%s: %s\n", __func__, off ? "off" : "on");
> +
> +	if (off != data->lna_is_off) {
> +		data->lna_is_off = off;
> +		if (!IS_ERR_OR_NULL(data->lna_regulator)) {
> +			if (off)
> +				regulator_disable(data->lna_regulator);
> +			else
> +				ret = regulator_enable(data->lna_regulator);
> +		}
> +	}
> +
> +	return ret;
> +}
> +
> +static void w2sg_data_set_power(void *pdata, int val)
> +{
> +	struct w2sg_data *data = (struct w2sg_data *) pdata;
> +	unsigned long flags;
> +
> +	pr_debug("%s to %d (%d)\n", __func__, val, data->requested);
> +
> +	spin_lock_irqsave(&data->lock, flags);
> +
> +	if (val && !data->requested) {
> +		data->requested = true;
> +	} else if (!val && data->requested) {
> +		data->backoff = HZ;
> +		data->requested = false;
> +	} else
> +		goto unlock;
> +
> +	pr_debug("w2sg scheduled for %d\n", data->requested);
> +
> +	if (!data->suspended)
> +		schedule_delayed_work(&data->work, 0);
> +unlock:
> +	spin_unlock_irqrestore(&data->lock, flags);
> +}
> +
> +/* called each time data is received by the host (i.e. sent by the w2sg0004) */
> +
> +static int rx_notification(void *pdata, unsigned int *c)
> +{
> +	struct w2sg_data *data = (struct w2sg_data *) pdata;
> +	unsigned long flags;
> +
> +	if (!data->requested && !data->is_on) {
> +		/* we have received a RX signal while GPS should be off */
> +		pr_debug("%02x!", *c);
> +
> +		if ((data->state == W2SG_IDLE) &&
> +		    time_after(jiffies,
> +		    data->last_toggle + data->backoff)) {
> +			/* Should be off by now, time to toggle again */
> +			pr_debug("w2sg has sent data although it should be off!\n");
> +			data->is_on = true;
> +			data->backoff *= 2;
> +			spin_lock_irqsave(&data->lock, flags);
> +			if (!data->suspended)
> +				schedule_delayed_work(&data->work, 0);
> +			spin_unlock_irqrestore(&data->lock, flags);
> +		}
> +	}
> +	return 0;	/* forward to tty */
> +}
> +
> +/* called by uart modem control line changes (DTR) */
> +
> +static int w2sg_mctrl(void *pdata, int val)
> +{
> +	pr_debug("%s(...,%x)\n", __func__, val);
> +	val = (val & TIOCM_DTR) != 0;	/* DTR controls power on/off */
> +	w2sg_data_set_power((struct w2sg_data *) pdata, val);
> +	return 0;
> +}
> +
> +/* try to toggle the power state by sending a pulse to the on-off GPIO */
> +
> +static void toggle_work(struct work_struct *work)
> +{
> +	struct w2sg_data *data = container_of(work, struct w2sg_data,
> +					      work.work);
> +
> +	switch (data->state) {
> +	case W2SG_IDLE:
> +		spin_lock_irq(&data->lock);
> +		if (data->requested == data->is_on) {
> +			spin_unlock_irq(&data->lock);
> +			return;
> +		}
> +		spin_unlock_irq(&data->lock);
> +		w2sg_data_set_lna_power(data);	/* update LNA power state */
> +		gpio_set_value_cansleep(data->on_off_gpio, 0);
> +		data->state = W2SG_PULSE;
> +
> +		pr_debug("w2sg: power gpio ON\n");
> +
> +		schedule_delayed_work(&data->work,
> +				      msecs_to_jiffies(10));
> +		break;
> +
> +	case W2SG_PULSE:
> +		gpio_set_value_cansleep(data->on_off_gpio, 1);
> +		data->last_toggle = jiffies;
> +		data->state = W2SG_NOPULSE;
> +		data->is_on = !data->is_on;
> +
> +		pr_debug("w2sg: power gpio OFF\n");
> +
> +		schedule_delayed_work(&data->work,
> +				      msecs_to_jiffies(10));
> +		break;
> +
> +	case W2SG_NOPULSE:
> +		data->state = W2SG_IDLE;
> +		pr_debug("w2sg: idle\n");
> +
> +		break;
> +
> +	}
> +}
> +
> +static int w2sg_data_rfkill_set_block(void *pdata, bool blocked)
> +{
> +	struct w2sg_data *data = pdata;
> +
> +	pr_debug("%s: blocked: %d\n", __func__, blocked);
> +
> +	data->lna_blocked = blocked;
> +
> +	return w2sg_data_set_lna_power(data);
> +}
> +
> +static struct rfkill_ops w2sg_data0004_rfkill_ops = {
> +	.set_block = w2sg_data_rfkill_set_block,
> +};
> +
> +static int w2sg_data_probe(struct platform_device *pdev)
> +{
> +	struct w2sg_pdata *pdata = dev_get_platdata(&pdev->dev);
> +	struct w2sg_data *data;
> +	struct rfkill *rf_kill;
> +	int err;
> +
> +	pr_debug("%s()\n", __func__);
> +
> +	if (pdev->dev.of_node) {
> +		struct device *dev = &pdev->dev;
> +		enum of_gpio_flags flags;
> +
> +		pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
> +		if (!pdata)
> +			return -ENOMEM;
> +
> +		pdata->on_off_gpio = of_get_named_gpio_flags(dev->of_node,
> +							     "on-off-gpio", 0,
> +							     &flags);
> +
> +		if (pdata->on_off_gpio == -EPROBE_DEFER)
> +			return -EPROBE_DEFER;	/* defer until we have all gpios */
> +
> +		pdata->lna_regulator = devm_regulator_get_optional(dev, "lna");
> +
> +		pr_debug("%s() lna_regulator = %p\n", __func__, pdata->lna_regulator);
> +
> +		pdev->dev.platform_data = pdata;
> +	}
> +
> +	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
> +	if (data == NULL)
> +		return -ENOMEM;
> +
> +	data->lna_regulator = pdata->lna_regulator;
> +	data->lna_blocked = true;
> +	data->lna_is_off = true;
> +
> +	data->on_off_gpio = pdata->on_off_gpio;
> +
> +	data->is_on = false;
> +	data->requested = false;
> +	data->state = W2SG_IDLE;
> +	data->last_toggle = jiffies;
> +	data->backoff = HZ;
> +
> +#ifdef CONFIG_OF
> +	data->uart = devm_serial_get_uart_by_phandle(&pdev->dev, "uart", 0);
> +	if (IS_ERR(data->uart)) {
> +		if (PTR_ERR(data->uart) == -EPROBE_DEFER)
> +			return -EPROBE_DEFER;	/* we can't probe yet */
> +		data->uart = NULL;	/* no UART */
> +		}
> +#endif
> +
> +	INIT_DELAYED_WORK(&data->work, toggle_work);
> +	spin_lock_init(&data->lock);
> +
> +	err = devm_gpio_request(&pdev->dev, data->on_off_gpio, "w2sg0004-on-off");
> +	if (err < 0)
> +		goto out;
> +
> +	gpio_direction_output(data->on_off_gpio, false);
> +
> +	if (data->uart) {
> +		struct ktermios termios = {
> +			.c_iflag = IGNBRK,
> +			.c_oflag = 0,
> +			.c_cflag = B9600 | CS8,
> +			.c_lflag = 0,
> +			.c_line = 0,
> +			.c_ispeed = 9600,
> +			.c_ospeed = 9600
> +		};
> +		uart_register_slave(data->uart, data);
> +		uart_register_mctrl_notification(data->uart, w2sg_mctrl);
> +		uart_register_rx_notification(data->uart, rx_notification,
> +					      &termios);
> +	}
> +
> +	rf_kill = rfkill_alloc("GPS", &pdev->dev, RFKILL_TYPE_GPS,
> +				&w2sg_data0004_rfkill_ops, data);
> +	if (rf_kill == NULL) {
> +		err = -ENOMEM;
> +		goto err_rfkill;
> +	}
> +
> +	err = rfkill_register(rf_kill);
> +	if (err) {
> +		dev_err(&pdev->dev, "Cannot register rfkill device\n");
> +		goto err_rfkill;
> +	}
> +
> +	data->rf_kill = rf_kill;
> +
> +	platform_set_drvdata(pdev, data);
> +
> +	pr_debug("w2sg0004 probed\n");
> +
> +#ifdef CONFIG_W2SG0004_DEBUG
> +	/* turn on for debugging rx notifications */
> +	pr_debug("w2sg power gpio ON\n");
> +	gpio_set_value_cansleep(data->on_off_gpio, 1);
> +	mdelay(100);
> +	pr_debug("w2sg power gpio OFF\n");
> +	gpio_set_value_cansleep(data->on_off_gpio, 0);
> +	mdelay(300);
> +#endif
> +
> +	/* if we won't receive mctrl notifications, turn on.
> +	 * otherwise keep off until DTR is asserted through mctrl.
> +	 */
> +
> +	w2sg_data_set_power(data, !data->uart);
> +
> +	return 0;
> +
> +err_rfkill:
> +	rfkill_destroy(rf_kill);
> +out:
> +	return err;
> +}
> +
> +static int w2sg_data_remove(struct platform_device *pdev)
> +{
> +	struct w2sg_data *data = platform_get_drvdata(pdev);
> +
> +	cancel_delayed_work_sync(&data->work);
> +
> +	if (data->uart) {
> +		uart_register_rx_notification(data->uart, NULL, NULL);
> +		uart_register_slave(data->uart, NULL);
> +	}
> +	return 0;
> +}
> +
> +static int w2sg_data_suspend(struct device *dev)
> +{
> +	struct w2sg_data *data = dev_get_drvdata(dev);
> +
> +	spin_lock_irq(&data->lock);
> +	data->suspended = true;
> +	spin_unlock_irq(&data->lock);
> +
> +	cancel_delayed_work_sync(&data->work);
> +
> +	w2sg_data_set_lna_power(data);	/* shuts down if needed */
> +
> +	if (data->state == W2SG_PULSE) {
> +		msleep(10);
> +		gpio_set_value_cansleep(data->on_off_gpio, 1);
> +		data->last_toggle = jiffies;
> +		data->is_on = !data->is_on;
> +		data->state = W2SG_NOPULSE;
> +	}
> +
> +	if (data->state == W2SG_NOPULSE) {
> +		msleep(10);
> +		data->state = W2SG_IDLE;
> +	}
> +
> +	if (data->is_on) {
> +		pr_info("GPS off for suspend %d %d %d\n", data->requested,
> +			data->is_on, data->lna_is_off);
> +
> +		gpio_set_value_cansleep(data->on_off_gpio, 0);
> +		msleep(10);
> +		gpio_set_value_cansleep(data->on_off_gpio, 1);
> +		data->is_on = 0;
> +	}
> +
> +	return 0;
> +}
> +
> +static int w2sg_data_resume(struct device *dev)
> +{
> +	struct w2sg_data *data = dev_get_drvdata(dev);
> +
> +	spin_lock_irq(&data->lock);
> +	data->suspended = false;
> +	spin_unlock_irq(&data->lock);
> +
> +	pr_info("GPS resuming %d %d %d\n", data->requested,
> +		data->is_on, data->lna_is_off);
> +
> +	schedule_delayed_work(&data->work, 0);	/* enables LNA if needed */
> +
> +	return 0;
> +}
> +
> +#if defined(CONFIG_OF)
> +static const struct of_device_id w2sg0004_of_match[] = {
> +	{ .compatible = "wi2wi,w2sg0004" },
> +	{ .compatible = "wi2wi,w2sg0084" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, w2sg0004_of_match);
> +#endif
> +
> +SIMPLE_DEV_PM_OPS(w2sg_pm_ops, w2sg_data_suspend, w2sg_data_resume);
> +
> +static struct platform_driver w2sg_data_driver = {
> +	.probe		= w2sg_data_probe,
> +	.remove		= w2sg_data_remove,
> +	.driver = {
> +		.name	= "w2sg0004",
> +		.owner	= THIS_MODULE,
> +		.pm	= &w2sg_pm_ops,
> +		.of_match_table = of_match_ptr(w2sg0004_of_match)
> +	},
> +};
> +
> +module_platform_driver(w2sg_data_driver);
> +
> +MODULE_ALIAS("w2sg0004");
> +
> +MODULE_AUTHOR("NeilBrown <neilb-l3A5Bk7waGM@public.gmane.org>");
> +MODULE_DESCRIPTION("w2sg0004 GPS power management driver");
> +MODULE_LICENSE("GPL v2");
VVVsorry this change is garbage from patch editingVVV
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index b731100..c8ae0dd 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -177,7 +177,7 @@ void uart_register_slave(struct uart_port *uport, void *slave)
> EXPORT_SYMBOL_GPL(uart_register_slave);
> 
> void uart_register_mctrl_notification(struct uart_port *uport,
> -		int (*function)(void *slave, int state))
> +			int (*function)(void *slave, int state))
> {
> 	uport->mctrl_notification = function;
> }
> @@ -208,14 +208,14 @@ void uart_register_rx_notification(struct uart_port *uport,
> 			retval = uport->ops->startup(uport);
> 			if (retval == 0 && termios) {
> 				int hw_stopped;
> -				/*
> -				 * Initialise the hardware port settings.
> -				 */
> +/*
> + * Initialise the hardware port settings.
> + */
> 				uport->ops->set_termios(uport, termios, NULL);
> 
> -				/*
> -				 * Set modem status enables based on termios cflag
> -				 */
> +/*
> + * Set modem status enables based on termios cflag
> + */
> 				spin_lock_irq(&uport->lock);
> 				if (termios->c_cflag & CRTSCTS)
> 					uport->status |= UPSTAT_CTS_ENABLE;
> @@ -227,11 +227,13 @@ void uart_register_rx_notification(struct uart_port *uport,
> 				else
> 					uport->status |= UPSTAT_DCD_ENABLE;
> 
> -				/* reset sw-assisted CTS flow control based on (possibly) new mode */
> +/*
> + * reset sw-assisted CTS flow control based on (possibly) new mode
> + */
> 				hw_stopped = uport->hw_stopped;
> 				uport->hw_stopped = uart_softcts_mode(uport) &&
> -					!(uport->ops->get_mctrl(uport)
> -						& TIOCM_CTS);
> +					!(uport->ops->get_mctrl(uport) &
> +						TIOCM_CTS);
> 				if (uport->hw_stopped) {
> 					if (!hw_stopped)
> 						uport->ops->stop_tx(uport);
> @@ -432,7 +434,8 @@ static void uart_shutdown(struct tty_struct *tty, struct uart_state *state)
> 			uart_clear_mctrl(uport, TIOCM_DTR | TIOCM_RTS);
> 		/*
> 		 * if we have a slave that has registered for rx_notifications
> -		 * we do not shut down the uart port to be able to monitor the device
> +		 * we do not shut down the uart port to be able to monitor the
> +		 * device
> 		 */
> 		if (!uport->rx_notification)
> 			uart_port_shutdown(port);
^^^sorry this change is garbage from patch editing^^^
> diff --git a/include/linux/w2sg0004.h b/include/linux/w2sg0004.h
> new file mode 100644
> index 0000000..ad0c4a1
> --- /dev/null
> +++ b/include/linux/w2sg0004.h
> @@ -0,0 +1,27 @@
> +/*
> + * UART slave to allow ON/OFF control of w2sg0004 GPS receiver.
> + *
> + * Copyright (C) 2011 Neil Brown <neil-+NVA1uvv1dVBDLzU/O5InQ@public.gmane.org>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * General Public License for more details.
> + */
> +
> +
> +
> +#ifndef __LINUX_W2SG0004_H
> +#define __LINUX_W2SG0004_H
> +
> +#include <linux/regulator/consumer.h>
> +
> +struct w2sg_pdata {
> +	struct regulator *lna_regulator;	/* enable LNA power */
> +	int	on_off_gpio;	/*  on-off input of the GPS module */
> +};
> +#endif /* __LINUX_W2SG0004_H */
> -- 
> 2.5.1
> 

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
