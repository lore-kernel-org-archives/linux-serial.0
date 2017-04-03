From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [PATCH v2 0/5] minitty: a minimal TTY layer alternative for
 embedded systems
Date: Mon, 3 Apr 2017 15:50:53 -0400 (EDT)
Message-ID: <alpine.LFD.2.20.1704031433480.1847@knanqh.ubzr>
References: <20170401222119.25106-1-nicolas.pitre@linaro.org> <CAHp75VdGm2uVPBhfAge4Wx6WW2y52oddpOSfJgdYAfTUQPN7TQ@mail.gmail.com> <alpine.LFD.2.20.1704021149550.1847@knanqh.ubzr> <1491224186.3704.11.camel@linux.intel.com> <alpine.LFD.2.20.1704031121520.1847@knanqh.ubzr>
 <1491242719.3704.33.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1504494712-1491246934=:1847"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1491242719.3704.33.camel@linux.intel.com>
Content-ID: <alpine.LFD.2.20.1704031517040.1847@knanqh.ubzr>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Rob Herring <robh@kernel.org>, Peter Hurley <peter@hurleysoftware.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1504494712-1491246934=:1847
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.LFD.2.20.1704031516241.1847@knanqh.ubzr>

On Mon, 3 Apr 2017, Alan Cox wrote:

> > evertheless very convenient to be able to use a standard
> > shell 
> > with it.
> 
> A standard shell will work over things other than a tty device. It
> really doesn't care so long as it gets a stream of data punctuated by
> end of statement symbols. It'll work over pipes, sockets, from files.

But no job control. No line editing with echo when the shell is busy, 
etc.

And actually it is not the TTY support per se that takes the most code. 
Just the chardev read/write/poll/open/release stuff is rather 
significant. Removing canonical support makes it 7.3K down from 8K. 
Removing echo support makes it down to 7.2K. Removing baudrate support = 
7.0K. Copying termios to/from user space is horrid: removing that and 
we're down to 5.6K. At which point there's only a raw device interface 
to serial hardware.

> > I beg to disagree here.  First, before you call my code "totally 
> > unmaintainable" I'd politely ask you to have a look at it first.
> 
> I said the combination makes it more unmaintainable. If you have two
> tty layers one of them faking the API of the other at various interface
> points then if the core tty layer wants to make a major change it no
> longer can - because it'll break the other tty layer. In addition I
> worry it won't be long before someone wants kgdb, gdbstubs and sysrq
> over the cut down console and on it will go.

sysrq is already there. It is handled directly at the UART driver level. 
I didn't have to do anything for it.

Isn't kgdb and gdbstubs the same thing?  In any case the TTY layer is 
also already completely bypassed in that case. Those are in fact just 
like kernel console targets that also can read and not just write.

Again, what I'm using is the same low-level UART interface as 
drivers/tty/serial/serial_core.c is using to interact with UART drivers. 
If someone wants to make a change to that interface, the 30 or so UART 
drivers will have to be changed as well. I don't think that would be a 
big deal to change the minitty code to follow suit. And I won't hide 
under a rock while this happens.

If you're making a change in any of the rest of the existing TTY stack, 
then my code won't care as it does not interact with it. I'm not even 
using tty_struct at all!

> The uart layer is also known broken as an API - it is itself bloated
> and over-locking (for example if it was being written today kfifo would
> be used). What happens if we want to abolish it or encourage people to
> move away from it (as we IMHO should be) ?

Same answer as above.

> The serio code started with exactly the same problem, but now at least
> talks tty layer. In your case you are tying it to something we
> eventually ought to get rid of.

You won't get rid of UART drivers, right?

> I also find the large scale need for it hard to believe. If you are
> within 64K of running out of memory on your debug/devel device how are
> you going to have space to fix security holes and do upgrades as they
> occur in production (where presumably you don't need the tty driver) ?

Some production devices can do it all in much less RAM than that and 
they are being connected to the net. Don't worry, that's not where I see 
any Linux derivative go.

Some devices, though, have 256K of on-chip RAM. Those devices will make 
it into your surrounding. Having so much more RAM (no pun intended) 
they'll be capable of even more damage. Would you be more confident, 
when a security issue arises (because it will), to know that some Linux 
code base is used rather than any random RTOS out there with only one 
hundredth of the actual Linux following? If so please indulge me a bit.

> The kernel doesn't exactly get smaller each release.

No kidding.

This is why a slight shift in the Linux model has to be accommodated 
for. We cannot just have a single subsystem to scale to both extremes 
all the time anymore.  We already have different memory allocators for 
different sizes and needs so precedents do exist.

The greatest value in Linux his its interfaces. Doesn't matter if the 
kernel internal interfaces change, the value is in having common 
interfaces for all Linux developers available anywhere. We should allow 
for parallel implementations of subsystems as long as they remain 
interchangeable. Hence this mini TTY alternative, and that's only the 
beginning.

I'd invite you to read more of the rationale for that here:

https://lkml.org/lkml/2017/3/24/634

It's rather long and I don't want to repeat it all.


Nicolas
--8323328-1504494712-1491246934=:1847--
