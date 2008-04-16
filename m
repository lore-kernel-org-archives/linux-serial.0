From: Haavard Skinnemoen <hskinnemoen@atmel.com>
Subject: Re: [2.6 patch] avr32: add include/asm-avr32/serial.h
Date: Wed, 16 Apr 2008 01:53:48 -0400
Message-ID: <20080416015348.5170cc64@siona.local>
References: <20080414141721.GI6695@cs181133002.pp.htv.fi>
	<20080414153625.6150e999@core>
	<20080414184220.GC6695@cs181133002.pp.htv.fi>
	<20080414225617.5d41a13b@core>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1761914AbYDPFyY@vger.kernel.org>
In-Reply-To: <20080414225617.5d41a13b@core>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Adrian Bunk <bunk@kernel.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Mon, 14 Apr 2008 22:56:17 +0100
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> > +/*
> > + * This assumes you have a 1.8432 MHz clock for your UART.
> > + *
> > + * It'd be nice if someone built a serial card with a 24.576 MHz
> > + * clock, since the 16550A is capable of handling a top speed of 1.5
> > + * megabits/second; but this requires the faster clock.
> > + */
> > +#define BASE_BAUD (1843200 / 16)
> > +
> > +#endif /* _ASM_SERIAL_H */  
> 
> Acked-by: Alan Cox <alan@redhat.com>

Not sure if that assumption is correct since I haven't heard of anyone
creating an avr32 board with a 16550A UART on it...

But I'm not going to be difficult about it. Applied this one and four
of the others:

Applying add include/asm-avr32/xor.h
Applying avr32: don't offer CONFIG_RTC
Applying avr32: don't offer CONFIG_GEN_RTC
Applying avr32: don't offer PARPORT_PC
Applying avr32: add include/asm-avr32/serial.h

I skipped the IDE one since Bart took it.

Thanks a lot!

Haavard
