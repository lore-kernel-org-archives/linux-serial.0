From: Feng Tang <feng.tang@intel.com>
Subject: Re: [PATCH v1 3/4] max3100: adds console support for MAX3100
Date: Tue, 30 Mar 2010 15:19:04 +0800
Message-ID: <20100330151904.30dd2a68@feng-i7>
References: <1269340105-6503-1-git-send-email-chripell@fsfe.org>
	<1269340170-6558-1-git-send-email-chripell@fsfe.org>
	<20100329104838.49c18075@feng-i7>
	<cabda6421003282311x78051e1eq38ada68f2553609e@mail.gmail.com>
	<20100329150642.4a94e78a@feng-i7>
	<cabda6421003290555k70d13168y4beba2c3ae6e2ece@mail.gmail.com>
	<20100330101445.5c64dedb@feng-i7>
	<cabda6421003292349m2dd6125cp2bcc1060f5aa8741@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:39312 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752562Ab0C3HPO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 30 Mar 2010 03:15:14 -0400
In-Reply-To: <cabda6421003292349m2dd6125cp2bcc1060f5aa8741@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: christian pellegrin <chripell@fsfe.org>
Cc: "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "greg@kroah.com" <greg@kroah.com>, "david-b@pacbell.net" <david-b@pacbell.net>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "alan@lxorguk.ukuu.org.uk" <alan@lxorguk.ukuu.org.uk>, "spi-devel-general@lists.sourceforge.net" <spi-devel-general@lists.sourceforge.net>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

On Tue, 30 Mar 2010 14:49:57 +0800
christian pellegrin <chripell@fsfe.org> wrote:

> On Tue, Mar 30, 2010 at 4:14 AM, Feng Tang <feng.tang@intel.com>
> wrote:
> > On Mon, 29 Mar 2010 20:55:51 +0800
> >
> > When the HW works at 230400 bps, when we copy bulk data to the
> > console, max3110 will probably receive about 20K characters, so the
> > time for handling each char is 50us. If you use one char per spi
> > transfer, it will have to execute 20K spi_transfer in one second,
> > and each need be done in 50us, in this 50us you'll have to deal
> > with controller IRQ handler + spi system overhead + tty receiving
> > overhead. Is it a little over-killing to use one char per spi
> > transfer? while the HW does have a 8 words RX FIFO
>=20
> this is too hackish, max3100 wasn't conceived this way. Let me point
> some problems of such an approach:
>=20
> 1) latency on rx chars becomes very high because we can process
> incoming transfers only after a full 8 byte (or whatever the spi
> transfer dimension is). For a 9600 this is too much.
>=20
> 2) even worse is that we can do flow control decision only on such
> boundary.
>=20
> 3) this is not reliable: think of what happens if the actual SPI
> transfer speed we get will be slower that the one we requested. We
> won't be emptying the RX buffer fastly enough even if could.
>=20
> 4) for low speeds we are going to monopolize the SPI bus for ages.

No words in my last email suggested to use dynamic SPI clock speed,
I admited that method is brutal and not mature when my driver was
reviewed. In early version of our 3110 driver, we don't use dynamic
clock speed, but the maxim clock supports by 3110, while we still use=20
8 words buffer read for RX.

Let me cut my question clear: why not use the 8 words RX HW fifo? For
bulk RX in 230400 case, is 50us enough to handle controller IRQ +
spi subsystem overhead + tty receive overhead for one char per spi
transfer model?

>=20
> So I'm rather convinced that the SPI transfer has to happen as soon a=
s
> possible at a SPI device driver level without any guess on how the
> data will be clocked out. I suggest you to improve the dw_spi driver
> for better performance.
Will consider that, thanks

>=20
> > [[ =C2=A0 =C2=A0..000000 =C2=A0iiuu =C2=A0eessoo =C2=A0....44rr11((=
eeggffnn--77
> > =C2=A0ggccvvrriinn444411((bbnnuu44441144bbnnuu)))) [[ =C2=A0 =C2=A0=
=2E.000000
> > =C2=A0BBOO--8800 =C2=A00000000000001100--0000000000008800 =C2=A0uua=
all))
>=20
> huh, here I'm seeing another kind of problem: the same char is
> repeated two times (for example BBOO is written instead of BIOS). I'm
> quite sure (but I will triple check shortly) the the console driver
> doesn't do this (it's quite an easy loop in max3100_console_work, I
> will check wit a printascii to another serial port what is sent). So =
I
> guess the problem can be in the SPI master driver: is it correctly
> handling the CS changes? Isn't it having problems with DMA for exampl=
e
> (I always found DMA for small data transfer (such 2 bytes in this
> case) problematic (for example many platforms just do it on a 4 byte
> boundary))? Have you tested it with other devices?
>=20
Yes, the controller HW has a register to chose slave devices and thus
the HW CS handling is transparent to software. The controller supports =
several
slave devices connecting to it simultaneously, one is a 3G modem whose
throughput is about several Mega bits. The current in-tree controller d=
river
lacks DMA part, which is rejected as the related DMA controller driver =
never
show up publicly.


--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
