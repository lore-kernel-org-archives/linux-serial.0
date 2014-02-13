From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: Is tty->receive_room no longer usable w/ SMP?
Date: Thu, 13 Feb 2014 14:09:48 -0500
Message-ID: <52FD187C.8020604@hurleysoftware.com>
References: <ldgte5$kp1$1@ger.gmane.org> <52FC1A14.5080004@hurleysoftware.com> <ldhaiq$jg$1@ger.gmane.org> <52FC427A.8050907@hurleysoftware.com> <ldhlpd$bbr$1@ger.gmane.org> <52FCE506.2040801@hurleysoftware.com> <ldj0o5$oq6$1@ger.gmane.org> <52FD0CD5.1050807@hurleysoftware.com> <ldj44p$4a0$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout32.mail01.mtsvc.net ([216.70.64.70]:49031 "EHLO
	n23.mail01.mtsvc.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750809AbaBMTJv (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 13 Feb 2014 14:09:51 -0500
In-Reply-To: <ldj44p$4a0$1@ger.gmane.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Grant Edwards <grant.b.edwards@gmail.com>, linux-serial@vger.kernel.org

On 02/13/2014 01:50 PM, Grant Edwards wrote:
> On 2014-02-13, Peter Hurley <peter@hurleysoftware.com> wrote:
>> By "support", do you mean "add new features" or "workaround hardware
>> bugs"?
>
> Both.  "New features" mostly meant support for new models, but there
> were also some actual new features and fixes for old ones that didn't
> work.  For example, it turns out almost nobody on the planet uses
> IXANY. It got left out of both our automated and manual regression
> testing, and (embarassingly) it took 10+ years for somebody to realize
> that it didn't work.  And that "somebody" was a customer that still
> had 2.4 kenels running in production machines.

Not unusual. The N_TTY ldisc just had a bug fixed in 3.10 where turning off
IXON with an already-stopped tty permanently hung the tty.

>>> For another driver, it's still a tty driver because the serial-core
>>> API just didn't fit the device well enough to make it work.  One
>>> issue I recall is that our driver for that device needs to be able to
>>> cause specific error returns for write() calls that are made when the
>>> hardware is unavailable (and I think there are different errors
>>> depending on why it's unavailable).
>>
>> And this is the driver that uses tty_flip_* interface directly?
>
> Well, they all do (under some circumstances). AFAICT, the method
> provided by serial core is uart_insert_char().  When we initially
> moved from tty driver to serial driver, we did everything in the
> simplest, most obvious way (e.g. uart_insert_char()).  But we moved
> away from that for performance reasons.  Our hardware is optimized for
> transferring data to/from continuous buffers using 32-bit bus cycles
> rather than reading/writing characters one at a time.  At one point in
> history our drivers would use inline assembly to execute a single
> machine instruction to write an entire block of tx data to the
> hardware or read an entire block of data from the hardware.  There
> were also some prototypes that did bus-master DMA for rx/tx data, but
> that turned out to be more overhead than programmed I/O, and it was
> abandoned.  Now that CPU speeds have increased so much faster than bus
> speeds, the inline assembly is no longer needed, but making a function
> call for every rx byte is still enough to use an alarming amount of
> CPU time.

We should extend the serial-core to add rx methods that work
with your UARTs in their fastest and most native way. The idea behind
serial-core is only to abstract the busy-work away from the i/o, not
become an ill-fitting shoe that enforces The One True Way.

Regards,
Peter Hurley
