From: "Mike Frysinger" <vapier.adi@gmail.com>
Subject: Re: should RTS init in serial core be tied to CRTSCTS
Date: Mon, 5 Mar 2007 13:13:14 -0500
Message-ID: <8bd0f97a0703051013u5732e127t598ae008e6f5894@mail.gmail.com>
References: <8bd0f97a0703011603m794e00f5x875eb68ad0db05de@mail.gmail.com>
	 <20070304194632.GC30345@flint.arm.linux.org.uk>
	 <8bd0f97a0703050909n18386114kd2c0b2a108591641@mail.gmail.com>
	 <20070305175604.GB18548@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752836AbXCESNR@vger.kernel.org>
In-Reply-To: <20070305175604.GB18548@flint.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org, Robin Getz <rgetz@blackfin.uclinux.org>
List-Id: linux-serial@vger.kernel.org

On 3/5/07, Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> On Mon, Mar 05, 2007 at 12:09:20PM -0500, Mike Frysinger wrote:
> > On 3/4/07, Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> > >On Thu, Mar 01, 2007 at 07:03:02PM -0500, Mike Frysinger wrote:
> > >> the console= bootcmd allows for controlling of the initial state of
> > >> flow control by adding/omitting the 'r' suffix ...
> > >
> > >The console command *only* sets the state for the kernel's use of one
> > >serial port.  It does not affect any other serial port, so tying
> > >random RTS behaviours into that command line option is absolutely
> > >silly.
> >
> > true ... so ignoring the original motivation for change i posted, is
> > it really correct for the serial core to be forcing TIOCM_RTS at uart
> > startup even though the uart doesnt have CTSRTS flow control enabled ?
> > in other words, my change is agnostic of the console, and is done for
> > all uarts ... it should prob have a similar change in uart_shutdown()
> > though ...
>
> No idea - it's something that Linux has always done.  Neither do I have
> any idea if changing it will break anyones setup.  However, since I don't
> maintain serial anymore, I'm not about to start playing about with this
> trying to find out.

ok, i was going by Documentation/serial/driver:
... any questions you have should be directed to <rmk@arm.linux.org.uk>
guessing that should be updated ? :)

> Feel free to submit a patch to akpm to leave RTS alone when CRTSCTS is
> not set.  I'd recommend that it sits in -mm for about 6 months to really
> get an idea if it breaks anything.

sounds good to me, thanks
-mike
