From: Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>
Subject: Re: USB Ooops PL2303 when unplug while use (linux v3.7.3)
Date: Wed, 13 Feb 2013 13:40:08 -0500
Message-ID: <1360780808.8499.43.camel@thor.lan>
References: <510B2C09.7020700@gtsys.com.hk>
	 <20130213142513.GA21078@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130213142513.GA21078@localhost>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Johan Hovold <jhovold-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Chris Ruehl <chris.ruehl-CR359r9tUDPXPF5Rlphj1Q@public.gmane.org>, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On Wed, 2013-02-13 at 15:25 +0100, Johan Hovold wrote:
> On Fri, Feb 01, 2013 at 10:44:25AM +0800, Chris Ruehl wrote:
> > I file a report for you, please have a look when you have time.
> 
> Thanks for the bug report, Chris.
> 
> You have come across what looks like a known issue, which since it's
> discovery last summer has been made worse by an unrelated change.
> 
> A similar oops was reported and its cause identified in this thread:
> 
> 	http://marc.info/?l=linux-usb&m=133837337927749&w=2
> 
> It turns out that the tty-layer may call the driver's dtr_rts even after
> the device has been disconnected and the tty device unregistered. Since
> last summer another change has made the problem worse by setting the
> port data to NULL which results in even more drivers hitting the
> problem.

The tty driver's close() routine must be called even if the open()
failed because the tty layer doesn't know if the driver left unfinished
business and is expecting to receive a close() to cleanup even if it
failed the open(). This behavior was just recently documented in
include/linux/tty_driver.h (ie., is in linux-next).

> While waiting for input from the tty-guru Alan Cox, and as the immediate
> cause of that oops was remedied (by moving the offending interface
> access in the driver in question), the problem was unfortunately
> forgotten (or rather down-prioritised) until now.

Looks to me like a bug the usb serial mini-port interface design.
A usb bus disconnect has the pl2303 (and every other) mini-port freeing
the private data (before unregistering with tty anyway -- not that
putting that first would fix the problem).

static int usb_serial_device_remove(struct device *dev)
{
	struct usb_serial_driver *driver;
	struct usb_serial_port *port;
	int retval = 0;
	int minor;

	port = to_usb_serial_port(dev);
	if (!port)
		return -ENODEV;

	/* make sure suspend/resume doesn't race against port_remove */
	usb_autopm_get_interface(port->serial->interface);

	device_remove_file(&port->dev, &dev_attr_port_number);

	driver = port->serial->type;
	if (driver->port_remove)
====>		retval = driver->port_remove(port);

	minor = port->number;
	tty_unregister_device(usb_serial_tty_driver, minor);
	dev_info(dev, "%s converter now disconnected from ttyUSB%d\n",
		 driver->description, minor);

	usb_autopm_put_interface(port->serial->interface);
	return retval;
}

The pl2303 mini-port dutifully:

static int pl2303_port_remove(struct usb_serial_port *port)
{
	struct pl2303_private *priv;

	priv = usb_get_serial_port_data(port);
===>	kfree(priv);

	return 0;
}

while the tty layer still has outstanding references to the port.

static void pl2303_dtr_rts(struct usb_serial_port *port, int on)
{
=====>	struct pl2303_private *priv = usb_get_serial_port_data(port);
	unsigned long flags;
	u8 control;

	[...]


The tty layer (and its port implementation) can't protect the pl2303
mini-port from this behavior/interface design.

It's the glue layer's responsibility to correctly manage the differing
lifetimes of its bus devices with tty devices (and tty_ports, if used).

Meaning, that if the physical device disconnects from the bus, the ports
must simply become in-operative; they can't disappear.

BTW, just fixing this one part won't work because the usb serial driver
is also abruptly deleting the usb_serial_port device as well:

static void usb_serial_disconnect(struct usb_interface *interface)
{
	[...]

	for (i = 0; i < serial->num_ports; ++i) {
		port = serial->port[i];
		if (port) {
			struct tty_struct *tty = tty_port_tty_get(&port->port);
			if (tty) {
				tty_vhangup(tty);
				tty_kref_put(tty);
			}
			kill_traffic(port);
			cancel_work_sync(&port->work);
			if (device_is_registered(&port->dev))
========>			device_del(&port->dev);
		}
	}
	
	[...]
}

Ummm, wasn't that where the port private data pointer was?

Regards,
Peter Hurley

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
