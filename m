From: Erwin Authried <eauth@softsys.co.at>
Subject: Re: [spi-devel-general] [RFC][PATCH] serial: spi: add spi-uart
	driver for Maxim 3110
Date: Tue, 29 Dec 2009 19:43:48 +0100
Message-ID: <1262112228.28396.93.camel@justakiss.home.at>
References: <20091229222006.1ddb28a4@feng-desktop>
	 <20091229145953.GC27213@jasper.tkos.co.il>
	 <73BDC2BA3DA0BD47BAAEE12383D407EF303E943D@shzsmsx502.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from corofin.softsys.co.at ([213.239.217.182]:48480 "EHLO
	hetzner.home.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752129AbZL2Sud (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 29 Dec 2009 13:50:33 -0500
In-Reply-To: <73BDC2BA3DA0BD47BAAEE12383D407EF303E943D@shzsmsx502.ccr.corp.intel.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: "Tang, Feng" <feng.tang@intel.com>
Cc: Baruch Siach <baruch@tkos.co.il>, David Brownell <dbrownell@users.sourceforge.net>, Greg Kroah-Hartman <gregkh@suse.de>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, spi-devel-list <spi-devel-general@lists.sourceforge.net>, Andrew Morton <akpm@linux-foundation.org>, "alan@lxorguk.ukuu.org.uk" <alan@lxorguk.ukuu.org.uk>

Am Mittwoch, den 30.12.2009, 00:05 +0800 schrieb Tang, Feng:
> >-----Original Message-----
> >From: Baruch Siach [mailto:baruch@tkos.co.il]
> >Sent: 2009=E5=B9=B412=E6=9C=8829=E6=97=A5 23:00
> >To: Tang, Feng
> >Cc: Greg Kroah-Hartman; David Brownell; Grant Likely; spi-devel-list=
;
> >linux-serial@vger.kernel.org; alan@lxorguk.ukuu.org.uk; Andrew Morto=
n
> >Subject: Re: [spi-devel-general] [RFC][PATCH] serial: spi: add spi-u=
art driver for
> >Maxim 3110
> >
> >Hi Feng,
> >
> >On Tue, Dec 29, 2009 at 10:20:06PM +0800, Feng Tang wrote:
> >> Here is a driver for Maxim 3110 SPI-UART device, please help to re=
view.
> >
> >Is this 3110 device so significantly different from the MAX3100 driv=
er that's
> >already in the mainline kernel (drivers/serial/max3100.c), to requir=
e a whole
> >new driver?
>=20
> Yes, I know this question will be asked :) I developed the max3110 be=
fore max3100
> was posted in public, so the 2 designs differs a lot from the start. =
I think this driver
> has 2 good points:
> 1. It provides a console, which is the main reason that our platform =
use max3110
> 2. It utilizes the RX buffer of max3110 that it can reads up to 8 cha=
racters in one
> spi_transfer, and its Tx function can transmit up to 128 chars in one=
 spi_transfer
> which will save much system load comparing to 1 char per spi transfer
>=20
> Current max3100.c also has its advantage, like good support in CTS/RT=
S control,
> and I think these 2 can merge in the future.
>=20
> Thanks,
> Feng=20
> >
> >> It has been validated with Designware SPI controller (drivers/spi:=
 dw_spi.c
> >> & dw_spi_pci.c). It supports polling and IRQ mode, supports batch =
read, and
> >> provides a console.
> >
> >baruch
> >
> >--

Hi,

looking at your driver, there are several points that make me doubt tha=
t
it is working at all:

* The MAX3110 requires CS going low at the start of each 16-bit
transfer, if you look at the datasheet.=20

* in max3110_read_multi, it looks to me that this will work for
big-endian architectures only.

* I can't see how send_circ_buf() should work at all. You are just
sending a burst of characters to the MAX3110 without checking the
transmit buffer status at all. The MAX3110 has a single TX buffer only,
so that will cause transmit characters to be lost.

I think there's no need for a MAX3100 **and** a MAX3110 driver, this is
just confusing. The MAX3110 driver is identical to the MAX3100 from the
software view, it is simply a MAX3100 with transceivers added to the
chip. If there's any improvement, that should be merged into the
existing MAX3100 driver.

-Erwin


--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
