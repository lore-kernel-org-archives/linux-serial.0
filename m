From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: Vizzini
Date: Fri, 21 Sep 2012 16:43:23 +0100
Message-ID: <20120921154323.GH18601@kroah.com>
References: <20120919162349.1d9107ba@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:43200 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757915Ab2IUT4N (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 21 Sep 2012 15:56:13 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so3313551pbb.19
        for <linux-serial@vger.kernel.org>; Fri, 21 Sep 2012 12:56:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120919162349.1d9107ba@pyramind.ukuu.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Rob Duncan <rob.duncan@exar.com>
Cc: linux-serial@vger.kernel.org

[Rob added, as he wrote this driver.]

On Wed, Sep 19, 2012 at 04:23:49PM +0100, Alan Cox wrote:
> 
> 	/* This version of the Linux driver source contains a number of
> 	   abominable conditional compilation sections to manage the API
> 	   changes between kernel versions 2.6.18, 2.6.25, and the latest
> 	   (currently 2.6.27).  At some point we'll hand a version of this
> 	   driver off to the mainline Linux source tree, and we'll strip
> 	   all these sections out.  For now it makes it much easier to
> 	   keep it all in sync while the driver is being developed. */

oops, I fixed those up, but forgot to drop this comment, now fixed.

> It doesn't seem to
> 
> #include <linux/usb/cdc.h>
> #ifndef CDC_DATA_INTERFACE_TYPE
> #define CDC_DATA_INTERFACE_TYPE 0x0a
> #endif
> 
> I was wondering why this wasn't using CDC-ACM ?

Yeah, I don't know either.  Rob, any ideas why you can't just use the
cdc-acm driver instead?

> 	struct vizzini_serial_private {
> 		struct usb_interface *data_interface;
> 	};
> 
> Perhaps that can get simplified ?

Will do.

> 	static struct vizzini_baud_rate vizzini_baud_rates[] = {
> 
> Some explanation might be useful ?

Seems to be how they set the baud rate in their chips, a static table
isn't very flexable :(

> 	static int vizzini_set_baud_rate(struct usb_serial_port *port,
> 	
> And the actual rate hould get passed back in the termios
> (tty_termios_encode*)

Ah, missed that.

> 	static void vizzini_set_termios(struct tty_struct *tty_param,
> 					struct usb_serial_port *port,
> 					struct ktermios *old_termios)
> 	{
> 
> 		struct tty_struct       *tty = port->port.tty;
> 
> This mistake is all over the driver. port->port.tty is unsafe as it may
> change under you. That's *why* we pass a safe tty reference that the
> driver then ignores.
> 
> If the driver disable/enable can lose bytes it also needs to figure out
> if a real hardware change has occurred or some apps will get upset.

Yes, I'll go fix those up.

> 	} else if ((cflag & CSIZE) == CS5) {
> 		/* Enabling 5-bit mode is really 9-bit mode! */
> 		format_size = UART_FORMAT_SIZE_9;
> 
> If this is magic hackery for 9bit char then it needs doing properly,
> if it's a clever way to get 5bit then fine.

I don't know, Rob?

> 
> 	} else {
> 		format_size = UART_FORMAT_SIZE_8;
> 	}
> 
> And for unsupported formats we need to report the format we actually
> picked in the tty->termios data.

Good point.

> static int vizzini_ioctl(struct tty_struct *tty, unsigned int cmd, unsigned long arg)
> {
> 	struct usb_serial_port *port = tty->driver_data;
> 	struct vizzini_port_private *portdata = usb_get_serial_port_data(port);
> 	struct serial_struct ss;
> 
> 	dev_dbg(&port->dev, "%s %08x\n", __func__, cmd);
> 
> 	switch (cmd) {
> 	case TIOCGSERIAL:
> 		if (!arg)
> 			return -EFAULT;
> 		memset(&ss, 0, sizeof(ss));
> 		ss.baud_base = portdata->baud_base;
> 
> This leaves lots of fields blank rather than correctly filled in as the
> apps will expect. If we support it then it needs to support it all for
> read even if only writing odd bits.

I'll drop it for now.

> 		if (copy_to_user((void __user *)arg, &ss, sizeof(ss)))
> 			return -EFAULT;
> 		break;
> 
> 	case TIOCSSERIAL:
> 		if (!arg)
> 			return -EFAULT;
> 		if (copy_from_user(&ss, (void __user *)arg, sizeof(ss)))
> 			return -EFAULT;
> 		portdata->baud_base = ss.baud_base;
> 
> Because setting stuff as non superuser without any validation is good.
> Should also support low latency config if we are doing this.

I'll drop it here also.

> 	#ifdef VIZZINI_IWA
> 	static const int vizzini_parity[] = {
> 		0, 1, 1, 0, 1, 0, 0, 1, 1, 0, 0, 1, 0, 1, 1, 0,
> 		1, 0, 0, 1, 0, 1, 1, 0, 0, 1, 1, 0, 1, 0, 0, 1,
> 		1, 0, 0, 1, 0, 1, 1, 0, 0, 1, 1, 0, 1, 0, 0, 1,
> 		0, 1, 1, 0, 1, 0, 0, 1, 1, 0, 0, 1, 0, 1, 1, 0,
> 		1, 0, 0, 1, 0, 1, 1, 0, 0, 1, 1, 0, 1, 0, 0, 1,
> 		0, 1, 1, 0, 1, 0, 0, 1, 1, 0, 0, 1, 0, 1, 1, 0,
> 		0, 1, 1, 0, 1, 0, 0, 1, 1, 0, 0, 1, 0, 1, 1, 0,
> 		1, 0, 0, 1, 0, 1, 1, 0, 0, 1, 1, 0, 1, 0, 0, 1,
> 		1, 0, 0, 1, 0, 1, 1, 0, 0, 1, 1, 0, 1, 0, 0, 1,
> 		0, 1, 1, 0, 1, 0, 0, 1, 1, 0, 0, 1, 0, 1, 1, 0,
> 		0, 1, 1, 0, 1, 0, 0, 1, 1, 0, 0, 1, 0, 1, 1, 0,
> 		1, 0, 0, 1, 0, 1, 1, 0, 0, 1, 1, 0, 1, 0, 0, 1,
> 		0, 1, 1, 0, 1, 0, 0, 1, 1, 0, 0, 1, 0, 1, 1, 0,
> 		1, 0, 0, 1, 0, 1, 1, 0, 0, 1, 1, 0, 1, 0, 0, 1,
> 		1, 0, 0, 1, 0, 1, 1, 0, 0, 1, 1, 0, 1, 0, 0, 1,
> 		0, 1, 1, 0, 1, 0, 0, 1, 1, 0, 0, 1, 0, 1, 1, 0
> 	};
> 	#endif
> 
> Doing parity is something I never bothered with but if we do it then we
> ought to have a helper in the tty core instead. Also it's stupid to use
> ints for this as it just blows more cache. In fact you might as well use
> bits and just test_bit() for parity.

This #define isn't enabled, so I really don't know what is going on.
Rob, any ideas?

> static int vizzini_write_room(struct tty_struct *tty)
> {
> 
> This seems dodgy - it must never report more than it can guarantee will
> fit. If it ever reports 2048 it can't un-report them as free until those
> 2048 bytes are written. Probably it should be using the kfifo code ?

Yes, odds are the whole driver should be using that instead, I'll see
about porting it to the generic serial buffer handling which does this.

> 	buffer = kmalloc(bufsize, GFP_ATOMIC);
> 
> A fifo would also avoid most of these problems as you can just retry
> tidily. This whole path is really ugly to be honest as it gets called
> with irqs off by code expecting the queueing to be fast.

Agreed.

> static void vizzini_in_callback(struct urb *urb)
> {
> 	int endpoint = usb_pipeendpoint(urb->pipe);
> 	struct usb_serial_port *port = urb->context;
> 	struct vizzini_port_private *portdata = usb_get_serial_port_data(port);
> 	struct tty_struct *tty = port->port.tty;
> 
> No kref taken so unsafe, could also be NULL, so you execute
> NULL->functiontptr. Not good on platforms that don't have low memory
> mapping blocked !

Good point.

> 	room = tty_buffer_request_room(tty, length);
> 	if (room != length)
> 		dev_dbg(&port->dev, "Not enough room in TTY buf, dropped %d chars.\n", length - room);
> 
> 	if (room) {
> 
> Not worth checking, just shovel it in - the buffer code will do the work
> and only fail when its really congested and the box is stuffed up. Plus
> your dev_dbg here will deadlock if this is a USB serial console I think ?

Yes, I think it will, but using usb serial consoles is so messy I don't
like thinking about it...

> 	static void vizzini_int_callback(struct urb *urb)
> 	{
> 		struct usb_serial_port *port = urb->context;
> 		struct vizzini_port_private *portdata =
> 		usb_get_serial_port_data(port); struct tty_struct *tty =
> 		port->port.tty;
> 
> Again kref...
> :
> 	dev_dbg(&port->dev, "Resubmitting interrupt IN urb %p\n", urb);
> 	status = usb_submit_urb(urb, GFP_ATOMIC);
> 	if (status)
> 		dev_err(&port->dev, "usb_submit_urb failed with result %d", status);
> 
> Whats the error recovery path for this - a single fail kills the port ?

That's pretty normal for usb-serial drivers, I haven't seen a submit
fail ever, unless the device is removed, so I don't think you need to
worry about it.

> }
> 
> 	static int vizzini_open(struct tty_struct *tty_param, struct
> 	usb_serial_port *port) {
> 		struct vizzini_port_private *portdata;
> 		struct usb_serial *serial = port->serial;
> 		struct tty_struct *tty = port->port.tty;
> 
> Again we pass the tty for a reason !
> 
> 	static void vizzini_close(struct usb_serial_port *port)
> 	{
> 		int                              i;
> 		struct usb_serial               *serial = port->serial;
> 		struct vizzini_port_private     *portdata;
> 		struct tty_struct               *tty    = port->port.tty;
> 
> You can't safelty reference tty from here, but it's not used anyway so
> just kill it off.

Ok I'll fix up both of these.

Thanks so much for the review, I'll work on these, and it would be great
if Rob could answer the above questions as well.

greg k-h
