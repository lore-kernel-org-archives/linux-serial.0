From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] tty: implement a rx led trigger
Date: Thu, 3 May 2018 13:52:27 +0200
Message-ID: <20180503115227.gogvknx5sbuyrcey@pengutronix.de>
References: <20180503100448.1350-1-u.kleine-koenig@pengutronix.de>
 <20180503101047.GF32180@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180503101047.GF32180@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Florian Fainelli <f.fainelli@gmail.com>, linux-serial@vger.kernel.org, Mathieu Poirier <mathieu.poirier@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Thu, May 03, 2018 at 12:10:47PM +0200, Pavel Machek wrote:
> Hi!
> 
> > The trigger fires when data is pushed to the ldisc. This is a bit later
> > than the actual receiving of data but has the nice benefit that it
> > doesn't need adaption for each driver and isn't in the hot path.
> > 
> > Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> 
> Well, why not, but there certainly should be config option? Because I
> really don't see many people wanting to use this trigger.

Yeah, can be done. I'll implement this for v2.

> > diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
> > index c996b6859c5e..4d364b77b1a7 100644
> > --- a/drivers/tty/tty_buffer.c
> > +++ b/drivers/tty/tty_buffer.c
> > @@ -17,6 +17,7 @@
> >  #include <linux/delay.h>
> >  #include <linux/module.h>
> >  #include <linux/ratelimit.h>
> > +#include <linux/leds.h>
> >  
> >  
> >  #define MIN_TTYB_SIZE	256
> > @@ -499,6 +500,7 @@ static void flush_to_ldisc(struct work_struct *work)
> >  		struct tty_buffer *head = buf->head;
> >  		struct tty_buffer *next;
> >  		int count;
> > +		unsigned long delay = 50 /* ms */;
> >  
> >  		/* Ldisc or user is trying to gain exclusive access */
> >  		if (atomic_read(&buf->priority))
> > @@ -521,6 +523,8 @@ static void flush_to_ldisc(struct work_struct *work)
> >  			continue;
> >  		}
> >  
> > +		led_trigger_blink_oneshot(port->led_trigger_rx, &delay, &delay, 0);
> > +
> >  		count = receive_buf(port, head, count);
> >  		if (!count)
> >  			break;
> > diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
> > index 25d736880013..51b78a585417 100644
> > --- a/drivers/tty/tty_port.c
> > +++ b/drivers/tty/tty_port.c
> > @@ -16,6 +16,7 @@
> >  #include <linux/wait.h>
> >  #include <linux/bitops.h>
> >  #include <linux/delay.h>
> > +#include <linux/leds.h>
> >  #include <linux/module.h>
> >  #include <linux/serdev.h>
> >  
> > @@ -157,6 +158,18 @@ struct device *tty_port_register_device_attr_serdev(struct tty_port *port,
> >  
> >  	tty_port_link_device(port, driver, index);
> >  
> > +	port->led_trigger_rx_name = kasprintf(GFP_KERNEL, "%s%d-rx",
> > +					      driver->name, index);
> > +	if (!port->led_trigger_rx_name) {
> > +		pr_err("Failed to allocate trigger name for %s%d\n",
> > +		       driver->name, index);
> > +		goto skip_trigger;
> > +	}
> > +
> > +	led_trigger_register_simple(port->led_trigger_rx_name,
> > +				    &port->led_trigger_rx);
> > +
> > +skip_trigger:
> >  	dev = serdev_tty_port_register(port, device, driver, index);
> >  	if (PTR_ERR(dev) != -ENODEV) {
> >  		/* Skip creating cdev if we registered a serdev device */
> > @@ -206,6 +219,9 @@ void tty_port_unregister_device(struct tty_port *port,
> >  	if (ret == 0)
> >  		return;
> >  
> > +	led_trigger_unregister_simple(port->led_trigger_rx);
> 
> Is it ok to unregister if it was not registered in the first place?

led_trigger_unregister_simple() looks as follows:

	if (trig)
		led_trigger_unregister(trig);
	kfree(trig);

So yes, it does the right thing when it wasn't registered. Assuming it
is NULL then, which doesn't seem to be guaranteed. Probably I'd need

	port->led_trigger_rx = NULL
	
if kasprintf failed.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
