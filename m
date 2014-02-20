From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2 01/19] serial: sh-sci: Enable the driver on all ARM
 platforms
Date: Thu, 20 Feb 2014 01:00:43 +0100
Message-ID: <20140220000043.GE6988@pengutronix.de>
References: <1383086274-11049-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1383086274-11049-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <20140219205446.GD6988@pengutronix.de>
 <1609898.QTd44x6TTB@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:57689 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751300AbaBTAAq (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 19 Feb 2014 19:00:46 -0500
Content-Disposition: inline
In-Reply-To: <1609898.QTd44x6TTB@avalon>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, linux-sh@vger.kernel.org

On Wed, Feb 19, 2014 at 11:24:38PM +0100, Laurent Pinchart wrote:
> Hi Uwe,
>=20
> On Wednesday 19 February 2014 21:54:46 Uwe Kleine-K=F6nig wrote:
> > On Tue, Oct 29, 2013 at 11:37:36PM +0100, Laurent Pinchart wrote:
> > > Renesas ARM platforms are transitioning from single-platform to
> > > multi-platform kernels using the new ARCH_SHMOBILE_MULTI. Make th=
e
> > > driver available on all ARM platforms to enable it on both ARCH_S=
HMOBILE
> > > and ARCH_SHMOBILE_MULTI, and increase build testing coverage with
> > > COMPILE_TEST.
> > >=20
> > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Cc: linux-serial@vger.kernel.org
> > > Signed-off-by: Laurent Pinchart
> > > <laurent.pinchart+renesas@ideasonboard.com>
> > > ---
> > >=20
> > >  drivers/tty/serial/Kconfig | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >=20
> > > diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kcon=
fig
> > > index febd45c..9a5a8ef 100644
> > > --- a/drivers/tty/serial/Kconfig
> > > +++ b/drivers/tty/serial/Kconfig
> > > @@ -709,7 +709,7 @@ config SERIAL_IP22_ZILOG_CONSOLE
> > >=20
> > >  config SERIAL_SH_SCI
> > > =20
> > >  	tristate "SuperH SCI(F) serial port support"
> > >=20
> > > -	depends on HAVE_CLK && (SUPERH || ARCH_SHMOBILE)
> > > +	depends on HAVE_CLK && (SUPERH || ARM || COMPILE_TEST)
> > >=20
> > >  	select SERIAL_CORE
> >=20
> > This patch is in mainline as d4f9e7b3d12e92ede642f6f4fc7d959f06da8c=
cc
> > since v3.13-rc1. I wonder if
> >=20
> > 	depends on HAVE_CLK && (SUPERH || ARCH_SHMOBILE || COMPILE_TEST)
> >=20
> > isn't the better option. (Since bf98c1eac1d4a6bcf00532e4fa41d8126cd=
6c187
> > ARCH_SHMOBILE is enabled for both multi-platform and legacy shmobil=
e
> > configs.) Or do you plan to deprecate ARCH_SHMOBILE?
>=20
> We don't plan to deprecate ARCH_SHMOBILE. I've posted a patch to fix =
this,=20
> please see http://www.spinics.net/lists/linux-sh/msg28296.html ("[PAT=
CH 1/2]=20
> serial: sh-sci: Restrict non-COMPILE_TEST compilation").
Ah, this is equivalent. So you can consider my suggestion as an Ack.

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
