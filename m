From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 3/5] ARM: dts: imx6: rename the uart's compatible property
Date: Tue, 2 Jul 2013 10:56:45 +0100
Message-ID: <20130702095645.GD31358@e106331-lin.cambridge.arm.com>
References: <1372746628-20092-1-git-send-email-b32955@freescale.com>
 <1372746628-20092-4-git-send-email-b32955@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1372746628-20092-4-git-send-email-b32955@freescale.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Huang Shijie <b32955@freescale.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

On Tue, Jul 02, 2013 at 07:30:26AM +0100, Huang Shijie wrote:
> The imx6 uart can supports the DMA, imx uart driver has added a new
> compatible property for the imx6 uart.
> 
> In order to enable the DMA for some uart port in imx6, we rename the
> uart's compatible property to "fsl,imx6-uart".

Doesn't this change break using these dts with an older kernel? You
remove the "fsl,imx21-uart" string older kernels understand.

Given you already had "fsl,imx6q-uart" and "fsl,imx6sl-uart" strings,
would it not have made more sense to just add these to the driver?

Thanks,
Mark.

> 
> Signed-off-by: Huang Shijie <b32955@freescale.com>
> ---
>  arch/arm/boot/dts/imx6qdl.dtsi |   10 +++++-----
>  arch/arm/boot/dts/imx6sl.dtsi  |   10 +++++-----
>  2 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
> index 0509344..d4ab0ee 100644
> --- a/arch/arm/boot/dts/imx6qdl.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl.dtsi
> @@ -179,7 +179,7 @@
>  				};
>  
>  				uart1: serial@02020000 {
> -					compatible = "fsl,imx6q-uart", "fsl,imx21-uart";
> +					compatible = "fsl,imx6-uart";
>  					reg = <0x02020000 0x4000>;
>  					interrupts = <0 26 0x04>;
>  					clocks = <&clks 160>, <&clks 161>;
> @@ -787,7 +787,7 @@
>  			};
>  
>  			uart2: serial@021e8000 {
> -				compatible = "fsl,imx6q-uart", "fsl,imx21-uart";
> +				compatible = "fsl,imx6-uart";
>  				reg = <0x021e8000 0x4000>;
>  				interrupts = <0 27 0x04>;
>  				clocks = <&clks 160>, <&clks 161>;
> @@ -796,7 +796,7 @@
>  			};
>  
>  			uart3: serial@021ec000 {
> -				compatible = "fsl,imx6q-uart", "fsl,imx21-uart";
> +				compatible = "fsl,imx6-uart";
>  				reg = <0x021ec000 0x4000>;
>  				interrupts = <0 28 0x04>;
>  				clocks = <&clks 160>, <&clks 161>;
> @@ -805,7 +805,7 @@
>  			};
>  
>  			uart4: serial@021f0000 {
> -				compatible = "fsl,imx6q-uart", "fsl,imx21-uart";
> +				compatible = "fsl,imx6-uart";
>  				reg = <0x021f0000 0x4000>;
>  				interrupts = <0 29 0x04>;
>  				clocks = <&clks 160>, <&clks 161>;
> @@ -814,7 +814,7 @@
>  			};
>  
>  			uart5: serial@021f4000 {
> -				compatible = "fsl,imx6q-uart", "fsl,imx21-uart";
> +				compatible = "fsl,imx6-uart";
>  				reg = <0x021f4000 0x4000>;
>  				interrupts = <0 30 0x04>;
>  				clocks = <&clks 160>, <&clks 161>;
> diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
> index 9138c67..ca1527f 100644
> --- a/arch/arm/boot/dts/imx6sl.dtsi
> +++ b/arch/arm/boot/dts/imx6sl.dtsi
> @@ -152,7 +152,7 @@
>  				};
>  
>  				uart5: serial@02018000 {
> -					compatible = "fsl,imx6sl-uart", "fsl,imx21-uart";
> +					compatible = "fsl,imx6-uart";
>  					reg = <0x02018000 0x4000>;
>  					interrupts = <0 30 0x04>;
>  					clocks = <&clks IMX6SL_CLK_UART>,
> @@ -162,7 +162,7 @@
>  				};
>  
>  				uart1: serial@02020000 {
> -					compatible = "fsl,imx6sl-uart", "fsl,imx21-uart";
> +					compatible = "fsl,imx6-uart";
>  					reg = <0x02020000 0x4000>;
>  					interrupts = <0 26 0x04>;
>  					clocks = <&clks IMX6SL_CLK_UART>,
> @@ -172,7 +172,7 @@
>  				};
>  
>  				uart2: serial@02024000 {
> -					compatible = "fsl,imx6sl-uart", "fsl,imx21-uart";
> +					compatible = "fsl,imx6-uart";
>  					reg = <0x02024000 0x4000>;
>  					interrupts = <0 27 0x04>;
>  					clocks = <&clks IMX6SL_CLK_UART>,
> @@ -209,7 +209,7 @@
>  				};
>  
>  				uart3: serial@02034000 {
> -					compatible = "fsl,imx6sl-uart", "fsl,imx21-uart";
> +					compatible = "fsl,imx6-uart";
>  					reg = <0x02034000 0x4000>;
>  					interrupts = <0 28 0x04>;
>  					clocks = <&clks IMX6SL_CLK_UART>,
> @@ -219,7 +219,7 @@
>  				};
>  
>  				uart4: serial@02038000 {
> -					compatible = "fsl,imx6sl-uart", "fsl,imx21-uart";
> +					compatible = "fsl,imx6-uart";
>  					reg = <0x02038000 0x4000>;
>  					interrupts = <0 29 0x04>;
>  					clocks = <&clks IMX6SL_CLK_UART>,
> -- 
> 1.7.1
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
