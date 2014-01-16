From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH] serial: 8250: enable UART_BUG_NOMSR for Tegra
Date: Thu, 16 Jan 2014 10:52:56 +0200
Message-ID: <20140116085256.GB11732@xps8300>
References: <1389132012-2257-1-git-send-email-swarren@wwwdotorg.org>
 <20140115111205.GA11732@xps8300>
 <52D6C59D.4070402@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <52D6C59D.4070402@wwwdotorg.org>
Sender: stable-owner@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, linux-tegra@vger.kernel.org, olof@lixom.net, Stephen Warren <swarren@nvidia.com>, stable@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Wed, Jan 15, 2014 at 10:30:05AM -0700, Stephen Warren wrote:
> On 01/15/2014 04:12 AM, Heikki Krogerus wrote:
> > On Tue, Jan 07, 2014 at 03:00:12PM -0700, Stephen Warren wrote:
> >> diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
> >> index e33d38cb170f..61ecd709a722 100644
> >> --- a/drivers/tty/serial/8250/8250_core.c
> >> +++ b/drivers/tty/serial/8250/8250_core.c
> >> @@ -2670,6 +2670,10 @@ static void serial8250_config_port(struct uart_port *port, int flags)
> >>  	if (port->type == PORT_16550A && port->iotype == UPIO_AU)
> >>  		up->bugs |= UART_BUG_NOMSR;
> >>  
> >> +	/* HW bugs may trigger IRQ while IIR == NO_INT */
> >> +	if (port->type == PORT_TEGRA)
> >> +		up->bugs |= UART_BUG_NOMSR;
> >> +
> > 
> > Is there any reason this needs to be in 8250_core.c? Why not set it in
> > drivers/tty/serial/of_serial.c?
> 
> I imagine the code could go in either place.
> 
> I don't see any advantage moving it to of_serial.c, and it'd actively be
> a disadvantage as far as I'm concerned; PORT_TEGRA is defined in 8250.c,
> and other code which enable the same UART_BUG_NOMSR flag is in exactly
> the same place, which keeps similar code co-located.

You are adding platform specific quirk to 8250 even though there is
nothing prevention you from keeping it in your probe driver. That is
_not_ acceptable. 8250_core.c is now the layer used by all 8250/16550
compatible UARTs. It must be kept as clean as possible of any
platform/UART specific information, even if it was not done before.

It's already really full of UART/platform specific quirks like this,
and some of them are really bad. Instead of adding one more, we need
to start cleaning the driver of the existing.

About the port types. Since we can now deliver 8250_core.c all the
capabilities and settings from the probe drivers except fcr, and we
need to fix that as well, we should start reducing the number of types
in the static uart config array. Ideally we only have the standard
types in it. So instead of using the custom PORT_TEGRA type, you would
just use perhaps PORT_16550A or PORT_16750, and replace the
capabilities that don't match your HW before registering the ports.

I guess it's fare to say, 8250 is a bit messy. Originally it was just
a driver, but it has now been made into (or it has turned into) an
abstraction layer, so it's probable not always so clear how it should
be used. In any case, the same rules apply as to any layer. It needs
to be kept as platform independent as possible.

Thanks,

-- 
heikki
