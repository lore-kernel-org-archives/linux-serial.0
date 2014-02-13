From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: Is tty->receive_room no longer usable w/ SMP?
Date: Thu, 13 Feb 2014 10:30:14 -0500
Message-ID: <52FCE506.2040801@hurleysoftware.com>
References: <ldgte5$kp1$1@ger.gmane.org> <52FC1A14.5080004@hurleysoftware.com> <ldhaiq$jg$1@ger.gmane.org> <52FC427A.8050907@hurleysoftware.com> <ldhlpd$bbr$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout32.mail01.mtsvc.net ([216.70.64.70]:57700 "EHLO
	n23.mail01.mtsvc.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751071AbaBMPaR (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 13 Feb 2014 10:30:17 -0500
In-Reply-To: <ldhlpd$bbr$1@ger.gmane.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Grant Edwards <grant.b.edwards@gmail.com>, linux-serial@vger.kernel.org

On 02/13/2014 12:38 AM, Grant Edwards wrote:
> On 2014-02-13, Peter Hurley <peter@hurleysoftware.com> wrote:
>>> If you can assume all rx data is TTY_NORMAL, then it looks like this
>>> is the right way to do it:
>>>
>>>     n = tty_prepare_flip_string()
>>>     <copy n data bytes>
>>>     tty_flip_buffer_push()
>
> Should I assume that this is the preferred method if I can know that I
> have a specific amount of TTY_NORMAL data available?

Yes.

>>> I've tried transferring one byte/flag pair at a time
>>
>> Don't do that.
>
> I'll have to do a little more investigating, but I think I can detect
> the case where there are no error flags present in the rx FIFO, so I
> can use the prepare/push method when that's true (which it should be
> the vast majority of the time).
>
> If I can do that, then I think I could live with tty_insert_char() in
> the much rarer case where there are errors present -- but I still need
> to know if there's room to insert a byte before reading the byte/flag
> from the rx FIFO and subsequently calling tty_insert_char().

Ok.

> That's the part I don't understand:
>
> How are drivers that use tty_insert_char() supposed to know when to
> stop calling it?  tty_insert_char() doesn't return a status, so you
> don't know even after the fact if the byte you just passed was
> accepted. Do you?

What tree are you looking at?

include/linux/tty_flip.h:tty_insert_flip_char() takes 1 byte and 1 flag
and returns how many bytes were consumed (ie., 0 or 1). If it returned
0, the data was not accepted.

> Similarly, how are drivers that use tty_insert_flip_string_flags()
> supposed to know how much data they can pass to it?

Drivers pass _all_ of the rx data to tty_insert_flip_string_flags(),
which returns how much was accepted. Eg.,

         c = tty_insert_flip_string_flags(&my_port->port, rx_data, flags, n_rx);
         if (c < 0) {
                 /* actual error - none of the data was taken up */
         }
         if (c < n_rx) {
                 /* tty buffer did not take up all the data */
         }

> Are they expected to keep reading data from the rx FIFO and passing it
> to tty_insert_flip_string_flags() until it returns a value smaller
> than the requested transfer size and then buffer the "overflow" data
> that has already been read from the rx FIFO but not accepted by
> tty_insert_flip_string_flags()?  Then at some point in the future you
> retry the old, buffered data, and once that's all been transferred you
> start reading from the rx FIFO again? That would work, but it's a
> little ugly.

While this approach is possible, there is another way to look at
this problem:

The tty buffers are very deep (at least 64K+, as high as 128K).
If data can't be taken in but the sender has not yet been throttled,
then some error is occurring. Rather than buffering data
outside the tty buffers (because eventually that will run out too
causing a fifo overflow), just drop the current rx and signal a
condition to insert a TTY_OVERRUN at the beginning of the next rx
(look at drivers/staging/fwserial/fwserial.c:fwtty_rx() -- but
don't use tty_buffer_space_avail() throttling part; that's only
for very high speeds where the tty buffers can overflow even
before the input processing worker runs).

In addition, the tty buffer space is now configurable per-port at
initialization time, so you could monitor the tty_buffer_space_avail()
at each rx time and if it is below a given watermark, emit a
diagnostic. Then update your driver to add more buffer space and/or
look to see if there is some other problem further in the rx chain,
like the app not pulling enough data per read, etc.

You could use this monitoring purely in testing or continue to use
it in the wild, so if there is some previously unknown high watermark,
you're alerted and can fix it without there having been data loss.

> Looking at existing in-tree users of tty_insert_flip_string_flags(),
> they call tty_buffer_request_room() to determine how many char/flag
> pairs can be transferred and then depend on the assumption that
> tty_insert_flip_string_flags() will accept that much. I didn't think
> that was valid because tty_buffer_request_room() assumes you're not
> going to transfer flags -- doesn't it?
>
> I must be missing something.

tty_buffer_request_room() returns a buffer suitable for data + flags;
you're just misreading the code.

>> At this point, I would prefer to code up a
>> tty_prepare_flip_string_flags(), than have out-of-tree drivers
>> hacking things up.
>
> I would be perfectly happy using tty_insert_flip_string_flags()
> instead of tty_prepare_flip_string_flags() if I knew how many
> char/flag pairs I can pass to it.
>
>> The thing is:
>>
>> 1. I'll have to convince Greg and he's not a fan of out-of-tree
>>     drivers :)
>
> I know.
>
>> 2. rc2 is pretty late for an exported function that will have almost
>>     no testing. But I'll do what I can do.
>
>> You can help avoid this situation in the future by testing linux-next
>> (or at least Greg's tty-next tree if you only work on serial stuff)
>> where these tty buffer changes have been sitting for 2 months (since
>> Dec 8).
>
> Point well taken.  I'll try get get resources allocated for periodic
> testing against linux-next.  Currently, we don't start testing with a
> kernel until an "rc" version comes out.

At least build against it; that's automatable.

>> Or better yet, submit your driver(s) for in-tree inclusion. That way
>> the situation doesn't happen in the first place.
>
> We've tried in-kernel drivers before, but it may be time to look into
> it again.
>
> <sob-story>
> In the past it didn't work out very well: maintaining both in-tree
> drivers and out-of-tree drivers was too much work.  The problem with
> in-tree drivers is that the only kernel version supported with fixes
> and new features is "the next version". Unfortunately, none of our
> customers are ever running "the next version". [One steady customer
> just switched from 2.4 to 2.6 within the past year.] So even when
> there is an in-tree driver, we still have to maintain a separate
> out-of-tree driver the same way we would if there weren't an in-tree
> driver.
>
> Since the out-of-tree driver has to support a wide range of kernel
> versions, the code had to be written in ways that are unacceptable for
> an in-tree driver. As a result, the in-tree and out-of-tree drivers
> diverge.  Every feature has to be added twice, bugs have to be fixed
> twice, there's twice as much QA, twice as much documentation, etc.  On
> top of that there's the additional work of getting those fixes and
> changes _into_ the in-tree driver.
>
> After struggling with that for a while, it was decided that the
> benefits gained from maintaining a set of in-tree drivers weren't
> enough to justify all additional work involved.  Whenever it's been
> mentioned subsequently the response is something on the lines of "we
> fell for that once, we're not going to fall for it again."
> </sob-story>

Yeah, that sucks.

[
   I don't mean to be critical but I can't really see that development
   model being sustainable. There's no realistic way to single-source
   a driver across hundreds of kernel versions.

   What was still being "maintained" for your driver for a 2.4 kernel
   (since any other active development there stopped years ago)?
]

One way to manage an in-kernel driver is to only have it support a
minimum/common feature set. The advantage is you get automatic patches
when the core changes -- and I don't just mean tty core but also
locking, workqueues, etc -- which you can then pull into the out-of-tree
driver (still adhering to the license requirements, of course). You
just maintain the actual hardware changes/bug fixes.

You have to deal with superseding the in-tree driver with the out-of-tree
driver when both are present, but that's not insurmountable.

[ For my own edification, why is the driver not a serial mini-port? ]

Regards,
Peter Hurley
