From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH v3] serial/efm32: add new driver
Date: Tue, 24 Jan 2012 14:05:22 -0800
Message-ID: <20120124220522.GA10590@kroah.com>
References: <1324561092-1945-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1326127447-20284-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:37076 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751702Ab2AXWQS (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 24 Jan 2012 17:16:18 -0500
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id DF42E2139A
	for <linux-serial@vger.kernel.org>; Tue, 24 Jan 2012 17:16:17 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <1326127447-20284-1-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@linux.intel.com>, kernel@pengutronix.de, devicetree-discuss@lists.ozlabs.org, Greg Kroah-Hartman <gregkh@suse.de>, linux-serial@vger.kernel.org

On Mon, Jan 09, 2012 at 05:44:07PM +0100, Uwe Kleine-K=F6nig wrote:
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> ---
> Hello,
>=20
> changes since v2:
> - use {read,write}l_relaxed
> - rename driver to efm32-uart as USARTs and UARTs can be handled both
>   with it
> - disable TX in .stop_tx (which needs some changes related to
>   USARTn_IF_TXC)
>=20
> Best regards
> Uwe
>=20
>  .../devicetree/bindings/tty/serial/efm32-uart.txt  |   14 +
>  arch/arm/boot/dts/efm32gg-dk3750.dts               |    2 +-
>  arch/arm/mach-efm32/devices/pdev-efm32-usart.c     |    6 +-

This file isn't in 3.3-rc1, so I can't apply this patch :(

What tree is it supposed to be against?

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
