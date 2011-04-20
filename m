From: John Linn <John.Linn@xilinx.com>
Subject: RE: [PATCH] tty/serial: add support for Xilinx PS UART
Date: Wed, 20 Apr 2011 09:19:22 -0600
Message-ID: <bde1ee6b-79a8-46f9-a8a3-38a91e51f1c3@VA3EHSMHS019.ehs.local>
References: <e35578a9-909d-4594-bbe4-41d89b5f9b3e@VA3EHSMHS014.ehs.local> <20110419221530.7370d013@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from va3ehsobe006.messaging.microsoft.com ([216.32.180.16]:53844
	"EHLO VA3EHSOBE009.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753468Ab1DTPTj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 20 Apr 2011 11:19:39 -0400
Content-Class: urn:content-classes:message
In-Reply-To: <20110419221530.7370d013@lxorguk.ukuu.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

> -----Original Message-----
> From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk]
> Sent: Tuesday, April 19, 2011 3:16 PM
> To: John Linn
> Cc: linux-kernel@vger.kernel.org; linux-serial@vger.kernel.org
> Subject: Re: [PATCH] tty/serial: add support for Xilinx PS UART
> 
> On Tue, 19 Apr 2011 14:14:52 -0600
> John Linn <john.linn@xilinx.com> wrote:
> 
> > The Xilinx PS Uart is used on the new ARM based SoC. This
> > UART is not compatible with others such that a seperate
> > driver is required.
> 
> Joyous. I wish people would standardise.
> 
> > +		 213 = /dev/ttyPS0		Xilinx PS serial port 0
> > +		 214 = /dev/ttyPS1		Xilinx PS serial port 1
> > +		 215 = /dev/ttyPS2		Xilinx PS serial port 2
> > +		 216 = /dev/ttyPS3		Xilinx PS serial port 3
> 
> Is there a specific reason you need fixed minor numbers ? If not
please
> use a dynamic range and keep Linus happy.
> 
> > +/**
> > + * xuartps_isr - Interrupt handler
> > + * @irq: Irq number
> > + * @dev_id: Id of the port
> > + *
> > + * Returns IRQHANDLED
> > + **/
> > +static irqreturn_t xuartps_isr(int irq, void *dev_id)
> > +{
> > +	struct uart_port *port = (struct uart_port *)dev_id;
> > +	struct tty_struct *tty = port->state->port.tty;
> > +	unsigned long flags;
> > +	unsigned int isrstatus, numbytes;
> > +	unsigned int data;
> > +	char status = TTY_NORMAL;
> > +
> > +	spin_lock_irqsave(&port->lock, flags);
> 
> The ttys are refcounting now and your locking subtly wrong if you want
> to
> avoid it (you lookup port-> stuff before you lock it)
> 
> The best way to do this is
> 
> 	tty = tty_port_tty_get(&port->state->port);
> 
> 	/* Returns a tty with reference or NULL */
> 
> 	Do stuff
> 
> 	tty_kref_put(tty);

I see the subtle locking issue you mention.

This looks like a good way to help it, but it's not clear to me what to
do in an isr 
if the function returns a NULL for the tty.  In other places you can say
the tty
was busy, but in an ISR that doesn't make much sense (to me anyway).

It seems easier in this case to just move the tty =
port->state->port.tty to after 
the lock is acquired.

I'm sure there's something obvious I'm missing here.

Thanks,
John

This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.


