From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] serial: fix au1xxx UART0 irq setup
Date: Thu, 25 Oct 2007 18:09:47 +0400
Message-ID: <4720A3AB.7070307@ru.mvista.com>
References: <4720A11E.5060101@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:45385 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754439AbXJYOJj (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 25 Oct 2007 10:09:39 -0400
In-Reply-To: <4720A11E.5060101@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jan Nikitenko <jan.nikitenko@gmail.com>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org, linux-serial@vger.kernel.org

Jan Nikitenko wrote:

> UART0 on Alchemy mips platforms (au1xxx) does not use real uart's hw
> irq, causing 'ttyS0: 1 input overrun(s)' kernel message with data loss,
> when more characters than uart's fifo size were to be received by the uart.

> This problem can be experienced for example when uart0 is used as a
> serial console on au1550 and more than 16 characters are pasted from
> clipboard to the console.
> 
> The is_real_interrupt(irq) macro is defined in drivers/serial/8250.c as
> a check, if the irq number is other than zero.
> Because UART0 on au1xxx platforms uses irq number 0, the
> is_real_interrupt() check fails and serial8250_backup_timeout() is used
> instead of uart's hw irq.
> 
> The patch redefines the is_real_interrupt(irq) macro, as suggested in
> the comment above the macro definition in 8250.c, in the
> asm-mips/serial.h to be always true for CONFIG_SERIAL_8250_AU1X00.
> This allows the irq number 0 to be used as hw irq for the alchemy uart0
> and fixes the overrun problem.
> 
> Signed-off-by: Jan Nikitenko <jan.nikitenko@gmail.com>
> 
> ---
> 
>  include/asm-mips/serial.h |    5 +++++
>  1 file changed, 5 insertions(+)
> 
> 
> ------------------------------------------------------------------------
> 
> diff --git a/include/asm-mips/serial.h b/include/asm-mips/serial.h
> index c07ebd8..526bd2e 100644
> --- a/include/asm-mips/serial.h
> +++ b/include/asm-mips/serial.h
> @@ -19,4 +19,9 @@
>   */
>  #define BASE_BAUD (1843200 / 16)
>  
> +#ifdef CONFIG_SERIAL_8250_AU1X00
> +#undef is_real_interrupt
> +#define is_real_interrupt(irq)  (1)
> +#endif
> +
>  #endif /* _ASM_SERIAL_H */

     I wonder why such patch hasn't still been checked, despite being 
suggested several times...

WBR, Sergei
