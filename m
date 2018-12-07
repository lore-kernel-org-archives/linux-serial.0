From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 12/15] dt-bindings: serial: Document RDA Micro UART
Date: Fri, 7 Dec 2018 17:41:18 -0600
Message-ID: <20181207234118.GA16289@bogus>
References: <20181128135106.9255-1-manivannan.sadhasivam@linaro.org>
 <20181128135106.9255-13-manivannan.sadhasivam@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181128135106.9255-13-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: olof@lixom.net, arnd@arndb.de, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, daniel.lezcano@linaro.org, gregkh@linuxfoundation.org, jslaby@suse.com, afaerber@suse.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-serial@vger.kernel.org, amit.kucheria@linaro.org, linus.walleij@linaro.org, zhao_steven@263.net, overseas.sales@unisoc.com
List-Id: linux-serial@vger.kernel.org

On Wed, Nov 28, 2018 at 07:21:03PM +0530, Manivannan Sadhasivam wrote:
> From: Andreas Färber <afaerber@suse.de>
> 
> Add an initial binding for the UART in RDA Micro RDA8810PL SoC.
> 
> Signed-off-by: Andreas Färber <afaerber@suse.de>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  .../bindings/serial/rda,8810pl-uart.txt           | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/serial/rda,8810pl-uart.txt
> 
> diff --git a/Documentation/devicetree/bindings/serial/rda,8810pl-uart.txt b/Documentation/devicetree/bindings/serial/rda,8810pl-uart.txt
> new file mode 100644
> index 000000000000..ee03116d7415
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/serial/rda,8810pl-uart.txt
> @@ -0,0 +1,15 @@
> +RDA Micro UART
> +
> +Required properties:
> +- compatible :  "rda,8810pl-uart" for RDA8810PL SoCs.
> +- reg        :  Offset and length of the register set for the device.
> +- interrupts :  Should contain UART interrupt.

Uarts generally need a clock.

> +
> +
> +Example:
> +
> +		uart2: serial@20a90000 {
> +			compatible = "rda,8810pl-uart";
> +			reg = <0x20a90000 0x1000>;
> +			interrupts = <11 IRQ_TYPE_LEVEL_HIGH>;
> +		};
> -- 
> 2.17.1
> 
