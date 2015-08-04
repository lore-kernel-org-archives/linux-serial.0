From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH] tty: serial: men_z135_uart.c: Fix race between IRQ and
 set_termios()
Date: Tue, 04 Aug 2015 11:14:36 -0400
Message-ID: <55C0D6DC.3020706@hurleysoftware.com>
References: <1438610285-1441-1-git-send-email-jthumshirn@suse.de>	<55BF893C.1000901@hurleysoftware.com> <mqdbnenv8ml.fsf@c203.arch.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <mqdbnenv8ml.fsf@c203.arch.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Andreas Werner <andreas.werner@men.de>
List-Id: linux-serial@vger.kernel.org

On 08/04/2015 03:02 AM, Johannes Thumshirn wrote:
> Peter Hurley <peter@hurleysoftware.com> writes:
>> On 08/03/2015 09:58 AM, Johannes Thumshirn wrote:
>>> Fix panic caused by a race between men_z135_intr() and men_z135_set_termios().
>>>
>>> men_z135_intr() and men_z135_set_termios() both hold the struct uart_port::lock
>>> spinlock, but men_z135_intr() does a spin_lock_irqsave() and
>>> men_z135_set_termios() does a normal spin_lock(), which can lead to a deadlock
>>> when an interrupt is called while the lock is being helt by
>>> men_z135_set_termios().
>>
>>
>> The irq handler can and should use normal spin_lock()/unlock().
> 
> I always thought an irq handler _must_ use the irqsave versions. Good to
> know that.

Your irq handler does not need to protect itself from re-entrancy (by using
the same irq handler for different irqs) and your serial driver doesn't support
console (so can't be deadlocked by printk() usage either).

>> The set_termios() method should used spin_lock_irq(); there's no need to save the
>> interrupt state because that method will never be called from interrupt context.
>>
>> So the 'flags' local can be dropped from the patch.
> 
> Given that the irqsave variant isn't needed that sounds reasonable.

It's for a different reason; irqs will _always_ be on when your driver's
set_termios() method is called. So you don't see to save the irq state, because
you know it's always on. That's why you can use the spin_lock_irq()/spin_unlock_irq()
version here.

>> Also, the port lock is already initialized in uart_add_one_port() and should
>> not be initialized by the probe() function.
> 
> OK, do you prefer (or better Greg and Jiri) prefer that change folded
> into this patch or an extra patch?

Separate patch please.

I assume this deadlock fix will need to be pushed to -stable as well, yes?

Regards,
Peter Hurley

>>> This was discovered using a insmod, hardware looppback send/receive, rmmod
>>> stress test.
>>>
>>> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
>>> Cc: Andreas Werner <andreas.werner@men.de>
>>> ---
>>>  drivers/tty/serial/men_z135_uart.c | 5 +++--
>>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/tty/serial/men_z135_uart.c b/drivers/tty/serial/men_z135_uart.c
>>> index 35c5550..d020435 100644
>>> --- a/drivers/tty/serial/men_z135_uart.c
>>> +++ b/drivers/tty/serial/men_z135_uart.c
>>> @@ -656,6 +656,7 @@ static void men_z135_set_termios(struct uart_port *port,
>>>  				struct ktermios *old)
>>>  {
>>>  	struct men_z135_port *uart = to_men_z135(port);
>>> +	unsigned long flags;
>>>  	unsigned int baud;
>>>  	u32 conf_reg;
>>>  	u32 bd_reg;
>>> @@ -717,7 +718,7 @@ static void men_z135_set_termios(struct uart_port *port,
>>>  
>>>  	baud = uart_get_baud_rate(port, termios, old, 0, uart_freq / 16);
>>>  
>>> -	spin_lock(&port->lock);
>>> +	spin_lock_irqsave(&port->lock, flags);
>>>  	if (tty_termios_baud_rate(termios))
>>>  		tty_termios_encode_baud_rate(termios, baud, baud);
>>>  
>>> @@ -725,7 +726,7 @@ static void men_z135_set_termios(struct uart_port *port,
>>>  	iowrite32(bd_reg, port->membase + MEN_Z135_BAUD_REG);
>>>  
>>>  	uart_update_timeout(port, termios->c_cflag, baud);
>>> -	spin_unlock(&port->lock);
>>> +	spin_unlock_irqrestore(&port->lock, flags);
>>>  }
>>>  
>>>  static const char *men_z135_type(struct uart_port *port)
>>>
>>
> 
