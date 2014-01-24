From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v4 3/3] serial: fsl_lpuart: documented the clock
 requirement.
Date: Fri, 24 Jan 2014 11:26:27 +0000
Message-ID: <20140124112626.GD814@e106331-lin.cambridge.arm.com>
References: <1390363773-24108-1-git-send-email-yao.yuan@freescale.com>
 <1390363773-24108-4-git-send-email-yao.yuan@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:43080 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752018AbaAXL1E (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 24 Jan 2014 06:27:04 -0500
Content-Disposition: inline
In-Reply-To: <1390363773-24108-4-git-send-email-yao.yuan@freescale.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Yuan Yao <yao.yuan@freescale.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "arnd@arndb.de" <arnd@arndb.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

On Wed, Jan 22, 2014 at 04:09:33AM +0000, Yuan Yao wrote:
> It was previously required but not documented.
> Add the text to the binding along with the new "dmas" addition.
> 
> Signed-off-by: Yuan Yao <yao.yuan@freescale.com>
> ---
>  Documentation/devicetree/bindings/serial/fsl-lpuart.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/serial/fsl-lpuart.txt b/Documentation/devicetree/bindings/serial/fsl-lpuart.txt
> index 6e1cbbf..9666f97 100644
> --- a/Documentation/devicetree/bindings/serial/fsl-lpuart.txt
> +++ b/Documentation/devicetree/bindings/serial/fsl-lpuart.txt
> @@ -4,6 +4,8 @@ Required properties:
>  - compatible : Should be "fsl,<soc>-lpuart"
>  - reg : Address and length of the register set for the device
>  - interrupts : Should contain uart interrupt
> +- clocks : phandle + clock specifier pairs, one for each entry in clock-names
> +- clock-names : should contain: "ipg" - the uart clock
>  
>  Optional properties:
>  - dmas: Generic dma devicetree binding as described
> @@ -19,6 +21,8 @@ uart0: serial@40027000 {
>  		compatible = "fsl,vf610-lpuart";
>  		reg = <0x40027000 0x1000>;
>  		interrupts = <0 61 0x00>;
> +		clocks = <&clks VF610_CLK_UART0>;
> +		clock-names = "ipg";
>  		dmas = <&edma0 0 2>,
>  			<&edma0 0 3>;
>  		dma-names = "rx","tx";

As this was a previous requirement, and this is a correction to the
documentation rather than a binding change:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.
