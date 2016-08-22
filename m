From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [RFC PATCH 0/3] UART slave device bus
Date: Mon, 22 Aug 2016 10:09:36 +0100
Message-ID: <20160822100936.19fd809f@lxorguk.ukuu.org.uk>
References: <20160818011445.22726-1-robh@kernel.org>
        <20160818202900.hyvm4hfxedifuefn@earth>
        <CAL_Jsq+OfT1AXaEKOgZ4oVfpVZhu=55dYoHTG7D_prpnTqpeOg@mail.gmail.com>
        <20160819052125.ze5zilppwoe3f2lx@earth>
        <ACEF800E-8DB3-4345-ADE2-15C99F3659D5@goldelico.com>
        <20160819120631.5fe2af0d@lxorguk.ukuu.org.uk>
        <61F43885-BE05-482C-9AD6-B52A2DA166B8@goldelico.com>
        <20160820142226.6121e76d@lxorguk.ukuu.org.uk>
        <CC150758-1D16-4BB7-A35B-1A7F4D061C7C@goldelico.com>
        <20160821180910.51cf919d@lxorguk.ukuu.org.uk>
        <FF7761E8-377A-43AD-96B2-83BA140E030B@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <FF7761E8-377A-43AD-96B2-83BA140E030B@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marcel Holtmann <marcel@holtmann.org>, Jiri Slaby <jslaby@suse.com>, Pavel Machek <pavel@ucw.cz>, Peter Hurley <peter@hurleysoftware.com>, NeilBrown <neil@brown.name>, Arnd Bergmann <arnd@arndb.de>, Linus Walleij <linus.walleij@linaro.org>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

> When and how fast is the work queue scheduled?
> And by which event?

That depends upon the platform and how busy the machine is. The dumb
uarts generally schedule it as soon as they've emptied the hardware. Some
controllers it may be done off a timer, others off DMA completion events
 
> > The workqueue involves the receive handler.  
> 
> This should be faster than if a driver directly processes incoming bytes?

It is in cases like n_tty yes and more importantly the serial port can
take another interrupt while the workqueue is running, so you won't drop
bytes if you have flow control.

> Or you have to assemble chunks into a frame, i.e. copy data around.

You have to do a pass over the data anyway to remove any quoting in the
framing for things like SLIP and PPP.

> Both seems a waste of scarce cpu cycles in high-speed situations to me.

The only case that I am aware of where there is a clear inefficiency is
where the hardware is handling characters in big chunks with good
buffering (eg DMA) and we are driving a protocol like PPP which simply
wants to do one pass over the data and stuff it into the network stack.

That one would be nice to fix with the port->rx suggestion I made.

> Which might become the pitfall of the design because as I have described it is an
> essential part of processing UART based protocols. You seem to focus on efficiently
> buffering only but not about efficiently processing the queued data.

There's a good reason for that - latency and throughput are not the same
thing. We need good latency on the buffering but good throughput on the
processing. Also if we fail to queue all the data reliably it doesn't
matter how efficient the processing side is.

> > We do, today for bluetooth and other protocols just fine  
> I think it works (even with user-space HCI daemon) because bluetooth HCI is slow (<300kByte/s).

We do it for PPP over 3G modem as well. Modern 3G modems pretend to be
network devices, older ones didn't - and you are correct that in that
scenario we struggled (it's a lot better since Peter sorted the locking
out to be efficient).

> Yes, but you should also take framing into account for a solution that helps to implement
> UART slave devices. That is my concern.

I understand that I think anyway - you want to know the protocol state in
order to do optimal power management. Use a GPIO edge and assume it's a
'$', pick up via UART from the next byte, power the UART off the moment
you see \n. Leave the power on if you seem to be out of sync so you can
find a '$' and resync.

If you have driver specific code for this your driver gets told when the
line discipline changes so you can actually bury such logic in your low
level driver and even hide what is going on from above. 

I've never had a problemw with what you are doing - just that it needs to
b generic to be upstream, otherwise every serial driver would immediately
develop thousands of lines of code for fifty differently wired and
working phone and IoT devices.

If the tty being open and normal tty operations are acceptable for the
write/configuration side then the point I've been trying to make is you
can't generically handle this at the uart layer. 


At the ldisc layer it would have a slightly higher latency but look
something like (in an NMEA ldisc)


	/* We got newline, tell the port to go into low power mode
	   directly or via whatever helpers it uses and to send us a '$'
	   when it wakes back up if it can't send us the true char */
	if (port->slave) {
		if (ch == '\n')
			port->slave->ops.lowpower(port, '$');
		/* If we get a $ then wakey wakey */
		if (ch == '$')
			port->slave->ops.lowpower(port, 0);
	}
	/* And if ops.lowpower is a no-op it all still works */

That also means that the port->slave-> method would be called in a
workqueue so can do sensible stuff even on things like USB


And the driver would presumably do something like

	name = find_slave_name(blah);	/* From DeviceTree etc */
	if (name)
		port->slave = request_tty_slave(name);

(if you for some reason needed different behaviour knowledge at the slave
level a tty ldisc change does notify the tty_port so we can do that too)


Alan
