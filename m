From: Jan Nikitenko <jan.nikitenko@gmail.com>
Subject: Re: [PATCH] serial: fix au1xxx UART0 irq setup
Date: Thu, 25 Oct 2007 16:47:15 +0200
Message-ID: <4720AC73.8030509@gmail.com>
References: <4720A11E.5060101@gmail.com> <20071025140940.GC23398@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.189]:48037 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754336AbXJYOp4 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 25 Oct 2007 10:45:56 -0400
Received: by nf-out-0910.google.com with SMTP id g13so503337nfb
        for <linux-serial@vger.kernel.org>; Thu, 25 Oct 2007 07:45:54 -0700 (PDT)
In-Reply-To: <20071025140940.GC23398@linux-mips.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org, linux-serial@vger.kernel.org

Ralf Baechle wrote:
> On Thu, Oct 25, 2007 at 03:58:54PM +0200, Jan Nikitenko wrote:
> 
>> UART0 on Alchemy mips platforms (au1xxx) does not use real uart's hw
>> irq, causing 'ttyS0: 1 input overrun(s)' kernel message with data loss,
>> when more characters than uart's fifo size were to be received by the uart.
>>
>> This problem can be experienced for example when uart0 is used as a
>> serial console on au1550 and more than 16 characters are pasted from
>> clipboard to the console.
>>
>> The is_real_interrupt(irq) macro is defined in drivers/serial/8250.c as
>> a check, if the irq number is other than zero.
>> Because UART0 on au1xxx platforms uses irq number 0, the
>> is_real_interrupt() check fails and serial8250_backup_timeout() is used
>> instead of uart's hw irq.
>>
>> The patch redefines the is_real_interrupt(irq) macro, as suggested in
>> the comment above the macro definition in 8250.c, in the
>> asm-mips/serial.h to be always true for CONFIG_SERIAL_8250_AU1X00.
>> This allows the irq number 0 to be used as hw irq for the alchemy uart0
>> and fixes the overrun problem.
>>
>> Signed-off-by: Jan Nikitenko <jan.nikitenko@gmail.com>
> 
> Fairly unelegent imho but anyway, for 2.6.24 I've added support for
> tickless to MIPS which in turn required a bit of a cleanup on the Alchemy
> code so I renumbered the Alchemy interrupt numbers, so what used to be
> IRQ 0 is now IRQ 8 which means your patch is no longer needed for master.

That's good to know.

> 
> That said, irq 0 is imho totally valid (take the good old PIT timer
> interrupt of the PC as the classic example) and treating it as an invalid 
> interrupt number is broken.
> 
> It's however equally pretty crude hack to undefine a symbol in a file other
> than the one defining it ...

I did exactly as the comment in 8250.c suggested (that arch include
could redefine that macro) - I did not like it either...

Jan
