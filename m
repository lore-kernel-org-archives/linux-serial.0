From: Matt Schulte <matts@commtech-fastcom.com>
Subject: Re: [PATCH] serial/8250: Add support for Exar's XR17V35x family of
 multi-port PCIe UARTs.
Date: Sat, 10 Nov 2012 11:52:32 -0600
Message-ID: <CAJp1Oe652P=eGTQjo2aWwn2f0iMDz0dM172QjkBcZhx+O2_Ygw@mail.gmail.com>
References: <CAJp1Oe4DuffN_EWP-zVznBX+JqnE6kEAsXS1oHvfvfLC5DVOAw@mail.gmail.com>
 <20121109235800.745dcf15@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:47948 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751281Ab2KJRwx (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 10 Nov 2012 12:52:53 -0500
Received: by mail-vb0-f46.google.com with SMTP id ff1so4972381vbb.19
        for <linux-serial@vger.kernel.org>; Sat, 10 Nov 2012 09:52:52 -0800 (PST)
In-Reply-To: <20121109235800.745dcf15@pyramind.ukuu.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-serial@vger.kernel.org, Greg KH <greg@kroah.com>, Theodore Ts'o <tytso@mit.edu>

On Fri, Nov 9, 2012 at 5:58 PM, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>> @@ -1484,6 +1526,7 @@ EXPORT_SYMBOL_GPL(serial8250_modem_status);
>>  int serial8250_handle_irq(struct uart_port *port, unsigned int iir)
>>  {
>>       unsigned char status;
>> +     unsigned char int0, int1, int2, int3;
>>       unsigned long flags;
>>       struct uart_8250_port *up =
>>               container_of(port, struct uart_8250_port, port);
>> @@ -1503,6 +1546,19 @@ int serial8250_handle_irq(struct uart_port
>> *port, unsigned int iir)
>>       if (status & UART_LSR_THRE)
>>               serial8250_tx_chars(up);
>>
>> +     /*
>> +      * These Exar UARTs have an extra interrupt indicator that could
>> +      * fire for a few unimplemented interrupts.  Put this here just
>> +      * to be on the safe side that these interrupts don't go unhandled.
>> +      */
>> +
>> +     if (up->port.type == PORT_XR17V35X && status == 0) {
>> +             int0 = serial_port_in(port, 0x80);
>> +             int1 = serial_port_in(port, 0x81);
>> +             int2 = serial_port_in(port, 0x82);
>> +             int3 = serial_port_in(port, 0x83);
>> +     }
>> +
>>       spin_unlock_irqrestore(&port->lock, flags);
>>       return 1;
>
> Provide your own handle_irq method rather than adding more special cases
> to the default one (you can just wrap the default one and then perform
> the extra actions). Just a case of trying to keep the fast paths clean and
> maintainable.
>
> Otherwise looks good.
>
> Alan

Thanks Alan, would the new Exar_handle_irq method be allowed to be
inside 8250.c?

Matt
