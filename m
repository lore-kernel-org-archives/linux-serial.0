From: Sean Young <sean@mess.org>
Subject: Re: console issue since 3.6, console=ttyS1 hangs
Date: Wed, 19 Oct 2016 10:07:19 +0100
Message-ID: <20161019090719.GA1764@gofer.mess.org>
References: <20161017144951.GA235535@stormcage.americas.sgi.com>
 <20161017151906.GA19082@gofer.mess.org>
 <20161017164140.GA35950@stormcage.americas.sgi.com>
 <20161018164004.GA159046@stormcage.americas.sgi.com>
 <20161018180518.GA28700@gofer.mess.org>
 <20161018192930.GA207959@stormcage.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161018192930.GA207959@stormcage.americas.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nathan Zimmer <nzimmer@sgi.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, gregkh@linuxfoundation.org, alan@linux.intel.com
List-Id: linux-serial@vger.kernel.org

On Tue, Oct 18, 2016 at 02:29:30PM -0500, Nathan Zimmer wrote:
> On Tue, Oct 18, 2016 at 07:05:18PM +0100, Sean Young wrote:
> > On Tue, Oct 18, 2016 at 11:40:04AM -0500, Nathan Zimmer wrote:
> > > 3.7.0
> > > cat /sys/bus/pnp/drivers/serial/*/resources
> > > state = active
> > > io 0x2f8-0x2ff
> > > irq 12
> > > dma disabled
> > > 
> > > 3.6.0
> > > :~ # cat /sys/bus/pnp/drivers/serial/*/resources
> > > cat: /sys/bus/pnp/drivers/serial/*/resources: No such file or directory
> > 
> > irq 12 for ttyS1? That should be irq 3. The bios is putting bogus information
> > in pnp. Maybe there is rubbish in the bios setup or maybe it's fixed in a 
> > newer bios update.
> > 
> > So before this change, the kernel would assume irq 3. After this change,
> > the kernel first uses the information in pnp to see where the serial
> > port is. It gets told that it's irq 12 and presumably it runs into all
> > sorts of problems then. If memory serves that's the irq for the ps/2 mouse.
> > 
> > The interesting bit is in 3.6.0:
> > 
> > setserial
> > /dev/ttyS1, UART: 16550A, Port: 0x02f8, IRQ: 3
> > 
> > becomes in 3.7.0:
> > 
> > setserial
> > /dev/ttyS1, UART: 16550A, Port: 0x02f8, IRQ: 12
> > 
> > You should be able to set the right irq with setserial, but obviously
> > that doesn't help you if it fails in early boot. It's not immediately
> > obvious to me what can be done in the kernel for this. Maybe the dmesg
> > output could inspire, thanks.
> 
> Yea the changing irq seemed weird to me too but I couldn't manage a guess to why.
> 
> Here are the dmesgs.

So with 3.6.0:

> [    2.079980] Serial: 8250/16550 driver, 8 ports, IRQ sharing disabled
> [    2.100887] serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
> [    2.101715] serial 00:04: unable to assign resources
> [    2.102174] serial: probe of 00:04 failed with error -16

The pnp probe fails for some reason. I don't understand why.

With 3.7.0:

> [    2.062700] Serial: 8250/16550 driver, 8 ports, IRQ sharing disabled
> [    2.063250] serial 00:04: [io  0x02f8-0x02ff]
> [    2.063875] serial 00:04: [irq 12]
> [    2.064345] serial 00:04: [dma 18446744073709551615 disabled]
> [    2.065540] serial 00:04: activated
> [    2.086442] 00:04: ttyS1 at I/O 0x2f8 (irq = 12) is a 16550A

Now the pnp probe succeeds (with broken irq from pnp).

Can you please check if there is a wrong irq configured in the bios setup
or if there is a bios update available? I don't know why this worked in
the first place.


Sean
