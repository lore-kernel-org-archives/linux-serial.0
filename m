From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH] tty: serial: men_z135_uart.c: Fix race between IRQ and
 set_termios()
Date: Wed, 05 Aug 2015 15:17:37 -0400
Message-ID: <55C26151.5080004@hurleysoftware.com>
References: <1438610285-1441-1-git-send-email-jthumshirn@suse.de>	<55BF893C.1000901@hurleysoftware.com>	<mqdbnenv8ml.fsf@c203.arch.suse.de>	<55C0D6DC.3020706@hurleysoftware.com> <mqdvbcu40sy.fsf@c203.arch.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <mqdvbcu40sy.fsf@c203.arch.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Andreas Werner <andreas.werner@men.de>
List-Id: linux-serial@vger.kernel.org

On 08/05/2015 04:06 AM, Johannes Thumshirn wrote:
> Peter Hurley <peter@hurleysoftware.com> writes:
> 
>> On 08/04/2015 03:02 AM, Johannes Thumshirn wrote:
>>> Peter Hurley <peter@hurleysoftware.com> writes:
>>>> On 08/03/2015 09:58 AM, Johannes Thumshirn wrote:
>>>>> Fix panic caused by a race between men_z135_intr() and men_z135_set_termios().
>>>>>
>>>>> men_z135_intr() and men_z135_set_termios() both hold the struct uart_port::lock
>>>>> spinlock, but men_z135_intr() does a spin_lock_irqsave() and
>>>>> men_z135_set_termios() does a normal spin_lock(), which can lead to a deadlock
>>>>> when an interrupt is called while the lock is being helt by
>>>>> men_z135_set_termios().
>>>>
>>>>
>>>> The irq handler can and should use normal spin_lock()/unlock().
>>>
>>> I always thought an irq handler _must_ use the irqsave versions. Good to
>>> know that.
>>
>> Your irq handler does not need to protect itself from re-entrancy (by using
>> the same irq handler for different irqs) and your serial driver doesn't support
>> console (so can't be deadlocked by printk() usage either).
>>
> 
> So once we have console support (I don't know if this is planned at
> all), we must go back to the irqsave variant?

Depends on if the platform for this hardware always disables irqs for interrupt
handlers. If it does, then the irqsave variant _in the interrupt handler_ is
not required.


> But looking at the driver
> again I have the feeling that the locking could be made more fine
> grained (if this makes sense) and I saw two possible races, please
> correct me if I'm wrong.
> 
> men_z135_intr() reads the status register and saves a copy in struct
> men_z135_port::stat_reg. The men_z135_handle_lsr() and
> men_z135_handle_modem_status() functions use this stat_reg value to get
> to the LSR and MSR registers. But in the meanwhile the content of the
> registers could have been changed by men_z135_intr() again. Is this a
> problem or am I on the wrong track here?

The irq handler itself can _never_ be re-entered (as long as the handler only
handles one irq # for a given device). So the race(s) outlined above can never
happen _regardless of which flavor spinlock is used_.

Regards,
Peter Hurley


>>>> The set_termios() method should used spin_lock_irq(); there's no need to save the
>>>> interrupt state because that method will never be called from interrupt context.
>>>>
>>>> So the 'flags' local can be dropped from the patch.
>>>
>>> Given that the irqsave variant isn't needed that sounds reasonable.
>>
>> It's for a different reason; irqs will _always_ be on when your driver's
>> set_termios() method is called. So you don't see to save the irq state, because
>> you know it's always on. That's why you can use the spin_lock_irq()/spin_unlock_irq()
>> version here.
>>
>>>> Also, the port lock is already initialized in uart_add_one_port() and should
>>>> not be initialized by the probe() function.
>>>
>>> OK, do you prefer (or better Greg and Jiri) prefer that change folded
>>> into this patch or an extra patch?
>>
>> Separate patch please.
> 
> OK.
> 
>>
>> I assume this deadlock fix will need to be pushed to -stable as well,
>> yes?
> 
> I wasn't quite sure about this, I 1st had a CC stable for v4.0+ but
> then removed it again before sending the patch. So I'll put it back in.
> 
> Thanks,
>         Johannes
> 
