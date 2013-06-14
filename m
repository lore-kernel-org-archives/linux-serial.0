From: Grant Edwards <grant.b.edwards@gmail.com>
Subject: Re: API to flush rx fifo?
Date: Fri, 14 Jun 2013 16:29:51 +0000 (UTC)
Message-ID: <kpfgdu$nfb$1@ger.gmane.org>
References: <kpak75$9ko$1@ger.gmane.org>
 <51BB2C2A.9050601@hurleysoftware.com> <kpfc5k$5u4$1@ger.gmane.org>
 <51BB3AD0.50201@hurleysoftware.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:52415 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752870Ab3FNQaM (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 14 Jun 2013 12:30:12 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <lnx-linux-serial@m.gmane.org>)
	id 1UnWt5-0006kL-MY
	for linux-serial@vger.kernel.org; Fri, 14 Jun 2013 18:30:07 +0200
Received: from dsl.comtrol.com ([64.122.56.22])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Fri, 14 Jun 2013 18:30:07 +0200
Received: from grant.b.edwards by dsl.comtrol.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Fri, 14 Jun 2013 18:30:07 +0200
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

On 2013-06-14, Peter Hurley <peter@hurleysoftware.com> wrote:
> On 06/14/2013 11:17 AM, Grant Edwards wrote:
>> On 2013-06-14, Peter Hurley <peter@hurleysoftware.com> wrote:
>>> On 06/12/2013 04:03 PM, Grant Edwards wrote:
>>>> I see the uart_ops.flush_buffer method which is used to flush the
>>>> UART's tx fifo (presumably when the user calls tcflush(TCOFLUSH)).
>>>>
>>>> How does the rx fifo get flushed when the user calls tcflush(TCIFLUSH)?
>>>
>>> It doesn't.
>>
>> Thanks.  I couldn't see any mechanism to do that, and I thought I must
>> be missing something.
>>
>>> If you're seeing stale i/o, it's more likely due to the flip buffers
>>> not being flushed
>>
>> Probably.  There is a scenario where you can get old data because the
>> rx fifo isn't flushed, but I suspect it's not what my customer is
>> complaining about.  FWIW, here's the scenario I'm worrying about:
>>
>>     1) Enable either RTS/CTS or Xon/Xoff flow control for a UART driver
>>        that handles that flow control in hardware[1].
>>
>>     2) Stop making read() calls on the tty device.
>>
>>     3) The buffers in the tty layer fill up, so the uart driver stops
>>        transferring data from the rx fifo to the tty layer.
>>
>>     4) The rx fifo fills up, and the flow control stops the other end
>>        from sending data.
>>
>>     [all working OK up to this point, now you wait for an arbitrary
>>     amount of time]
>>
>>     5) tcflush(TCIFLUSH) is called.
>>
>>     [data in the tty layer gets flushed, but old data in the rx
>>      fifo remains]
>
> Yep. Your driver continues to push new data as it should, but that's
> getting buffered up in the flip buffers. So that is what the app is
> reading now that it has restarted read()s.
>
> Your hardware rx fifo shouldn't have stale data in it because that
> should generate an overrun; ie., if the flip buffers cannot accept
> data because they're full then the next char pushed when space
> becomes available should be a NUL flagged with TTY_OVERRUN.

If flow control is enabled, there should be no rx overruns -- that's
what flow control is for.  In the scenario above, flow control is
enabled (and working).  In order to allow the UART to handle flow
control, the UART driver must stop reading data from the rx fifo when
the tty layer is "full".  The documentation for the serial core API
specifically states that UARTs are allowed to implement flow control
in hardware, and the only way that can be done is to alow the rx fifo
to fill up when the application stops makeing read() calls and the tty
layer fills up.

I think in newer kernels instead of explicitly checking for room in
the tty layer before unloading the rx fifo, the UART is supposed to
rely on the throttle/unthrottle callbacks, but the end result is the
same: when the tty layer gets "full", the UART driver stops reading
data from the rx fifo, and the rx fifo fills up.

> Would a trial patch help (something that you might have to carry
> yourself for a little while until I could do some historical
> research)?

Let's not do that yet.  The bug report from the customer is
sufficiently vague that I'm not sure the above scenario is what he's
run into.  I'm currently waiting on more detailed info, but probably
won't have an update for a few days.

>> [1] Because of a bug in the serial-driver layer's handling of the
>>      setting of Xon/Xoff characters by the settermios() call, it's not
>>      possible to correctly use Xon/Xoff support in a UART for the case
>>      where the user wants to use non-default Xon/Xoff characters.
>
> Can you be more specific about why setting non-default START_CHAR() and
> STOP_CHAR() didn't work?  I recently overhauled this code so if there's
> a problem here, we should probably fix it.

<pulling foot out of mouth>

It was fixed in 3.8!

I'll re-enable support for hardware supported xon/xoff flow control in
my drivers when they're being built for kernels >= 3.8.
  
-- 
Grant Edwards               grant.b.edwards        Yow! Hmmm ... an arrogant
                                  at               bouquet with a subtle
                              gmail.com            suggestion of POLYVINYL
                                                   CHLORIDE ...

