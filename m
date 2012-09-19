From: Jason Wessel <jason.wessel@windriver.com>
Subject: Re: [PATCH 07/11] tty/serial: Add kgdb_nmi driver
Date: Wed, 19 Sep 2012 06:52:32 -0500
Message-ID: <5059B200.9040706@windriver.com>
References: <20120913150133.GA16238@lizard> <1347548615-18227-7-git-send-email-anton.vorontsov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail1.windriver.com ([147.11.146.13]:60926 "EHLO
	mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755509Ab2ISLxD (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 19 Sep 2012 07:53:03 -0400
In-Reply-To: <1347548615-18227-7-git-send-email-anton.vorontsov@linaro.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Anton Vorontsov <anton.vorontsov@linaro.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <alan@linux.intel.com>, =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>, Colin Cross <ccross@android.com>, Brian Swetland <swetland@google.com>, John Stultz <john.stultz@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linaro-kernel@lists.linaro.org, patches@linaro.org, kernel-team@android.com, kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org

On 09/13/2012 10:03 AM, Anton Vorontsov wrote:
> This special driver makes it possible to temporary use NMI debugger p=
ort
> as a normal console by issuing 'nmi_console' command (assuming that t=
he
> port is attached to KGDB).
>=20
> Unlike KDB's disable_nmi command, with this driver you are always abl=
e
> to go back to the debugger using KGDB escape sequence ($3#33).  This =
is
> because this console driver processes the input in NMI context, and t=
hus
> is able to intercept the magic sequence.
>=20
> Note that since the console interprets input and uses polling
> communication methods, for things like PPP it is still better to full=
y
> detach debugger port from the KGDB NMI (i.e. disable_nmi), and use ra=
w
> console.
>=20
> Usually, to enter the debugger one have to type the magic sequence, s=
o
> initially the kernel will print the following prompt on the NMI debug=
ger
> console:
>=20
> 	Type $3#33 to enter the debugger>
>=20
> For convenience, there is a kgdb_fiq.knock kernel command line option=
,
> when set to 0, this turns the special command to just a return key
> press, so the kernel will be printing this:
>=20
> 	Hit <return> to enter the debugger>
>=20
> This is more convenient for long debugging sessions, although it make=
s
> nmi_console feature somewhat useless.
>=20
> And for the cases when NMI connected to a dedicated button, the knock=
ing
> can be disabled altogether by setting kgdb_fiq.knock to -1.
>=20
> Suggested-by: Colin Cross <ccross@android.com>
> Signed-off-by: Anton Vorontsov <anton.vorontsov@linaro.org>
> ---
>  drivers/tty/serial/Kconfig    |  19 ++
>  drivers/tty/serial/Makefile   |   1 +
>  drivers/tty/serial/kgdb_nmi.c | 396 ++++++++++++++++++++++++++++++++=
++++++++++
>  drivers/tty/serial/kgdboc.c   |   6 +
>  include/linux/kgdb.h          |  10 ++
>  5 files changed, 432 insertions(+)
>  create mode 100644 drivers/tty/serial/kgdb_nmi.c
>=20
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index 26907cf..b22e45b 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -141,6 +141,25 @@ config SERIAL_ATMEL_TTYAT
> =20
>  	  Say Y if you have an external 8250/16C550 UART.  If unsure, say N=
=2E
> =20
> +config SERIAL_KGDB_NMI
> +	bool "Serial console over KGDB NMI debugger port"
> +	depends on KGDB_SERIAL_CONSOLE
> +	help
> +	  This special driver allows you to temporary use NMI debugger port
> +	  as a normal console (assuming that the port is attached to KGDB).
> +
> +	  Unlike KDB's disable_nmi command, with this driver you are always
> +	  able to go back to the debugger using KGDB escape sequence ($3#33=
).
> +	  This is because this console driver processes the input in NMI
> +	  context, and thus is able to intercept the magic sequence.
> +
> +	  Note that since the console interprets input and uses polling
> +	  communication methods, for things like PPP you still must fully
> +	  detach debugger port from the KGDB NMI (i.e. disable_nmi), and
> +	  use raw console.
> +
> +	  If unsure, say N.
> +
>  config SERIAL_KS8695
>  	bool "Micrel KS8695 (Centaur) serial port support"
>  	depends on ARCH_KS8695
> diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefil=
e
> index ce88667..4f694da 100644
> --- a/drivers/tty/serial/Makefile
> +++ b/drivers/tty/serial/Makefile
> @@ -61,6 +61,7 @@ obj-$(CONFIG_SERIAL_MSM_HS) +=3D msm_serial_hs.o
>  obj-$(CONFIG_SERIAL_NETX) +=3D netx-serial.o
>  obj-$(CONFIG_SERIAL_OF_PLATFORM) +=3D of_serial.o
>  obj-$(CONFIG_SERIAL_OF_PLATFORM_NWPSERIAL) +=3D nwpserial.o
> +obj-$(CONFIG_SERIAL_KGDB_NMI) +=3D kgdb_nmi.o
>  obj-$(CONFIG_SERIAL_KS8695) +=3D serial_ks8695.o
>  obj-$(CONFIG_SERIAL_OMAP) +=3D omap-serial.o
>  obj-$(CONFIG_SERIAL_ALTERA_UART) +=3D altera_uart.o
> diff --git a/drivers/tty/serial/kgdb_nmi.c b/drivers/tty/serial/kgdb_=
nmi.c
> new file mode 100644
> index 0000000..57bf744
> --- /dev/null
> +++ b/drivers/tty/serial/kgdb_nmi.c
> @@ -0,0 +1,396 @@
> +/*
> + * KGDB NMI serial console
> + *
> + * Copyright 2010 Google, Inc.
> + *		  Arve Hj=F8nnev=E5g <arve@android.com>
> + *		  Colin Cross <ccross@android.com>
> + * Copyright 2012 Linaro Ltd.
> + *		  Anton Vorontsov <anton.vorontsov@linaro.org>
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify it
> + * under the terms of the GNU General Public License version 2 as pu=
blished
> + * by the Free Software Foundation.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/compiler.h>
> +#include <linux/init.h>
> +#include <linux/slab.h>
> +#include <linux/errno.h>
> +#include <linux/atomic.h>
> +#include <linux/console.h>
> +#include <linux/tty.h>
> +#include <linux/tty_driver.h>
> +#include <linux/tty_flip.h>
> +#include <linux/interrupt.h>
> +#include <linux/hrtimer.h>
> +#include <linux/tick.h>
> +#include <linux/kfifo.h>
> +#include <linux/kgdb.h>
> +#include <linux/kdb.h>
> +
> +static int kgdb_nmi_knock =3D 1;
> +module_param_named(knock, kgdb_nmi_knock, int, 0600);
> +MODULE_PARM_DESC(knock, "if set to 1 (default), the special '$3#33' =
command "
> +			"must be used to enter the debugger; when set to 0, "
> +			"hitting return key is enough to enter the debugger; "
> +			"when set to -1, the debugger is entered immediately "
> +			"upon NMI");
> +
> +static char *kgdb_nmi_magic =3D "$3#33";
> +module_param_named(magic, kgdb_nmi_magic, charp, 0600);
> +MODULE_PARM_DESC(magic, "magic sequence to enter NMI debugger (defau=
lt $3#33)");
> +
> +static bool kgdb_nmi_tty_enabled;
> +
> +static void kgdb_nmi_console_write(struct console *co, const char *s=
, uint c)
> +{
> +	int i;
> +
> +	if (!kgdb_nmi_tty_enabled || atomic_read(&kgdb_active) >=3D 0)
> +		return;
> +
> +	for (i =3D 0; i < c; i++)
> +		dbg_io_ops->write_char(s[i]);
> +}
> +
> +static struct tty_driver *kgdb_nmi_tty_driver;
> +
> +static struct tty_driver *kgdb_nmi_console_device(struct console *co=
, int *idx)
> +{
> +	*idx =3D co->index;
> +	return kgdb_nmi_tty_driver;
> +}
> +
> +static struct console kgdb_nmi_console =3D {
> +	.name	=3D "ttyNMI",
> +	.write	=3D kgdb_nmi_console_write,
> +	.device	=3D kgdb_nmi_console_device,
> +	.flags	=3D CON_PRINTBUFFER | CON_ANYTIME | CON_ENABLED,
> +	.index	=3D -1,
> +};
> +
> +/*
> + * This is usually the maximum rate on debug ports. We make fifo lar=
ge enough
> + * to make copy-pasting to the terminal usable.
> + */
> +#define KGDB_NMI_BAUD		115200
> +#define KGDB_NMI_FIFO_SIZE	roundup_pow_of_two(KGDB_NMI_BAUD / 8 / HZ=
)
> +
> +struct kgdb_nmi_tty_priv {
> +	struct tty_port port;
> +	struct tasklet_struct tlet;
> +	STRUCT_KFIFO(char, KGDB_NMI_FIFO_SIZE) fifo;
> +};
> +
> +static struct kgdb_nmi_tty_priv *kgdb_nmi_port_to_priv(struct tty_po=
rt *port)
> +{
> +	return container_of(port, struct kgdb_nmi_tty_priv, port);
> +}
> +
> +/*
> + * Our debugging console is polled in a tasklet, so we'll check for =
input
> + * every tick. In HZ-less mode, we should program the next tick.  We=
 have
> + * to use the lowlevel stuff as no locks should be grabbed.
> + */
> +#ifdef CONFIG_HIGH_RES_TIMERS
> +static void kgdb_tty_poke(void)
> +{
> +	tick_program_event(ktime_get(), 0);
> +}
> +#else
> +static inline void kgdb_tty_poke(void) {}
> +#endif
> +
> +static struct tty_port *kgdb_nmi_port;
> +
> +static void kgdb_tty_recv(int ch)
> +{
> +	struct kgdb_nmi_tty_priv *priv;
> +	char c =3D ch;
> +
> +	if (!kgdb_nmi_port || ch < 0)
> +		return;
> +	/*
> +	 * Can't use port->tty->driver_data as tty might be not there. Task=
let
> +	 * will check for tty and will get the ref, but here we don't have =
to
> +	 * do that, and actually, we can't: we're in NMI context, no locks =
are
> +	 * possible.
> +	 */
> +	priv =3D kgdb_nmi_port_to_priv(kgdb_nmi_port);
> +	kfifo_in(&priv->fifo, &c, 1);
> +	kgdb_tty_poke();
> +}
> +
> +static int kgdb_nmi_poll_one_knock(void)
> +{
> +	static int n;
> +	int c =3D -1;
> +	const char *magic =3D kgdb_nmi_magic;
> +	size_t m =3D strlen(magic);
> +	bool printch =3D 0;
> +
> +	c =3D dbg_io_ops->read_char();
> +	if (c =3D=3D NO_POLL_CHAR)
> +		return c;
> +
> +	if (!kgdb_nmi_knock && (c =3D=3D '\r' || c =3D=3D '\n')) {
> +		return 1;
> +	} else if (c =3D=3D magic[n]) {
> +		n =3D (n + 1) % m;
> +		if (!n)
> +			return 1;
> +		printch =3D 1;
> +	} else {
> +		n =3D 0;
> +	}
> +
> +	if (kgdb_nmi_tty_enabled) {
> +		kgdb_tty_recv(c);
> +		return 0;
> +	}
> +
> +	if (printch) {
> +		kdb_printf("%c", c);
> +		return 0;
> +	}
> +
> +	kdb_printf("\r%s %s to enter the debugger> %*s",
> +		   kgdb_nmi_knock ? "Type" : "Hit",
> +		   kgdb_nmi_knock ? magic  : "<return>", m, "");
> +	while (m--)
> +		kdb_printf("\b");
> +	return 0;
> +}
> +
> +/**
> + * kgdb_nmi_poll_knock - Check if it is time to enter the debugger
> + *
> + * "Serial ports are often noisy, especially when muxed over another=
 port (we
> + * often use serial over the headset connector). Noise on the async =
command
> + * line just causes characters that are ignored, on a command line t=
hat blocked
> + * execution noise would be catastrophic." -- Colin Cross
> + *
> + * So, this function implements KGDB/KDB knocking on the serial line=
: we won't
> + * enter the debugger until we receive a known magic phrase (which i=
s actually
> + * "$3#33", known as "escape to KDB" command. There is also a relaxe=
d variant
> + * of knocking, i.e. just pressing the return key is enough to enter=
 the
> + * debugger. And if knocking is disabled, the function always return=
s 1.
> + */
> +bool kgdb_nmi_poll_knock(void)
> +{
> +	if (kgdb_nmi_knock < 0)
> +		return 1;
> +
> +	while (1) {
> +		int ret;
> +
> +		ret =3D kgdb_nmi_poll_one_knock();
> +		if (ret =3D=3D NO_POLL_CHAR)
> +			return 0;
> +		else if (ret =3D=3D 1)
> +			break;
> +	}
> +	return 1;
> +}
> +
> +/*
> + * The tasklet is cheap, it does not cause wakeups when reschedules =
itself,
> + * instead it waits for the next tick.
> + */
> +static void kgdb_nmi_tty_receiver(unsigned long data)
> +{
> +	struct kgdb_nmi_tty_priv *priv =3D (void *)data;
> +	struct tty_struct *tty;
> +	char ch;
> +
> +	tasklet_schedule(&priv->tlet);
> +
> +	if (likely(!kgdb_nmi_tty_enabled || !kfifo_len(&priv->fifo)))
> +		return;
> +
> +	/* Port is there, but tty might be hung up, check. */
> +	tty =3D tty_port_tty_get(kgdb_nmi_port);
> +	if (!tty)
> +		return;
> +
> +	while (kfifo_out(&priv->fifo, &ch, 1))
> +		tty_insert_flip_char(priv->port.tty, ch, TTY_NORMAL);
> +	tty_flip_buffer_push(priv->port.tty);
> +
> +	tty_kref_put(tty);
> +}
> +
> +static int kgdb_nmi_tty_activate(struct tty_port *port, struct tty_s=
truct *tty)
> +{
> +	struct kgdb_nmi_tty_priv *priv =3D tty->driver_data;
> +
> +	kgdb_nmi_port =3D port;
> +	tasklet_schedule(&priv->tlet);
> +	return 0;
> +}
> +
> +static void kgdb_nmi_tty_shutdown(struct tty_port *port)
> +{
> +	struct kgdb_nmi_tty_priv *priv =3D port->tty->driver_data;
> +
> +	tasklet_kill(&priv->tlet);
> +	kgdb_nmi_port =3D NULL;
> +}
> +
> +static const struct tty_port_operations kgdb_nmi_tty_port_ops =3D {
> +	.activate	=3D kgdb_nmi_tty_activate,
> +	.shutdown	=3D kgdb_nmi_tty_shutdown,
> +};
> +
> +static int kgdb_nmi_tty_install(struct tty_driver *drv, struct tty_s=
truct *tty)
> +{
> +	struct kgdb_nmi_tty_priv *priv;
> +	int ret;
> +
> +	priv =3D kzalloc(sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	INIT_KFIFO(priv->fifo);
> +	tasklet_init(&priv->tlet, kgdb_nmi_tty_receiver, (unsigned long)pri=
v);
> +	tty_port_init(&priv->port);
> +	priv->port.ops =3D &kgdb_nmi_tty_port_ops;
> +	tty->driver_data =3D priv;
> +
> +	ret =3D tty_port_install(&priv->port, drv, tty);
> +	if (ret) {
> +		pr_err("%s: can't nstall tty port: %d\n", __func__, ret);
> +		goto err;
> +	}
> +	return 0;
> +err:
> +	kfree(priv);
> +	return ret;
> +}
> +
> +static void kgdb_nmi_tty_cleanup(struct tty_struct *tty)
> +{
> +	struct kgdb_nmi_tty_priv *priv =3D tty->driver_data;
> +
> +	tty->driver_data =3D NULL;
> +	kfree(priv);
> +}
> +
> +static int kgdb_nmi_tty_open(struct tty_struct *tty, struct file *fi=
le)
> +{
> +	struct kgdb_nmi_tty_priv *priv =3D tty->driver_data;
> +
> +	return tty_port_open(&priv->port, tty, file);
> +}
> +
> +static void kgdb_nmi_tty_close(struct tty_struct *tty, struct file *=
file)
> +{
> +	struct kgdb_nmi_tty_priv *priv =3D tty->driver_data;
> +
> +	tty_port_close(&priv->port, tty, file);
> +}
> +
> +static void kgdb_nmi_tty_hangup(struct tty_struct *tty)
> +{
> +	struct kgdb_nmi_tty_priv *priv =3D tty->driver_data;
> +
> +	tty_port_hangup(&priv->port);
> +}
> +
> +static int kgdb_nmi_tty_write_room(struct tty_struct *tty)
> +{
> +	/* Actually, we can handle any amount as we use polled writes. */
> +	return 2048;
> +}
> +
> +static int kgdb_nmi_tty_write(struct tty_struct *tty, const unchar *=
buf, int c)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < c; i++)
> +		dbg_io_ops->write_char(buf[i]);
> +	return c;
> +}
> +
> +static const struct tty_operations kgdb_nmi_tty_ops =3D {
> +	.open		=3D kgdb_nmi_tty_open,
> +	.close		=3D kgdb_nmi_tty_close,
> +	.install	=3D kgdb_nmi_tty_install,
> +	.cleanup	=3D kgdb_nmi_tty_cleanup,
> +	.hangup		=3D kgdb_nmi_tty_hangup,
> +	.write_room	=3D kgdb_nmi_tty_write_room,
> +	.write		=3D kgdb_nmi_tty_write,
> +};
> +
> +static int kgdb_nmi_enable_console(int argc, const char *argv[])
> +{
> +	kgdb_nmi_tty_enabled =3D !(argc =3D=3D 1 && !strcmp(argv[1], "off")=
);
> +	return 0;
> +}
> +
> +int kgdb_register_nmi_console(void)
> +{
> +	int ret;
> +
> +	kgdb_nmi_tty_driver =3D alloc_tty_driver(1);
> +	if (!kgdb_nmi_tty_driver) {
> +		pr_err("%s: cannot allocate tty\n", __func__);
> +		return -ENOMEM;
> +	}
> +	kgdb_nmi_tty_driver->driver_name	=3D "ttyNMI";
> +	kgdb_nmi_tty_driver->name		=3D "ttyNMI";
> +	kgdb_nmi_tty_driver->num		=3D 1;
> +	kgdb_nmi_tty_driver->type		=3D TTY_DRIVER_TYPE_SERIAL;
> +	kgdb_nmi_tty_driver->subtype		=3D SERIAL_TYPE_NORMAL;
> +	kgdb_nmi_tty_driver->flags		=3D TTY_DRIVER_REAL_RAW;
> +	kgdb_nmi_tty_driver->init_termios	=3D tty_std_termios;
> +	tty_termios_encode_baud_rate(&kgdb_nmi_tty_driver->init_termios,
> +				     KGDB_NMI_BAUD, KGDB_NMI_BAUD);
> +	tty_set_operations(kgdb_nmi_tty_driver, &kgdb_nmi_tty_ops);
> +
> +	ret =3D tty_register_driver(kgdb_nmi_tty_driver);
> +	if (ret) {
> +		pr_err("%s: can't register tty driver: %d\n", __func__, ret);
> +		goto err_drv_reg;
> +	}
> +
> +	ret =3D kdb_register("nmi_console", kgdb_nmi_enable_console, "[off]=
",
> +			   "switch to Linux NMI console", 0);
> +	if (ret) {
> +		pr_err("%s: can't register kdb command: %d\n", __func__, ret);
> +		goto err_kdb_reg;
> +	}
> +
> +	register_console(&kgdb_nmi_console);
> +	kgdb_enable_nmi(1);
> +
> +	return 0;
> +err_kdb_reg:
> +	tty_unregister_driver(kgdb_nmi_tty_driver);
> +err_drv_reg:
> +	put_tty_driver(kgdb_nmi_tty_driver);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(kgdb_register_nmi_console);
> +
> +int kgdb_unregister_nmi_console(void)
> +{
> +	int ret;
> +
> +	kgdb_enable_nmi(0);
> +	kdb_unregister("nmi_console");
> +
> +	ret =3D unregister_console(&kgdb_nmi_console);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D tty_unregister_driver(kgdb_nmi_tty_driver);
> +	if (ret)
> +		return ret;
> +	put_tty_driver(kgdb_nmi_tty_driver);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(kgdb_unregister_nmi_console);
> diff --git a/drivers/tty/serial/kgdboc.c b/drivers/tty/serial/kgdboc.=
c
> index 2b42a01..ed97cfd 100644
> --- a/drivers/tty/serial/kgdboc.c
> +++ b/drivers/tty/serial/kgdboc.c
> @@ -145,6 +145,8 @@ __setup("kgdboc=3D", kgdboc_option_setup);
> =20
>  static void cleanup_kgdboc(void)
>  {
> +	if (kgdb_unregister_nmi_console())
> +		return;
>  	kgdboc_unregister_kbd();
>  	if (configured =3D=3D 1)
>  		kgdb_unregister_io_module(&kgdboc_io_ops);
> @@ -198,6 +200,10 @@ do_register:
>  	if (err)
>  		goto noconfig;
> =20
> +	err =3D kgdb_register_nmi_console();
> +	if (err)
> +		goto noconfig;
> +


Just one question on this one, what do you expect to happen, or how doe=
s this work when you use a different serial port for example on a board=
 that has a real serial port and an FIQ port?   It was not obvious that=
 there was a path to check if the port you are registering is an FIQ en=
abled port and then call the kgdb_register_nmi_console at that point.

Jason.
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
