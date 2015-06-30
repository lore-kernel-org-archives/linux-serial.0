From: "Dr. H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH RFC v2 3/3] misc: Add w2g0004 gps receiver driver
Date: Tue, 30 Jun 2015 10:35:21 +0200
Message-ID: <91726F4B-ADE4-455E-9283-A0AE17C40D77@goldelico.com>
References: <1435520786-31867-1-git-send-email-marek@goldelico.com> <1435520786-31867-4-git-send-email-marek@goldelico.com> <20150630082354.GD17917@localhost.localdomain>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150630082354.GD17917@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Sergei Zviagintsev <sergei@s15v.net>
Cc: Marek Belisko <marek@goldelico.com>, jslaby@suse.cz, gregkh@linuxfoundation.org, arnd@arndb.de, peter@hurleysoftware.com, mark.rutland@arm.com, gnomes@lxorguk.ukuu.org.uk, sre@kernel.org, neil@brown.name, grant.likely@linaro.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, robh+dt@kernel.org, pawel.moll@arm.com
List-Id: linux-serial@vger.kernel.org

Hi,
thanks for the valid and very valuable comments!
We will integrate them into RFC v3.
BR,
Nikolaus

Am 30.06.2015 um 10:23 schrieb Sergei Zviagintsev <sergei@s15v.net>:

> Hi,
>=20
> I left some comments below.
>=20
> On Sun, Jun 28, 2015 at 09:46:26PM +0200, Marek Belisko wrote:
>> From: "H. Nikolaus Schaller" <hns@goldelico.com>
>>=20
>> Add driver for Wi2Wi w2g004 GPS module connected through  uart. Use =
uart
>> slave + notification hooks to glue with tty.
>>=20
>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
>> Signed-off-by: Marek Belisko <marek@goldelico.com>
>> ---
>> .../devicetree/bindings/misc/wi2wi,w2sg0004.txt    |  18 +
>> drivers/misc/Kconfig                               |  18 +
>> drivers/misc/Makefile                              |   1 +
>> drivers/misc/w2sg0004.c                            | 436 +++++++++++=
++++++++++
>> include/linux/w2sg0004.h                           |  28 ++
>> 5 files changed, 501 insertions(+)
>> create mode 100644 Documentation/devicetree/bindings/misc/wi2wi,w2sg=
0004.txt
>> create mode 100644 drivers/misc/w2sg0004.c
>> create mode 100644 include/linux/w2sg0004.h
>>=20
>> diff --git a/Documentation/devicetree/bindings/misc/wi2wi,w2sg0004.t=
xt b/Documentation/devicetree/bindings/misc/wi2wi,w2sg0004.txt
>> new file mode 100644
>> index 0000000..ef0d6d5
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/misc/wi2wi,w2sg0004.txt
>> @@ -0,0 +1,18 @@
>> +Wi2Wi GPS module connected through UART
>> +
>> +Required properties:
>> +- compatible: wi2wi,w2sg0004 or wi2wi,w2sg0084
>> +- on-off-gpio: the GPIO that controls the module's on-off toggle in=
put
>> +- uart: the uart we are connected to (provides DTR for power contro=
l)
>> +
>> +Optional properties:
>> +- lna-suppy: an (optional) LNA regulator that is enabled together w=
ith the GPS receiver
>> +
>> +example:
>> +
>> +        gps_receiver: w2sg0004 {
>> +                compatible =3D "wi2wi,w2sg0004";
>> +                lna-supply =3D <&vsim>;	/* LNA regulator */
>> +                on-off-gpio =3D <&gpio5 17 0>;	/* GPIO_145: trigger=
 for turning on/off w2sg0004 */
>> +                uart =3D <&uart1>;	/* we are a slave of uart1 */
>> +        }
>> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
>> index 42c3852..952add4 100644
>> --- a/drivers/misc/Kconfig
>> +++ b/drivers/misc/Kconfig
>> @@ -527,4 +527,22 @@ source "drivers/misc/mic/Kconfig"
>> source "drivers/misc/genwqe/Kconfig"
>> source "drivers/misc/echo/Kconfig"
>> source "drivers/misc/cxl/Kconfig"
>> +
>> +menu "GTA04 misc hardware support"
>> +
>> +config W2SG0004
>> +	tristate "W2SG0004 on/off control"
>> +	depends on GPIOLIB
>> +	help
>> +	  Enable on/off control of W2SG0004 GPS using a tty slave to
>> +	  to allow powering up if the /dev/tty$n is opened.
>> +	  It also provides a rfkill gps node to control the LNA power.
>> +
>> +config W2SG0004_DEBUG
>> +	bool "W2SG0004 on/off debugging"
>> +	depends on W2SG0004
>> +	help
>> +	  Enable driver debugging mode of W2SG0004 GPS.
>> +
>> +endmenu
>> endmenu
>> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
>> index d056fb7..3bc67c7 100644
>> --- a/drivers/misc/Makefile
>> +++ b/drivers/misc/Makefile
>> @@ -53,5 +53,6 @@ obj-$(CONFIG_SRAM)		+=3D sram.o
>> obj-y				+=3D mic/
>> obj-$(CONFIG_GENWQE)		+=3D genwqe/
>> obj-$(CONFIG_ECHO)		+=3D echo/
>> +obj-$(CONFIG_W2SG0004)		+=3D w2sg0004.o
>> obj-$(CONFIG_VEXPRESS_SYSCFG)	+=3D vexpress-syscfg.o
>> obj-$(CONFIG_CXL_BASE)		+=3D cxl/
>> diff --git a/drivers/misc/w2sg0004.c b/drivers/misc/w2sg0004.c
>> new file mode 100644
>> index 0000000..c5f0f7b
>> --- /dev/null
>> +++ b/drivers/misc/w2sg0004.c
>> @@ -0,0 +1,436 @@
>> +/*
>> + * w2sg0004.c
>> + * Driver for power controlling the w2sg0004/w2sg0084 GPS receiver.
>> + *
>> + * This receiver has an ON/OFF pin which must be toggled to
>> + * turn the device 'on' of 'off'.  A high->low->high toggle
>> + * will switch the device on if it is off, and off if it is on.
>> + *
>> + * To enable receiving on/off requests we register with the
>> + * UART power management notifications.
>> + *
>> + * It is not possible to directly detect the state of the device.
>> + * However when it is on it will send characters on a UART line
>> + * regularly.
>> + *
>> + * To detect that the power state is out of sync (e.g. if GPS
>> + * was enabled before a reboot), we register for UART data received
>> + * notifications.
>> + *
>> + * In addition we register as a rfkill client so that we can
>> + * control the LNA power.
>> + *
>> + */
>> +
>> +#include <linux/module.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/sched.h>
>> +#include <linux/irq.h>
>> +#include <linux/slab.h>
>> +#include <linux/err.h>
>> +#include <linux/delay.h>
>> +#include <linux/of.h>
>> +#include <linux/of_irq.h>
>> +#include <linux/of_gpio.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/w2sg0004.h>
>> +#include <linux/workqueue.h>
>> +#include <linux/rfkill.h>
>> +#include <linux/serial_core.h>
>> +
>> +#ifdef CONFIG_W2SG0004_DEBUG
>> +#undef pr_debug
>> +#define pr_debug printk
>> +#endif
>> +
>> +/*
>> + * There seems to be restrictions on how quickly we can toggle the
>> + * on/off line.  data sheets says "two rtc ticks", whatever that me=
ans.
>> + * If we do it too soon it doesn't work.
>> + * So we have a state machine which uses the common work queue to e=
nsure
>> + * clean transitions.
>> + * When a change is requested we record that request and only act o=
n it
>> + * once the previous change has completed.
>> + * A change involves a 10ms low pulse, and a 990ms raised level, so=
 only
>> + * one change per second.
>> + */
>> +
>> +enum w2sg_state {
>> +	W2SG_IDLE,	/* is not changing state */
>> +	W2SG_PULSE,	/* activate on/off impulse */
>> +	W2SG_NOPULSE	/* deactivate on/off impulse */
>> +};
>> +
>> +struct w2sg_data {
>> +	struct		rfkill *rf_kill;
>> +	struct		regulator *lna_regulator;
>> +	int		lna_blocked;	/* rfkill block gps active */
>> +	int		lna_is_off;	/* LNA is currently off */
>> +	int		is_on;		/* current state (0/1) */
>=20
> Wouldn't bool types be better for these three and also for `requested=
'
> and `suspended'?
>=20
>> +	unsigned long	last_toggle;
>> +	unsigned long	backoff;	/* time to wait since last_toggle */
>> +	int		on_off_gpio;	/* the on-off gpio number */
>> +	struct uart_port	*uart;		/* the drvdata of the uart or tty */
>> +	enum w2sg_state	state;
>> +	int		requested;	/* requested state (0/1) */
>> +	int		suspended;
>> +	spinlock_t	lock;
>> +	struct delayed_work work;
>> +};
>> +
>> +static int w2sg_data_set_lna_power(struct w2sg_data *data)
>> +{
>> +	int ret =3D 0;
>> +	int off =3D data->suspended || !data->requested || data->lna_block=
ed;
>> +
>> +	pr_debug("%s: %s\n", __func__, off ? "off" : "on");
>> +
>> +	if (off !=3D data->lna_is_off) {
>> +		data->lna_is_off =3D off;
>> +		if (!IS_ERR_OR_NULL(data->lna_regulator)) {
>> +			if (off)
>> +				regulator_disable(data->lna_regulator);
>> +			else
>> +				ret =3D regulator_enable(data->lna_regulator);
>> +		}
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +static void w2sg_data_set_power(void *pdata, int val)
>=20
> int val -> bool val?
>=20
>> +{
>> +	struct w2sg_data *data =3D (struct w2sg_data *) pdata;
>> +	unsigned long flags;
>> +
>> +	pr_debug("%s to %d (%d)\n", __func__, val, data->requested);
>> +
>> +	spin_lock_irqsave(&data->lock, flags);
>> +
>> +	if (val && !data->requested) {
>> +		data->requested =3D true;
>> +	} else if (!val && data->requested) {
>> +		data->backoff =3D HZ;
>> +		data->requested =3D false;
>> +	} else
>=20
> Braces issue with `else' branch.
>=20
>> +		goto unlock;
>> +
>> +	pr_debug("w2sg scheduled for %d\n", data->requested);
>> +
>> +	if (!data->suspended)
>> +		schedule_delayed_work(&data->work, 0);
>> +unlock:
>> +	spin_unlock_irqrestore(&data->lock, flags);
>> +}
>> +
>> +/* called each time data is received by the host (i.e. sent by the =
w2sg0004) */
>> +
>> +static int rx_notification(void *pdata, unsigned int *c)
>> +{
>> +	struct w2sg_data *data =3D (struct w2sg_data *) pdata;
>> +	unsigned long flags;
>> +
>> +	if (!data->requested && !data->is_on) {
>=20
> Isn't it better to invert the if-statement and place return to be les=
s
> indented and more readable?

Well, it is intended to describe the =93problematic=94 case, i.e. nothi=
ng requested and not on.

But a proper comment might help with reversed logic. Something like /* =
rx was expected */

>=20
>> +		pr_debug("%02x!", *c); /* we have received a RX signal while GPS =
should be off */
>> +		if ((data->state =3D=3D W2SG_IDLE) &&
>> +		    time_after(jiffies,
>> +		    data->last_toggle + data->backoff)) {
>=20
> Whole time_after() call should be on the same line.
>=20
>> +			/* Should be off by now, time to toggle again */
>> +			pr_debug("w2sg has sent data although it should be off!\n");
>> +			data->is_on =3D true;
>> +			data->backoff *=3D 2;
>> +			spin_lock_irqsave(&data->lock, flags);
>> +			if (!data->suspended)
>> +				schedule_delayed_work(&data->work, 0);
>> +			spin_unlock_irqrestore(&data->lock, flags);
>> +		}
>> +	}
>> +	return 0;	/* forward to tty */
>> +}
>> +
>> +/* called by uart modem control line changes (DTR) */
>> +
>> +static int w2sg_mctrl(void *pdata, int val)
>> +{
>> +	pr_debug("%s(...,%x)\n", __func__, val);
>> +	val =3D (val & TIOCM_DTR) !=3D 0;	/* DTR controls power on/off */
>=20
> IMO the following would be more readable:
>=20
> bool power_on =3D !!(val & TIOCM_DTR);
>=20
>> +	w2sg_data_set_power((struct w2sg_data *) pdata, val);
>> +	return 0;
>> +}
>> +
>> +/* try to toggle the power state by sending a pulse to the on-off G=
PIO */
>> +
>> +static void toggle_work(struct work_struct *work)
>> +{
>> +	struct w2sg_data *data =3D container_of(work, struct w2sg_data, wo=
rk.work);
>> +
>> +	switch (data->state) {
>> +	case W2SG_IDLE:
>> +		spin_lock_irq(&data->lock);
>> +		if (data->requested =3D=3D data->is_on) {
>> +			spin_unlock_irq(&data->lock);
>> +			return;
>> +		}
>> +		spin_unlock_irq(&data->lock);
>> +		w2sg_data_set_lna_power(data);	/* update LNA power state */
>> +		gpio_set_value_cansleep(data->on_off_gpio, 0);
>> +		data->state =3D W2SG_PULSE;
>> +
>> +		pr_debug("w2sg: power gpio ON\n");
>> +
>> +		schedule_delayed_work(&data->work,
>> +				      msecs_to_jiffies(10));
>> +		break;
>> +
>> +	case W2SG_PULSE:
>> +		gpio_set_value_cansleep(data->on_off_gpio, 1);
>> +		data->last_toggle =3D jiffies;
>> +		data->state =3D W2SG_NOPULSE;
>> +		data->is_on =3D !data->is_on;
>> +
>> +		pr_debug("w2sg: power gpio OFF\n");
>> +
>> +		schedule_delayed_work(&data->work,
>> +				      msecs_to_jiffies(10));
>> +		break;
>> +
>> +	case W2SG_NOPULSE:
>> +		data->state =3D W2SG_IDLE;
>> +		pr_debug("w2sg: idle\n");
>> +
>> +		break;
>> +
>=20
> default case?
>=20
>> +	}
>> +}
>> +
>> +static int w2sg_data_rfkill_set_block(void *pdata, bool blocked)
>> +{
>> +	struct w2sg_data *data =3D pdata;
>> +
>> +	pr_debug("%s: blocked: %d\n", __func__, blocked);
>> +
>> +	data->lna_blocked =3D blocked;
>> +
>> +	return w2sg_data_set_lna_power(data);
>> +}
>> +
>> +static struct rfkill_ops w2sg_data0004_rfkill_ops =3D {
>> +	.set_block =3D w2sg_data_rfkill_set_block,
>> +};
>> +
>> +static int w2sg_data_probe(struct platform_device *pdev)
>> +{
>> +	struct w2sg_pdata *pdata =3D dev_get_platdata(&pdev->dev);
>> +	struct w2sg_data *data;
>> +	struct rfkill *rf_kill;
>> +	int err;
>> +
>> +	pr_debug("%s()\n", __func__);
>> +
>> +	if (pdev->dev.of_node) {
>> +		struct device *dev =3D &pdev->dev;
>> +		enum of_gpio_flags flags;
>> +
>> +		pdata =3D devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
>> +		if (!pdata)
>> +			return -ENOMEM;
>> +
>> +		pdata->on_off_gpio =3D of_get_named_gpio_flags(dev->of_node, "on-=
off-gpio", 0, &flags);
>> +
>> +		if (pdata->on_off_gpio =3D=3D -EPROBE_DEFER)
>> +			return -EPROBE_DEFER;	/* defer until we have all gpios */
>> +
>> +		pdata->lna_regulator =3D devm_regulator_get_optional(dev, "lna");
>> +
>> +		pr_debug("%x() lna_regulator =3D %p\n", __func__, pdata->lna_regu=
lator);
>> +
>> +		pdev->dev.platform_data =3D pdata;
>> +	}
>> +
>> +	data =3D devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
>> +	if (data =3D=3D NULL)
>> +		return -ENOMEM;
>> +
>> +	data->lna_regulator =3D pdata->lna_regulator;
>> +	data->lna_blocked =3D true;
>> +	data->lna_is_off =3D true;
>> +
>> +	data->on_off_gpio =3D pdata->on_off_gpio;
>> +
>> +	data->is_on =3D false;
>> +	data->requested =3D false;
>> +	data->state =3D W2SG_IDLE;
>> +	data->last_toggle =3D jiffies;
>> +	data->backoff =3D HZ;
>> +
>> +#ifdef CONFIG_OF
>> +	data->uart =3D devm_serial_get_uart_by_phandle(&pdev->dev, "uart",=
 0);
>> +	if (IS_ERR(data->uart)) {
>> +		if (PTR_ERR(data->uart) =3D=3D -EPROBE_DEFER)
>> +			return -EPROBE_DEFER;	/* we can't probe yet */
>> +		else
>=20
> `else' is redundand
>=20
>> +			data->uart =3D NULL;	/* no UART */
>> +		}
>> +#endif
>> +
>> +	INIT_DELAYED_WORK(&data->work, toggle_work);
>> +	spin_lock_init(&data->lock);
>> +
>> +	err =3D devm_gpio_request(&pdev->dev, data->on_off_gpio, "w2sg0004=
-on-off");
>> +	if (err < 0)
>> +		goto out;
>> +
>> +	gpio_direction_output(data->on_off_gpio, false);
>> +
>> +	if (data->uart) {
>> +		struct ktermios termios =3D {
>> +			.c_iflag =3D IGNBRK,
>> +			.c_oflag =3D 0,
>> +			.c_cflag =3D B9600 | CS8,
>> +			.c_lflag =3D 0,
>> +			.c_line =3D 0,
>> +			.c_ispeed =3D 9600,
>> +			.c_ospeed =3D 9600
>> +		};
>> +		uart_register_slave(data->uart, data);
>> +		uart_register_mctrl_notification(data->uart, w2sg_mctrl);
>> +		uart_register_rx_notification(data->uart, rx_notification, &termi=
os);
>> +	}
>> +
>> +	rf_kill =3D rfkill_alloc("GPS", &pdev->dev, RFKILL_TYPE_GPS,
>> +				&w2sg_data0004_rfkill_ops, data);
>> +	if (rf_kill =3D=3D NULL) {
>> +		err =3D -ENOMEM;
>> +		goto err_rfkill;
>=20
> return -ENOMEM;
>=20
>> +	}
>> +
>> +	err =3D rfkill_register(rf_kill);
>> +	if (err) {
>> +		dev_err(&pdev->dev, "Cannot register rfkill device\n");
>> +		goto err_rfkill;
>> +	}
>> +
>> +	data->rf_kill =3D rf_kill;
>> +
>> +	platform_set_drvdata(pdev, data);
>> +
>> +	pr_debug("w2sg0004 probed\n");
>> +
>> +#ifdef CONFIG_W2SG0004_DEBUG
>> +	/* turn on for debugging rx notifications */
>> +	pr_debug("w2sg power gpio ON\n");
>> +	gpio_set_value_cansleep(data->on_off_gpio, 1);
>> +	mdelay(100);
>> +	pr_debug("w2sg power gpio OFF\n");
>> +	gpio_set_value_cansleep(data->on_off_gpio, 0);
>> +	mdelay(300);
>> +#endif
>> +
>> +	/* if we won't receive mctrl notifications, turn on.
>> +	 * otherwise keep off until DTR is asserted through mctrl.
>> +	 */
>> +
>> +	w2sg_data_set_power(data, !data->uart);
>> +
>> +	return 0;
>> +
>> +err_rfkill:
>> +	rfkill_destroy(rf_kill);
>> +out:
>=20
> `out' label is useless as no cleanup code here.
>=20
> Keeping in mind that the one of two `goto err_rfkill' is incorrect,
> `err_rfkill' label can be removed as there is the only one code path
> left which is using it.
>=20
>> +	return err;
>> +}
>> +
>> +static int w2sg_data_remove(struct platform_device *pdev)
>> +{
>> +	struct w2sg_data *data =3D platform_get_drvdata(pdev);
>> +
>> +	cancel_delayed_work_sync(&data->work);
>> +
>> +	if (data->uart) {
>> +		uart_register_rx_notification(data->uart, NULL, NULL);
>> +		uart_register_slave(data->uart, NULL);
>> +	}
>> +	return 0;
>> +}
>> +
>> +static int w2sg_data_suspend(struct device *dev)
>> +{
>> +	struct w2sg_data *data =3D dev_get_drvdata(dev);
>> +
>> +	spin_lock_irq(&data->lock);
>> +	data->suspended =3D true;
>> +	spin_unlock_irq(&data->lock);
>> +
>> +	cancel_delayed_work_sync(&data->work);
>> +
>> +	w2sg_data_set_lna_power(data);	/* shuts down if needed */
>> +
>> +	if (data->state =3D=3D W2SG_PULSE) {
>> +		msleep(10);
>> +		gpio_set_value_cansleep(data->on_off_gpio, 1);
>> +		data->last_toggle =3D jiffies;
>> +		data->is_on =3D !data->is_on;
>> +		data->state =3D W2SG_NOPULSE;
>> +	}
>> +
>> +	if (data->state =3D=3D W2SG_NOPULSE) {
>> +		msleep(10);
>> +		data->state =3D W2SG_IDLE;
>> +	}
>> +
>> +	if (data->is_on) {
>> +		pr_info("GPS off for suspend %d %d %d\n", data->requested, data->=
is_on, data->lna_is_off);
>> +
>> +		gpio_set_value_cansleep(data->on_off_gpio, 0);
>> +		msleep(10);
>> +		gpio_set_value_cansleep(data->on_off_gpio, 1);
>> +		data->is_on =3D 0;
>=20
> 0 -> false (to stay similar with other code)
>=20
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int w2sg_data_resume(struct device *dev)
>> +{
>> +	struct w2sg_data *data =3D dev_get_drvdata(dev);
>> +
>> +	spin_lock_irq(&data->lock);
>> +	data->suspended =3D false;
>> +	spin_unlock_irq(&data->lock);
>> +
>> +	pr_info("GPS resuming %d %d %d\n", data->requested, data->is_on, d=
ata->lna_is_off);
>> +
>> +	schedule_delayed_work(&data->work, 0);	/* enables LNA if needed */
>> +
>> +	return 0;
>> +}
>> +
>> +#if defined(CONFIG_OF)
>> +static const struct of_device_id w2sg0004_of_match[] =3D {
>> +	{ .compatible =3D "wi2wi,w2sg0004" },
>> +	{ .compatible =3D "wi2wi,w2sg0084" },
>> +	{},
>> +};
>> +MODULE_DEVICE_TABLE(of, w2sg0004_of_match);
>> +#endif
>> +
>> +SIMPLE_DEV_PM_OPS(w2sg_pm_ops, w2sg_data_suspend, w2sg_data_resume)=
;
>> +
>> +static struct platform_driver w2sg_data_driver =3D {
>> +	.probe		=3D w2sg_data_probe,
>> +	.remove		=3D w2sg_data_remove,
>> +	.driver =3D {
>> +		.name	=3D "w2sg0004",
>> +		.owner	=3D THIS_MODULE,
>> +		.pm	=3D &w2sg_pm_ops,
>> +		.of_match_table =3D of_match_ptr(w2sg0004_of_match)
>> +	},
>> +};
>> +
>> +module_platform_driver(w2sg_data_driver);
>> +
>> +MODULE_ALIAS("w2sg0004");
>> +
>> +MODULE_AUTHOR("NeilBrown <neilb@suse.de>");
>> +MODULE_DESCRIPTION("w2sg0004 GPS power management driver");
>> +MODULE_LICENSE("GPL v2");
>> diff --git a/include/linux/w2sg0004.h b/include/linux/w2sg0004.h
>> new file mode 100644
>> index 0000000..7aee709
>> --- /dev/null
>> +++ b/include/linux/w2sg0004.h
>> @@ -0,0 +1,28 @@
>> +/*
>> + * UART slave to allow ON/OFF control of w2sg0004 GPS receiver.
>> + *
>> + * Copyright (C) 2011 Neil Brown <neil@brown.name>
>> + *
>> + * This program is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU General Public License
>> + * version 2 as published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful, =
but
>> + * WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GN=
U
>> + * General Public License for more details.
>> + *
>> + */
>> +
>> +
>> +
>> +#ifndef __LINUX_W2SG0004_H
>> +#define __LINUX_W2SG0004_H
>> +
>> +#include <linux/regulator/consumer.h>
>> +
>> +struct w2sg_pdata {
>> +	struct regulator *lna_regulator;	/* enable LNA power */
>> +	int	on_off_gpio;	/* connected to the on-off input of the GPS modul=
e */
>> +};
>> +#endif /* __LINUX_W2SG0004_H */
>> --=20
>> 1.9.1
>>=20
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-kern=
el" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
