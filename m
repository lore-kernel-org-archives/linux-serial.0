From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [PATCH v2 0/5] minitty: a minimal TTY layer alternative for
 embedded systems
Date: Mon, 3 Apr 2017 12:06:55 -0400 (EDT)
Message-ID: <alpine.LFD.2.20.1704031121520.1847@knanqh.ubzr>
References: <20170401222119.25106-1-nicolas.pitre@linaro.org>
 <CAHp75VdGm2uVPBhfAge4Wx6WW2y52oddpOSfJgdYAfTUQPN7TQ@mail.gmail.com>
 <alpine.LFD.2.20.1704021149550.1847@knanqh.ubzr>
 <1491224186.3704.11.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1491224186.3704.11.camel@linux.intel.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Alan Cox <alan@linux.intel.com>
Cc: Rob Herring <robh@kernel.org>, Peter Hurley <peter@hurleysoftware.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Jiri Slaby <jslaby@suse.com>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

On Mon, 3 Apr 2017, Alan Cox wrote:

> If you need a tiny tiny tty layer console for some kind of not quite
> mini-Linux please just steal the one from Fuzix or something similar
> thats only a couple of K in size and only needs extremely simple send
> byte/rx byte type handlers.

This, however, requires that every UART driver be rewritten to suit this 
code. I don't want to lose one of Linux's best advantage which is 
extensive hardware support. I want to reuse as much of the existing 
hardware drivers as possible unchanged.

I already have code that fits the Linux model and it weights 
only 8K.

> Alternatively just compile out tty support entirely. What do you
> actually need ? Console doesn't need tty layer and if you have a
> debug/management interface that doesn't have to be tty and text based
> either.

It is nevertheless very convenient to be able to use a standard shell 
with it. I can easily remove canonical mode support and then it is down 
to 7.3K. Modem line control and runtime baudrate handling could also 
trivially be configured out for yet more saving.

> Being able to compile out tty support would be useful, having two tty
> layers that are intertwined and now both totally unmaintable is not
> IMHO progress.

I beg to disagree here.  First, before you call my code "totally 
unmaintainable" I'd politely ask you to have a look at it first.

There is also very little intertwining here. My code does not rely on 
the existing TTY code (except for the termios baudrate handling which I 
factored out). I'm creating my own char devices on one end and 
interacting with UART drivers using the same low-level call interface 
used by the existing code at the other end. And given that it is much 
simpler in termps of capabilities, it is also very easy to maintain.


Nicolas
