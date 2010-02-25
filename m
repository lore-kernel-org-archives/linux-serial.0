From: Feng Tang <feng.tang@intel.com>
Subject: Re: [RFC][PATCH v3] serial: spi: add spi-uart driver for Maxim 3110
Date: Thu, 25 Feb 2010 15:44:11 +0800
Message-ID: <20100225154411.6d1ec4d0@feng-i7>
References: <20091229222006.1ddb28a4@feng-desktop>
	<20100217225817.GD31557@kroah.com>
	<20100224131130.61530b62@feng-i7>
	<201002242043.15231.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:24894 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752996Ab0BYHmv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 25 Feb 2010 02:42:51 -0500
In-Reply-To: <201002242043.15231.david-b@pacbell.net>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Greg KH <greg@kroah.com>, Grant Likely <grant.likely@secretlab.ca>, Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@suse.de>, spi-devel-list <spi-devel-general@lists.sourceforge.net>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "alan@lxorguk.ukuu.org.uk" <alan@lxorguk.ukuu.org.uk>

On Thu, 25 Feb 2010 12:43:14 +0800
David Brownell <david-b@pacbell.net> wrote:

> On Tuesday 23 February 2010, Feng Tang wrote:
> >=20
> > +config SERIAL_MAX3110
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0tristate "SPI UART drive=
r for Max3110"
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0select SERIAL_CORE
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0select SERIAL_CORE_CONSO=
LE
>=20
> Shouldn't that depend on SPI_MASTER?  As it stands, you're
> permitting it to build on systems that you *know* don't have
> a prayer of running this code ... or often, even finishing
> the build.
>=20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0help
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0This is the UART =
protocol driver for MAX3110 device
> > +
> > +config MAX3110_DESIGNWARE
>=20
> Having this depend on a specific underlying SPI master controller
> is not a good thing.  It should instead be written so that it
> runs correctly on *any* controller which exports the standard SPI
> programming interface.
>=20
>=20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0boolean "Enable Max3110 =
to work with Designware controller"
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0default y
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0depends on SERIAL_MAX311=
0
> > +
>=20
> That is, stuff like this, from your max3110 driver:
>=20
> > +
> > +#ifdef CONFIG_MAX3110_DESIGNWARE
> > +static struct dw_spi_chip spi_uart =3D {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.poll_mode =3D 1,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.enable_dma =3D 0,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.type =3D SPI_FRF_SPI,
> > +};
> > +#endif
>=20
> Is completely irrelevant for other hardware ... or else
> (as with DMA, which should be "enabled by default") is
> relevant, but shouldn't be parameterized.
>=20
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0spi->mode =3D SPI_MODE_0=
;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0spi->bits_per_word =3D 1=
6;
> > +#ifdef CONFIG_MAX3110_DESIGNWARE
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0spi->controller_data =3D=
 &spi_uart;
> > +#endif
>=20
> That all looks fishy too.  SPI_MODE should have
> been set up as part of device creation.  Ditto
> any spi->controller_data ... normally, that all
> gets set up as part of board-specific setup.
>=20
> Normally one goes to a lot of effort to keep
> such board-specific code out of drivers.

Good point about the DW controller specific data, I'll remove them.
=46or those "bits_per_word" setting, I think we can put it here instead=
 of
the board initialization code, as many types of boards can leverage the
setting here as it only works in 16b mode.

Thanks,
=46eng

>=20
> - Dave
>=20
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
