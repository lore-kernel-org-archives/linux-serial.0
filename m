From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 2/3] serial: mxs: enable the DMA only when the RTS/CTS
 is valid
Date: Fri, 26 Jul 2013 16:10:08 -0700
Message-ID: <20130726231008.GA32627@kroah.com>
References: <1373957732-16638-1-git-send-email-b32955@freescale.com>
 <1373957732-16638-3-git-send-email-b32955@freescale.com>
 <20130716095449.GS12139@pengutronix.de>
 <51E648C2.3010304@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:52550 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759938Ab3GZXKJ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 26 Jul 2013 19:10:09 -0400
Content-Disposition: inline
In-Reply-To: <51E648C2.3010304@freescale.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Huang Shijie <b32955@freescale.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, shawn.guo@linaro.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org

On Wed, Jul 17, 2013 at 03:33:22PM +0800, Huang Shijie wrote:
> =E4=BA=8E 2013=E5=B9=B407=E6=9C=8816=E6=97=A5 17:54, Uwe Kleine-K=C3=B6=
nig =E5=86=99=E9=81=93:
> >On Tue, Jul 16, 2013 at 02:55:31PM +0800, Huang Shijie wrote:
> >>The original DMA support works only when RTS/CTS is enabled.
> >What is original here?
> >
> i will add more information for this in the next version.
> >>But after several patches, DMA support has lost this limit.
> >This is still misleading.
> >
> >>This patch adds an optional property for the UART DT node
> >>which indicates the UART has RTS and CTS lines.
> >>
> >>This patch also adds a macro MXS_AUART_RTSCTS, and uses it to check
> >>RTS/CTS before we enable the DMA for the UART.
> >I still think this should go to stable. The options are:
> >
> >	a) also take patch 1 into stable
> >	b) apply this patch without patch 1
> >
> >I don't know if option a) is OK, b) is probably preferable. And as G=
reg
> to Greg:
>=20
> I think a) is ok to me. what's your opinion?

Please reorder them, making patch 2 first, and mark it for stable, then
do patch 1, and the rest, so I don't have to take non-needed patches
into the stable tree.

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
