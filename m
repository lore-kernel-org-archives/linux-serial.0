From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [STLinux Kernel] [PATCH 3/8] serial: st-asc: Read in all Pinctrl
 states
Date: Fri, 27 Jan 2017 11:54:58 +0000
Message-ID: <20170127115458.k4edg42nnna3bv4v@dell>
References: <20170124134310.27512-1-lee.jones@linaro.org>
 <20170124134310.27512-4-lee.jones@linaro.org>
 <20170125112142.GE5680@griffinp-ThinkPad-X1-Carbon-2nd>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170125112142.GE5680@griffinp-ThinkPad-X1-Carbon-2nd>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Griffin <peter.griffin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, jslaby-IBi9RG/b67k@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, kernel-F5mvAk5X5gdBDgjK7y7TUQ@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On Wed, 25 Jan 2017, Peter Griffin wrote:

> Hi Lee,
> 
> On Tue, 24 Jan 2017, Lee Jones wrote:
> 
> > There are now 2 possible separate/different Pinctrl states which can
> > be provided from platform data.  One which encompasses the lines
> > required for HW flow-control (CTS/RTS) and another which does not
> > specify these lines, such that they can be used via GPIO mechanisms
> > for manually toggling (i.e. from a request by `stty`).
> > 
> > Signed-off-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> > ---
> >  drivers/tty/serial/st-asc.c | 28 ++++++++++++++++++++++++++++
> >  1 file changed, 28 insertions(+)
> > 
> > diff --git a/drivers/tty/serial/st-asc.c b/drivers/tty/serial/st-asc.c
> > index 397df50..03801ed 100644
> > --- a/drivers/tty/serial/st-asc.c
> > +++ b/drivers/tty/serial/st-asc.c
> > @@ -37,10 +37,16 @@
> >  #define ASC_FIFO_SIZE 16
> >  #define ASC_MAX_PORTS 8
> >  
> > +/* Pinctrl states */
> > +#define DEFAULT		0
> > +#define MANUAL_RTS	1
> 
> Nit: Would be better to have them aligned.

These are aligned in code.  The patch format throws things out.

Look, same lines with the "> > +" removed:

/* Pinctrl states */
#define DEFAULT		0
#define MANUAL_RTS	1

Try it.

> > +
> >  struct asc_port {
> >  	struct uart_port port;
> >  	struct gpio_desc *rts;
> >  	struct clk *clk;
> > +	struct pinctrl *pinctrl;
> > +	struct pinctrl_state *states[2];
> >  	unsigned int hw_flow_control:1;
> >  	unsigned int force_m1:1;
> >  };
> > @@ -694,6 +700,7 @@ static int asc_init_port(struct asc_port *ascport,
> >  {
> >  	struct uart_port *port = &ascport->port;
> >  	struct resource *res;
> > +	int ret;
> >  
> >  	port->iotype	= UPIO_MEM;
> >  	port->flags	= UPF_BOOT_AUTOCONF;
> > @@ -720,6 +727,27 @@ static int asc_init_port(struct asc_port *ascport,
> >  	WARN_ON(ascport->port.uartclk == 0);
> >  	clk_disable_unprepare(ascport->clk);
> >  
> > +	ascport->pinctrl = devm_pinctrl_get(&pdev->dev);
> > +	if (IS_ERR(ascport->pinctrl)) {
> > +		ret = PTR_ERR(ascport->pinctrl);
> > +		dev_err(&pdev->dev, "Failed to get Pinctrl: %d\n", ret);
> > +	}
> > +
> > +	ascport->states[DEFAULT] =
> > +		pinctrl_lookup_state(ascport->pinctrl, "default");
> > +	if (IS_ERR(ascport->states[DEFAULT])) {
> > +		ret = PTR_ERR(ascport->states[DEFAULT]);
> > +		dev_err(&pdev->dev,
> > +			"Failed to look up Pinctrl state 'default': %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	/* "manual-rts" state is optional */
> > +	ascport->states[MANUAL_RTS] =
> > +		pinctrl_lookup_state(ascport->pinctrl, "manual-rts");
> > +	if (IS_ERR(ascport->states[MANUAL_RTS]))
> > +		ascport->states[MANUAL_RTS] = NULL;
> > +
> 
> The different pinctrl states looks like a neat solution to the problem.
> 
> My only concern here is that 'default' state is implying a hw-flow-control
> pinmux config, and manual-rts is implying what is the current upstream
> 'default' pinmux config.
> 
> Which maybe ok if you update all uarts, but currently only serial0
> is updated. So the other uarts current 'default' is actually the same as serial0
> 'manual-rts' grouping, which conceptually is odd.
> 
> Would it not be better to make 'manual-rts' the default state? As that aligns
> to what is currently already the default for the other UARTS? And then make
> hw-flow-control the optional state for serial0?
> 
> That also has the advantage that 'default' has the same meaning with older DT's.

The reason it was done is this was because none of the other UARTs
require 2 separate Pinctrl configurations, only this one.  Moreover,
if they support RTS/CTS then I believe that the lines should be
defined in Pinctrl.  Thus, it was my plan to update all UART's default
Pinctrl configs to include the RTS/CTS lines.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
