From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: API to flush rx fifo?
Date: Fri, 14 Jun 2013 11:46:24 -0400
Message-ID: <51BB3AD0.50201@hurleysoftware.com>
References: <kpak75$9ko$1@ger.gmane.org> <51BB2C2A.9050601@hurleysoftware.com> <kpfc5k$5u4$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout39.mail01.mtsvc.net ([216.70.64.83]:52278 "EHLO
	n12.mail01.mtsvc.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750930Ab3FNPq2 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 14 Jun 2013 11:46:28 -0400
In-Reply-To: <kpfc5k$5u4$1@ger.gmane.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Grant Edwards <grant.b.edwards@gmail.com>
Cc: linux-serial@vger.kernel.org

On 06/14/2013 11:17 AM, Grant Edwards wrote:
> On 2013-06-14, Peter Hurley <peter@hurleysoftware.com> wrote:
>> On 06/12/2013 04:03 PM, Grant Edwards wrote:
>>> I see the uart_ops.flush_buffer method which is used to flush the
>>> UART's tx fifo (presumably when the user calls tcflush(TCOFLUSH)).
>>>
>>> How does the rx fifo get flushed when the user calls tcflush(TCIFLUSH)?
>>
>> It doesn't.
>
> Thanks.  I couldn't see any mechanism to do that, and I thought I must
> be missing something.
>
>> If you're seeing stale i/o, it's more likely due to the flip buffers
>> not being flushed
>
> Probably.  There is a scenario where you can get old data because the
> rx fifo isn't flushed, but I suspect it's not what my customer is
> complaining about.  FWIW, here's the scenario I'm worrying about:
>
>     1) Enable either RTS/CTS or Xon/Xoff flow control for a UART driver
>        that handles that flow control in hardware[1].
>
>     2) Stop making read() calls on the tty device.
>
>     3) The buffers in the tty layer fill up, so the uart driver stops
>        transferring data from the rx fifo to the tty layer.
>
>     4) The rx fifo fills up, and the flow control stops the other end
>        from sending data.
>
>     [all working OK up to this point, now you wait for an arbitrary
>     amount of time]
>
>     5) tcflush(TCIFLUSH) is called.
>
>     [data in the tty layer gets flushed, but old data in the rx
>      fifo remains]

Yep. Your driver continues to push new data as it should, but that's
getting buffered up in the flip buffers. So that is what the app is
reading now that it has restarted read()s.

Your hardware rx fifo shouldn't have stale data in it because that
should generate an overrun; ie., if the flip buffers cannot accept
data because they're full then the next char pushed when space becomes
available should be a NUL flagged with TTY_OVERRUN.

Would a trial patch help (something that you might have to carry yourself
for a little while until I could do some historical research)?

>     6) Now that there's room for more rx data in the tty layer, the
>        uart driver resumes transferring (old) data from the rx fifo to
>        the tty layer.
>
>     7) read() is called and returns data that was received an arbitrary
>        amount of time before tcflush(TCIFLUSH) was called.
>
> My "old" drivers that interfaced directly with the tty layer handled
> this scenario, but those drivers were becoming unmaintainable because
> of instability of the tty API over the range of kernel versions I
> support. So, I converted them over to be "uart drivers" for the common
> serial layer which has a much more stable API (and generally requires
> much less code). Now I've got a customer complaining about not being
> able to flush data, so I'm looking closer at how the tcflush() calls
> are handled.
>
> [1] Because of a bug in the serial-driver layer's handling of the
>      setting of Xon/Xoff characters by the settermios() call, it's not
>      possible to correctly use Xon/Xoff support in a UART for the case
>      where the user wants to use non-default Xon/Xoff characters.

Can you be more specific about why setting non-default START_CHAR() and
STOP_CHAR() didn't work?  I recently overhauled this code so if there's
a problem here, we should probably fix it.

Regards,
Peter Hurley

