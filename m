From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] serial/mxs-auart: increase time to wait for transmitter
 to become idle
Date: Thu, 4 Jul 2013 18:02:50 +0200
Message-ID: <20130704160250.GC32260@pengutronix.de>
References: <1372413017-23252-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20130704092716.GC17454@pengutronix.de>
 <20130704155836.GA13897@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:46113 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756525Ab3GDQC4 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 4 Jul 2013 12:02:56 -0400
Content-Disposition: inline
In-Reply-To: <20130704155836.GA13897@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, kernel@pengutronix.de, stable@vger.kernel.org

Hi Greg,

On Thu, Jul 04, 2013 at 08:58:36AM -0700, Greg Kroah-Hartman wrote:
> On Thu, Jul 04, 2013 at 11:27:16AM +0200, Uwe Kleine-K=F6nig wrote:
> > On Fri, Jun 28, 2013 at 11:49:41AM +0200, Uwe Kleine-K=F6nig wrote:
> > > Without this patch the driver waits ~1 ms for the UART to become =
idle. At
> > > 115200n8 this time is (theoretically) enough to transfer 11.5 cha=
racters
> > > (=3D 115200 bits/s / (10 Bits/char) * 1ms). As the mxs-auart has =
a fifo size
> > > of 16 characters the clock is gated too early. The problem is wor=
se for
> > > lower baud rates.
> > >=20
> > > This only happens to really shut down the transmitter in the midd=
le of a
> > > transfer if /dev/ttyAPPx isn't opened in userspace (e.g. by a get=
ty) but
> > > was at least once (because the bootloader doesn't disable the tra=
nsmitter).
> > >=20
> > > So increase the timeout to 20 ms which should be enough for 9600n=
8, too.
> > > Moreover skip gating the clock if the timeout is elapsed.
> > >=20
> > > Cc: stable@vger.kernel.org # v2.6.39+
> > > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de=
>
> > Any comments on this. I hoped this patch would make it in for 3.10 =
:-(
>=20
> You sent it after my tree closed for 3.11, 3.10 is a stretch :)
You close your tree for fixes?

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
