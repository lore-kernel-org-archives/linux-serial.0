From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Vizzini
Date: Wed, 19 Sep 2012 16:23:49 +0100
Message-ID: <20120919162349.1d9107ba@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:36338 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754276Ab2ISPS5 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 19 Sep 2012 11:18:57 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: greg@kroah.com, linux-serial@vger.kernel.org


	/* This version of the Linux driver source contains a number of
	   abominable conditional compilation sections to manage the API
	   changes between kernel versions 2.6.18, 2.6.25, and the latest
	   (currently 2.6.27).  At some point we'll hand a version of this
	   driver off to the mainline Linux source tree, and we'll strip
	   all these sections out.  For now it makes it much easier to
	   keep it all in sync while the driver is being developed. */


It doesn't seem to

#include <linux/usb/cdc.h>
#ifndef CDC_DATA_INTERFACE_TYPE
#define CDC_DATA_INTERFACE_TYPE 0x0a
#endif

I was wondering why this wasn't using CDC-ACM ?


	struct vizzini_serial_private {
		struct usb_interface *data_interface;
	};

Perhaps that can get simplified ?

	static struct vizzini_baud_rate vizzini_baud_rates[] = {

Some explanation might be useful ?

	static int vizzini_set_baud_rate(struct usb_serial_port *port,
	
And the actual rate hould get passed back in the termios
(tty_termios_encode*)


	static void vizzini_set_termios(struct tty_struct *tty_param,
					struct usb_serial_port *port,
					struct ktermios *old_termios)
	{

		struct tty_struct       *tty = port->port.tty;

This mistake is all over the driver. port->port.tty is unsafe as it may
change under you. That's *why* we pass a safe tty reference that the
driver then ignores.

If the driver disable/enable can lose bytes it also needs to figure out
if a real hardware change has occurred or some apps will get upset.


	} else if ((cflag & CSIZE) == CS5) {
		/* Enabling 5-bit mode is really 9-bit mode! */
		format_size = UART_FORMAT_SIZE_9;

If this is magic hackery for 9bit char then it needs doing properly,
if it's a clever way to get 5bit then fine.


	} else {
		format_size = UART_FORMAT_SIZE_8;
	}

And for unsupported formats we need to report the format we actually
picked in the tty->termios data.


static int vizzini_ioctl(struct tty_struct *tty, unsigned int cmd, unsigned long arg)
{
	struct usb_serial_port *port = tty->driver_data;
	struct vizzini_port_private *portdata = usb_get_serial_port_data(port);
	struct serial_struct ss;

	dev_dbg(&port->dev, "%s %08x\n", __func__, cmd);

	switch (cmd) {
	case TIOCGSERIAL:
		if (!arg)
			return -EFAULT;
		memset(&ss, 0, sizeof(ss));
		ss.baud_base = portdata->baud_base;

This leaves lots of fields blank rather than correctly filled in as the
apps will expect. If we support it then it needs to support it all for
read even if only writing odd bits.

		if (copy_to_user((void __user *)arg, &ss, sizeof(ss)))
			return -EFAULT;
		break;

	case TIOCSSERIAL:
		if (!arg)
			return -EFAULT;
		if (copy_from_user(&ss, (void __user *)arg, sizeof(ss)))
			return -EFAULT;
		portdata->baud_base = ss.baud_base;

Because setting stuff as non superuser without any validation is good.
Should also support low latency config if we are doing this.


	#ifdef VIZZINI_IWA
	static const int vizzini_parity[] = {
		0, 1, 1, 0, 1, 0, 0, 1, 1, 0, 0, 1, 0, 1, 1, 0,
		1, 0, 0, 1, 0, 1, 1, 0, 0, 1, 1, 0, 1, 0, 0, 1,
		1, 0, 0, 1, 0, 1, 1, 0, 0, 1, 1, 0, 1, 0, 0, 1,
		0, 1, 1, 0, 1, 0, 0, 1, 1, 0, 0, 1, 0, 1, 1, 0,
		1, 0, 0, 1, 0, 1, 1, 0, 0, 1, 1, 0, 1, 0, 0, 1,
		0, 1, 1, 0, 1, 0, 0, 1, 1, 0, 0, 1, 0, 1, 1, 0,
		0, 1, 1, 0, 1, 0, 0, 1, 1, 0, 0, 1, 0, 1, 1, 0,
		1, 0, 0, 1, 0, 1, 1, 0, 0, 1, 1, 0, 1, 0, 0, 1,
		1, 0, 0, 1, 0, 1, 1, 0, 0, 1, 1, 0, 1, 0, 0, 1,
		0, 1, 1, 0, 1, 0, 0, 1, 1, 0, 0, 1, 0, 1, 1, 0,
		0, 1, 1, 0, 1, 0, 0, 1, 1, 0, 0, 1, 0, 1, 1, 0,
		1, 0, 0, 1, 0, 1, 1, 0, 0, 1, 1, 0, 1, 0, 0, 1,
		0, 1, 1, 0, 1, 0, 0, 1, 1, 0, 0, 1, 0, 1, 1, 0,
		1, 0, 0, 1, 0, 1, 1, 0, 0, 1, 1, 0, 1, 0, 0, 1,
		1, 0, 0, 1, 0, 1, 1, 0, 0, 1, 1, 0, 1, 0, 0, 1,
		0, 1, 1, 0, 1, 0, 0, 1, 1, 0, 0, 1, 0, 1, 1, 0
	};
	#endif

Doing parity is something I never bothered with but if we do it then we
ought to have a helper in the tty core instead. Also it's stupid to use
ints for this as it just blows more cache. In fact you might as well use
bits and just test_bit() for parity.


static int vizzini_write_room(struct tty_struct *tty)
{

This seems dodgy - it must never report more than it can guarantee will
fit. If it ever reports 2048 it can't un-report them as free until those
2048 bytes are written. Probably it should be using the kfifo code ?


	buffer = kmalloc(bufsize, GFP_ATOMIC);

A fifo would also avoid most of these problems as you can just retry
tidily. This whole path is really ugly to be honest as it gets called
with irqs off by code expecting the queueing to be fast.





static void vizzini_in_callback(struct urb *urb)
{
	int endpoint = usb_pipeendpoint(urb->pipe);
	struct usb_serial_port *port = urb->context;
	struct vizzini_port_private *portdata = usb_get_serial_port_data(port);
	struct tty_struct *tty = port->port.tty;

No kref taken so unsafe, could also be NULL, so you execute
NULL->functiontptr. Not good on platforms that don't have low memory
mapping blocked !

	room = tty_buffer_request_room(tty, length);
	if (room != length)
		dev_dbg(&port->dev, "Not enough room in TTY buf, dropped %d chars.\n", length - room);

	if (room) {

Not worth checking, just shovel it in - the buffer code will do the work
and only fail when its really congested and the box is stuffed up. Plus
your dev_dbg here will deadlock if this is a USB serial console I think ?


	static void vizzini_int_callback(struct urb *urb)
	{
		struct usb_serial_port *port = urb->context;
		struct vizzini_port_private *portdata =
		usb_get_serial_port_data(port); struct tty_struct *tty =
		port->port.tty;

Again kref...
:
	dev_dbg(&port->dev, "Resubmitting interrupt IN urb %p\n", urb);
	status = usb_submit_urb(urb, GFP_ATOMIC);
	if (status)
		dev_err(&port->dev, "usb_submit_urb failed with result %d", status);

Whats the error recovery path for this - a single fail kills the port ?

}

	static int vizzini_open(struct tty_struct *tty_param, struct
	usb_serial_port *port) {
		struct vizzini_port_private *portdata;
		struct usb_serial *serial = port->serial;
		struct tty_struct *tty = port->port.tty;

Again we pass the tty for a reason !

	static void vizzini_close(struct usb_serial_port *port)
	{
		int                              i;
		struct usb_serial               *serial = port->serial;
		struct vizzini_port_private     *portdata;
		struct tty_struct               *tty    = port->port.tty;

You can't safelty reference tty from here, but it's not used anyway so
just kill it off.


	portdata = usb_get_serial_port_data(port);

	acm_set_control(port, portdata->ctrlout = 0);

	if (serial->dev) {
		/* Stop reading/writing urbs */
		for (i = 0; i < N_IN_URB; i++)
			usb_kill_urb(portdata->in_urbs[i]);
	}

	usb_kill_urb(port->interrupt_in_urb);

	tty = NULL; /* FIXME */


Alan
