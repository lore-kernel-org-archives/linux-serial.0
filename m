From: Peter Griffin <peter.griffin@linaro.org>
Subject: Re: [STLinux Kernel] [PATCH 2/8] serial: st-asc: Provide RTS
 functionality
Date: Wed, 25 Jan 2017 11:03:57 +0000
Message-ID: <20170125110357.GD5680@griffinp-ThinkPad-X1-Carbon-2nd>
References: <20170124134310.27512-1-lee.jones@linaro.org>
 <20170124134310.27512-3-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170124134310.27512-3-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: gregkh@linuxfoundation.org, jslaby@suse.com, linux-serial@vger.kernel.org, robh+dt@kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@stlinux.com
List-Id: linux-serial@vger.kernel.org

On Tue, 24 Jan 2017, Lee Jones wrote:

> Until this point, it has not been possible for userland serial
> applications (e.g. stty) to toggle the UART RTS line.  This can
> be useful with certain configurations. For example, when using
> a Mezzanine on a Linaro 96board, RTS line is used to take the
> on-board microcontroller in and out of reset.
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Peter Griffin <peter.griffin@linaro.org>

> ---
>  drivers/tty/serial/st-asc.c | 27 +++++++++++++++++++++++----
>  1 file changed, 23 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/serial/st-asc.c b/drivers/tty/serial/st-asc.c
> index 69e6232..397df50 100644
> --- a/drivers/tty/serial/st-asc.c
> +++ b/drivers/tty/serial/st-asc.c
> @@ -30,6 +30,7 @@
>  #include <linux/of_platform.h>
>  #include <linux/serial_core.h>
>  #include <linux/clk.h>
> +#include <linux/gpio/consumer.h>
>  
>  #define DRIVER_NAME "st-asc"
>  #define ASC_SERIAL_NAME "ttyAS"
> @@ -38,6 +39,7 @@
>  
>  struct asc_port {
>  	struct uart_port port;
> +	struct gpio_desc *rts;
>  	struct clk *clk;
>  	unsigned int hw_flow_control:1;
>  	unsigned int force_m1:1;
> @@ -391,12 +393,27 @@ static unsigned int asc_tx_empty(struct uart_port *port)
>  
>  static void asc_set_mctrl(struct uart_port *port, unsigned int mctrl)
>  {
> +	struct asc_port *ascport = to_asc_port(port);
> +
>  	/*
> -	 * This routine is used for seting signals of: DTR, DCD, CTS/RTS
> -	 * We use ASC's hardware for CTS/RTS, so don't need any for that.
> -	 * Some boards have DTR and DCD implemented using PIO pins,
> -	 * code to do this should be hooked in here.
> +	 * This routine is used for seting signals of: DTR, DCD, CTS and RTS.
> +	 * We use ASC's hardware for CTS/RTS when hardware flow-control is
> +	 * enabled, however if the RTS line is required for another purpose,
> +	 * commonly controlled using HUP from userspace, then we need to toggle
> +	 * it manually, using GPIO.
> +	 *
> +	 * Some boards also have DTR and DCD implemented using PIO pins, code to
> +	 * do this should be hooked in here.
>  	 */
> +
> +	if (!ascport->rts)
> +		return;
> +
> +	/* If HW flow-control is enabled, we can't fiddle with the RTS line */
> +	if (asc_in(port, ASC_CTL) & ASC_CTL_CTSENABLE)
> +		return;
> +
> +	gpiod_set_value(ascport->rts, mctrl & TIOCM_RTS);
>  }
>  
>  static unsigned int asc_get_mctrl(struct uart_port *port)
> @@ -726,6 +743,8 @@ static struct asc_port *asc_of_get_asc_port(struct platform_device *pdev)
>  							"st,hw-flow-control");
>  	asc_ports[id].force_m1 =  of_property_read_bool(np, "st,force_m1");
>  	asc_ports[id].port.line = id;
> +	asc_ports[id].rts = NULL;
> +
>  	return &asc_ports[id];
>  }
>  
