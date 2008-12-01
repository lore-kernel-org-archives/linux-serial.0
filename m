From: David Daney <ddaney@caviumnetworks.com>
Subject: Re: [PATCH 5/5] Serial: UART driver changes for Cavium OCTEON.
Date: Mon, 01 Dec 2008 10:43:11 -0800
Message-ID: <4934303F.1000509@caviumnetworks.com>
References: <492C94FC.9070906@caviumnetworks.com> <1227658719-18297-5-git-send-email-ddaney@caviumnetworks.com> <492F6525.9010308@necel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail3.caviumnetworks.com ([12.108.191.235]:19492 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750895AbYLASnY (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 1 Dec 2008 13:43:24 -0500
In-Reply-To: <492F6525.9010308@necel.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Shinya Kuribayashi <shinya.kuribayashi@necel.com>
Cc: linux-serial@vger.kernel.org, akpm@linux-foundation.org, alan@lxorguk.ukuu.org.uk, linux-mips@linux-mips.org, Tomaso Paoletti <tpaoletti@caviumnetworks.com>

Shinya Kuribayashi wrote:
> Hi David,
> 
> David Daney wrote:
>> Cavium UART implementation won't work with the standard 8250 driver
>> as-is.  Define a new uart_config (PORT_OCTEON) and use it to enable
>> special handling required by the OCTEON's serial port.  Two new bug
>> types are defined.
> 
> You just added one new bug type, not two. ;-)
> 

Unfortunately I overlooked the patch comment when I moved the other bug 
  workaround to platform code.

However after your suggestion below...
[...]
> I see your point.  Then let's look at this commit:
> 
> |commit 40b36daad0ac704e6d5c1b75789f371ef5b053c1
> |Author: Alex Williamson <alex.williamson@hp.com>
> |Date:   Wed Feb 14 00:33:04 2007 -0800
> |
> |    [PATCH] 8250 UART backup timer
> |
> |    The patch below works around a minor bug found in the UART of the remote
> |    management card used in many HP ia64 and parisc servers (aka the Diva
> |    UARTs).  The problem is that the UART does not reassert the THRE interrupt
> |    if it has been previously cleared and the IIR THRI bit is re-enabled.  This
> |    can produce a very annoying failure mode when used as a serial console,
> |    allowing a boot/reboot to hang indefinitely until an RX interrupt kicks it
> |    into working again (ie.  an unattended reboot could stall).
> |
> |    To solve this problem, a backup timer is introduced that runs alongside the
> |    standard interrupt driven mechanism.  This timer wakes up periodically,
> |    checks for a hang condition and gets characters moving again.  This backup
> |    mechanism is only enabled if the UART is detected as having this problem,
> |    so systems without these UARTs will have no additional overhead.
> |
> |    This version of the patch incorporates previous comments from Pavel and
> |    removes races in the bug detection code.  The test is now done before the
> |    irq linking to prevent races with interrupt handler clearing the THRE
> |    interrupt.  Short delays and syncs are also added to ensure the device is
> |    able to update register state before the result is tested.
> |
> |    Aristeu says:
> |
> |      this was tested on the following HP machines and solved the problem:
> |      rx2600, rx2620, rx1600 and rx1620s.
> |
> |    hpa says:
> |
> |      I have seen this same bug in soft UART IP from "a major vendor."
> |
> |    Signed-off-by: Alex Williamson <alex.williamson@hp.com>
> |    Cc: "H. Peter Anvin" <hpa@zytor.com>
> |    Cc: Russell King <rmk@arm.linux.org.uk>
> |    Acked-by: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
> |    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> |    Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> 
> AFAICS this patch tries to handle the same problem, and added reasonable
> framework with serial8250_backup_timeout, etc.  And now we have UART_BUG
> _THRE for this issue.  Then it might be better to use existing codes as
> much as possible.
> 
> Just random thoughts,
> 
> - could we dynamically probe this bug in serial8250_startup as well?
> 
> - is there any possibility this hardware works with an existing
>   serial8250_backup_timeout, not doing this below:
> 
>> @@ -1714,7 +1722,7 @@ static void serial8250_timeout(unsigned long data)
>>  	unsigned int iir;
>>  
>>  	iir = serial_in(up, UART_IIR);
>> -	if (!(iir & UART_IIR_NO_INT))
>> +	if (!(iir & UART_IIR_NO_INT) || (up->bugs & UART_BUG_TIMEOUT))
>>  		serial8250_handle_port(up);
>>  	mod_timer(&up->timer, jiffies + poll_timeout(up->port.timeout));
>>  }
> 
> I'm not an UART expert, any feedback is highly appreciated.
> 
... All our boards are now working with no extra bug flags needed.  So I 
will simplify this patch set by getting rid of UART_BUG_TIMEOUT.

Thanks,

David Daney
