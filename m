From: Alan Cox <alan@linux.intel.com>
Subject: Re: [PATCH v2 0/5] minitty: a minimal TTY layer alternative for
 embedded systems
Date: Mon, 03 Apr 2017 13:56:26 +0100
Message-ID: <1491224186.3704.11.camel@linux.intel.com>
References: <20170401222119.25106-1-nicolas.pitre@linaro.org>
         <CAHp75VdGm2uVPBhfAge4Wx6WW2y52oddpOSfJgdYAfTUQPN7TQ@mail.gmail.com>
         <alpine.LFD.2.20.1704021149550.1847@knanqh.ubzr>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LFD.2.20.1704021149550.1847@knanqh.ubzr>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Pitre <nicolas.pitre@linaro.org>, Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Peter Hurley <peter@hurleysoftware.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

On Sun, 2017-04-02 at 11:55 -0400, Nicolas Pitre wrote:
> On Sun, 2 Apr 2017, Andy Shevchenko wrote:
> 
> > 
> > +Cc people, who have a key roles in all TTY stuff (btw, why you did
> > miss them?
> 
> I used what MAINTAINERS and get_maintainer.pl gave me.
> 

I didn't see this until now as I'm mid house move so not following a
lot of l/k.

If you need a tiny tiny tty layer console for some kind of not quite
mini-Linux please just steal the one from Fuzix or something similar
thats only a couple of K in size and only needs extremely simple send
byte/rx byte type handlers.

Alternatively just compile out tty support entirely. What do you
actually need ? Console doesn't need tty layer and if you have a
debug/management interface that doesn't have to be tty and text based
either.

Being able to compile out tty support would be useful, having two tty
layers that are intertwined and now both totally unmaintable is not
IMHO progress.

Alan
