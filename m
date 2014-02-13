From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: Is tty->receive_room no longer usable w/ SMP?
Date: Wed, 12 Feb 2014 22:56:42 -0500
Message-ID: <52FC427A.8050907@hurleysoftware.com>
References: <ldgte5$kp1$1@ger.gmane.org> <52FC1A14.5080004@hurleysoftware.com> <ldhaiq$jg$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout32.mail01.mtsvc.net ([216.70.64.70]:53055 "EHLO
	n23.mail01.mtsvc.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751320AbaBMD4o (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 12 Feb 2014 22:56:44 -0500
In-Reply-To: <ldhaiq$jg$1@ger.gmane.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Grant Edwards <grant.b.edwards@gmail.com>, linux-serial@vger.kernel.org
Cc: Greg KH <gregkh@linuxfoundation.org>

[ +cc Greg Kroah-Hartman]

On 02/12/2014 09:27 PM, Grant Edwards wrote:
> On 2014-02-13, Peter Hurley <peter@hurleysoftware.com> wrote:
>> On 02/12/2014 05:43 PM, Grant Edwards wrote:
>>> A couple serial drivers I maintain check the value of tty->receive_room
>>> to decide the max number of bytes to pull out of the UART's receive
>>> FIFO and shove into a flip buffer.
>>
>> tty->receive_room is not part of the driver<->tty core interface.
>
> OK, fair enough.  Where is the driver<->tty core interface documented?

Exported functions and the data mentioned in Documentation/serial/tty.txt,
like certain flag bits (eg., TTY_IO_ERROR).

But the documentation could use some modernization. Eg., I don't think
there's any docs on tty_port other than the example in-tree drivers.

>>> After checking tty->receive room to decide how many bytes to read, one
>>> of the drivers uses this sequence:
>>>
>>>    tty_prepare_flip_string_flags(...)
>>         ^^^^^^^^^^^^
>> This was removed for 3.14.
>
> Why?

The tty flip buffer code now uses an encoding method to maximize
memory usage for actual data (when the data is all TTY_NORMAL).
Since there were no in-tree users, it was pointless to rewrite the function.

> What is the replacement?

There isn't one. No in-tree drivers use this function.

>> The use of tty->receive_room by drivers is not supported on any
>> kernel.
>
> Got it.
>
>>> How _should_ a serial driver decide how many rx characters there are
>>> room for?
>>
>> All of the flip buffer functions that reserve/use buffer space return
>> the space reserved/consumed. Is rx overflowing the flip buffers
>> before you can throttle the sender?
>
> Well, it certainly didn't when I used tty->receive_room to decide how
> much data to read from the UART's rx FIFO. :)
>
> I _was_ planning on removing the code that checks tty->receive_room
> and instead rely instead on the return value from
> tty_prepare_flip_string_flags().  But, as you noted, that's gone now.

That's one of the hazards of out-of-tree drivers, for you and for me.
When I'm writing functionality, I can't know if some defunct code is
actually being used in the wild. For you, breakage ensues.

> Is there any documentation explaining how one is supposed to handle rx
> data in a serial driver?  The topic doesn't seem to be mentioned at
> all in Documentation/serial/driver.

This has been and continues to be one of the most active areas of
development with the tty subsystem, especially to support really high
speed tty (50+MB/sec).

> If you can assume all rx data is TTY_NORMAL, then it looks like this
> is the right way to do it:
>
>    n = tty_prepare_flip_string()
>    <copy n data bytes>
>    tty_flip_buffer_push()
>
> What do you do if you can't assume all rx data is going to have a flag
> value of TTY_NORMAL?

ATM (meaning in 3.14-rc1/2) there's no direct replacement for
tty_prepare_flip_string_flags() but see below.

> According to the comments in tty_buffer.c you can't use
> tty_buffer_space_avail(), instead you're supposed to use
> tty_prepare_flip_string(), but you can't use that unless you can
> assume all rx data will be TTY_NORMAL.
>
> Now that tty_prepare_flip_string_flags() is gone, it looks like
> tty_insert_flip_string_flags() is the only option for transferring
> blocks of data/flags.  For that you need to know ahead of time how
> many bytes can be guaranteed to be transferred because once you've
> read data from the UART's rx FIFO it's lost if it can't be
> transferred.
>
> AFAICT, tty_buffer_request_room() can't be used in the case where you
> you're passing a flags buffer: it can only be used to request a buffer
> where all data will be TTY_NORMAL.

Although tty_buffer_request_room() can be used in this situation
(because it does return a buffer suitable for 1/2 data + 1/2 flags),
I'd rather you didn't - see below.

> I've tried transferring one byte/flag pair at a time

Don't do that.

At this point, I would prefer to code up a tty_prepare_flip_string_flags(),
than have out-of-tree drivers hacking things up.

The thing is:
1. I'll have to convince Greg and he's not a fan of out-of-tree drivers :)
2. rc2 is pretty late for an exported function that will have almost no testing.
But I'll do what I can do.

You can help avoid this situation in the future by testing linux-next
(or at least Greg's tty-next tree if you only work on serial stuff) where
these tty buffer changes have been sitting for 2 months (since Dec 8).

Or better yet, submit your driver(s) for in-tree inclusion. That way
the situation doesn't happen in the first place.

Regards,
Peter Hurley
