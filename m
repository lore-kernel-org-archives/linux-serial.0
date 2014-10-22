From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH] USB: kobil_sct: Remove unused transfer buffer allocs
Date: Wed, 22 Oct 2014 07:40:20 -0400
Message-ID: <544797A4.5070402@hurleysoftware.com>
References: <1413482362-14368-1-git-send-email-peter@hurleysoftware.com> <544009D9.3090701@hurleysoftware.com> <20141019171252.GB1992@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout32.mail01.mtsvc.net ([216.70.64.70]:41359 "EHLO
	n23.mail01.mtsvc.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932764AbaJVLkZ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 22 Oct 2014 07:40:25 -0400
In-Reply-To: <20141019171252.GB1992@localhost>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Johan Hovold <johan@kernel.org>
Cc: Johan Hovold <jhovold@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>

On 10/19/2014 01:12 PM, Johan Hovold wrote:
> [ +CC: Jiri, Alan, linux-serial ]
> 
> On Thu, Oct 16, 2014 at 02:09:29PM -0400, Peter Hurley wrote:
>> On 10/16/2014 01:59 PM, Peter Hurley wrote:
>>> Commit 90419cfcb5d9c889b10dc51363c56a4d394d670e,
>>> "USB: kobil_sct: fix control requests without data stage", removed
>>> the bogus data buffer arguments, but still allocate transfer
>>> buffers which are not used.
>>>
>>> Cc: Johan Hovold <jhovold@gmail.com>
>>> Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
>>> ---
>>>  drivers/usb/serial/kobil_sct.c | 15 ---------------
>>>  1 file changed, 15 deletions(-)
>>>
>>> diff --git a/drivers/usb/serial/kobil_sct.c b/drivers/usb/serial/kobil_sct.c
>>> index 078f9ed..3d2bd65 100644
>>> --- a/drivers/usb/serial/kobil_sct.c
>>> +++ b/drivers/usb/serial/kobil_sct.c
>>> @@ -414,8 +414,6 @@ static int kobil_tiocmset(struct tty_struct *tty,
>>>  	int result;
>>>  	int dtr = 0;
>>>  	int rts = 0;
>>> -	unsigned char *transfer_buffer;
>>> -	int transfer_buffer_length = 8;
>>>  
>>>  	/* FIXME: locking ? */
>>>  	priv = usb_get_serial_port_data(port);
>>> @@ -425,11 +423,6 @@ static int kobil_tiocmset(struct tty_struct *tty,
>>>  		return -EINVAL;
>>>  	}
>>>  
>>> -	/* allocate memory for transfer buffer */
>>> -	transfer_buffer = kzalloc(transfer_buffer_length, GFP_KERNEL);
>>> -	if (!transfer_buffer)
>>> -		return -ENOMEM;
>>> -
>>>  	if (set & TIOCM_RTS)
>>>  		rts = 1;
>>>  	if (set & TIOCM_DTR)
>>> @@ -469,7 +462,6 @@ static int kobil_tiocmset(struct tty_struct *tty,
>>>  			KOBIL_TIMEOUT);
>>>  	}
>>>  	dev_dbg(dev, "%s - Send set_status_line URB returns: %i\n", __func__, result);
>>> -	kfree(transfer_buffer);
>>>  	return (result < 0) ? result : 0;
>>>  }
>>>  
>>> @@ -530,8 +522,6 @@ static int kobil_ioctl(struct tty_struct *tty,
>>>  {
>>>  	struct usb_serial_port *port = tty->driver_data;
>>>  	struct kobil_private *priv = usb_get_serial_port_data(port);
>>> -	unsigned char *transfer_buffer;
>>> -	int transfer_buffer_length = 8;
>>>  	int result;
>>>  
>>>  	if (priv->device_type == KOBIL_USBTWIN_PRODUCT_ID ||
>>> @@ -541,10 +531,6 @@ static int kobil_ioctl(struct tty_struct *tty,
>>>  
>>>  	switch (cmd) {
>>>  	case TCFLSH:
>>> -		transfer_buffer = kmalloc(transfer_buffer_length, GFP_KERNEL);
>>> -		if (!transfer_buffer)
>>> -			return -ENOBUFS;
>>> -
>>>  		result = usb_control_msg(port->serial->dev,
>>>  			  usb_sndctrlpipe(port->serial->dev, 0),
>>>  			  SUSBCRequest_Misc,
>>> @@ -559,7 +545,6 @@ static int kobil_ioctl(struct tty_struct *tty,
>>>  		dev_dbg(&port->dev,
>>>  			"%s - Send reset_all_queues (FLUSH) URB returns: %i\n",
>>>  			__func__, result);
>>> -		kfree(transfer_buffer);
>>>  		return (result < 0) ? -EIO: 0;
>>                                            ^^^
>> Returning 0 is almost certainly wrong; no further processing for
>> TCFLSH is performed.
> 
> Indeed.
> 
>> Only this driver returns 0 (of all the tty drivers in mainline).
>>
>> Returning -ENOIOCTLCMD allows further processing to continue;
>> especially the line discipline's input flushing, if TCIFLUSH/TCIOFLUSH.
> 
> That doesn't seem like a very good idea, and only two *staging* drivers
> try to play such games (i.e. pretending not to implement the ioctl) as
> far as I can see.

Well, returning EIONOCTLCMD is the standard method of ioctl passthrough
from driver to line discipline.

Since driver 'input buffer' flushing is not currently supported by the
core, this seems the only available workaround.

> The only non-staging tty driver which appears to implement TCFLSH,
> ipwireless, calls tty_perform_flush directly to flush the ldisc buffers.
> That doesn't seem right either.

I'm not sure why ipwireless does this; I can only guess that it's a
workaround for some line discipline that doesn't use n_tty_ioctl_helper().

> Shouldn't this be fixed by removing TCFLSH from these tty drivers'
> ioctl callbacks and implementing flush_buffer()?
>
> The staging drivers also flush a device input buffer, which could be
> done in a new callback if at all needed.

Yeah, that's why the Digi staging drivers are trapping TCFLSH; so they
can clear input buffers on TCIFLUSH/TCIOFLUSH.

I'd like to better understand the hardware and driver before extending
the core interface; this driver may not even run.

For example, this driver clears its 'input buffer' for
tcsetattr(TCSADRAIN or TCSAFLUSH). But that doesn't make sense considering
that the flip buffers could have data in them that isn't flushed; the tty
core doesn't dump the flip buffers because 'input processing' has not
happened on that data.

I think when/if these drivers are promoted is when/if the core interface
should address this. Just my opinion, though :)

>> Is it trying to avoid the tty_driver_flush_buffer() because it doesn't
>> have an output buffer?
> 
> I don't think so. The author probably just assumed returning 0 for a
> "handled" ioctl was the right thing to do.
> 
> I'll add flush_buffer support to usb-serial and fix up kobil_sct
> meanwhile.

Thanks.

Regards,
Peter Hurley

