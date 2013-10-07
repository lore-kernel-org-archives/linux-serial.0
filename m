From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: base baud reporting strange on efm32
Date: Mon, 7 Oct 2013 09:28:24 +0200
Message-ID: <20131007072824.GJ10079@pengutronix.de>
References: <20131007070306.GA31070@pengutronix.de>
 <20131007072149.GB4755@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:52519 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752344Ab3JGH22 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 7 Oct 2013 03:28:28 -0400
Content-Disposition: inline
In-Reply-To: <20131007072149.GB4755@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Kees Cook <keescook@chromium.org>, linux-serial@vger.kernel.org, kernel@pengutronix.de

On Mon, Oct 07, 2013 at 12:21:49AM -0700, Greg Kroah-Hartman wrote:
> On Mon, Oct 07, 2013 at 09:03:06AM +0200, Uwe Kleine-K=F6nig wrote:
> > Hello Kees, hello Greg,
> >=20
> > since commit=20
> > 	7d12b97 (serial: report base_baud after initialization)
> > my efm32 machine says during startup:
> > 	4000e400.uart: ttyefm4 at MMIO 0x4000e400 (irq =3D 25, base_baud =3D=
 0) is a efm32-uart
> >=20
> > Is this "=3D 0" expected or is there something wrong in the driver?
>=20
> Does the hardware work properly?  That's the best test of this, right=
?
Yes, it works fine. Still I wonder if there is a problem that the drive=
r
doesn't fill in port.uartclk early enough. In the efm32-uart driver (i.=
e.
drivers/tty/serial/efm32-uart.c) this member is only assigned to in
=2Estartup.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
