From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/2] serial/efm32-uart: don't use pdev->id to determine
 the port's line
Date: Tue, 30 Jul 2013 07:02:50 -0700
Message-ID: <20130730140250.GG27962@kroah.com>
References: <20130730082146.GP1754@pengutronix.de>
 <1375172593-24345-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20130730083441.GQ1754@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:40470 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755385Ab3G3OBc (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 30 Jul 2013 10:01:32 -0400
Content-Disposition: inline
In-Reply-To: <20130730083441.GQ1754@pengutronix.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: kernel@pengutronix.de, linux-serial@vger.kernel.org

On Tue, Jul 30, 2013 at 10:34:41AM +0200, Uwe Kleine-K=F6nig wrote:
> On Tue, Jul 30, 2013 at 10:23:12AM +0200, Uwe Kleine-K=F6nig wrote:
> > pdev->id is not a valid choice for device-tree probed devices. So u=
se
> > the (properly determined) line from efm32_uart_probe consistenly
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > Forwarded: id:1374043721-30677-1-git-send-email-u.kleine-koenig@pen=
gutronix.de
> I forgot to drop these lines that I use for tracking which patches we=
re
> sent for inclusion into mainline. I don't care much, but you might wa=
nt
> to drop them.

Please resend so I don't have to hand-edit the messages.  I handle
thousands of patches a month, hand-editing is a pain and slows me
down...

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
