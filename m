From: Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH v2 7/7] ARM: zynq: DT: Migrate UART to Cadence binding
Date: Tue, 11 Mar 2014 09:52:35 +0100
Message-ID: <62cd32ad-8743-4d49-a1b6-c178054a9756@CO9EHSMHS011.ehs.local>
References: <1394487610-2419-1-git-send-email-soren.brinkmann@xilinx.com> <1394487610-2419-8-git-send-email-soren.brinkmann@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1394487610-2419-8-git-send-email-soren.brinkmann@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Soren Brinkmann <soren.brinkmann@xilinx.com>
Cc: Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Michal Simek <michal.simek@xilinx.com>, Peter Crosthwaite <peter.crosthwaite@xilinx.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Rob Landley <rob@landley.net>, Grant Likely <grant.likely@linaro.org>, devicetree@vger.kernel.org, linux-doc@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 03/10/2014 10:40 PM, Soren Brinkmann wrote:
> The Zynq UART is Cadence IP and the driver has been renamed accordingly.
> Migrate the DT to use the new binding for the UART driver.
> 
> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> Acked-by: Peter Crosthwaite <peter.crosthwaite@xilinx.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
> This change depends on 'tty: xuartps: Rebrand driver as Cadence UART',
> which introduces the new clock-names.
> ---
>  arch/arm/boot/dts/zynq-7000.dtsi | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000.dtsi
> index 8b67b19392ec..0ed0d4b0579a 100644
> --- a/arch/arm/boot/dts/zynq-7000.dtsi
> +++ b/arch/arm/boot/dts/zynq-7000.dtsi
> @@ -67,19 +67,19 @@
>  		};
>  
>  		uart0: uart@e0000000 {
> -			compatible = "xlnx,xuartps";
> +			compatible = "xlnx,xuartps", "cdns,uart-r1p8";
>  			status = "disabled";
>  			clocks = <&clkc 23>, <&clkc 40>;
> -			clock-names = "ref_clk", "aper_clk";
> +			clock-names = "uart_clk", "pclk";
>  			reg = <0xE0000000 0x1000>;
>  			interrupts = <0 27 4>;
>  		};
>  
>  		uart1: uart@e0001000 {
> -			compatible = "xlnx,xuartps";
> +			compatible = "xlnx,xuartps", "cdns,uart-r1p8";
>  			status = "disabled";
>  			clocks = <&clkc 24>, <&clkc 41>;
> -			clock-names = "ref_clk", "aper_clk";
> +			clock-names = "uart_clk", "pclk";
>  			reg = <0xE0001000 0x1000>;
>  			interrupts = <0 50 4>;
>  		};

This should be at least the part of 5/7 because between 5/7 and 7/7
driver will fail to probe.

Thanks,
Michal
