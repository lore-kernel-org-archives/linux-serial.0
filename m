From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3 1/3] serial: mxs: enable the DMA only when the RTS/CTS
 is valid
Date: Mon, 5 Aug 2013 15:02:35 +0800
Message-ID: <20130805070235.GA30211@kroah.com>
References: <1375538956-15862-1-git-send-email-shijie8@gmail.com>
 <1375538956-15862-2-git-send-email-shijie8@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:33949 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754742Ab3HEHBR (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 5 Aug 2013 03:01:17 -0400
Content-Disposition: inline
In-Reply-To: <1375538956-15862-2-git-send-email-shijie8@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Huang Shijie <shijie8@gmail.com>
Cc: linux-serial@vger.kernel.org, shawn.guo@linaro.org, linux-arm-kernel@lists.infradead.org, u.kleine-koenig@pengutronix.de, Huang Shijie <b32955@freescale.com>, stable@vger.kernel.org

On Sat, Aug 03, 2013 at 10:09:14AM -0400, Huang Shijie wrote:
> From: Huang Shijie <b32955@freescale.com>
> 
> The original DMA support works only when RTS/CTS is enabled.
> (see the "e800163 serial: mxs-auart: add the DMA support for mx28")
> But after several patches, DMA support has lost this limit.
> (see the "bcc20f9 serial: mxs-auart: move to use generic DMA helper")
> 
> So an UART without the RTS/CTS lines may also enables the DMA support,
> in which case the UART may gets unpredictable results.
> 
> This patch adds an optional property for the UART DT node
> which indicates the UART has RTS and CTS lines, and it also means you
> enable the DMA support for this UART.
> 
> This patch also adds a macro MXS_AUART_RTSCTS, and uses it to check
> RTS/CTS before we enable the DMA for the UART.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Huang Shijie <b32955@freescale.com>
> Signed-off-by: Huang Shijie <shijie8@gmail.com>
> ---
>  .../bindings/tty/serial/fsl-mxs-auart.txt          |    4 ++++
>  drivers/tty/serial/mxs-auart.c                     |    7 ++++++-
>  2 files changed, 10 insertions(+), 1 deletions(-)

I don't see how this patch follows the stable kernel guidelines, so I'll
take the marking of it off, and queue it up for 3.12.

thanks,

greg k-h
