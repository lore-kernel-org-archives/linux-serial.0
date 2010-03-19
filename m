From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 3/3] max3100: adds console support for MAX3100
Date: Fri, 19 Mar 2010 13:31:59 -0600
Message-ID: <fa686aa41003191231w54d7489ds917c3cd2de0bea52@mail.gmail.com>
References: <cabda6421003190139h344bc172h3556fca78e4b25cb@mail.gmail.com>
	<1268987997-22746-1-git-send-email-chripell@fsfe.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-yx0-f182.google.com ([209.85.210.182]:56959 "EHLO
	mail-yx0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751013Ab0CSTcU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 19 Mar 2010 15:32:20 -0400
Received: by yxe12 with SMTP id 12so741131yxe.33
        for <linux-serial@vger.kernel.org>; Fri, 19 Mar 2010 12:32:19 -0700 (PDT)
In-Reply-To: <1268987997-22746-1-git-send-email-chripell@fsfe.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Christian Pellegrin <chripell@fsfe.org>
Cc: feng.tang@intel.com, akpm@linux-foundation.org, greg@kroah.com, david-b@pacbell.net, alan@lxorguk.ukuu.org.uk, spi-devel-general@lists.sourceforge.net, linux-serial@vger.kernel.org

Hi Christian,

Comments below.

g.

On Fri, Mar 19, 2010 at 2:39 AM, Christian Pellegrin <chripell@fsfe.org=
> wrote:
> This patch adds console support for the MAX3100 UART
> (console=3DttyMAX0,11500). The SPI subsystem and an
> suitable SPI master driver have to be compiled in the kernel.
>
> Signed-off-by: Christian Pellegrin <chripell@fsfe.org>
> ---
> =A0drivers/serial/Kconfig =A0 | =A0 20 +++++
> =A0drivers/serial/max3100.c | =A0184 ++++++++++++++++++++++++++++++++=
+++++++++----
> =A02 files changed, 187 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
> index 9ff47db..bc72e84 100644
> --- a/drivers/serial/Kconfig
> +++ b/drivers/serial/Kconfig
> @@ -547,6 +547,26 @@ config SERIAL_MAX3100
> =A0 =A0 =A0 =A0help
> =A0 =A0 =A0 =A0 =A0MAX3100 chip support
>
> +config SERIAL_MAX3100_CONSOLE
> + =A0 =A0 =A0 bool "Support console on MAX3100"
> + =A0 =A0 =A0 depends on SERIAL_MAX3100=3Dy
> + =A0 =A0 =A0 select SERIAL_CORE_CONSOLE
> + =A0 =A0 =A0 help
> + =A0 =A0 =A0 =A0 Console on MAX3100
> +
> +config SERIAL_MAX3100_CONSOLE_N
> + =A0 =A0 =A0 int "Number of MAX3100 chips to wait before registering=
 console"
> + =A0 =A0 =A0 depends on SERIAL_MAX3100_CONSOLE=3Dy
> + =A0 =A0 =A0 default "1"
> + =A0 =A0 =A0 help
> + =A0 =A0 =A0 =A0 Unfortunately due to the async nature of Linux boot=
 we must
> + =A0 =A0 =A0 =A0 know in advance when to register the console. If we=
 do it
> + =A0 =A0 =A0 =A0 too early not all the MAX3100 chips are known to th=
e system
> + =A0 =A0 =A0 =A0 yet. And we just cannot know how many MAX3100 will =
be in the
> + =A0 =A0 =A0 =A0 system so it's impossible to wait for the last one.=
 =A0If you
> + =A0 =A0 =A0 =A0 just want to have the console on the first MAX3100 =
chip
> + =A0 =A0 =A0 =A0 probed (ttyMAX0) it's safe to leave this to 1.

This seems wrong and fragile.  It certainly isn't multiplatform safe
to have it as a CONFIG setting because every board will have a
different number of devices that it needs to wait for.  I don't know
the console code very well though, but it seems to me that there
should be a way to register the console regardless and then be able to
hold off output until the actual backing device shows up.

Anybody know the right thing to do here?

> +
> =A0config SERIAL_DZ
> =A0 =A0 =A0 =A0bool "DECstation DZ serial driver"
> =A0 =A0 =A0 =A0depends on MACH_DECSTATION && 32BIT
> diff --git a/drivers/serial/max3100.c b/drivers/serial/max3100.c
> index 0c972c6..f6d250d 100644
> --- a/drivers/serial/max3100.c
> +++ b/drivers/serial/max3100.c
> @@ -48,6 +48,7 @@
> =A0#include <linux/kthread.h>
> =A0#include <linux/interrupt.h>
> =A0#include <linux/bitops.h>
> +#include <linux/console.h>
>
> =A0#include <linux/serial_max3100.h>
>
> @@ -131,6 +132,10 @@ struct max3100_port {
> =A0 =A0 =A0 =A0int poll_time;
> =A0 =A0 =A0 =A0/* and its timer */
> =A0 =A0 =A0 =A0struct timer_list =A0 =A0 =A0 timer;
> +
> + =A0 =A0 =A0 int console_flags;
> + =A0 =A0 =A0 /* is this port a console? */
> +#define MAX3100_IS_CONSOLE =A0 (1 << 0)
> =A0};
>
> =A0static struct max3100_port *max3100s[MAX_MAX3100]; /* the chips */
> @@ -175,7 +180,8 @@ static void max3100_resume_work(struct work_struc=
t *w)
> =A0 =A0 =A0 =A0struct max3100_port *s =3D container_of(w, struct max3=
100_port,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0resume_work);
>
> - =A0 =A0 =A0 raise_threaded_irq(s->irq);
> + =A0 =A0 =A0 if (s->irq)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 raise_threaded_irq(s->irq);
> =A0}
>
> =A0static void max3100_timeout(unsigned long data)
> @@ -552,14 +558,16 @@ static void max3100_shutdown(struct uart_port *=
port)
> =A0 =A0 =A0 =A0if (s->irq)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0free_irq(s->irq, s);
>
> - =A0 =A0 =A0 /* set shutdown mode to save power */
> - =A0 =A0 =A0 if (s->max3100_hw_suspend)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 s->max3100_hw_suspend(1);
> - =A0 =A0 =A0 else =A0{
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 u16 tx, rx;
> + =A0 =A0 =A0 if (!(s->console_flags & MAX3100_IS_CONSOLE)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* set shutdown mode to save power */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (s->max3100_hw_suspend)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 s->max3100_hw_suspend(1=
);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else =A0{
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 u16 tx, rx;

inconsistent braces.  If you use {} on the else side, then please use
{} on the if side too.

>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 tx =3D MAX3100_WC | MAX3100_SHDN;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 max3100_sr(s, tx, &rx);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tx =3D MAX3100_WC | MAX=
3100_SHDN;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 max3100_sr(s, tx, &rx);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0}
> =A0}
>
> @@ -578,10 +586,8 @@ static int max3100_startup(struct uart_port *por=
t)
> =A0 =A0 =A0 =A0s->parity =3D 0;
> =A0 =A0 =A0 =A0s->rts =3D 0;
>
> - =A0 =A0 =A0 INIT_WORK(&s->resume_work, max3100_resume_work);
> -
> =A0 =A0 =A0 =A0if (request_threaded_irq(s->irq, NULL, max3100_ist,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 IRQF_TRIGGER_FALLING, "=
max3100", s) < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0IRQF=
_TRIGGER_FALLING, "max3100", s) < 0) {

try to avoid unrelated whitespace changes, it adds noise when reviewing=
=2E

> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(&s->spi->dev, "cannot allocate=
 irq %d\n", s->irq);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0s->irq =3D 0;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EBUSY;
> @@ -699,6 +705,136 @@ static struct uart_ops max3100_ops =3D {
> =A0 =A0 =A0 =A0.verify_port =A0 =A0=3D max3100_verify_port,
> =A0};
>
> +#ifdef CONFIG_SERIAL_MAX3100_CONSOLE
> +
> +static void max3100_console_putchar(struct uart_port *port, int ch)
> +{
> + =A0 =A0 =A0 struct max3100_port *s =3D container_of(port, struct ma=
x3100_port, port);
> + =A0 =A0 =A0 unsigned long tout =3D 10 * HZ / 1000; /* 10ms */
> + =A0 =A0 =A0 unsigned long start;
> + =A0 =A0 =A0 u16 tx, rx;
> +
> + =A0 =A0 =A0 if (tout =3D=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tout =3D 1;
> + =A0 =A0 =A0 start =3D jiffies;
> + =A0 =A0 =A0 do {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tx =3D MAX3100_RC;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 max3100_sr(s, tx, &rx);
> + =A0 =A0 =A0 } while ((rx & MAX3100_T) =3D=3D 0 &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0!time_after(jiffies, start + tout));
> + =A0 =A0 =A0 tx =3D ch;
> + =A0 =A0 =A0 max3100_calc_parity(s, &tx);
> + =A0 =A0 =A0 tx |=3D MAX3100_WD | MAX3100_RTS;
> + =A0 =A0 =A0 max3100_sr(s, tx, &rx);
> +}
> +
> +static void max3100_console_write(struct console *co,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 con=
st char *str, unsigned int count)
> +{
> + =A0 =A0 =A0 struct max3100_port *s =3D max3100s[co->index];;
> +
> + =A0 =A0 =A0 uart_console_write(&s->port, str, count, max3100_consol=
e_putchar);
> +}
> +
> +static int max3100_console_setup(struct console *co, char *options)
> +{
> + =A0 =A0 =A0 struct max3100_port *s;
> + =A0 =A0 =A0 int baud =3D 115200;
> + =A0 =A0 =A0 int bits =3D 8;
> + =A0 =A0 =A0 int parity =3D 'n';
> + =A0 =A0 =A0 int flow =3D 'n';
> + =A0 =A0 =A0 int ret;
> + =A0 =A0 =A0 u16 tx, rx;
> +
> + =A0 =A0 =A0 if (co->index =3D=3D -1 || co->index >=3D MAX_MAX3100)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 co->index =3D 0;
> + =A0 =A0 =A0 s =3D max3100s[co->index];
> + =A0 =A0 =A0 if (!s)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOENT;
> + =A0 =A0 =A0 s->console_flags |=3D MAX3100_IS_CONSOLE;
> +
> + =A0 =A0 =A0 if (options)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 uart_parse_options(options, &baud, &par=
ity, &bits, &flow);
> + =A0 =A0 =A0 ret =3D uart_set_options(&s->port, co, baud, parity, bi=
ts, flow);
> +
> + =A0 =A0 =A0 tx =3D 0;
> + =A0 =A0 =A0 switch (baud) {
> + =A0 =A0 =A0 case 300:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tx =3D 15;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case 600:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tx =3D 14 + s->crystal;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case 1200:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tx =3D 13 + s->crystal;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case 2400:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tx =3D 12 + s->crystal;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case 4800:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tx =3D 11 + s->crystal;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case 9600:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tx =3D 10 + s->crystal;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case 19200:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tx =3D 9 + s->crystal;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case 38400:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tx =3D 8 + s->crystal;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case 57600:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tx =3D 1 + s->crystal;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case 115200:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tx =3D 0 + s->crystal;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case 230400:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tx =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (bits =3D=3D 8) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tx &=3D ~MAX3100_L;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 s->parity &=3D ~MAX3100_7BIT;
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tx |=3D MAX3100_L;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 s->parity |=3D MAX3100_7BIT;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (parity =3D=3D 'o' || parity =3D=3D 'e') {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tx |=3D MAX3100_PE;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 parity |=3D MAX3100_PARITY_ON;

s->parity?

> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tx &=3D ~MAX3100_PE;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 parity &=3D ~MAX3100_PARITY_ON;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (parity =3D=3D 'o')
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 parity |=3D MAX3100_PARITY_ODD;
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 parity &=3D ~MAX3100_PARITY_ODD;

ditto?


Also, these blocks are really verbose; maybe do this:
       tx &=3D ~(MAX3100_L | MAX3100_PE);
       s->parity &=3D ~(MAX3100_7BIT | MAX3100_PARITY_ON | MAX3100_PARI=
TY_ODD);
       if (bits !=3D 8) {
               tx |=3D MAX3100_L;
               s->parity |=3D MAX3100_7BIT;
       }

       if (parity =3D=3D 'o' || parity =3D=3D 'e') {
               tx |=3D MAX3100_PE;
               s->parity |=3D MAX3100_PARITY_ON;
       }

       if (parity =3D=3D 'o')
               s->parity |=3D MAX3100_PARITY_ODD;

> +
> +
> + =A0 =A0 =A0 tx |=3D MAX3100_WC;
> + =A0 =A0 =A0 max3100_sr(s, tx, &rx);
> +
> + =A0 =A0 =A0 msleep(50);

Why the sleep?  Shouldn't the console driver be able to handle the SPI
device not being ready yet?

> + =A0 =A0 =A0 return ret;
> +}
> +
> +static struct uart_driver max3100_uart_driver;
> +static struct console max3100_console =3D {
> + =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "ttyMAX",
> + =A0 =A0 =A0 .write =A0 =A0 =A0 =A0 =A0=3D max3100_console_write,
> + =A0 =A0 =A0 .device =A0 =A0 =A0 =A0 =3D uart_console_device,
> + =A0 =A0 =A0 .setup =A0 =A0 =A0 =A0 =A0=3D max3100_console_setup,
> + =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D CON_PRINTBUFFER,
> + =A0 =A0 =A0 .index =A0 =A0 =A0 =A0 =A0=3D -1,
> + =A0 =A0 =A0 .data =A0 =A0 =A0 =A0 =A0 =3D &max3100_uart_driver,
> +};
> +#endif
> +
> =A0static struct uart_driver max3100_uart_driver =3D {
> =A0 =A0 =A0 =A0.owner =A0 =A0 =A0 =A0 =A0=3D THIS_MODULE,
> =A0 =A0 =A0 =A0.driver_name =A0 =A0=3D "ttyMAX",
> @@ -706,6 +842,9 @@ static struct uart_driver max3100_uart_driver =3D=
 {
> =A0 =A0 =A0 =A0.major =A0 =A0 =A0 =A0 =A0=3D MAX3100_MAJOR,
> =A0 =A0 =A0 =A0.minor =A0 =A0 =A0 =A0 =A0=3D MAX3100_MINOR,
> =A0 =A0 =A0 =A0.nr =A0 =A0 =A0 =A0 =A0 =A0 =3D MAX_MAX3100,
> +#ifdef CONFIG_SERIAL_MAX3100_CONSOLE
> + =A0 =A0 =A0 .cons =A0 =A0 =A0 =A0 =A0 =3D &max3100_console,
> +#endif
> =A0};
> =A0static int uart_driver_registered;
>
> @@ -768,18 +907,26 @@ static int __devinit max3100_probe(struct spi_d=
evice *spi)
> =A0 =A0 =A0 =A0max3100s[i]->port.line =3D i;
> =A0 =A0 =A0 =A0max3100s[i]->port.type =3D PORT_MAX3100;
> =A0 =A0 =A0 =A0max3100s[i]->port.dev =3D &spi->dev;
> + =A0 =A0 =A0 INIT_WORK(&max3100s[i]->resume_work, max3100_resume_wor=
k);
> =A0 =A0 =A0 =A0retval =3D uart_add_one_port(&max3100_uart_driver, &ma=
x3100s[i]->port);
> =A0 =A0 =A0 =A0if (retval < 0)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_warn(&spi->dev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "uart_add_one_port fa=
iled for line %d with error %d\n",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 i, retval);
>
> - =A0 =A0 =A0 /* set shutdown mode to save power. Will be woken-up on=
 open */
> - =A0 =A0 =A0 if (max3100s[i]->max3100_hw_suspend)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 max3100s[i]->max3100_hw_suspend(1);
> - =A0 =A0 =A0 else {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 tx =3D MAX3100_WC | MAX3100_SHDN;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 max3100_sr(max3100s[i], tx, &rx);
> +#ifdef CONFIG_SERIAL_MAX3100_CONSOLE
> + =A0 =A0 =A0 if (i =3D=3D (CONFIG_SERIAL_MAX3100_CONSOLE_N - 1))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 register_console(&max3100_console);
> +#endif
> +
> + =A0 =A0 =A0 if (!(max3100s[i]->console_flags & MAX3100_IS_CONSOLE))=
 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* set shutdown mode to save power. Wil=
l be woken-up on open */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (max3100s[i]->max3100_hw_suspend)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 max3100s[i]->max3100_hw=
_suspend(1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tx =3D MAX3100_WC | MAX=
3100_SHDN;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 max3100_sr(max3100s[i],=
 tx, &rx);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }

Same comment on braces as for above.

> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0mutex_unlock(&max3100s_lock);
> =A0 =A0 =A0 =A0return 0;
> @@ -810,6 +957,9 @@ static int __devexit max3100_remove(struct spi_de=
vice *spi)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0pr_debug("removing max3100 driver\n");
> =A0 =A0 =A0 =A0uart_unregister_driver(&max3100_uart_driver);
> +#ifdef CONFIG_SERIAL_MAX3100_CONSOLE
> + =A0 =A0 =A0 unregister_console(&max3100_console);
> +#endif
>
> =A0 =A0 =A0 =A0mutex_unlock(&max3100s_lock);
> =A0 =A0 =A0 =A0return 0;
> --
> 1.5.6.5
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
