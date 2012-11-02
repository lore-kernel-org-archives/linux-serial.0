From: Matt Schulte <matts@commtech-fastcom.com>
Subject: Re: New serial card development
Date: Fri, 2 Nov 2012 13:47:25 -0500
Message-ID: <CAJp1Oe7Gsi_5jYQwj8xdLRBqTQEvOWMwAoa2e4CDZH5FD5ZbVw@mail.gmail.com>
References: <5074703E.408@commtech-fastcom.com> <20121014093704.GA6207@thunk.org>
 <CAJp1Oe6F+KiXoWdhb7JjbYmNBY4gxbtBzwNu0gWC7XzA_ZJxMg@mail.gmail.com>
 <20121016002608.64b33de5@pyramind.ukuu.org.uk> <20121016023226.GA17446@thunk.org>
 <CAJp1Oe4n-TtxDM8D82bFQxjBtx8rSAX8mWrFk0bSM6uGL9X=Eg@mail.gmail.com>
 <20121019212158.GB4721@thunk.org> <CAJp1Oe6ekkaZ29iwJ91VXwM_CSL6Z0_KEaqVQTa1XMzTB5niEQ@mail.gmail.com>
 <CAJp1Oe67Jd+FaaDPosexrVrrUFS=c-0FUZx_JHTbpTN5RCCcUw@mail.gmail.com>
 <20121023183859.GA3317@kroah.com> <CAJp1Oe7MMuk8TNBom2EDXx6UBdMV6qAE5fDdKTZ0o-329QSdaA@mail.gmail.com>
 <CAJp1Oe7Lk2q6v+5jrj2wD4cW=M9LX6kkia=AQnJKOiUEod5uRQ@mail.gmail.com>
 <CAJp1Oe4cnWot=wgou91dea81hHNxo8RWOPwXJj3o+JL4zOwQpg@mail.gmail.com> <20121101222619.12bb9c50@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:34534 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932260Ab2KBSrq (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 2 Nov 2012 14:47:46 -0400
Received: by mail-vb0-f46.google.com with SMTP id ff1so4091076vbb.19
        for <linux-serial@vger.kernel.org>; Fri, 02 Nov 2012 11:47:45 -0700 (PDT)
In-Reply-To: <20121101222619.12bb9c50@pyramind.ukuu.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Greg KH <greg@kroah.com>, Theodore Ts'o <tytso@mit.edu>, linux-serial@vger.kernel.org

On Thu, Nov 1, 2012 at 5:26 PM, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>> Hello, the next question that I have is how to handle the interrupts
>> on this UART.  It has a more complex interrupt scheme than a
>> traditional 8250 UART.  There is a global ISR register that tells you
>> which port had the interrupt and then there is another set of
>> registers that hold the actual interrupts.
>
> port->handle_irq is half of what you need, but you probably need to be
> able to hook serial8250_interruot and provide your own alternative. Given
> you don't need the irq chain handling either probably the bit that wants
> to be hookable is the calls to serial_link_irq_chain and
> serial_unlink_irq_chain in the startup/shutdown methods.
>
> In yor case all that and all the irq scanning the chain becomes a simple
> read of the port and call of the handlers (serial8250_handlee_irq(port,
> iir)

To be clear, I shouldn't put a custom irq handler inside 8250.c, correct?

I would want to do something along the vein of 8250_dw.c with a custom
probe and a custome handle_irq?

Matt Schulte
