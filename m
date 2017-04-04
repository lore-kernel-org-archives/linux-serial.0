From: Alan Cox <alan@linux.intel.com>
Subject: Re: [PATCH v2 0/5] minitty: a minimal TTY layer alternative for
 embedded systems
Date: Tue, 04 Apr 2017 14:40:28 +0100
Message-ID: <1491313228.3704.42.camel@linux.intel.com>
References: <20170401222119.25106-1-nicolas.pitre@linaro.org>
         <CAHp75VdGm2uVPBhfAge4Wx6WW2y52oddpOSfJgdYAfTUQPN7TQ@mail.gmail.com>
         <alpine.LFD.2.20.1704021149550.1847@knanqh.ubzr>
         <1491224186.3704.11.camel@linux.intel.com>
         <alpine.LFD.2.20.1704031121520.1847@knanqh.ubzr>
         <1491242719.3704.33.camel@linux.intel.com>
         <alpine.LFD.2.20.1704031433480.1847@knanqh.ubzr>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LFD.2.20.1704031433480.1847@knanqh.ubzr>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Rob Herring <robh@kernel.org>, Peter Hurley <peter@hurleysoftware.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

> But no job control. No line editing with echo when the shell is
> busy, 
> etc.

This is a debug interface. If RAM is that precious do the line editing
on the other end of the link, like normal sane RTOS people do. Most
terminal apps support line by line modes.

> we're down to 5.6K. At which point there's only a raw device
> interface 
> to serial hardware.

Which if you did a simple plain chardev without trying to fake the
rather out of date uart layer would come down way further still.

>  the same low-level UART interface as 
> drivers/tty/serial/serial_core.c is using to interact with UART
> drivers. 
> If someone wants to make a change to that interface, the 30 or so
> UART 
> drivers will have to be changed as well. I don't think that would be
> a 
> big deal to change the minitty code to follow suit. And I won't hide 
> under a rock while this happens.

Fair enough.


> > talks tty layer. In your case you are tying it to something we
> > eventually ought to get rid of.
> 
> You won't get rid of UART drivers, right?

Given infinite time the uart layer ought to go away and be replaced
with a simple kfifo queue.

> vices, though, have 256K of on-chip RAM. Those devices will
> make 
> it into your surrounding. Having so much more RAM (no pun intended) 
> they'll be capable of even more damage. Would you be more confident, 
> when a security issue arises (because it will), to know that some
> Linux 
> code base is used rather than any random RTOS out there with only
> one 
> hundredth of the actual Linux following? If so please indulge me a
> bit.

Actually for any safety critical system both terrify me about as much.
None of them are generally written to any appropriate ISO safety
standard, or in an appropriate language.

I did read your rationale. I am deeply dubious that re-doing the uart
layer is the right approach versus just doing a tiny char device, but
I've said my piece.

Alan
