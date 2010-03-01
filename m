From: Feng Tang <feng.tang@intel.com>
Subject: Re: [PATCH v4] serial: spi: add spi-uart driver for Maxim 3110
Date: Mon, 1 Mar 2010 10:30:07 +0800
Message-ID: <20100301103007.60926192@feng-i7>
References: <20100224131130.61530b62@feng-i7>
	<20100226114729.679bb933@feng-i7>
	<201002260959.o1Q9xIVA021953@imail.sm.sony.co.jp>
	<201002261141.43002.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:12681 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752478Ab0CAC1r convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 28 Feb 2010 21:27:47 -0500
In-Reply-To: <201002261141.43002.david-b@pacbell.net>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Masakazu Mokuno <mokuno@sm.sony.co.jp>, Greg KH <greg@kroah.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, spi-devel-list <spi-devel-general@lists.sourceforge.net>, Andrew Morton <akpm@linux-foundation.org>, "alan@lxorguk.ukuu.org.uk" <alan@lxorguk.ukuu.org.uk>

On Sat, 27 Feb 2010 03:41:42 +0800
David Brownell <david-b@pacbell.net> wrote:

> On Friday 26 February 2010, Masakazu Mokuno wrote:
> > > +static int max3110_read_multi(struct uart_max3110 *max, u8 *buf)
> > > +{
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u16 obuf[M3110_RX_FIFO_DEPTH], ibu=
f[M3110_RX_FIFO_DEPTH];
> >=20
> > Doing I/O on stack is guaranteed safe for spi functions?
>=20
> Good catch ...  no it's not safe.
>=20
> No DMA-enabled programming interface allows it, including SPI.
Hi David,

I agree that DMA working mode must not use stack as IO buffer, and spi =
core
code(spi.c/spi.h) has clearly message stating that. But this driver doe=
sn't
intend to use DMA by design. In early version of this patch there is so=
me
controller specific data which show "enable_dma =3D 0".

The reason of not using DMA for Maxim 3110 is, it is a low speed SPI UA=
RT
device, which only has one word (16b) TX buffer and 8 words RX buffer, =
using
DMA may benefit in some use case but will be over-kill for others. This
driver implement a console,  take one example of editing a file on the =
console,
each char we input will be echoed back on screen, which will use a spi_=
message
and a spi_transfer, if using DMA, that DMA operation length will be 2 b=
ytes,
if the file been edited has 4K characters, there will be 4K DMA transac=
tions,
which will occupy quiet some system load.=20

Also whether a 16b word could be DMAed is still a question for some typ=
es of
DMA controllers, I know some platform whose DMA controllers can only  o=
r
configured to only work with data at least 32 bits aligned.=20

So in this driver, it leverages some options provided by SPI controller=
 drivers
(pxa2xx and Designware) to chose not using DMA.=20

Thanks,
=46eng

>=20
> The Documentation/PCI/PCI-DMA-mapping.txt file has a section with
> the oddly punctuated title "What memory is DMA'able?".  That's
> generic to all uses of DMA.  When it was moved to the PCI area,
> that information became harder to find ... but no less true for
> non-PCI contexts (sigh).  One relevant paragraph being:
>=20
>   This rule also means that you may use neither kernel image addresse=
s
>   (items in data/text/bss segments), nor module image addresses, nor
>   stack addresses for DMA.  These could all be mapped somewhere
> entirely different than the rest of physical memory.  Even if those
> classes of memory could physically work with DMA, you'd need to
> ensure the I/O buffers were cacheline-aligned.  Without that, you'd
> see cacheline sharing problems (data corruption) on CPUs with
> DMA-incoherent caches. (The CPU could write to one word, DMA would
> write to a different one in the same cache line, and one of them
> could be overwritten.)
>=20
> Those cacheline sharing problems are particularly bad for the stack,
> since the data corruption often includes return addresses.
>=20
> In short, passing a stack-based I/O buffer could work on some
> machines, but cause perplexing data corruption issues on others.  So
> don't try to do it any driver that claims to be portable.
>=20
> - Dave
>=20
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
