From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH] serial: 8250: Fix clearing FIFOs in RS485 mode again
Date: Thu, 13 Dec 2018 03:27:51 +0100
Message-ID: <117fda17-40e6-664b-2b8a-f1032610bf0b@denx.de>
References: <20181213004120.yn35mzfo4skffabv@pburton-laptop>
 <cd3e2787-48e1-ce70-0fa7-94df6dc81794@denx.de>
 <20181213014805.77u5dzydo23cm6fq@pburton-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181213014805.77u5dzydo23cm6fq@pburton-laptop>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Burton <paul.burton@mips.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On 12/13/2018 02:48 AM, Paul Burton wrote:
> Hi Marek,

Hi,

> On Thu, Dec 13, 2018 at 01:55:29AM +0100, Marek Vasut wrote:
>> On 12/13/2018 01:41 AM, Paul Burton wrote:
>>> This patch has broken the UART on my Ingenic JZ4780 based MIPS Creator
>>> Ci20 board. After this patch the system seems to detect garbage input
>>> that is recognized as SysRq triggers which spam the console & eventually
>>> reset the system.
>>>
>>> One thing of note is that both serial8250_do_startup() &
>>> serial8250_do_shutdown() contain comments that explicitly state their
>>> expectation that the FIFOs will be disabled by serial8250_clear_fifos(),
>>> which is no longer true after this patch.
>>>
>>> I found that restoring the old behaviour for serial8250_do_startup() is
>>> enough to make my system work again, but this is obviously a hack:
>> %
>>> Any ideas? Given the mismatch between this patch & comments that clearly
>>> expect the old behaviour I think the __do_stop_tx_rs485() case probably
>>> needs something different to other callers.
>>
>> The problem the original patch fixed was that too many bits were cleared
>> in the FCR on OMAP3/AM335x . If you have such a system (a beaglebone or
>> similar), you can come up with a solution which can accommodate both the
>> JZ4780 and AM335x. Can you take a look ? The datasheet for both should
>> be public too.
> 
> I don't have such a system, but hey - the Ingenic JZ4780 manual is
> public too [1] so you have just as much opportunity to fix it :)
> 
> I wonder whether the issue may be the JZ4780 UART not automatically
> resetting the FIFOs when FCR[0] changes. This is a guess, but the manual
> doesn't explicitly say it'll happen & the programming example it gives
> says to explicitly clear the FIFOs using FCR[2:1]. Since this is what
> the kernel has been doing for at least the whole git era I wouldn't be
> surprised if other devices are bitten by the change as people start
> trying 4.20 on them.

The patch you're complaining about is doing exactly that -- it sets
UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT in FCR , and then clears it.
Those two bits are exactly FCR[2:1]. It also explicitly does not touch
any other bits in FCR.

> So I think the safest option might be to restore the original behaviour
> & just keep your change for the __do_stop_tx_rs485() path specifically,
> something like the below. Could you test it on your system?
> 
> Assuming it works I'll clean it up & submit. Otherwise your patch is a
> regression so I think a revert would make sense until the problem is
> found.
> 
> Thanks,
>     Paul
> 
> [1] ftp://ftp.ingenic.cn/SOC/JZ4780/JZ4780_pm.pdf
> 
> ---
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index f776b3eafb96..0df0ed437a87 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -550,7 +550,7 @@ static unsigned int serial_icr_read(struct uart_8250_port *up, int offset)
>  /*
>   * FIFO support.
>   */
> -static void serial8250_clear_fifos(struct uart_8250_port *p)
> +static void __serial8250_clear_fifos(struct uart_8250_port *p, int clr)
>  {
>  	unsigned char fcr;
>  	unsigned char clr_mask = UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT;
> @@ -558,25 +558,26 @@ static void serial8250_clear_fifos(struct uart_8250_port *p)
>  	if (p->capabilities & UART_CAP_FIFO) {
>  		/*
>  		 * Make sure to avoid changing FCR[7:3] and ENABLE_FIFO bits.
> -		 * In case ENABLE_FIFO is not set, there is nothing to flush
> -		 * so just return. Furthermore, on certain implementations of
> -		 * the 8250 core, the FCR[7:3] bits may only be changed under
> -		 * specific conditions and changing them if those conditions
> -		 * are not met can have nasty side effects. One such core is
> -		 * the 8250-omap present in TI AM335x.
> +		 * On certain implementations of the 8250 core, the FCR[7:3]
> +		 * bits may only be changed under specific conditions and
> +		 * changing them if those conditions are not met can have nasty
> +		 * side effects. One such core is the 8250-omap present in TI
> +		 * AM335x.
>  		 */
>  		fcr = serial_in(p, UART_FCR);
> +		serial_out(p, UART_FCR, fcr | clr_mask);
> +		serial_out(p, UART_FCR, fcr & ~clr);

Note that, if I understand the patch correctly, this will _not_ restore
the original (broken) behavior. The original behavior cleared the entire
FCR at the end, which cleared even bits that were not supposed to be
cleared .

This patch will make things worse by retaining the clr_mask set in the
FCR, thus the FCR[2:1] will be set when you return from this function.
That cannot be right ?

> +	}
> +}
>  
> -		/* FIFO is not enabled, there's nothing to clear. */
> -		if (!(fcr & UART_FCR_ENABLE_FIFO))
> -			return;
> -
> -		fcr |= clr_mask;
> -		serial_out(p, UART_FCR, fcr);
> +static void serial8250_clear_fifos(struct uart_8250_port *p)
> +{
> +	__serial8250_clear_fifos(p, 0);
> +}
>  
> -		fcr &= ~clr_mask;
> -		serial_out(p, UART_FCR, fcr);
> -	}
> +static void serial8250_clear_and_disable_fifos(struct uart_8250_port *p)
> +{
> +	__serial8250_clear_fifos(p, UART_FCR_ENABLE_FIFO);
>  }
>  
>  static inline void serial8250_em485_rts_after_send(struct uart_8250_port *p)
> @@ -595,7 +596,7 @@ static enum hrtimer_restart serial8250_em485_handle_stop_tx(struct hrtimer *t);
>  
>  void serial8250_clear_and_reinit_fifos(struct uart_8250_port *p)
>  {
> -	serial8250_clear_fifos(p);
> +	serial8250_clear_and_disable_fifos(p);
>  	serial_out(p, UART_FCR, p->fcr);
>  }
>  EXPORT_SYMBOL_GPL(serial8250_clear_and_reinit_fifos);
> @@ -1364,7 +1365,7 @@ static void autoconfig(struct uart_8250_port *up)
>  		serial_out(up, UART_RSA_FRR, 0);
>  #endif
>  	serial8250_out_MCR(up, save_mcr);
> -	serial8250_clear_fifos(up);
> +	serial8250_clear_and_disable_fifos(up);
>  	serial_in(up, UART_RX);
>  	if (up->capabilities & UART_CAP_UUE)
>  		serial_out(up, UART_IER, UART_IER_UUE);
> @@ -2210,7 +2211,7 @@ int serial8250_do_startup(struct uart_port *port)
>  	 * Clear the FIFO buffers and disable them.
>  	 * (they will be reenabled in set_termios())
>  	 */
> -	serial8250_clear_fifos(up);
> +	serial8250_clear_and_disable_fifos(up);
>  
>  	/*
>  	 * Clear the interrupt registers.
> @@ -2460,7 +2461,7 @@ void serial8250_do_shutdown(struct uart_port *port)
>  	 */
>  	serial_port_out(port, UART_LCR,
>  			serial_port_in(port, UART_LCR) & ~UART_LCR_SBC);
> -	serial8250_clear_fifos(up);
> +	serial8250_clear_and_disable_fifos(up);
>  
>  #ifdef CONFIG_SERIAL_8250_RSA
>  	/*
> 


-- 
Best regards,
Marek Vasut
