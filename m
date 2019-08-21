From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 4/6] dt-bindings: serial: Document Freescale LINFlex
 UART
Date: Wed, 21 Aug 2019 16:18:41 -0500
Message-ID: <20190821211841.GA16627@bogus>
References: <20190809112853.15846-1-stefan-gabriel.mirea@nxp.com>
 <20190809112853.15846-5-stefan-gabriel.mirea@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190809112853.15846-5-stefan-gabriel.mirea@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Stefan-gabriel Mirea <stefan-gabriel.mirea@nxp.com>
Cc: "corbet@lwn.net" <corbet@lwn.net>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will@kernel.org" <will@kernel.org>, "shawnguo@kernel.org" <shawnguo@kernel.org>, Leo Li <leoyang.li@nxp.com>, "jslaby@suse.com" <jslaby@suse.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Cosmin Stefan Stoica <cosmin.stoica@nxp.com>, Larisa Ileana Grigore <larisa.grigore@nxp.com>
List-Id: linux-serial@vger.kernel.org

On Fri, Aug 09, 2019 at 11:29:14AM +0000, Stefan-gabriel Mirea wrote:
> From: Stoica Cosmin-Stefan <cosmin.stoica@nxp.com>
> 
> Add documentation for the serial communication interface module (LINFlex),
> found in two instances on S32V234.
> 
> Signed-off-by: Stoica Cosmin-Stefan <cosmin.stoica@nxp.com>
> Signed-off-by: Larisa Grigore <Larisa.Grigore@nxp.com>
> Signed-off-by: Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>
> ---
>  .../bindings/serial/fsl,s32-linflexuart.txt   | 24 +++++++++++++++++++
>  1 file changed, 24 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.txt
> 
> diff --git a/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.txt b/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.txt
> new file mode 100644
> index 000000000000..957ffeaca9f1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.txt
> @@ -0,0 +1,24 @@
> +* Freescale Linflex UART

Be consistent with the name: LINFlexD?

> +
> +The LINFlexD controller implements several LIN protocol versions, as well as
> +support for full-duplex UART communication through 8-bit and 9-bit frames. The
> +Linflex UART driver enables operation only in UART mode.

What the driver supports or not is independent of the binding.

> +
> +See chapter 47 ("LINFlexD") in the reference manual[1].
> +
> +Required properties:
> +- compatible :
> +  - "fsl,s32-linflexuart" for linflex configured in uart mode which

LINFlexD?

> +  is compatible with the one integrated on S32V234 SoC

Compatibles should be SoC specific. Is 's32' specific enough to account 
for any differences or future bugs found?

> +- reg : Address and length of the register set for the device
> +- interrupts : Should contain uart interrupt
> +
> +Example:
> +uart0:serial@40053000 {

space    ^

> +	compatible = "fsl,s32-linflexuart";
> +	reg = <0x0 0x40053000 0x0 0x1000>;
> +	interrupts = <0 59 4>;
> +	status = "disabled";

Don't show status in examples.

> +};
> +
> +[1] https://www.nxp.com/webapp/Download?colCode=S32V234RM
> -- 
> 2.22.0
> 
