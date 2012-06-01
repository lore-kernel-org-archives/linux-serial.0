From: Darren Hart <dvhart@linux.intel.com>
Subject: Re: [RFC PATCH] pch_uart: Add eg20t_port lock field, avoid recursive
 spinlocks
Date: Fri, 01 Jun 2012 11:36:29 -0700
Message-ID: <4FC90BAD.3080606@linux.intel.com>
References: <8854635ac5471f8671b93c65e3663eb1cb204c9d.1338454156.git.dvhart@linux.intel.com> <CANKRQnhZErpvcsRW3ukNzY0_zv4x=5OzQ-sr+aeuxL63=tQ=4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:61689 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932756Ab2FAShd (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 1 Jun 2012 14:37:33 -0400
In-Reply-To: <CANKRQnhZErpvcsRW3ukNzY0_zv4x=5OzQ-sr+aeuxL63=tQ=4A@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Tomoya MORINAGA <tomoya.rohm@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Feng Tang <feng.tang@intel.com>, Alexander Stein <alexander.stein@systec-electronic.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <alan@linux.intel.com>, linux-serial@vger.kernel.org



On 06/01/2012 01:30 AM, Tomoya MORINAGA wrote:
> On Thu, May 31, 2012 at 5:54 PM, Darren Hart <dvhart@linux.intel.com> wrote:
>> @@ -1376,7 +1379,8 @@ static void pch_uart_set_termios(struct uart_port *port,
>>
>>        baud = uart_get_baud_rate(port, termios, old, 0, port->uartclk / 16);
>>
>> -       spin_lock_irqsave(&port->lock, flags);
>> +       spin_lock_irqsave(&priv->lock, flags);
>> +       spin_lock(&port->lock);
>>
>>        uart_update_timeout(port, termios->c_cflag, baud);
>>        rtn = pch_uart_hal_set_line(priv, baud, parity, bits, stb);
>> @@ -1389,7 +1393,8 @@ static void pch_uart_set_termios(struct uart_port *port,
>>                tty_termios_encode_baud_rate(termios, baud, baud);
>>
>>  out:
>> -       spin_unlock_irqrestore(&port->lock, flags);
>> +       spin_unlock(&port->lock);
>> +       spin_unlock_irqrestore(&priv->lock, flags);
>>  }
> 
> Are both port->lock and priv->lock really necessary ?

The priv lock protects the pch_uart_hal* calls and the io access.

The port lock protects the uart_update_timeout call. I'm assuming the
8250.c driver is correct in holding the port lock before making this
call and making other modifcations to the port struct.

So yes, I believe both are required. The port->lock was used as the lock
to protect the private data in the interrupt handler,
pch_uart_interrupt. If we could avoid holding that lock across the
entire function, limiting it to just around the pch_uart_hal calls
(perhaps by adding it to the hal calls and adding lockless __pch_uart*
calls) we could avoid the recursive lock that occurs with handle_rx. I
still think a priv-lock is a good idea though, even if just to clarify
what is being protected.

Thoughts?

> 
> 
>> @@ -1572,7 +1578,9 @@ pch_console_write(struct console *co, const char *s, unsigned int count)
>>
>>        if (locked)
>>                spin_unlock(&priv->port.lock);
>> +       spin_unlock(&priv->lock);
>>        local_irq_restore(flags);
>> +
>>  }
> 
> Looks spare blank line.

Thanks, will fix for V2 after this discussion wraps up.

> 
> thanks.

-- 
Darren Hart
Intel Open Source Technology Center
Yocto Project - Linux Kernel
