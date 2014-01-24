From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v4 2/3] serial: fsl_lpuart: add DMA support
Date: Fri, 24 Jan 2014 11:31:14 +0000
Message-ID: <20140124113114.GE814@e106331-lin.cambridge.arm.com>
References: <1390363773-24108-1-git-send-email-yao.yuan@freescale.com>
 <1390363773-24108-3-git-send-email-yao.yuan@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:43290 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751053AbaAXLbn (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 24 Jan 2014 06:31:43 -0500
Content-Disposition: inline
In-Reply-To: <1390363773-24108-3-git-send-email-yao.yuan@freescale.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Yuan Yao <yao.yuan@freescale.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "arnd@arndb.de" <arnd@arndb.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

On Wed, Jan 22, 2014 at 04:09:32AM +0000, Yuan Yao wrote:
> Add dma support for lpuart. This function depend on DMA driver.
> You can turn on it by write both the dmas and dma-name properties in dts node.
> 
> Signed-off-by: Yuan Yao <yao.yuan@freescale.com>
> ---
>  .../devicetree/bindings/serial/fsl-lpuart.txt      |  19 +-
>  drivers/tty/serial/fsl_lpuart.c                    | 430 ++++++++++++++++++++-
>  2 files changed, 433 insertions(+), 16 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/serial/fsl-lpuart.txt b/Documentation/devicetree/bindings/serial/fsl-lpuart.txt
> index 6fd1dd1..6e1cbbf 100644
> --- a/Documentation/devicetree/bindings/serial/fsl-lpuart.txt
> +++ b/Documentation/devicetree/bindings/serial/fsl-lpuart.txt
> @@ -5,10 +5,21 @@ Required properties:
>  - reg : Address and length of the register set for the device
>  - interrupts : Should contain uart interrupt
> 
> +Optional properties:
> +- dmas: Generic dma devicetree binding as described
> +       in Documentation/devicetree/bindings/dma/dma.txt.
> +- dma-names: Two dmas have to be defined, "rx" and "tx".
> +       An ordered list of channel names affiliated to the above.

Please describe dmas in terms of dma-names (as with the patch describing
clocks and clock-names).

It would be nice to describe the type of the dmas property, but I see
that we have a propblem with inconsistent terminology in the area of
${THING}-specifiers, so I'll try to get that cleaned up separately.

Cheers,
Mark.
