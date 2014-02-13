From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [RFC PATCH] serial: omap: only inform once about missing wakeirq
 support
Date: Thu, 13 Feb 2014 10:57:25 +0100
Message-ID: <20140213095725.GB17650@pengutronix.de>
References: <1392283510-16774-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20140213094711.GG31787@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:58637 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751464AbaBMJ5m (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 13 Feb 2014 04:57:42 -0500
Content-Disposition: inline
In-Reply-To: <20140213094711.GG31787@pengutronix.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Markus Pargmann <mpa@pengutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tony Lindgren <tony@atomide.com>, linux-serial@vger.kernel.org, kernel@pengutronix.de, Roger Quadros <rogerq@ti.com>, Felipe Balbi <balbi@ti.com>, Linus Walleij <linus.walleij@linaro.org>, Kevin Hilman <khilman@linaro.org>

Hi Markus,

On Thu, Feb 13, 2014 at 10:47:11AM +0100, Markus Pargmann wrote:
> On Thu, Feb 13, 2014 at 10:25:10AM +0100, Uwe Kleine-K=F6nig wrote:
> > The unconditional output in serial_omap_startup clutters dmesg quit=
e a
> > bit when booting with systemd because the console device is opened
> > repeatedly.
> >=20
> > Without this patch, directly after boot + login I get:
> >=20
> > 	# dmesg | grep -c 'omap_uart 48024000.serial: no wakeirq for uart2=
'
> > 	79
> >=20
> > This was introduced in commit 2a0b965cfb6e (serial: omap: Add suppo=
rt
> > for optional wake-up) which was applied for v3.13-rc1.
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
>=20
> I sent a similar patch, that moves the info message to the probe
> function [1].
That looks better. I just acked your patch and so please disregard mine=
=2E

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
