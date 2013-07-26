From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/2] serial/efm32-uart: don't use pdev->id to determine
 the port's line
Date: Fri, 26 Jul 2013 16:05:12 -0700
Message-ID: <20130726230512.GA12940@kroah.com>
References: <1374043721-30677-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:52433 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758135Ab3GZXFN (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 26 Jul 2013 19:05:13 -0400
Content-Disposition: inline
In-Reply-To: <1374043721-30677-1-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-serial@vger.kernel.org

On Wed, Jul 17, 2013 at 08:48:40AM +0200, Uwe Kleine-K=F6nig wrote:
> pdev->id is not a valid choice for device-tree probed devices. So use
> the (properly determined) line from efm32_uart_probe consistenly.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/tty/serial/efm32-uart.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)

This patch doesn't apply, care to redo it?

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
