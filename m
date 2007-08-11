From: Michael Mauch <michael.mauch@gmx.de>
Subject: Re: Serial ports rearranged in 2.6.22?
Date: Sat, 11 Aug 2007 17:49:25 +0200
Message-ID: <20070811154925.GA9618@elmicha>
References: <20070810213925.GB10855@elmicha> <86802c440708102154r59e1acbj90fa0d5b73197fb9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1761363AbXHKPtn@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <86802c440708102154r59e1acbj90fa0d5b73197fb9@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Bjorn Helgaas <bjorn.helgaas@hp.com>
List-Id: linux-serial@vger.kernel.org

Yinghai Lu wrote:

> On 8/10/07, Michael Mauch <michael.mauch@gmx.de> wrote:
> > Hi,
> >
> > until 2.6.21, I had the normal assignments for ttyS0 and ttyS1:
> >
> > 00:08: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
> > 00:09: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
> >
> > With 2.6.22 I get the names <-> ports/irqs the other way around:
> >
> > 00:08: ttyS0 at I/O 0x2f8 (irq = 3) is a 16550A
> > 00:09: ttyS1 at I/O 0x3f8 (irq = 4) is a 16550A
> >
> > Is this supposed to be that way? Should we reassign these names with
> > udev? udev-114 doesn't seem to have built-in rules to assign the
> > traditional names.
> >
> > Or could it be related to some brokeness in my BIOS (ACPI/PNP)?
> >
> > I'm using the 8250_pnp module (and it's the same with builtin serial
> > modules). I made sure that I did not accidentally change the BIOS
> > settings for the serial ports.
> >
> > I'm using Gentoo, but on the lirc list was a Fedora user with the same
> > symptoms.
> 
> http://lkml.org/lkml/2007/7/25/455

Thanks - I applied that patch and the names are back to normal again:

00:06: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
00:07: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A

Regards...
		Michael
