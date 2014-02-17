From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v6 2/3] serial: fsl_lpuart: add DMA support
Date: Mon, 17 Feb 2014 10:37:06 +0000
Message-ID: <20140217103706.GA18920@e106331-lin.cambridge.arm.com>
References: <1392614888-10261-1-git-send-email-yao.yuan@freescale.com>
 <1392614888-10261-3-git-send-email-yao.yuan@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:59998 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751254AbaBQKhr (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 17 Feb 2014 05:37:47 -0500
Content-Disposition: inline
In-Reply-To: <1392614888-10261-3-git-send-email-yao.yuan@freescale.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Yuan Yao <yao.yuan@freescale.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>, "arnd@arndb.de" <arnd@arndb.de>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

On Mon, Feb 17, 2014 at 05:28:07AM +0000, Yuan Yao wrote:
> Add dma support for lpuart. This function depend on DMA driver.
> You can turn on it by write both the dmas and dma-name properties in dts node.
> 
> Signed-off-by: Yuan Yao <yao.yuan@freescale.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  .../devicetree/bindings/serial/fsl-lpuart.txt      |  19 +-
>  drivers/tty/serial/fsl_lpuart.c                    | 430 ++++++++++++++++++++-
>  2 files changed, 433 insertions(+), 16 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/serial/fsl-lpuart.txt b/Documentation/devicetree/bindings/serial/fsl-lpuart.txt
> index 6fd1dd1..6e1cbbf 100644
> --- a/Documentation/devicetree/bindings/serial/fsl-lpuart.txt
> +++ b/Documentation/devicetree/bindings/serial/fsl-lpuart.txt
> @@ -5,10 +5,19 @@ Reqiuired properties:
>  - reg : Address and length of the register set for the device
>  - interrupts : Should contain uart interrupt
> 
> +Optional properties:
> +- dmas: A list of two dma specifiers, one for each entry in dma-names.
> +- dma-names: should contain "tx" and "rx".
> +
> +Note: Optional properties for DMA support. Write them both or both not.
> +
>  Example:
> 
>  uart0: serial@40027000 {
> -              compatible = "fsl,vf610-lpuart";
> -              reg = <0x40027000 0x1000>;
> -              interrupts = <0 61 0x00>;
> -       };
> +               compatible = "fsl,vf610-lpuart";
> +               reg = <0x40027000 0x1000>;
> +               interrupts = <0 61 0x00>;
> +               dmas = <&edma0 0 2>,
> +                       <&edma0 0 3>;
> +               dma-names = "rx","tx";
> +       };

For the binding:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.
