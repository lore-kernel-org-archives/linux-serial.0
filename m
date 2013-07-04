From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] serial/mxs-auart: increase time to wait for transmitter
 to become idle
Date: Thu, 4 Jul 2013 08:58:36 -0700
Message-ID: <20130704155836.GA13897@kroah.com>
References: <1372413017-23252-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20130704092716.GC17454@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:47762 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752838Ab3GDP5p (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 4 Jul 2013 11:57:45 -0400
Content-Disposition: inline
In-Reply-To: <20130704092716.GC17454@pengutronix.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, kernel@pengutronix.de, stable@vger.kernel.org

On Thu, Jul 04, 2013 at 11:27:16AM +0200, Uwe Kleine-K=F6nig wrote:
> Hi Greg,
>=20
> On Fri, Jun 28, 2013 at 11:49:41AM +0200, Uwe Kleine-K=F6nig wrote:
> > Without this patch the driver waits ~1 ms for the UART to become id=
le. At
> > 115200n8 this time is (theoretically) enough to transfer 11.5 chara=
cters
> > (=3D 115200 bits/s / (10 Bits/char) * 1ms). As the mxs-auart has a =
fifo size
> > of 16 characters the clock is gated too early. The problem is worse=
 for
> > lower baud rates.
> >=20
> > This only happens to really shut down the transmitter in the middle=
 of a
> > transfer if /dev/ttyAPPx isn't opened in userspace (e.g. by a getty=
) but
> > was at least once (because the bootloader doesn't disable the trans=
mitter).
> >=20
> > So increase the timeout to 20 ms which should be enough for 9600n8,=
 too.
> > Moreover skip gating the clock if the timeout is elapsed.
> >=20
> > Cc: stable@vger.kernel.org # v2.6.39+
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> Any comments on this. I hoped this patch would make it in for 3.10 :-=
(

You sent it after my tree closed for 3.11, 3.10 is a stretch :)

I'll look at it after the 3.11-rc1 merge window is closed, give me a
chance, I'm a bit busy for the next week or so with the fallout of
that...

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
