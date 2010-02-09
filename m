From: Feng Tang <feng.tang@intel.com>
Subject: Re: [RFC][PATCH v2] serial: spi: add spi-uart driver for Maxim 3110
Date: Tue, 9 Feb 2010 09:36:44 +0800
Message-ID: <20100209093644.2dead2d9@feng-i7>
References: <20091229222006.1ddb28a4@feng-desktop>
	<20100208165946.0e4dde83@feng-i7>
	<20100208162010.b1f69728.akpm@linux-foundation.org>
	<fa686aa41002081626i24caff52n15f140d0fffadedd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:3673 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751763Ab0BIBfS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 8 Feb 2010 20:35:18 -0500
In-Reply-To: <fa686aa41002081626i24caff52n15f140d0fffadedd@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@suse.de>, David Brownell <dbrownell@users.sourceforge.net>, spi-devel-list <spi-devel-general@lists.sourceforge.net>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "alan@lxorguk.ukuu.org.uk" <alan@lxorguk.ukuu.org.uk>, Greg KH <greg@kroah.com>

On Tue, 9 Feb 2010 08:26:35 +0800
Grant Likely <grant.likely@secretlab.ca> wrote:

> On Mon, Feb 8, 2010 at 5:20 PM, Andrew Morton
> <akpm@linux-foundation.org> wrote:
> > On Mon, 8 Feb 2010 16:59:46 +0800
> > Feng Tang <feng.tang@intel.com> wrote:
> >
> >> Hi All,
> >>
> >> Here is a driver for Maxim 3110 SPI-UART device, please help to
> >> review.
> >>
> >> It has been validated with Designware SPI controller (drivers/spi:
> >> dw_spi.c & dw_spi_pci.c). It supports polling and IRQ mode,
> >> supports batch read, and provides a console.
> >>

> > I wonder if this is an "spi" subsystem thing or a "serial" subsyste=
m
> > thing. =C2=A0It looks more like a serial driver to me.
>=20
> I'm assuming serial; and hence I haven't picked it up into my tree.
>=20
> g.

Yes, it's more related to serial stuff, and thus I put them into
drivers/serial

Thanks,
=46eng
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
