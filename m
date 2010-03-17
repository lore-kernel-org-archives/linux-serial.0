From: Feng Tang <feng.tang@intel.com>
Subject: Re: [PATCH v6] serial: spi: add spi-uart driver for Maxim 3110
Date: Wed, 17 Mar 2010 10:35:32 +0800
Message-ID: <20100317103532.6e19db08@feng-i7>
References: <cabda6421003161022x7c6e5a14xd283969e0843c493@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:14412 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752380Ab0CQCeb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 16 Mar 2010 22:34:31 -0400
In-Reply-To: <cabda6421003161022x7c6e5a14xd283969e0843c493@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: christian pellegrin <chripell@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Greg KH <greg@kroah.com>, David Brownell <david-b@pacbell.net>, Grant Likely <grant.likely@secretlab.ca>, Alan Cox <alan@lxorguk.ukuu.org.uk>, spi-devel-list <spi-devel-general@lists.sourceforge.net>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

Hi Christian,

Thanks for taking time to review the driver. Please see my answers inli=
ne

- Feng
On Wed, 17 Mar 2010 01:22:46 +0800
christian pellegrin <chripell@gmail.com> wrote:

> On Thu, Mar 4, 2010 at 8:22 AM,
> <spi-devel-general-request@lists.sourceforge.net> wrote:
>=20
> >
> > Hi All,
> >
>=20
> Hi, first of all let me apologize that I haven't see your previous
> versions of the driver. I completely missed them. I am the author of
> the max3100 driver. As far as I can see the max3110 is just a max3100
> with the TTL to EIA level converter. So, first of all, may I ask why
> you did start a new driver from scratch? I'm quite happy with the
I don't want to reinvent the wheel, as I have many more tasks to handle=
 :)
My 3110 driver started to work in 2008(surely very basic at that time) =
before
your driver is posted on public. And the reasons I still posted driver =
here are:
1. It provides a console
2. It use buffer read/write to meet our performance goal, max3110 doesn=
't have
good FIFO, but spi controller have and we can leverage that for perform=
ance=20

If we can cooperate to make current 3100 driver meet our expectation, I=
'm more
than happy to drop my 3110 one. I'd rather submit some bug fix for it t=
han
posting 6 or more versions of code :)

> current one, the only problem I see is that it uses worqueues which
> are scheduled like normal processes and so under load their latency i=
s
> *big*. I wanted to move to threaded interrupts (otherwise you have to
> use some ugly tricks to give workqueue threads real-time scheduling
> class) but was waiting for my beta testers^H^H^H^H^H^H^H^H^H^H^H^H^H
> customers to move to modern kernel that support them. Anyway the patc=
h
> is trivial and I can provide it if there is some interest. A quick
> glance at your patch shows you are using the same sched_other threads
> so you will face the same problems. I saw you added console capabilit=
y
> which isn't present in current driver, but it's easy to add (I didn't
> implement it initially because I don't see a good idea using the
> max3100 for initial bring-up of an embedded system because it relies
> on the SPI subsystem, worqueues, scheduler and such complicated
> things). Anyway keep in mind that the MAX3100 is rather low-end UART
> so don't push it too much.
It's not me push it too much, but I was pushed too much :)
We can't make the decision how the HW is used on all kinds of platforms=
=2E For
ours, we heavily rely on it as a sole console, and basic requirement is=
:
the datasheet say it supports 230400~300 baud rate, then driver guy nee=
d make
it work as it claims, like copying 500 bytes string somewhere and paste=
 it on
this console in 230400/600 rate.

=46or the kernel early boot phase debug, I actually had another 3110
early_printk patch which can work right after the kernel starts

>=20
> I'm more than happy to work with you to have just one perfect (or
> almost perfect) driver instead of two of them half-done. See some
> comments inline.
Can't agree more, all I want is just a upstream driver which meets the =
basic
requirement.

>=20
> > + * 1. From Max3110 spec, the Rx FIFO has 8 words, while the Tx
> > FIFO only has
> > + * =C2=A0 =C2=A01 word. If SPI master controller doesn't support s=
clk
> > frequency change,
> > + * =C2=A0 =C2=A0then the char need be sent out one by one with som=
e delay
>=20
> I don't think this is a good idea to change speed. Just check the T
> bit to see when the TX buffer is empty and send at the maximum
> available speed. So the usage of the SPI bus is better.
Yes, checking T bit is a good idea for single word transfer model, but =
it
doesn't help when using buffer read/write

>=20
> > + *
> > + * 2. Currently only RX availabe interrrupt is used
>=20
> yeah, this is one of the reasons why MAX31x0 sucks: when you change
> configuration of interrupts the  RX buffer is cleared. So you cannot
> activate/deactivate TX empty interrupt as needed.
>=20
> > +static int use_irq =3D 1;
> > +module_param(use_irq, int, 0444);
> > +MODULE_PARM_DESC(use_irq, "Whether using Max3110's IRQ
> > capability");
>=20
> I don't think it's a good idea using an UART in polling mode, it just
> kills the system. Just pretend this is not possible otherwise some
> hardware guys will pester us to do this just to save an electric wire=
=2E
Yes, like Grant and others have mentioned, I plan to use spi->irq as th=
e
condition, platform code which initialize the board_info should clear t=
he
irq to 0 if they won't use IRQ for 3110

	if (spi->irq)
		request_irq(spi->irq,...);
	else
		start_read_thread;

>=20
>=20
> > + =C2=A0 =C2=A0 =C2=A0 buf =3D kmalloc(8, GFP_KERNEL | GFP_DMA);
>=20
> you do kmalloc and kfree in routines that are called in quite tight
> loops: I guess it's an overkill for performance.

Overkill is just the word I have used when replying comments on my
earlier version :)

I didn't use kmalloc/kfree in my earlier submission, but other develope=
rs
mentioned the buffer allocated here need be DMA safe, as 3110 may work
with many kinds of SPI controller, some of them only supports DMA mode.

>=20
> are you sure it's sane to just ignore these from higher level?
>=20
> > + =C2=A0 =C2=A0 =C2=A0 u8 recv_buf[512], *pbuf;
>=20
> is this sane to allocate 512 byte on the stack?

The function is called only in driver's own main thread and reader thre=
ad
context, 512 should be safe enough. Also the reason I don't use
kzalloc/kfree is the same as you mentioned: performance

>=20
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 wait_event_inter=
ruptible(*wq,
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 max->flags ||
> > kthread_should_stop());
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 test_and_set_bit=
(0, &max->mthread_up);
>=20
> I guess you are using mthread_up to avoid awakening the main thread
> too many times. But this makes sense? Anyway because the awakening an=
d
> the setting of the bit is not atomic it won't work anyway.
Why this can't work? the test/set_bit are atomic operations. This bit
check is not exclusive, it just try to save some waking up, though waki=
ng a
already running thread doesn't cost too much as mentioned by Andrew

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
