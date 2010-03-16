From: christian pellegrin <chripell-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v6] serial: spi: add spi-uart driver for
	Maxim 3110
Date: Tue, 16 Mar 2010 18:22:46 +0100
Message-ID: <cabda6421003161022x7c6e5a14xd283969e0843c493@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spi-devel-list <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

On Thu, Mar 4, 2010 at 8:22 AM,
<spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org> wrote:

>
> Hi All,
>

Hi, first of all let me apologize that I haven't see your previous
versions of the driver. I completely missed them. I am the author of
the max3100 driver. As far as I can see the max3110 is just a max3100
with the TTL to EIA level converter. So, first of all, may I ask why
you did start a new driver from scratch? I'm quite happy with the
current one, the only problem I see is that it uses worqueues which
are scheduled like normal processes and so under load their latency is
*big*. I wanted to move to threaded interrupts (otherwise you have to
use some ugly tricks to give workqueue threads real-time scheduling
class) but was waiting for my beta testers^H^H^H^H^H^H^H^H^H^H^H^H^H
customers to move to modern kernel that support them. Anyway the patch
is trivial and I can provide it if there is some interest. A quick
glance at your patch shows you are using the same sched_other threads
so you will face the same problems. I saw you added console capability
which isn't present in current driver, but it's easy to add (I didn't
implement it initially because I don't see a good idea using the
max3100 for initial bring-up of an embedded system because it relies
on the SPI subsystem, worqueues, scheduler and such complicated
things). Anyway keep in mind that the MAX3100 is rather low-end UART
so don't push it too much.

I'm more than happy to work with you to have just one perfect (or
almost perfect) driver instead of two of them half-done. See some
comments inline.

> + * 1. From Max3110 spec, the Rx FIFO has 8 words, while the Tx FIFO only=
 has
> + * =A0 =A01 word. If SPI master controller doesn't support sclk frequenc=
y change,
> + * =A0 =A0then the char need be sent out one by one with some delay

I don't think this is a good idea to change speed. Just check the T
bit to see when the TX buffer is empty and send at the maximum
available speed. So the usage of the SPI bus is better.

> + *
> + * 2. Currently only RX availabe interrrupt is used

yeah, this is one of the reasons why MAX31x0 sucks: when you change
configuration of interrupts the  RX buffer is cleared. So you cannot
activate/deactivate TX empty interrupt as needed.

> +static int use_irq =3D 1;
> +module_param(use_irq, int, 0444);
> +MODULE_PARM_DESC(use_irq, "Whether using Max3110's IRQ capability");

I don't think it's a good idea using an UART in polling mode, it just
kills the system. Just pretend this is not possible otherwise some
hardware guys will pester us to do this just to save an electric wire.

> + =A0 =A0 =A0 memset(&x, 0, sizeof x);
> + =A0 =A0 =A0 x.len =3D len;
> + =A0 =A0 =A0 x.tx_buf =3D txbuf;
> + =A0 =A0 =A0 x.rx_buf =3D rxbuf;

why don't initialize this like:

        struct spi_transfer x =3D {
                .tx_buf =3D txbuf,
                .rx_buf =3D rxbuf,
                .len =3D len,
        };


> + =A0 =A0 =A0 buf =3D kmalloc(8, GFP_KERNEL | GFP_DMA);

you do kmalloc and kfree in routines that are called in quite tight
loops: I guess it's an overkill for performance.

> +static unsigned int serial_m3110_tx_empty(struct uart_port *port)
> +{
> + =A0 =A0 =A0 return 1;
> +}
> +
> +static void serial_m3110_stop_tx(struct uart_port *port)
> +{
> + =A0 =A0 =A0 return;
> +}
> +
> +static void serial_m3110_stop_rx(struct uart_port *port)
> +{
> + =A0 =A0 =A0 return;
> +}

are you sure it's sane to just ignore these from higher level?

> + =A0 =A0 =A0 u8 recv_buf[512], *pbuf;

is this sane to allocate 512 byte on the stack?

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 wait_event_interruptible(*wq,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 max->flags =
|| kthread_should_stop());
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 test_and_set_bit(0, &max->mthread_up);

I guess you are using mthread_up to avoid awakening the main thread
too many times. But this makes sense? Anyway because the awakening and
the setting of the bit is not atomic it won't work anyway.

> +/* Don't handle hw handshaking */
> +static unsigned int serial_m3110_get_mctrl(struct uart_port *port)
> +{
> + =A0 =A0 =A0 return TIOCM_DSR | TIOCM_CAR | TIOCM_DSR;
> +}
> +
> +static void serial_m3110_set_mctrl(struct uart_port *port, unsigned int =
mctrl)
> +{
> +}
> +

this is quite bad because the MAX3100 is rather slow.

Bye!

-- =

Christian Pellegrin, see http://www.evolware.org/chri/
"Real Programmers don't play tennis, or any other sport which requires
you to change clothes. Mountain climbing is OK, and Real Programmers
wear their climbing boots to work in case a mountain should suddenly
spring up in the middle of the computer room."

---------------------------------------------------------------------------=
---
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
