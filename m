From: Grant Edwards <grant.b.edwards@gmail.com>
Subject: Re: Is tty->receive_room no longer usable w/ SMP?
Date: Thu, 13 Feb 2014 05:38:53 +0000 (UTC)
Message-ID: <ldhlpd$bbr$1@ger.gmane.org>
References: <ldgte5$kp1$1@ger.gmane.org>
 <52FC1A14.5080004@hurleysoftware.com> <ldhaiq$jg$1@ger.gmane.org>
 <52FC427A.8050907@hurleysoftware.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:45757 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751526AbaBMFjU (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 13 Feb 2014 00:39:20 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <lnx-linux-serial@m.gmane.org>)
	id 1WDp14-0007Ef-Vz
	for linux-serial@vger.kernel.org; Thu, 13 Feb 2014 06:39:18 +0100
Received: from c-24-118-110-103.hsd1.mn.comcast.net ([24.118.110.103])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Thu, 13 Feb 2014 06:39:18 +0100
Received: from grant.b.edwards by c-24-118-110-103.hsd1.mn.comcast.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Thu, 13 Feb 2014 06:39:18 +0100
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

On 2014-02-13, Peter Hurley <peter@hurleysoftware.com> wrote:

>>>>    tty_prepare_flip_string_flags(...)
>>>         ^^^^^^^^^^^^
>>> This was removed for 3.14.
>>
>> Why?
>
> The tty flip buffer code now uses an encoding method to maximize
> memory usage for actual data (when the data is all TTY_NORMAL). Since
> there were no in-tree users,

I noticed that earlier this evening when browsing the in-kernel
drivers.

>> I _was_ planning on removing the code that checks tty->receive_room
>> and instead rely instead on the return value from
>> tty_prepare_flip_string_flags().  But, as you noted, that's gone now.
>
> That's one of the hazards of out-of-tree drivers, for you and for me.
> When I'm writing functionality, I can't know if some defunct code is
> actually being used in the wild. For you, breakage ensues.

Indeed.

>> Is there any documentation explaining how one is supposed to handle
>> rx data in a serial driver?  The topic doesn't seem to be mentioned
>> at all in Documentation/serial/driver.
>
> This has been and continues to be one of the most active areas of
> development with the tty subsystem, especially to support really high
> speed tty (50+MB/sec).

Thankfully, my drivers don't have to support baud rates that high. 
Our serial ports top out at 921K bits/sec, but in theory we support up
to 256 ports.  In practice I've never heard of anybody with more than
128 ports, and speeds above 115K are pretty rare -- but just running a
few dozen ports at 115K starts to add up.

>> If you can assume all rx data is TTY_NORMAL, then it looks like this
>> is the right way to do it:
>>
>>    n = tty_prepare_flip_string()
>>    <copy n data bytes>
>>    tty_flip_buffer_push()

Should I assume that this is the preferred method if I can know that I
have a specific amount of TTY_NORMAL data available?

>> I've tried transferring one byte/flag pair at a time
>
> Don't do that.

I'll have to do a little more investigating, but I think I can detect
the case where there are no error flags present in the rx FIFO, so I
can use the prepare/push method when that's true (which it should be
the vast majority of the time).

If I can do that, then I think I could live with tty_insert_char() in
the much rarer case where there are errors present -- but I still need
to know if there's room to insert a byte before reading the byte/flag
from the rx FIFO and subsequently calling tty_insert_char().

That's the part I don't understand:

How are drivers that use tty_insert_char() supposed to know when to
stop calling it?  tty_insert_char() doesn't return a status, so you
don't know even after the fact if the byte you just passed was
accepted. Do you?

Similarly, how are drivers that use tty_insert_flip_string_flags()
supposed to know how much data they can pass to it?

Are they expected to keep reading data from the rx FIFO and passing it
to tty_insert_flip_string_flags() until it returns a value smaller
than the requested transfer size and then buffer the "overflow" data
that has already been read from the rx FIFO but not accepted by
tty_insert_flip_string_flags()?  Then at some point in the future you
retry the old, buffered data, and once that's all been transferred you
start reading from the rx FIFO again? That would work, but it's a
little ugly.

Looking at existing in-tree users of tty_insert_flip_string_flags(),
they call tty_buffer_request_room() to determine how many char/flag
pairs can be transferred and then depend on the assumption that
tty_insert_flip_string_flags() will accept that much. I didn't think
that was valid because tty_buffer_request_room() assumes you're not
going to transfer flags -- doesn't it?

I must be missing something.

> At this point, I would prefer to code up a
> tty_prepare_flip_string_flags(), than have out-of-tree drivers
> hacking things up.

I would be perfectly happy using tty_insert_flip_string_flags()
instead of tty_prepare_flip_string_flags() if I knew how many
char/flag pairs I can pass to it.

> The thing is:
>
> 1. I'll have to convince Greg and he's not a fan of out-of-tree
>    drivers :)

I know.

> 2. rc2 is pretty late for an exported function that will have almost
>    no testing. But I'll do what I can do.

> You can help avoid this situation in the future by testing linux-next
> (or at least Greg's tty-next tree if you only work on serial stuff)
> where these tty buffer changes have been sitting for 2 months (since
> Dec 8).

Point well taken.  I'll try get get resources allocated for periodic
testing against linux-next.  Currently, we don't start testing with a
kernel until an "rc" version comes out.

> Or better yet, submit your driver(s) for in-tree inclusion. That way
> the situation doesn't happen in the first place.

We've tried in-kernel drivers before, but it may be time to look into
it again.

<sob-story>
In the past it didn't work out very well: maintaining both in-tree
drivers and out-of-tree drivers was too much work.  The problem with
in-tree drivers is that the only kernel version supported with fixes
and new features is "the next version". Unfortunately, none of our
customers are ever running "the next version". [One steady customer
just switched from 2.4 to 2.6 within the past year.] So even when
there is an in-tree driver, we still have to maintain a separate
out-of-tree driver the same way we would if there weren't an in-tree
driver.

Since the out-of-tree driver has to support a wide range of kernel
versions, the code had to be written in ways that are unacceptable for
an in-tree driver. As a result, the in-tree and out-of-tree drivers
diverge.  Every feature has to be added twice, bugs have to be fixed
twice, there's twice as much QA, twice as much documentation, etc.  On
top of that there's the additional work of getting those fixes and
changes _into_ the in-tree driver.

After struggling with that for a while, it was decided that the
benefits gained from maintaining a set of in-tree drivers weren't
enough to justify all additional work involved.  Whenever it's been
mentioned subsequently the response is something on the lines of "we
fell for that once, we're not going to fall for it again."
</sob-story>

-- 
Grant

