From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] RM9000 serial driver
Date: Sat, 10 Feb 2007 21:20:47 +0300
Message-ID: <45CE0CFF.1000105@ru.mvista.com>
References: <200608102318.52143.thomas.koeller@baslerweb.com> <20060830121216.GA25699@flint.arm.linux.org.uk> <44F5C1BB.7010205@ru.mvista.com> <200702101711.46826.thomas@koeller.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:61882 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751723AbXBJSU4 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sat, 10 Feb 2007 13:20:56 -0500
In-Reply-To: <200702101711.46826.thomas@koeller.dyndns.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Thomas Koeller <thomas@koeller.dyndns.org>
Cc: Russell King <rmk@arm.linux.org.uk>, linux-serial@vger.kernel.org, ralf@linux-mips.org, linux-mips@linux-mips.org

Hello.

Thomas Koeller wrote:

>>>>I would like to return to the port type vs. iotype  stuff once again.

>>>From what you wrote I seem to understand that the iotype is not just

>>>>a method of accessing device registers, but also the primary means of
>>>>discrimination between different h/w implementations, and hence every
>>>>code to support a nonstandard device must define an iotype of its own,
>>>>even though one of the existing iotypes would work just fine?

>>>iotype is all about the access method used to access the registers of
>>>the device, be it by byte or word, and it also takes account of any
>>>variance in the addressing of the registers.

>>>It does not refer to features or bugs in any particular implementation.

>>    Well, the introduction of the UPIO_TSI case seems to contradict this --
>>it's exactly about the bugs in the particular UART implementation
>>(otherwise well described by UPIO_MEM). Its only function was to mask 2
>>hardware issues. And the UUE bit workaround seems like an abuse to me. The
>>driver could just skip the UUE test altogether based on iotype == UPIO_TSI
>>(or at least not to ignore writes with UUE set completely like it does but
>>just mask off UUE bit). With no provision to pass the implicit UART type
>>for platform devices (and skip the autoconfiguation), the introduction of
>>UPIO_TSI seems again the necessary evil. Otherwise, we could have this
>>handled with a distinct TSI UART type...

>>WBR, Sergei

> after a long delay (for which I apologize) I would like to return to

    I should also apologize for my discussion style back then -- I just was 
short of time (and now I am as well), and might have gotten too nervous for 
that reason...

> this topic. Since so much time has passed since the discussion ceased, I
> think I should summarize its state at that point:

> 1. In the RM9000 serial driver patch I submitted, I had introduced a new
>    port type PORT_RM9000. I set the iotype to UPIO_MEM32. Wherever I
>    needed to handle any peculiarities of the RM9000 h/w, I did so based
>    upon the port type. AFAICT this is in agreement with Russel's view as
>    quoted above.

    It was good in theory but the practice has shown that this approach had a 
breache.

> 2. Sergei says this is wrong, I need to introduce a new iotype instead,
>    and make the code conditional upon that, like the AU1000 does (UPIO_AU).
>    The reason he gives (see quote above) is that there is no way to pass
>    the port type along with a platform device. Is this argument still valid?

    Of course.

>    What about including the port type in the information attached to
>    platform_device.platform_data?

    As they say, "patches welcome". :-)

> Btw., I had a look ath the existing code dealing with platform
> devices. Is there a particular reason for not using the standard
> platform_device.resource mechanism of passing mem/io/irq resources from
> the platform to the driver?

    Good question...
    It was probably easier to get all info from one place than to parse the 
resources. :-)

> Another topic discussed was the use (or abuse) of dl_serial_read()/
> dl_serial_write() to get/set the divisor registers.

    More like necessary evil since Pantelis decided to merge support for the 
Alchemy UARTs... :-)

> 3. Russel says (qoute from an earlier mail),
>    > It's worse than that - this code is there to read the ID from the divisor
>    > registers implemented in some UARTs. If it isn't one of those UARTs,
>    > it's expected to return zero.

    Could you remind regarding which exactly code Russell has said this,
the one in autoconfig_read_divisor_id()?  Are you sure this code gets actually 
called for your UART or Alchemy one?  From looking at the code, I could 
conclude that it shouldn't be -- IIR (sharing address with EFR) shouldn't be 
reading as zero unless the modem status interrupt is pending -- that's what 
the EFR detection code counts on...
     But anyway, I don't see why this code is unsafe to convert to using the 
dl_serail_read/write accessors...

> 4. I followed the AU1X00 code in this case, using the functions to read/write
>    the divisor value. My hardware has its UART_DLL and UART_DLM registers at
>    nonstandard addresses, and so the only other option would have been to
>    monitor every write to the LCR register for setting or clearing the DLAB
>    bit, and to switch between different mapping tables accordingly. In the

    Why, if we already have a working approach?

>    light of this, would it still be unacceptable to use the dl_*() functions
>    tho access the divisor registers?

    Why would it be unacceptable, if the like code is already there, in the 
driver?

> Once these issues have been resolved, I will submit an updated version of
> my patch.

    I'm afraid you're on your own with resolving the issues now, as the serial 
drivers are no longer maintaned by anybody (so, you probably will have to work 
with Andrew Morton)...

> tk

MBR, Sergei
