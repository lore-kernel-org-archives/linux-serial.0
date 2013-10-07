From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: base baud reporting strange on efm32
Date: Mon, 7 Oct 2013 00:21:49 -0700
Message-ID: <20131007072149.GB4755@kroah.com>
References: <20131007070306.GA31070@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:55106 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751689Ab3JGHVg (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 7 Oct 2013 03:21:36 -0400
Content-Disposition: inline
In-Reply-To: <20131007070306.GA31070@pengutronix.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Kees Cook <keescook@chromium.org>, linux-serial@vger.kernel.org, kernel@pengutronix.de

On Mon, Oct 07, 2013 at 09:03:06AM +0200, Uwe Kleine-K=F6nig wrote:
> Hello Kees, hello Greg,
>=20
> since commit=20
> 	7d12b97 (serial: report base_baud after initialization)
> my efm32 machine says during startup:
> 	4000e400.uart: ttyefm4 at MMIO 0x4000e400 (irq =3D 25, base_baud =3D=
 0) is a efm32-uart
>=20
> Is this "=3D 0" expected or is there something wrong in the driver?

Does the hardware work properly?  That's the best test of this, right?

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
