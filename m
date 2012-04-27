From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/2] serial/imx: add DMA support
Date: Fri, 27 Apr 2012 17:24:44 +0000
Message-ID: <201204271724.45435.arnd@arndb.de>
References: <1335436632-29499-1-git-send-email-b32955@freescale.com> <1335436632-29499-2-git-send-email-b32955@freescale.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:57125 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759736Ab2D0UPE (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 27 Apr 2012 16:15:04 -0400
In-Reply-To: <1335436632-29499-2-git-send-email-b32955@freescale.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Huang Shijie <b32955@freescale.com>, alan@linux.intel.com, B20596@freescale.com, B20223@freescale.com, gregkh@linuxfoundation.org, r58066@freescale.com, linux-serial@vger.kernel.org, shawn.guo@linaro.org, s.hauer@pengutronix.de

On Thursday 26 April 2012, Huang Shijie wrote:
> diff --git a/Documentation/devicetree/bindings/tty/serial/fsl-imx-uart.txt b/Documentation/devicetree/bindings/tty/serial/fsl-imx-uart.txt
> index a9c0406..f27489d 100644
> --- a/Documentation/devicetree/bindings/tty/serial/fsl-imx-uart.txt
> +++ b/Documentation/devicetree/bindings/tty/serial/fsl-imx-uart.txt
> @@ -8,6 +8,10 @@ Required properties:
>  Optional properties:
>  - fsl,uart-has-rtscts : Indicate the uart has rts and cts
>  - fsl,irda-mode : Indicate the uart supports irda mode
> +- fsl,enable-dma : Indicate the uart supports DMA
> +- fsl,uart-dma-events : contains the DMA events for RX and TX,
> +                 The first is the RX event, while the other is TX.
> +- fsl,enable-dte: Indicate the uart works in DTE mode
>  

I think we should not add any ad-hoc DMA bindings for device drivers
until we have a proper generic binding for DMA.

	Arnd

