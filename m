From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v3 2/2] serial: fsl_lpuart: add DMA support
Date: Wed, 15 Jan 2014 11:05:37 +0000
Message-ID: <20140115110537.GA25824@e106331-lin.cambridge.arm.com>
References: <1389763265-27300-2-git-send-email-yao.yuan@freescale.com>
 <1389763265-27300-3-git-send-email-yao.yuan@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:59155 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750856AbaAOLGU (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 15 Jan 2014 06:06:20 -0500
Content-Disposition: inline
In-Reply-To: <1389763265-27300-3-git-send-email-yao.yuan@freescale.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Yuan Yao <yao.yuan@freescale.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "arnd@arndb.de" <arnd@arndb.de>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

On Wed, Jan 15, 2014 at 05:21:05AM +0000, Yuan Yao wrote:
> Add dma support for lpuart. This function depend on DMA driver.
> You can turn on it by SERIAL_FSL_LPUART_DMA=y. And It works if dts node has dma properties.
> 
> Signed-off-by: Yuan Yao <yao.yuan@freescale.com>
> ---
>  .../devicetree/bindings/serial/fsl-lpuart.txt      |  21 +-
>  drivers/tty/serial/Kconfig                         |   7 +
>  drivers/tty/serial/fsl_lpuart.c                    | 457 ++++++++++++++++++++-
>  3 files changed, 473 insertions(+), 12 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/serial/fsl-lpuart.txt b/Documentation/devicetree/bindings/serial/fsl-lpuart.txt
> index 6fd1dd1..7509080 100644
> --- a/Documentation/devicetree/bindings/serial/fsl-lpuart.txt
> +++ b/Documentation/devicetree/bindings/serial/fsl-lpuart.txt
> @@ -4,11 +4,24 @@ Required properties:
>  - compatible : Should be "fsl,<soc>-lpuart"
>  - reg : Address and length of the register set for the device
>  - interrupts : Should contain uart interrupt
> +- clocks : from common clock binding: handle to uart clock
> +- clock-names : from common clock binding: Shall be "ipg"

Why are these now requried if they weren't previously? That breaks old
dts. I can't see any new code touching clocks. Was this an old but
undocumented requirement?

Could you please reword this so clocks is defined in terms of
clock-names so as to make the relationship between them clear:

- clocks: a list of phandles + clock-specifier pairs, one for each entry
  in clock-names

- clock-names: should contain:
   * "ipg" - the uart clock

> +
> +Optional properties:
> +- dma-names: Should contain "lpuart-tx" for transmit and "lpuart-rx" for receive channels
> +- dmas: Should contain dma specifiers for transmit and receive channels

Likewise could you please define dmas in terms of dma-names please. Why
not just "tx" and "rx" as other bindings use?

[...]

> +#ifdef CONFIG_SERIAL_FSL_LPUART_DMA
> +       struct platform_device *pdev = to_platform_device(port->dev);
> +       struct device_node *np = pdev->dev.of_node;
> +
> +       if (of_get_property(np, "dmas", NULL)) {
> +               sport->lpuart_dma_use = true;
> +               lpuart_dma_tx_request(port);
> +               lpuart_dma_rx_request(port);
> +               temp = readb(port->membase + UARTCR5);
> +               writeb(temp | UARTCR5_TDMAS, port->membase + UARTCR5);

Rather than reading the raw dt to find out if you have dmas, can you not
just attempt to request the dmas and if either fail give up on using
them?

> +       } else
> +               sport->lpuart_dma_use = false;

Nit: if you have brackets on one half of an if-else, they should be on
the other half too (even if i's a single line).

Cheers,
Mark.
