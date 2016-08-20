From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [RFC PATCH 0/3] UART slave device bus
Date: Sat, 20 Aug 2016 14:22:26 +0100
Message-ID: <20160820142226.6121e76d@lxorguk.ukuu.org.uk>
References: <20160818011445.22726-1-robh@kernel.org>
        <20160818202900.hyvm4hfxedifuefn@earth>
        <CAL_Jsq+OfT1AXaEKOgZ4oVfpVZhu=55dYoHTG7D_prpnTqpeOg@mail.gmail.com>
        <20160819052125.ze5zilppwoe3f2lx@earth>
        <ACEF800E-8DB3-4345-ADE2-15C99F3659D5@goldelico.com>
        <20160819120631.5fe2af0d@lxorguk.ukuu.org.uk>
        <61F43885-BE05-482C-9AD6-B52A2DA166B8@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <61F43885-BE05-482C-9AD6-B52A2DA166B8@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marcel Holtmann <marcel@holtmann.org>, Jiri Slaby <jslaby@suse.com>, Pavel Machek <pavel@ucw.cz>, Peter Hurley <peter@hurleysoftware.com>, NeilBrown <neil@brown.name>, Arnd Bergmann <arnd@arndb.de>, Linus Walleij <linus.walleij@linaro.org>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Fri, 19 Aug 2016 19:42:37 +0200
"H. Nikolaus Schaller" <hns@goldelico.com> wrote:

> > Am 19.08.2016 um 13:06 schrieb One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>:
> >   
> >> If possible, please do a callback for every character that arrives.
> >> And not only if the rx buffer becomes full, to give the slave driver
> >> a chance to trigger actions almost immediately after every character.
> >> This probably runs in interrupt context and can happen often.  
> > 
> > We don't realistically have the clock cycles to do that on a low end
> > embedded processor handling high speed I/O.  
> 
> well, if we have a low end embedded processor and high-speed I/O, then
> buffering the data before processing doesn't help either since processing
> still will eat up clock cycles.

Of course it helps. You are out of the IRQ handler within the 9 serial
clocks, so you can take another interrupt and grab the next byte. You
will also get benefits from processing the bytes further in blocks, and
if you get too far behind you'll make the flow control limit.

You've also usually got multiple cores these days - although not on the
very low end quite often.

> The question is if this is needed at all. If we have a bluetooth stack with HCI the
> fastest UART interface I am aware of is running at 3 Mbit/s. 10 bits incl. framing
> means 300kByte/s equiv. 3µs per byte to process. Should be enough to decide
> if the byte should go to a buffer or not, check checksums, or discard and move
> the protocol engine to a different state. This is what I assume would be done in
> a callback. No processing needing some ms per frame.

That depends on the processor - remember people run Linux on low end CPUs
including those embedded in an FPGA not just high end PC and ARM class
devices.

The more important question is - purely for the receive side of things -
is a callback which guarantees to be called "soon" after the bytes arrive
sufficient.

If it is then almost no work is needed on the receive side to allow pure
kernel code to manage recevied data directly because the current
buffering support throughout the receive side is completely capable of
providing those services without a tty structure, and to anything which
can have a tty attached.

Doesn't solve transmit or configuration but it's one step that needs no
additional real work and re-invention.

Alan
