From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: API to flush rx fifo?
Date: Fri, 14 Jun 2013 14:04:08 -0400
Message-ID: <51BB5B18.6000304@hurleysoftware.com>
References: <kpak75$9ko$1@ger.gmane.org> <51BB2C2A.9050601@hurleysoftware.com> <kpfc5k$5u4$1@ger.gmane.org> <51BB3AD0.50201@hurleysoftware.com> <kpfgdu$nfb$1@ger.gmane.org> <51BB4E64.2000705@hurleysoftware.com> <20130614173941.GA15623@grante>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout39.mail01.mtsvc.net ([216.70.64.83]:57211 "EHLO
	n12.mail01.mtsvc.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752261Ab3FNSEK (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 14 Jun 2013 14:04:10 -0400
In-Reply-To: <20130614173941.GA15623@grante>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Grant Edwards <grant.b.edwards@gmail.com>
Cc: linux-serial@vger.kernel.org

On 06/14/2013 01:39 PM, Grant Edwards wrote:
> On Fri, Jun 14, 2013 at 01:09:56PM -0400, Peter Hurley wrote:
>> On 06/14/2013 12:29 PM, Grant Edwards wrote:
>>
>>>> Your hardware rx fifo shouldn't have stale data in it because that
>>>> should generate an overrun; ie., if the flip buffers cannot accept
>>>> data because they're full then the next char pushed when space
>>>> becomes available should be a NUL flagged with TTY_OVERRUN.
>>>
>>> If flow control is enabled, there should be no rx overruns -- that's
>>> what flow control is for.  In the scenario above, flow control is
>>> enabled (and working).  In order to allow the UART to handle flow
>>> control, the UART driver must stop reading data from the rx fifo when
>>> the tty layer is "full".  The documentation for the serial core API
>>> specifically states that UARTs are allowed to implement flow control
>>> in hardware, and the only way that can be done is to alow the rx fifo
>>> to fill up when the application stops makeing read() calls and the tty
>>> layer fills up.
>>>
>>> I think in newer kernels instead of explicitly checking for room in
>>> the tty layer before unloading the rx fifo, the UART is supposed to
>>> rely on the throttle/unthrottle callbacks, but the end result is the
>>> same: when the tty layer gets "full", the UART driver stops reading
>>> data from the rx fifo, and the rx fifo fills up.
>>
>> AFAIK, only USB serial stops reading the rx fifo on throttle;
>
> All the drivers I maintain do that.  It's the only way to get flow
> control to work.  For UART with large FIFOs (e.g. 1KB) -- espcially
> those attached via USB or Ethernet -- flow control driven by code in
> serial_core just doesn't work right: you've got to let the UART handle
> it.

I had a similar situation with the firewire serial driver (which fakes
serial i/o over the firewire bus @ 250~400Mb/s). The existing throttle
mechanism is too ponderous to shut-off the transmitter before the
receiver overflows the flip buffers.

Currently, that driver buffers rx up on the receiver side but I plan to
change that; right now, the plan is to track the "high watermark" in the
flip buffers and self-throttle when that is too low. Also, I might expose
a way of upping the max flip buffer amount per-port (but probably not
until I add a no-flags-buffer for tty_insert_flip_string_fixed_flag()).

>> the serial core and other tty drivers continue to empty the rx fifo
>> -- throttle only shuts off the transmitter on the other end.
>>
>> Without handling throttle/unthrottle, how are you determining that the
>> tty layer is "full"?  Return code from tty_insert_flip_xxxx()?
>
> I check tty->receive_room.

That will be going away as a means of flow control because it's not
thread-safe (if you backscan this list, my 'lockless n_tty receive path'
patchset only keeps tty->receive_room for the non-flow controlled
line disciplines).

> What are you supposed to do for kernel
> versions that don't have the throttle()/unthrottle() callbacks?

Which versions specifically do you mean?

Regards,
Peter Hurley

