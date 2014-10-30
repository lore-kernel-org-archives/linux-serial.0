From: Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH] USB: kobil_sct: Remove unused transfer buffer allocs
Date: Thu, 30 Oct 2014 09:08:07 -0400
Message-ID: <54523837.8050700@hurleysoftware.com>
References: <1413482362-14368-1-git-send-email-peter@hurleysoftware.com> <544009D9.3090701@hurleysoftware.com> <20141019171252.GB1992@localhost> <544797A4.5070402@hurleysoftware.com> <20141030120806.GF13062@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141030120806.GF13062@localhost>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Johan Hovold <jhovold-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jiri Slaby <jslaby-AlSwsSmVLrQ@public.gmane.org>, One Thousand Gnomes <gnomes-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

On 10/30/2014 08:08 AM, Johan Hovold wrote:
> Hi Peter,
> 
> Forgot to reply to this one.
> 
> On Wed, Oct 22, 2014 at 07:40:20AM -0400, Peter Hurley wrote:
>> On 10/19/2014 01:12 PM, Johan Hovold wrote:
>>> [ +CC: Jiri, Alan, linux-serial ]
>>>
>>> On Thu, Oct 16, 2014 at 02:09:29PM -0400, Peter Hurley wrote:
>>>> On 10/16/2014 01:59 PM, Peter Hurley wrote:
> 
>>>>> @@ -541,10 +531,6 @@ static int kobil_ioctl(struct tty_struct *tty,
>>>>>  
>>>>>  	switch (cmd) {
>>>>>  	case TCFLSH:
>>>>> -		transfer_buffer = kmalloc(transfer_buffer_length, GFP_KERNEL);
>>>>> -		if (!transfer_buffer)
>>>>> -			return -ENOBUFS;
>>>>> -
>>>>>  		result = usb_control_msg(port->serial->dev,
>>>>>  			  usb_sndctrlpipe(port->serial->dev, 0),
>>>>>  			  SUSBCRequest_Misc,
>>>>> @@ -559,7 +545,6 @@ static int kobil_ioctl(struct tty_struct *tty,
>>>>>  		dev_dbg(&port->dev,
>>>>>  			"%s - Send reset_all_queues (FLUSH) URB returns: %i\n",
>>>>>  			__func__, result);
>>>>> -		kfree(transfer_buffer);
>>>>>  		return (result < 0) ? -EIO: 0;
>>>>                                            ^^^
>>>> Returning 0 is almost certainly wrong; no further processing for
>>>> TCFLSH is performed.
>>>
>>> Indeed.
>>>
>>>> Only this driver returns 0 (of all the tty drivers in mainline).
>>>>
>>>> Returning -ENOIOCTLCMD allows further processing to continue;
>>>> especially the line discipline's input flushing, if TCIFLUSH/TCIOFLUSH.
>>>
>>> That doesn't seem like a very good idea, and only two *staging* drivers
>>> try to play such games (i.e. pretending not to implement the ioctl) as
>>> far as I can see.
>>
>> Well, returning EIONOCTLCMD is the standard method of ioctl passthrough
>> from driver to line discipline.
> 
> I disagree with you there. AFAICS only these two staging drivers are
> abusing the meaning of EIONOCTLCMD (unrecognised ioctl) to have the
> line discipline also act on the ioctl.

Sorry, I wasn't as clear as I should have been here.

My point was that every driver gets ioctl(TCFLSH) and returns ENOIOCTLCMD
so that the line discipline will handle it. You're absolutely correct, in
that, only these drivers (and ipwireless) doing anything with TCFLSH

>> Since driver 'input buffer' flushing is not currently supported by the
>> core, this seems the only available workaround.
> 
> That is true. But I doubt we should use these two staging drivers as a
> model for how this should be handled, if it's at all needed.

Right. My comments implied approval of the design, which I don't.

The main problem with the existing design is that it allows for a
significant variation in how ioctl(WHATEVER) is handled by various
driver/ldisc combinations. That's a bad thing because it makes
audit/review really time-consuming and makes changes prone to userspace
regressions.

Regards,
Peter Hurley
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
