From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: [PATCH] serial: core: fix console problems on uart_close
Date: Tue, 25 Oct 2016 15:29:05 +0200
Message-ID: <1477402145.4332.11.camel@gmail.com>
References: <20161024205649.32430-1-robh@kernel.org>
         <CAMuHMdUtp9w6RE0abNZ3q3h7viH7bkGA0iqOM7Azo3kgHq4K-w@mail.gmail.com>
         <1477400150.4332.9.camel@gmail.com>
         <CAL_JsqKE1-Y+1mrJAzr87Vv=bpYHN-qKQ4tOf+fKNZ1uFSTSMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAL_JsqKE1-Y+1mrJAzr87Vv=bpYHN-qKQ4tOf+fKNZ1uFSTSMQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Niklas =?ISO-8859-1?Q?S=F6derlund?= <niklas.soderlund+renesas@ragnatech.se>, Mugunthan V N <mugunthanvnm@ti.com>, Geert Uytterhoeven <geert+renesas@glider.be>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Peter Hurley <peter@hurleysoftware.com>, Alan Cox <alan@linux.intel.com>, Jiri Slaby <jslaby@suse.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Tue, 2016-10-25 at 08:25 -0500, Rob Herring wrote:
> On Tue, Oct 25, 2016 at 7:55 AM, Mike Galbraith
> <umgwanakikbuti@gmail.com> wrote:
> > On Tue, 2016-10-25 at 12:40 +0200, Geert Uytterhoeven wrote:
> > 
> > > Mike: I see you are using a PC, while I'm using an ARM board (with DT).
> > > Are you using a serial console? If yes, what's the value of port->console
> > > before and after the call to uart_console() that Rob's patch below removes?
> > 
> > Well, it's a bit larger than the average PC, it's a 64 core HP DL980,
> > and my console is its virtual serial port.
> > 
> > [   15.217487] Serial: 8250/16550 driver, 32 ports, IRQ sharing disabled
> > [   15.228212] MIKE port:ffff880276400000 port->console:0
> > [   15.240889] MIKE port:ffff880276400000 port->console:0
> > [   15.269606] 00:03: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
> > [   15.282538] MIKE port:ffff8802764001a8 port->console:0
> > [   15.293195] MIKE port:ffff8802764001a8 port->console:1
> > [   15.322806] serial8250: ttyS1 at I/O 0x2f8 (irq = 3, base_baud = 115200) is a 16550A
> > (30 more calls, all 0 pre 0 post)
> > 
> > That's with the below from Jiri Slaby applied to quell the reboot time
> > explosion.
> 
> This alone is enough to fix things for you?

Yup.

	-Mike
