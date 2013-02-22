From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: USB: serial: port lifetimes (was: Re: USB Ooops PL2303 when
 unplug while use (linux v3.7.3))
Date: Fri, 22 Feb 2013 13:57:44 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1302221348180.1220-100000@iolanthe.rowland.org>
References: <1361557284.5752.25.camel@thor.lan>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1361557284.5752.25.camel-AsKIXgLx6sE@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>
Cc: Johan Hovold <jhovold-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On Fri, 22 Feb 2013, Peter Hurley wrote:

> ISTM the usb_serial_port private data should not be freed until
> port_release().

I don't think that's right.  In general, a driver doesn't know what's 
going to happen to a device after the two are unbound from each other.  
Another driver may get bound to that same device, and may overwrite the 
old private-data pointer with its own new one.

The same reasoning applies here.  The serial subdriver isn't involved 
in the creation of the usb_serial_port structure, and therefore it 
shouldn't be involved in that structure's destruction.

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
> 
> static void garmin_write_bulk_callback(struct urb *urb)
> {
> 	struct usb_serial_port *port = urb->context;
> 
> 	if (port) {
> 		struct garmin_data *garmin_data_p =
> 					usb_get_serial_port_data(port);
> 
> 		if (GARMIN_LAYERID_APPL == getLayerId(urb->transfer_buffer)) {
> 
> ====>			if (garmin_data_p->mode == MODE_GARMIN_SERIAL) {
> 				gsp_send_ack(garmin_data_p,
> 					((__u8 *)urb->transfer_buffer)[4]);
> 			}

Clearly this is a mistake.  Probably it is the result of historical
confusion between the overall USB device and the multiple serial ports
embodied within it.  At any rate, it is clear that all port-related USB
activity should be stopped when the port is unregistered.

Whether this can be carried out by the usb-serial core or needs help 
from the subdriver, I leave up to you guys.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
