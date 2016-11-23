From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH 1/4] serial: core: Add LED trigger support
Date: Wed, 23 Nov 2016 11:18:27 +0100
Message-ID: <20161123101827.5c3n5mrezyyw2us3@pengutronix.de>
References: <20161123100106.15969-1-s.hauer@pengutronix.de>
 <20161123100106.15969-2-s.hauer@pengutronix.de>
 <20161123100819.GA20137@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20161123100819.GA20137@kroah.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, kernel@pengutronix.de
List-Id: linux-serial@vger.kernel.org

On Wed, Nov 23, 2016 at 11:08:19AM +0100, Greg Kroah-Hartman wrote:
> On Wed, Nov 23, 2016 at 11:01:03AM +0100, Sascha Hauer wrote:
> > With this patch the serial core provides LED triggers for RX and TX.
> > 
> > As the serial core layer does not know when the hardware actually sends
> > or receives characters, this needs help from the UART drivers. The
> > LED triggers are registered in uart_add_led_triggers() called from
> > the UART drivers which want to support LED triggers. All the driver
> > has to do then is to call uart_led_trigger_[tx|rx] to indicate
> > activity.
> > 
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > ---
> >  drivers/tty/serial/serial_core.c | 73 ++++++++++++++++++++++++++++++++++++++++
> >  include/linux/serial_core.h      | 10 ++++++
> >  2 files changed, 83 insertions(+)
> > 
> > diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> > index f2303f3..3e8afb7 100644
> > --- a/drivers/tty/serial/serial_core.c
> > +++ b/drivers/tty/serial/serial_core.c
> > @@ -34,6 +34,7 @@
> >  #include <linux/serial_core.h>
> >  #include <linux/delay.h>
> >  #include <linux/mutex.h>
> > +#include <linux/leds.h>
> >  
> >  #include <asm/irq.h>
> >  #include <asm/uaccess.h>
> > @@ -2703,6 +2704,77 @@ static const struct attribute_group tty_dev_attr_group = {
> >  	.attrs = tty_dev_attrs,
> >  	};
> >  
> > +void uart_led_trigger_tx(struct uart_port *uport)
> > +{
> > +	unsigned long delay = 50;
> > +
> > +	led_trigger_blink_oneshot(uport->led_trigger_tx, &delay, &delay, 0);
> > +}
> > +
> > +void uart_led_trigger_rx(struct uart_port *uport)
> > +{
> > +	unsigned long delay = 50;
> > +
> > +	led_trigger_blink_oneshot(uport->led_trigger_rx, &delay, &delay, 0);
> > +}
> 
> Don't these functions need an EXPORT_SYMBOL_GPL() to work properly with
> uart drivers being built as a module?

Yes, for sure. Will fix in next version.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
