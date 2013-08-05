From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v3 0/3] serial: mxs-auart: add RTS/CTS check for DMA
 support
Date: Mon, 5 Aug 2013 14:24:58 +0800
Message-ID: <20130805062456.GG24629@S2101-09.ap.freescale.net>
References: <1375538956-15862-1-git-send-email-shijie8@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-db9lp0250.outbound.messaging.microsoft.com ([213.199.154.250]:45116
	"EHLO db9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753486Ab3HEGYG (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 5 Aug 2013 02:24:06 -0400
Content-Disposition: inline
In-Reply-To: <1375538956-15862-1-git-send-email-shijie8@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Huang Shijie <shijie8@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, u.kleine-koenig@pengutronix.de

On Sat, Aug 03, 2013 at 10:09:13AM -0400, Huang Shijie wrote:
> Huang Shijie (3):
>   serial: mxs: enable the DMA only when the RTS/CTS is valid
>   serial: mxs: remove the MXS_AUART_DMA_CONFIG
>   ARM: dts: imx28-evk: add the RTS/CTS property for auart0

For the series,

Acked-by: Shawn Guo <shawn.guo@linaro.org>

