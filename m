From: Robert Baldyga <r.baldyga@samsung.com>
Subject: Re: [PATCH v2 3/4] serial: samsung: introduce
 s3c24xx_serial_rx_drain_fifo() function
Date: Tue, 15 Sep 2015 14:42:45 +0200
Message-ID: <55F81245.1070302@samsung.com>
References: <1441892476-14273-1-git-send-email-r.baldyga@samsung.com>
 <1441892476-14273-4-git-send-email-r.baldyga@samsung.com>
 <55F27197.8020402@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <55F27197.8020402@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>, gregkh@linuxfoundation.org
Cc: jslaby@suse.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, m.szyprowski@samsung.com
List-Id: linux-serial@vger.kernel.org

On 09/11/2015 08:15 AM, Krzysztof Kozlowski wrote:
> On 10.09.2015 22:41, Robert Baldyga wrote:
>> This patch introduces s3c24xx_serial_rx_drain_fifo() which reads data
>> from RX FIFO and writes it to tty buffer. It also checks for special
>> conditions (such as 'break') and handles it. This function has been
>> separated from s3c24xx_serial_rx_chars_pio() as it contains code which
>> can be used also in DMA mode.
> 
> Much better, thanks! Now it is also easier to spot the difference (see
> below).
> 
>>
>> Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
>> ---
>>  drivers/tty/serial/samsung.c | 23 +++++++++++++----------
>>  1 file changed, 13 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
>> index dc4be54..1d7dd86 100644
>> --- a/drivers/tty/serial/samsung.c
>> +++ b/drivers/tty/serial/samsung.c
>> @@ -621,16 +621,12 @@ finish:
>>  	return IRQ_HANDLED;
>>  }
>>  
>> -static irqreturn_t s3c24xx_serial_rx_chars_pio(void *dev_id)
>> +static void s3c24xx_serial_rx_drain_fifo(struct s3c24xx_uart_port *ourport)
>>  {
>> -	struct s3c24xx_uart_port *ourport = dev_id;
>>  	struct uart_port *port = &ourport->port;
>>  	unsigned int ufcon, ch, flag, ufstat, uerstat;
>> -	unsigned long flags;
>>  	int max_count = port->fifosize;
>>  
>> -	spin_lock_irqsave(&port->lock, flags);
>> -
>>  	while (max_count-- > 0) {
>>  		ufcon = rd_regl(port, S3C2410_UFCON);
>>  		ufstat = rd_regl(port, S3C2410_UFSTAT);
>> @@ -654,9 +650,7 @@ static irqreturn_t s3c24xx_serial_rx_chars_pio(void *dev_id)
>>  					ufcon |= S3C2410_UFCON_RESETRX;
>>  					wr_regl(port, S3C2410_UFCON, ufcon);
>>  					rx_enabled(port) = 1;
>> -					spin_unlock_irqrestore(&port->lock,
>> -							flags);
>> -					goto out;
>> +					return;
>>  				}
>>  				continue;
>>  			}
>> @@ -702,10 +696,19 @@ static irqreturn_t s3c24xx_serial_rx_chars_pio(void *dev_id)
>>  				 ch, flag);
>>  	}
>>  
>> -	spin_unlock_irqrestore(&port->lock, flags);
>>  	tty_flip_buffer_push(&port->state->port);
> 
> Here is a difference - previously this was outside of spinlock. I think
> moving it inside spin lock is okay, just the interrupts won't be
> disabled before unlock and queue_work() from tty_flip_buffer_push().
> 
> However after testing this patchset (entire) on:
> next-20150910 + my dt-for-next branch (dma for serial) + this patchset
> you can see quite complicated lockdep warning:
> 
> [    3.568657] =========================================================
> [    3.575079] [ INFO: possible irq lock inversion dependency detected ]
> [    3.581506] 4.2.0-next-20150910-00009-g65fd5a9cff54 #218 Not tainted
> [    3.587838] ---------------------------------------------------------
> [    3.594263] swapper/0/0 just changed the state of lock:
> [    3.599470]  (&port_lock_key){..-...}, at: [<c02a8fac>]
> s3c24xx_serial_tx_dma_complete+0x8c/0xfc
> [    3.608237] but this lock took another, SOFTIRQ-unsafe lock in the past:
> [    3.614919]  (&(&ctx->lock)->rlock){+.+...}
> [    3.614919]
> [    3.614919] and interrupts could create inverse lock ordering between
> them.
> [    3.614919]
> [    3.625076]
> [    3.625076] other info that might help us debug this:
> [    3.631586]  Possible interrupt unsafe locking scenario:
> [    3.631586]
> [    3.638356]        CPU0                    CPU1
> [    3.642870]        ----                    ----
> [    3.647382]   lock(&(&ctx->lock)->rlock);
> [    3.651376]                                local_irq_disable();
> [    3.657278]                                lock(&port_lock_key);
> [    3.663267]                                lock(&(&ctx->lock)->rlock);
> [    3.669777]   <Interrupt>
> [    3.672381]     lock(&port_lock_key);
> 
> 
> Config: exynos, disabled MMC_CLKGATE, enabled usual testing stuff
> Board: Trats2
> 
> Didn't you notice it?
> 
> 
> Additionally the SysRq "Show backtrace of all active CPUs" on this
> linux-next (without additional patches, pure next) has significant delay
> (like 5 seconds) and a:
> [  169.221223] s3c-i2c 138d0000.i2c: timeout waiting for bus idle
> 
> That's weird. But as I said this occurs on pure next as well.
> 

I've noticed that commit [1] reveals the problem, but in result of git
bisect (at each step I was applying [1]) I got:

d71fc239b6915a8b750e9a447311029ff45b6580 is the first bad commit

That points to [2], which looks strange to me. However bug seems to be
unrelated to my patches, so I will send v3 soon.

[1] commit: 22374fbedb2ce03ef81323b3f7ceb3fa29344aa6
    "ARM: dts: Add DMA support for serial ports in exynos4"

[2] commit: d71fc239b6915a8b750e9a447311029ff45b6580
    "Merge tag 'armsoc-late' of
git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc"


Best regards,
Robert Baldyga

> 
>> +}
>> +
>> +static irqreturn_t s3c24xx_serial_rx_chars_pio(void *dev_id)
>> +{
>> +	struct s3c24xx_uart_port *ourport = dev_id;
>> +	struct uart_port *port = &ourport->port;
>> +	unsigned long flags;
>> +
>> +	spin_lock_irqsave(&port->lock, flags);
>> +	s3c24xx_serial_rx_drain_fifo(ourport);
>> +	spin_unlock_irqrestore(&port->lock, flags);
>>  
>> -out:
>>  	return IRQ_HANDLED;
>>  }
>>  
>>
> 
