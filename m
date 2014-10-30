From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH] USB: kobil_sct: Remove unused transfer buffer allocs
Date: Thu, 30 Oct 2014 13:08:06 +0100
Message-ID: <20141030120806.GF13062@localhost>
References: <1413482362-14368-1-git-send-email-peter@hurleysoftware.com>
 <544009D9.3090701@hurleysoftware.com>
 <20141019171252.GB1992@localhost>
 <544797A4.5070402@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-lb0-f180.google.com ([209.85.217.180]:39464 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759338AbaJ3MLO (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 30 Oct 2014 08:11:14 -0400
Content-Disposition: inline
In-Reply-To: <544797A4.5070402@hurleysoftware.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Johan Hovold <johan@kernel.org>, Johan Hovold <jhovold@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>

Hi Peter,

Forgot to reply to this one.

On Wed, Oct 22, 2014 at 07:40:20AM -0400, Peter Hurley wrote:
> On 10/19/2014 01:12 PM, Johan Hovold wrote:
> > [ +CC: Jiri, Alan, linux-serial ]
> > 
> > On Thu, Oct 16, 2014 at 02:09:29PM -0400, Peter Hurley wrote:
> >> On 10/16/2014 01:59 PM, Peter Hurley wrote:

> >>> @@ -541,10 +531,6 @@ static int kobil_ioctl(struct tty_struct *tty,
> >>>  
> >>>  	switch (cmd) {
> >>>  	case TCFLSH:
> >>> -		transfer_buffer = kmalloc(transfer_buffer_length, GFP_KERNEL);
> >>> -		if (!transfer_buffer)
> >>> -			return -ENOBUFS;
> >>> -
> >>>  		result = usb_control_msg(port->serial->dev,
> >>>  			  usb_sndctrlpipe(port->serial->dev, 0),
> >>>  			  SUSBCRequest_Misc,
> >>> @@ -559,7 +545,6 @@ static int kobil_ioctl(struct tty_struct *tty,
> >>>  		dev_dbg(&port->dev,
> >>>  			"%s - Send reset_all_queues (FLUSH) URB returns: %i\n",
> >>>  			__func__, result);
> >>> -		kfree(transfer_buffer);
> >>>  		return (result < 0) ? -EIO: 0;
> >>                                            ^^^
> >> Returning 0 is almost certainly wrong; no further processing for
> >> TCFLSH is performed.
> > 
> > Indeed.
> > 
> >> Only this driver returns 0 (of all the tty drivers in mainline).
> >>
> >> Returning -ENOIOCTLCMD allows further processing to continue;
> >> especially the line discipline's input flushing, if TCIFLUSH/TCIOFLUSH.
> > 
> > That doesn't seem like a very good idea, and only two *staging* drivers
> > try to play such games (i.e. pretending not to implement the ioctl) as
> > far as I can see.
> 
> Well, returning EIONOCTLCMD is the standard method of ioctl passthrough
> from driver to line discipline.

I disagree with you there. AFAICS only these two staging drivers are
abusing the meaning of EIONOCTLCMD (unrecognised ioctl) to have the
line discipline also act on the ioctl.

> Since driver 'input buffer' flushing is not currently supported by the
> core, this seems the only available workaround.

That is true. But I doubt we should use these two staging drivers as a
model for how this should be handled, if it's at all needed.

> > The only non-staging tty driver which appears to implement TCFLSH,
> > ipwireless, calls tty_perform_flush directly to flush the ldisc buffers.
> > That doesn't seem right either.
> 
> I'm not sure why ipwireless does this; I can only guess that it's a
> workaround for some line discipline that doesn't use n_tty_ioctl_helper().
> 
> > Shouldn't this be fixed by removing TCFLSH from these tty drivers'
> > ioctl callbacks and implementing flush_buffer()?
> >
> > The staging drivers also flush a device input buffer, which could be
> > done in a new callback if at all needed.
> 
> Yeah, that's why the Digi staging drivers are trapping TCFLSH; so they
> can clear input buffers on TCIFLUSH/TCIOFLUSH.
> 
> I'd like to better understand the hardware and driver before extending
> the core interface; this driver may not even run.

Agreed.

> For example, this driver clears its 'input buffer' for
> tcsetattr(TCSADRAIN or TCSAFLUSH). But that doesn't make sense considering
> that the flip buffers could have data in them that isn't flushed; the tty
> core doesn't dump the flip buffers because 'input processing' has not
> happened on that data.
> 
> I think when/if these drivers are promoted is when/if the core interface
> should address this. Just my opinion, though :)

I agree.

Johan
