From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFC][PATCH v3] serial: spi: add spi-uart driver for Maxim 3110
Date: Wed, 24 Feb 2010 20:43:14 -0800
Message-ID: <201002242043.15231.david-b@pacbell.net>
References: <20091229222006.1ddb28a4@feng-desktop> <20100217225817.GD31557@kroah.com> <20100224131130.61530b62@feng-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp125.sbc.mail.sp1.yahoo.com ([69.147.65.184]:28229 "HELO
	smtp125.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755455Ab0BYHAR (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 25 Feb 2010 02:00:17 -0500
In-Reply-To: <20100224131130.61530b62@feng-i7>
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Feng Tang <feng.tang@intel.com>
Cc: Greg KH <greg@kroah.com>, Grant Likely <grant.likely@secretlab.ca>, Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@suse.de>, spi-devel-list <spi-devel-general@lists.sourceforge.net>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "alan@lxorguk.ukuu.org.uk" <alan@lxorguk.ukuu.org.uk>

On Tuesday 23 February 2010, Feng Tang wrote:
>=20
> +config SERIAL_MAX3110
> +=A0=A0=A0=A0=A0=A0=A0tristate "SPI UART driver for Max3110"
> +=A0=A0=A0=A0=A0=A0=A0select SERIAL_CORE
> +=A0=A0=A0=A0=A0=A0=A0select SERIAL_CORE_CONSOLE

Shouldn't that depend on SPI_MASTER?  As it stands, you're
permitting it to build on systems that you *know* don't have
a prayer of running this code ... or often, even finishing
the build.


> +=A0=A0=A0=A0=A0=A0=A0help
> +=A0=A0=A0=A0=A0=A0=A0 =A0This is the UART protocol driver for MAX311=
0 device
> +
> +config MAX3110_DESIGNWARE

Having this depend on a specific underlying SPI master controller
is not a good thing.  It should instead be written so that it
runs correctly on *any* controller which exports the standard SPI
programming interface.



> +=A0=A0=A0=A0=A0=A0=A0boolean "Enable Max3110 to work with Designware=
 controller"
> +=A0=A0=A0=A0=A0=A0=A0default y
> +=A0=A0=A0=A0=A0=A0=A0depends on SERIAL_MAX3110
> +

That is, stuff like this, from your max3110 driver:

> +
> +#ifdef CONFIG_MAX3110_DESIGNWARE
> +static struct dw_spi_chip spi_uart =3D {
> +=A0=A0=A0=A0=A0=A0=A0.poll_mode =3D 1,
> +=A0=A0=A0=A0=A0=A0=A0.enable_dma =3D 0,
> +=A0=A0=A0=A0=A0=A0=A0.type =3D SPI_FRF_SPI,
> +};
> +#endif

Is completely irrelevant for other hardware ... or else
(as with DMA, which should be "enabled by default") is
relevant, but shouldn't be parameterized.


> +=A0=A0=A0=A0=A0=A0=A0spi->mode =3D SPI_MODE_0;
> +=A0=A0=A0=A0=A0=A0=A0spi->bits_per_word =3D 16;
> +#ifdef CONFIG_MAX3110_DESIGNWARE
> +=A0=A0=A0=A0=A0=A0=A0spi->controller_data =3D &spi_uart;
> +#endif

That all looks fishy too.  SPI_MODE should have
been set up as part of device creation.  Ditto
any spi->controller_data ... normally, that all
gets set up as part of board-specific setup.

Normally one goes to a lot of effort to keep
such board-specific code out of drivers.

- Dave

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
