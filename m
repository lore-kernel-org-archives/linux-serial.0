From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 1/2] serial/efm32-uart: don't use pdev->id to determine
 the port's line
Date: Tue, 30 Jul 2013 10:34:41 +0200
Message-ID: <20130730083441.GQ1754@pengutronix.de>
References: <20130730082146.GP1754@pengutronix.de>
 <1375172593-24345-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:49471 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754760Ab3G3Iep (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 30 Jul 2013 04:34:45 -0400
Content-Disposition: inline
In-Reply-To: <1375172593-24345-1-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: kernel@pengutronix.de, linux-serial@vger.kernel.org

On Tue, Jul 30, 2013 at 10:23:12AM +0200, Uwe Kleine-K=F6nig wrote:
> pdev->id is not a valid choice for device-tree probed devices. So use
> the (properly determined) line from efm32_uart_probe consistenly
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> Forwarded: id:1374043721-30677-1-git-send-email-u.kleine-koenig@pengu=
tronix.de
I forgot to drop these lines that I use for tracking which patches were
sent for inclusion into mainline. I don't care much, but you might want
to drop them.

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
