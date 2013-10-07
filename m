From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: base baud reporting strange on efm32
Date: Mon, 7 Oct 2013 09:03:06 +0200
Message-ID: <20131007070306.GA31070@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:51401 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751745Ab3JGHDK (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 7 Oct 2013 03:03:10 -0400
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Kees Cook <keescook@chromium.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, kernel@pengutronix.de

Hello Kees, hello Greg,

since commit=20
	7d12b97 (serial: report base_baud after initialization)
my efm32 machine says during startup:
	4000e400.uart: ttyefm4 at MMIO 0x4000e400 (irq =3D 25, base_baud =3D 0=
) is a efm32-uart

Is this "=3D 0" expected or is there something wrong in the driver?

(Sorry for not replying to the patch, but I didn't find it neither on
lkml nor on linux-serial.)

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
