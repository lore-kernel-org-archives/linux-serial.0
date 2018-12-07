From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 09/15] dt-bindings: timer: Document RDA8810PL SoC timer
Date: Fri, 7 Dec 2018 17:39:56 -0600
Message-ID: <20181207233956.GA13852@bogus>
References: <20181128135106.9255-1-manivannan.sadhasivam@linaro.org>
 <20181128135106.9255-10-manivannan.sadhasivam@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181128135106.9255-10-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: olof@lixom.net, arnd@arndb.de, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, daniel.lezcano@linaro.org, gregkh@linuxfoundation.org, jslaby@suse.com, afaerber@suse.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-serial@vger.kernel.org, amit.kucheria@linaro.org, linus.walleij@linaro.org, zhao_steven@263.net, overseas.sales@unisoc.com
List-Id: linux-serial@vger.kernel.org

On Wed, Nov 28, 2018 at 07:21:00PM +0530, Manivannan Sadhasivam wrote:
> Document RDA Micro RDA8810PL SoC timer.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  .../bindings/timer/rda,8810pl-timer.txt       | 21 +++++++++++++++++++
>  1 file changed, 21 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/timer/rda,8810pl-timer.txt
> 
> diff --git a/Documentation/devicetree/bindings/timer/rda,8810pl-timer.txt b/Documentation/devicetree/bindings/timer/rda,8810pl-timer.txt
> new file mode 100644
> index 000000000000..06cc2b00be12
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/timer/rda,8810pl-timer.txt
> @@ -0,0 +1,21 @@
> +RDA Micro RDA8810PL Timer
> +
> +Required properties:
> +- compatible      :  "rda,8810pl-timer"
> +- reg             :  Offset and length of the register set for the device.
> +- interrupts      :  Should contain the interrupts.

How many?

> +- interrupt-names :  Valid names are: "hwtimer", "ostimer".

It's more than just valid names, but rather must be those 2 strings.

> +                     See ../resource-names.txt
> +
> +Example:
> +
> +		apb@20900000 {
> +			compatible = "simple-bus";
> +			...
> +			timer@10000 {
> +				compatible = "rda,8810pl-timer";
> +				reg = <0x10000 0x1000>;
> +				interrupts = <16 IRQ_TYPE_LEVEL_HIGH>,
> +					     <17 IRQ_TYPE_LEVEL_HIGH>;
> +				interrupt-names = "hwtimer", "ostimer";
> +			};
> -- 
> 2.17.1
> 
