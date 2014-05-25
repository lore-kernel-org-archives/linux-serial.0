From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] serial: efm32: add module_exit
Date: Sun, 25 May 2014 23:57:56 +0200
Message-ID: <20140525215756.GA18901@pengutronix.de>
References: <1401052385-3786-1-git-send-email-vincent.stehle@laposte.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:52461 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750811AbaEYV56 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 25 May 2014 17:57:58 -0400
Content-Disposition: inline
In-Reply-To: <1401052385-3786-1-git-send-email-vincent.stehle@laposte.net>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Vincent =?iso-8859-1?Q?Stehl=E9?= <vincent.stehle@laposte.net>
Cc: linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, Jiri Slaby <jslaby@suse.cz>

On Sun, May 25, 2014 at 11:13:05PM +0200, Vincent Stehl=C3=A9 wrote:
> Add missing specification of efm32_uart_exit as module_exit.
>=20
> This fixes the following compilation warning:
>=20
>   drivers/tty/serial/efm32-uart.c:840:123: warning: =E2=80=98efm32_ua=
rt_exit=E2=80=99 defined but not used [-Wunused-function]
This warning doesn't occur in my builds, probably because I have
MODULES=3Dn. I can reproduce it on allmodconfig though.
=20
> Signed-off-by: Vincent Stehl=C3=A9 <vincent.stehle@laposte.net>
> Cc: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
Acked-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig     =
       |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
