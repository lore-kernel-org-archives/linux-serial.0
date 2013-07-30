From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] serial/efm32-uart: don't slur over failure in probe_dt
Date: Tue, 30 Jul 2013 10:21:46 +0200
Message-ID: <20130730082146.GP1754@pengutronix.de>
References: <1374177342-23129-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20130726230629.GA15987@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:39006 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758042Ab3G3IVu (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 30 Jul 2013 04:21:50 -0400
Content-Disposition: inline
In-Reply-To: <20130726230629.GA15987@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: kernel@pengutronix.de, linux-serial@vger.kernel.org

On Fri, Jul 26, 2013 at 04:06:29PM -0700, Greg Kroah-Hartman wrote:
> On Thu, Jul 18, 2013 at 09:55:42PM +0200, Uwe Kleine-K=F6nig wrote:
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > ---
> >  drivers/tty/serial/efm32-uart.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> This doesn't apply either :(
If you take my other patch "serial/efm32-uart: don't use pdev->id to
determine the port's line" first, it should apply well. I'll reply to
this mail with the two patches based on next-20130730.

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
