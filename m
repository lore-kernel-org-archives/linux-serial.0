From: Johan Hovold <jhovold-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: USB: serial: port lifetimes (was: Re: USB Ooops PL2303 when
 unplug while use (linux v3.7.3))
Date: Sat, 23 Feb 2013 17:05:40 +0100
Message-ID: <20130223160540.GB30855@localhost>
References: <Pine.LNX.4.44L0.1302221218270.1365-100000@iolanthe.rowland.org>
 <1361557284.5752.25.camel@thor.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1361557284.5752.25.camel-AsKIXgLx6sE@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>
Cc: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Johan Hovold <jhovold-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On Fri, Feb 22, 2013 at 01:21:24PM -0500, Peter Hurley wrote:
> On Fri, 2013-02-22 at 12:35 -0500, Alan Stern wrote:
> > On Fri, 22 Feb 2013, Johan Hovold wrote:
> ISTM the usb_serial_port private data should not be freed until
> port_release().
> 
> If usb traffic isn't halted until port_release() ...
> 
> static void port_release(struct device *dev)
> {
> 	struct usb_serial_port *port = to_usb_serial_port(dev);
> 	int i;
> 
> 	dev_dbg(dev, "%s\n", __func__);
> 
> 	/*
> 	 * Stop all the traffic before cancelling the work, so that
> 	 * nobody will restart it by calling usb_serial_port_softint.
> 	 */
> ====>	kill_traffic(port);
> 	cancel_work_sync(&port->work);
> 
> then what happens here if ->port_remove() has already been called?

I agree with Alan on this one. In fact, the call to kill_traffic in
port_release is wrong and I'm removing it as part of a disconnect clean
up series I'm preparing.

Exactly when the private port data is freed isn't the main issue here as
the subdrivers mustn't access the ports after the device has been
unregistered, and it's up to tty and usb-serial core to prevent any port
related calls after disconnect.

Johan
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
