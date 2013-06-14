From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: API to flush rx fifo?
Date: Fri, 14 Jun 2013 13:09:56 -0400
Message-ID: <51BB4E64.2000705@hurleysoftware.com>
References: <kpak75$9ko$1@ger.gmane.org> <51BB2C2A.9050601@hurleysoftware.com> <kpfc5k$5u4$1@ger.gmane.org> <51BB3AD0.50201@hurleysoftware.com> <kpfgdu$nfb$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout39.mail01.mtsvc.net ([216.70.64.83]:35453 "EHLO
	n12.mail01.mtsvc.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753595Ab3FNRJ6 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 14 Jun 2013 13:09:58 -0400
In-Reply-To: <kpfgdu$nfb$1@ger.gmane.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Grant Edwards <grant.b.edwards@gmail.com>
Cc: linux-serial@vger.kernel.org

On 06/14/2013 12:29 PM, Grant Edwards wrote:
> On 2013-06-14, Peter Hurley <peter@hurleysoftware.com> wrote:
>> On 06/14/2013 11:17 AM, Grant Edwards wrote:
>>> On 2013-06-14, Peter Hurley <peter@hurleysoftware.com> wrote:
>>>> On 06/12/2013 04:03 PM, Grant Edwards wrote:
>>>>> I see the uart_ops.flush_buffer method which is used to flush the
>>>>> UART's tx fifo (presumably when the user calls tcflush(TCOFLUSH)).
>>>>>
>>>>> How does the rx fifo get flushed when the user calls tcflush(TCIFLUSH)?
>>>>
>>>> It doesn't.
>>>
>>> Thanks.  I couldn't see any mechanism to do that, and I thought I must
>>> be missing something.
>>>
>>>> If you're seeing stale i/o, it's more likely due to the flip buffers
>>>> not being flushed
>>>
>>> Probably.  There is a scenario where you can get old data because the
>>> rx fifo isn't flushed, but I suspect it's not what my customer is
>>> complaining about.  FWIW, here's the scenario I'm worrying about:
>>>
>>>      1) Enable either RTS/CTS or Xon/Xoff flow control for a UART driver
>>>         that handles that flow control in hardware[1].
>>>
>>>      2) Stop making read() calls on the tty device.
>>>
>>>      3) The buffers in the tty layer fill up, so the uart driver stops
>>>         transferring data from the rx fifo to the tty layer.
>>>
>>>      4) The rx fifo fills up, and the flow control stops the other end
>>>         from sending data.
>>>
>>>      [all working OK up to this point, now you wait for an arbitrary
>>>      amount of time]
>>>
>>>      5) tcflush(TCIFLUSH) is called.
>>>
>>>      [data in the tty layer gets flushed, but old data in the rx
>>>       fifo remains]
>>
>> Yep. Your driver continues to push new data as it should, but that's
>> getting buffered up in the flip buffers. So that is what the app is
>> reading now that it has restarted read()s.
>>
>> Your hardware rx fifo shouldn't have stale data in it because that
>> should generate an overrun; ie., if the flip buffers cannot accept
>> data because they're full then the next char pushed when space
>> becomes available should be a NUL flagged with TTY_OVERRUN.
>
> If flow control is enabled, there should be no rx overruns -- that's
> what flow control is for.  In the scenario above, flow control is
> enabled (and working).  In order to allow the UART to handle flow
> control, the UART driver must stop reading data from the rx fifo when
> the tty layer is "full".  The documentation for the serial core API
> specifically states that UARTs are allowed to implement flow control
> in hardware, and the only way that can be done is to alow the rx fifo
> to fill up when the application stops makeing read() calls and the tty
> layer fills up.
>
> I think in newer kernels instead of explicitly checking for room in
> the tty layer before unloading the rx fifo, the UART is supposed to
> rely on the throttle/unthrottle callbacks, but the end result is the
> same: when the tty layer gets "full", the UART driver stops reading
> data from the rx fifo, and the rx fifo fills up.

AFAIK, only USB serial stops reading the rx fifo on throttle;
the serial core and other tty drivers continue to empty the rx fifo --
throttle only shuts off the transmitter on the other end.

Without handling throttle/unthrottle, how are you determining that the
tty layer is "full"?  Return code from tty_insert_flip_xxxx()?

Regards,
Peter Hurley
