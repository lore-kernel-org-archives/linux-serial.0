From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 2/5] serial: imx: Use generic uart-has-rtscts DT property
Date: Thu, 14 Apr 2016 12:22:59 -0500
Message-ID: <20160414172259.GA16348@rob-hp-laptop>
References: <1460636003-3011-1-git-send-email-geert+renesas@glider.be>
 <1460636003-3011-3-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1460636003-3011-3-git-send-email-geert+renesas@glider.be>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Barry Song <baohua@kernel.org>, Qipan Li <Qipan.Li@csr.com>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, Kumar Gala <galak@codeaurora.org>, Fabio Estevam <fabio.estevam@nxp.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Thu, Apr 14, 2016 at 02:13:20PM +0200, Geert Uytterhoeven wrote:
> Convert the Freescale IMX UART driver from using the vendor-specific
> "fsl,uart-has-rtscts" to the generic "uart-has-rtscts" DT property, as
> documented by the Generic Serial DT Bindings.
> 
> The old vendor-specific property is still recognized by the driver for
> backwards compatibility, but deprecated.

You should update the dts files as well.

> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  Documentation/devicetree/bindings/serial/fsl-imx-uart.txt | 4 ++--
>  drivers/tty/serial/imx.c                                  | 3 ++-
>  2 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/serial/fsl-imx-uart.txt b/Documentation/devicetree/bindings/serial/fsl-imx-uart.txt
> index ed94c217c98d18a6..1e82802d8e322db5 100644
> --- a/Documentation/devicetree/bindings/serial/fsl-imx-uart.txt
> +++ b/Documentation/devicetree/bindings/serial/fsl-imx-uart.txt
> @@ -6,7 +6,7 @@ Required properties:
>  - interrupts : Should contain uart interrupt
>  
>  Optional properties:
> -- fsl,uart-has-rtscts : Indicate the uart has rts and cts
> +- uart-has-rtscts : Indicate the uart has rts and cts
>  - fsl,irda-mode : Indicate the uart supports irda mode
>  - fsl,dte-mode : Indicate the uart works in DTE mode. The uart works
>                    in DCE mode by default.
> @@ -24,6 +24,6 @@ uart1: serial@73fbc000 {
>  	compatible = "fsl,imx51-uart", "fsl,imx21-uart";
>  	reg = <0x73fbc000 0x4000>;
>  	interrupts = <31>;
> -	fsl,uart-has-rtscts;
> +	uart-has-rtscts;
>  	fsl,dte-mode;
>  };
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 231e7d5caf6c1845..9fc09d3de1e2428b 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -1927,7 +1927,8 @@ static int serial_imx_probe_dt(struct imx_port *sport,
>  	}
>  	sport->port.line = ret;
>  
> -	if (of_get_property(np, "fsl,uart-has-rtscts", NULL))
> +	if (of_get_property(np, "uart-has-rtscts", NULL) ||
> +	    of_get_property(np, "fsl,uart-has-rtscts", NULL) /* deprecated */)
>  		sport->have_rtscts = 1;
>  
>  	if (of_get_property(np, "fsl,dte-mode", NULL))
> -- 
> 1.9.1
> 
