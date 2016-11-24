From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH 1/4] serial: core: Add LED trigger support
Date: Thu, 24 Nov 2016 09:17:48 +0100
Message-ID: <20161124081748.fx3xm5ww64ngn5it@pengutronix.de>
References: <20161123100106.15969-1-s.hauer@pengutronix.de>
 <20161123100106.15969-2-s.hauer@pengutronix.de>
 <e9fc12b8-d4a7-067d-ef87-03f0aae39bd7@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <e9fc12b8-d4a7-067d-ef87-03f0aae39bd7@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: linux-serial@vger.kernel.org, kernel@pengutronix.de, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Wed, Nov 23, 2016 at 10:57:13AM -0800, Florian Fainelli wrote:
> On 11/23/2016 02:01 AM, Sascha Hauer wrote:
> > With this patch the serial core provides LED triggers for RX and TX.
> > 
> > As the serial core layer does not know when the hardware actually sends
> > or receives characters, this needs help from the UART drivers.
> 
> Looking at 8250, we call serial8250_tx_chars from __start_tx which is
> called form the uart_ops::start_tx, for RX I sort of agree, since this
> happens in interrupt handler. I suppose some drivers could actually
> queue work but not do it right away though?

RX is not the problem. When characters are received all drivers call
tty_flip_buffer_push() which could be used for LED triggering (either
directly or we replace the calls to tty_flip_buffer_push() with some
wrapper function).
The problem comes with TX. The serial core has a FIFO which gets
characters from the tty layer. There is no function which the serial
drivers could call to read from this FIFO, instead they have to open code
this.
Continuing with the 8250 driver serial8250_tx_chars() is not only called
from __start_tx(), but also from the interrupt handler. Transmission
works without the serial_core ever noticing.

> 
> > The LED triggers are registered in uart_add_led_triggers() called from
> > the UART drivers which want to support LED triggers. All the driver
> > has to do then is to call uart_led_trigger_[tx|rx] to indicate
> > activity.
> 
> Could we somehow remedy the lack of knowledge from the core as whether
> the HW sends/receives characters first before adding support for LED
> triggers? It would be more generic and future proof to require UART
> drivers to report to the core when they actually TX/RX, and then at the
> core level, utilize that knowledge to perform the LED trigger.

Maybe we could introduce a function to read from the TX FIFO. Having
open coded this in each and every driver is not nice anyway.

> 
> Side note: are you positive using drv->dev_name is robust enough on
> systems with many different UART drivers, yet all of them being ttyS*?

If we have different UART drivers, only one of them provides ttyS*, no?
Other drivers will have to use another namespace.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
