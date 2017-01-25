From: Peter Griffin <peter.griffin@linaro.org>
Subject: Re: [STLinux Kernel] [PATCH 3/8] serial: st-asc: Read in all Pinctrl
 states
Date: Wed, 25 Jan 2017 11:21:42 +0000
Message-ID: <20170125112142.GE5680@griffinp-ThinkPad-X1-Carbon-2nd>
References: <20170124134310.27512-1-lee.jones@linaro.org>
 <20170124134310.27512-4-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170124134310.27512-4-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: gregkh@linuxfoundation.org, jslaby@suse.com, linux-serial@vger.kernel.org, robh+dt@kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@stlinux.com
List-Id: linux-serial@vger.kernel.org

Hi Lee,

On Tue, 24 Jan 2017, Lee Jones wrote:

> There are now 2 possible separate/different Pinctrl states which can
> be provided from platform data.  One which encompasses the lines
> required for HW flow-control (CTS/RTS) and another which does not
> specify these lines, such that they can be used via GPIO mechanisms
> for manually toggling (i.e. from a request by `stty`).
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/tty/serial/st-asc.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/drivers/tty/serial/st-asc.c b/drivers/tty/serial/st-asc.c
> index 397df50..03801ed 100644
> --- a/drivers/tty/serial/st-asc.c
> +++ b/drivers/tty/serial/st-asc.c
> @@ -37,10 +37,16 @@
>  #define ASC_FIFO_SIZE 16
>  #define ASC_MAX_PORTS 8
>  
> +/* Pinctrl states */
> +#define DEFAULT		0
> +#define MANUAL_RTS	1

Nit: Would be better to have them aligned.

> +
>  struct asc_port {
>  	struct uart_port port;
>  	struct gpio_desc *rts;
>  	struct clk *clk;
> +	struct pinctrl *pinctrl;
> +	struct pinctrl_state *states[2];
>  	unsigned int hw_flow_control:1;
>  	unsigned int force_m1:1;
>  };
> @@ -694,6 +700,7 @@ static int asc_init_port(struct asc_port *ascport,
>  {
>  	struct uart_port *port = &ascport->port;
>  	struct resource *res;
> +	int ret;
>  
>  	port->iotype	= UPIO_MEM;
>  	port->flags	= UPF_BOOT_AUTOCONF;
> @@ -720,6 +727,27 @@ static int asc_init_port(struct asc_port *ascport,
>  	WARN_ON(ascport->port.uartclk == 0);
>  	clk_disable_unprepare(ascport->clk);
>  
> +	ascport->pinctrl = devm_pinctrl_get(&pdev->dev);
> +	if (IS_ERR(ascport->pinctrl)) {
> +		ret = PTR_ERR(ascport->pinctrl);
> +		dev_err(&pdev->dev, "Failed to get Pinctrl: %d\n", ret);
> +	}
> +
> +	ascport->states[DEFAULT] =
> +		pinctrl_lookup_state(ascport->pinctrl, "default");
> +	if (IS_ERR(ascport->states[DEFAULT])) {
> +		ret = PTR_ERR(ascport->states[DEFAULT]);
> +		dev_err(&pdev->dev,
> +			"Failed to look up Pinctrl state 'default': %d\n", ret);
> +		return ret;
> +	}
> +
> +	/* "manual-rts" state is optional */
> +	ascport->states[MANUAL_RTS] =
> +		pinctrl_lookup_state(ascport->pinctrl, "manual-rts");
> +	if (IS_ERR(ascport->states[MANUAL_RTS]))
> +		ascport->states[MANUAL_RTS] = NULL;
> +

The different pinctrl states looks like a neat solution to the problem.

My only concern here is that 'default' state is implying a hw-flow-control
pinmux config, and manual-rts is implying what is the current upstream
'default' pinmux config.

Which maybe ok if you update all uarts, but currently only serial0
is updated. So the other uarts current 'default' is actually the same as serial0
'manual-rts' grouping, which conceptually is odd.

Would it not be better to make 'manual-rts' the default state? As that aligns
to what is currently already the default for the other UARTS? And then make
hw-flow-control the optional state for serial0?

That also has the advantage that 'default' has the same meaning with older DT's.

regards,

Peter.
