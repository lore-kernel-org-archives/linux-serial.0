From: Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: Re: [PATCH 1/4] serial: core: Add LED trigger support
Date: Thu, 24 Nov 2016 08:45:43 -0700
Message-ID: <20161124154543.GA8937@linaro.org>
References: <20161123100106.15969-1-s.hauer@pengutronix.de>
 <20161123100106.15969-2-s.hauer@pengutronix.de>
 <20161123171302.GD19856@linaro.org>
 <20161124064137.l3i3p3brbyz74cd5@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20161124064137.l3i3p3brbyz74cd5@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-arm-kernel@lists.infradead.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, kernel@pengutronix.de
List-Id: linux-serial@vger.kernel.org

On Thu, Nov 24, 2016 at 07:41:37AM +0100, Sascha Hauer wrote:
> On Wed, Nov 23, 2016 at 10:13:02AM -0700, Mathieu Poirier wrote:
> > On Wed, Nov 23, 2016 at 11:01:03AM +0100, Sascha Hauer wrote:
> > > With this patch the serial core provides LED triggers for RX and TX.
> > > 
> > > As the serial core layer does not know when the hardware actually sends
> > > or receives characters, this needs help from the UART drivers. The
> > > LED triggers are registered in uart_add_led_triggers() called from
> > > the UART drivers which want to support LED triggers. All the driver
> > > has to do then is to call uart_led_trigger_[tx|rx] to indicate
> > > activite.
> > 
> > Hello Sascha,
> > 
> > > 
> > > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > > ---
> > >  drivers/tty/serial/serial_core.c | 73 ++++++++++++++++++++++++++++++++++++++++
> > >  include/linux/serial_core.h      | 10 ++++++
> > >  2 files changed, 83 insertions(+)
> > > 
> > > diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> > > index f2303f3..3e8afb7 100644
> > > --- a/drivers/tty/serial/serial_core.c
> > > +++ b/drivers/tty/serial/serial_core.c
> > > @@ -34,6 +34,7 @@
> > >  #include <linux/serial_core.h>
> > >  #include <linux/delay.h>
> > >  #include <linux/mutex.h>
> > > +#include <linux/leds.h>
> > >  
> > >  #include <asm/irq.h>
> > >  #include <asm/uaccess.h>
> > > @@ -2703,6 +2704,77 @@ static const struct attribute_group tty_dev_attr_group = {
> > >  	.attrs = tty_dev_attrs,
> > >  	};
> > >  
> > > +void uart_led_trigger_tx(struct uart_port *uport)
> > > +{
> > > +	unsigned long delay = 50;
> > > +
> > > +	led_trigger_blink_oneshot(uport->led_trigger_tx, &delay, &delay, 0);
> > > +}
> > > +
> > > +void uart_led_trigger_rx(struct uart_port *uport)
> > > +{
> > > +	unsigned long delay = 50;
> > > +
> > > +	led_trigger_blink_oneshot(uport->led_trigger_rx, &delay, &delay, 0);
> > 
> > For both rx/tx the core constrains the delay_on/off along with the inversion.
> > Instead of adding the led_trigger_rx/tx and led_trigger_rx/tx_name to the 
> > struct uart_port, wouldn't it be better to add a new struct led_trigger that
> > would encapsulate those along wit the on/off delay and the inversion?
> > 
> > That way those values could be communicated to the core at registration time
> > instead of hard-coding things.
> 
> Not sure this goes into the right direction. Looking at the other
> callers of led_trigger_blink_oneshot() most of them use an arbitrary
> blink time of 30 or 50ms and the users seem to be happy with it. There
> doesn't seem to be the desire to make that value configurable. If we
> want to make it configurable, it's probably better to move the option
> to the led device rather than putting the burden on every user of the
> led triggers.

So you did find instances where the blink time wasn't 50ms.  To me that's
a valid reason to not hard code the blink time and proceed differently.

> 
> I don't think the inversion flag is meant for being configurable. It's
> rather used for the default state of the LED. The CAN layer for example
> turns the LED on when the interface is up and then blinks (turns off and
> on again) on activity. For this it uses the inversion flag.
> 
> >  
> > > +}
> > > +
> > > +/**
> > > + *	uart_add_led_triggers - register LED triggers for a UART
> > > + *	@drv: pointer to the uart low level driver structure for this port
> > > + *	@uport: uart port structure to use for this port.
> > > + *
> > > + *	Called by the driver to register LED triggers for a UART. It's the
> > > + *	drivers responsibility to call uart_led_trigger_rx/tx on received
> > > + *	and transmitted chars then.
> > > + */
> > > +int uart_add_led_triggers(struct uart_driver *drv, struct uart_port *uport)
> > > +{
> > > +	int ret;
> > > +
> > > +	if (!IS_ENABLED(CONFIG_LEDS_TRIGGERS))
> > > +		return 0;
> > 
> > Since this is a public interface, checking for valid led_trigger_tx/rx before
> > moving on with the rest of the initialisation is probably a good idea.
> 
> What do you mean? Should we return an error when CONFIG_LEDS_TRIGGERS is
> disabled?

        if (!uport->led_trigger_rx || !uport->led_triggertx)
                return -EINVAL;


> 
> Sascha
> 
> 
> -- 
> Pengutronix e.K.                           |                             |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
