From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: API to flush rx fifo?
Date: Fri, 14 Jun 2013 16:53:20 -0400
Message-ID: <51BB82C0.2040309@hurleysoftware.com>
References: <kpak75$9ko$1@ger.gmane.org> <51BB2C2A.9050601@hurleysoftware.com> <kpfc5k$5u4$1@ger.gmane.org> <51BB3AD0.50201@hurleysoftware.com> <kpfgdu$nfb$1@ger.gmane.org> <51BB4E64.2000705@hurleysoftware.com> <20130614173941.GA15623@grante> <51BB5B18.6000304@hurleysoftware.com> <kpfpv8$u09$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout39.mail01.mtsvc.net ([216.70.64.83]:49182 "EHLO
	n12.mail01.mtsvc.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751126Ab3FNUxW (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 14 Jun 2013 16:53:22 -0400
In-Reply-To: <kpfpv8$u09$1@ger.gmane.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Grant Edwards <grant.b.edwards@gmail.com>
Cc: linux-serial@vger.kernel.org

On 06/14/2013 03:12 PM, Grant Edwards wrote:
> On 2013-06-14, Peter Hurley <peter@hurleysoftware.com> wrote:
>
>>> All the drivers I maintain do that.  It's the only way to get flow
>>> control to work.  For UART with large FIFOs (e.g. 1KB) -- espcially
>>> those attached via USB or Ethernet -- flow control driven by code in
>>> serial_core just doesn't work right: you've got to let the UART handle
>>> it.
>>
>> I had a similar situation with the firewire serial driver (which fakes
>> serial i/o over the firewire bus @ 250~400Mb/s). The existing throttle
>> mechanism is too ponderous to shut-off the transmitter before the
>> receiver overflows the flip buffers.
>
> Any time you combine high baud rates, large FIFOs, and latency, you
> run into that problem.
>
>>>> Without handling throttle/unthrottle, how are you determining that the
>>>> tty layer is "full"?  Return code from tty_insert_flip_xxxx()?
>>>
>>> I check tty->receive_room.
>>
>> That will be going away as a means of flow control because it's not
>> thread-safe (if you backscan this list, my 'lockless n_tty receive
>> path' patchset only keeps tty->receive_room for the non-flow
>> controlled line disciplines).
>
> Good to know.
>
> Will tty_prepare_flip_string_flags() continue to return a "room"
> value?  If so, then I could also switch over to using that instead of
> looking at tty->receive_room.  [The advantage being simpler backwards
> compatibility.]

Yes to both.

> The tty_prepare_flip_string_flags() approach also uses a lot less CPU
> time than the uart_insert_char() approach.
>
> I'll probably add throttle()/unthrottle() callbacks that set/clear an
> internal flag that tells the driver whether or not to read data from
> the rx fifo. That should less overhead than polling the tty layer by
> calling tty_prepare_flip_string_flags(). But, it doesn't help the
> situation for kernels before 3.8.
>
>>> What are you supposed to do for kernel versions that don't have the
>>> throttle()/unthrottle() callbacks?
>>
>> Which versions specifically do you mean?
>
> My serial_core UART drivers support 2.6.25 and newer. The tech support
> guys would like support further back, but I've given up trying for
> anything older than that. Before our recent change-over to serial_core
> drivers (a few months back) I supported 2.6.18 and later. Tech support
> would have liked to go back to 2.6.12, which is still in use by some
> customers who've tested their systems with some ancient version of RH
> and don't want to change it.  One customer just moved from 2.4 to 2.6
> about a year ago.
>
> I believe that the throttle/unthrottle callbacks didn't show up until
> 3.8.  I doubt we even have any customers running 3.8 yet. :)

Either backporting that commit or something similar specifically for
your driver is the only realistic solution. There was nothing suitable
before that.

[ FWIW, I think that commit went in for 3.7 not 3.8 ]


