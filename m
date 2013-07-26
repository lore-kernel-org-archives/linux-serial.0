From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] serial/efm32-uart: don't slur over failure in probe_dt
Date: Fri, 26 Jul 2013 16:06:29 -0700
Message-ID: <20130726230629.GA15987@kroah.com>
References: <1374177342-23129-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:52449 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758135Ab3GZXGb (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 26 Jul 2013 19:06:31 -0400
Content-Disposition: inline
In-Reply-To: <1374177342-23129-1-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: kernel@pengutronix.de, linux-serial@vger.kernel.org

On Thu, Jul 18, 2013 at 09:55:42PM +0200, Uwe Kleine-K=F6nig wrote:
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/tty/serial/efm32-uart.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

This doesn't apply either :(

--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
