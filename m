From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: Is tty->receive_room no longer usable w/ SMP?
Date: Thu, 13 Feb 2014 13:20:05 -0500
Message-ID: <52FD0CD5.1050807@hurleysoftware.com>
References: <ldgte5$kp1$1@ger.gmane.org> <52FC1A14.5080004@hurleysoftware.com> <ldhaiq$jg$1@ger.gmane.org> <52FC427A.8050907@hurleysoftware.com> <ldhlpd$bbr$1@ger.gmane.org> <52FCE506.2040801@hurleysoftware.com> <ldj0o5$oq6$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout32.mail01.mtsvc.net ([216.70.64.70]:55233 "EHLO
	n23.mail01.mtsvc.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752172AbaBMSUI (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 13 Feb 2014 13:20:08 -0500
In-Reply-To: <ldj0o5$oq6$1@ger.gmane.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Grant Edwards <grant.b.edwards@gmail.com>, linux-serial@vger.kernel.org

On 02/13/2014 12:52 PM, Grant Edwards wrote:
> On 2014-02-13, Peter Hurley <peter@hurleysoftware.com> wrote:
>> On 02/13/2014 12:38 AM, Grant Edwards wrote:
>> While this approach is possible, there is another way to look at
>> this problem:
>>
>> The tty buffers are very deep (at least 64K+, as high as 128K).
>> If data can't be taken in but the sender has not yet been throttled,
>> then some error is occurring.
>
> Not necessarily.
>
> With modern UARTs, the way you throttle the sender is by not reading
> data from the rx FIFO when there's nowhere to put that data.  When the
> rx FIFO starts getting too full, the UART will send an XOFF or assirt
> or de-assert RTS or DTR or whatever.
>
> In order for that mechanism to work, you need to know when to stop
> reading the rx FIFO.  That's what we had been using tty->receive_room
> for, and now it appears I should be using tty_buffer_request_room()
> for.
>
>> Rather than buffering data outside the tty buffers (because
>> eventually that will run out too causing a fifo overflow),
>
> Not if flow control is enabled.  When you end up with data buffered in
> the driver, the driver stops reading the rx FIFO, the rx FIFO fills
> up, and the UART throttles the sender.  Once the buffered data has
> been transferred, you start read the rx FIFO again and the UART
> unthrottles the sender.  If flow control _isn't_ enable, and the
> application isn't reading receive data, then there's going to be an
> overflow error and data is lost no matter what approach you take. It
> makes a lot more sense to let the UART do the overflow error detection
> and discard the data than to do that in driver code.

Ok. I assumed your hardware didn't do this because otherwise you wouldn't
need to use the tty_flip_* interface directly because your driver would
be a UART miniport (ie., serial-core port).

>> just drop the current rx and signal a condition to insert a
>> TTY_OVERRUN at the beginning of the next rx (look at
>> drivers/staging/fwserial/fwserial.c:fwtty_rx().
>
> That seems like writing driver code to emulate functions that already
> exist in the UART hardware.  I'd much rather just use the UART for
> that.

Again, I assumed your hardware didn't do this for you (which is why
I pointed you to an example of how to simulate it for hardware that
isn't a UART/doesn't auto-flow-control).

>> but don't use tty_buffer_space_avail() throttling part; that's only
>> for very high speeds where the tty buffers can overflow even before
>> the input processing worker runs).
>
> The whole point of knowing when to stop reading the rx FIFO is to
> _prevent_ data loss/overrun by allowing the UART to throttle the
> sender before we get to the point where we've got nowhere to put data
> we've read from the rx FIFO.
>
>>> I must be missing something.
>>
>> tty_buffer_request_room() returns a buffer suitable for data + flags;
>> you're just misreading the code.
>
> Great!
>
> That solves my problem.  I can call tty_buffer_request_room(), read
> the indicated number of chars or char/flag pairs and then depend on
> being able to call _either_ tty_insert_flip_string() or
> tty_insert_flip_string_flags() to transfer the data I read.

Yep.

> When the application stops reading data and buffers fill up,
> tty_buffer_request_room() will tell me to stop reading data from the
> UART and everything will work the way it should.
>
>> At least build against it; that's automatable.
>
> Good point.  That would catch the obvious stuff with very little work.
>
>> I don't mean to be critical but I can't really see that development
>> model being sustainable.
>
> We've been doing it for 20+ years (though I've only been involved for
> the last 15).  We can't beat the Chinese on the price of boards, so we
> had better beat them on support.

Just trying to be helpful. Please don't take my comments as an attack
on either your business model or your development processes; I don't
know enough about either to criticize.

>> There's no realistic way to single-source a driver across hundreds of
>> kernel versions.
>
> Maybe not hundreds.  Our current drivers only support 2.6.24 and
> later.  We can still support previous driver versions if required for
> customers running older 2.6 kernels.  We officially stopped supporting
> 2.4 several years ago.

By "support", do you mean "add new features" or "workaround hardware bugs"?

>> What was still being "maintained" for your driver for a 2.4 kernel
>> (since any other active development there stopped years ago)?
>
> We hadn't supported 2.4 for several years at that point -- I was just
> illustrating how reluctant many customers are to upgrade kernels and
> the infeasibility of depending on in-tree drivers to support customers
> like that.
>
>> One way to manage an in-kernel driver is to only have it support a
>> minimum/common feature set. The advantage is you get automatic
>> patches when the core changes -- and I don't just mean tty core but
>> also locking, workqueues, etc -- which you can then pull into the
>> out-of-tree driver (still adhering to the license requirements, of
>> course). You just maintain the actual hardware changes/bug fixes.
>
> A couple of our products do have in-tree drivers, but they've diverged
> so far from the out-of-tree drivers that they aren't particularly
> useful resources for maintaining the out-of-tree drivers.  It's
> actually been more useful over the years to look at changes made to
> other in-tree drivers.
>
>> You have to deal with superseding the in-tree driver with the out-of-tree
>> driver when both are present, but that's not insurmountable.
>
> That doesn't seem to be an issue.  It's only been a problem a couple
> times in the past couple decades when a customer has built a custom
> configured kernel and configured the in-tree driver as built-in rather
> than a module.
>
>> [ For my own edification, why is the driver not a serial mini-port? ]
>
> I don't know what a serial mini-port is.  We recently transitioned two
> of our drivers from being tty drivers to being serial-core drivers.
> Is mini-port something different that the serial core?

No, same thing.

> For another driver, it's still a tty driver because the serial-core
> API just didn't fit the device well enough to make it work.  One issue
> I recall is that our driver for that device needs to be able to cause
> specific error returns for write() calls that are made when the
> hardware is unavailable (and I think there are different errors
> depending on why it's unavailable).

And this is the driver that uses tty_flip_* interface directly?

Regards,
Peter Hurley

