From: Sean Young <sean@mess.org>
Subject: Re: console issue since 3.6, console=ttyS1 hangs
Date: Tue, 18 Oct 2016 19:05:18 +0100
Message-ID: <20161018180518.GA28700@gofer.mess.org>
References: <20161017144951.GA235535@stormcage.americas.sgi.com>
 <20161017151906.GA19082@gofer.mess.org>
 <20161017164140.GA35950@stormcage.americas.sgi.com>
 <20161018164004.GA159046@stormcage.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161018164004.GA159046@stormcage.americas.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nathan Zimmer <nzimmer@sgi.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, gregkh@linuxfoundation.org, alan@linux.intel.com
List-Id: linux-serial@vger.kernel.org

On Tue, Oct 18, 2016 at 11:40:04AM -0500, Nathan Zimmer wrote:
> 3.7.0
> cat /sys/bus/pnp/drivers/serial/*/resources
> state = active
> io 0x2f8-0x2ff
> irq 12
> dma disabled
> 
> 3.6.0
> :~ # cat /sys/bus/pnp/drivers/serial/*/resources
> cat: /sys/bus/pnp/drivers/serial/*/resources: No such file or directory

irq 12 for ttyS1? That should be irq 3. The bios is putting bogus information
in pnp. Maybe there is rubbish in the bios setup or maybe it's fixed in a 
newer bios update.

So before this change, the kernel would assume irq 3. After this change,
the kernel first uses the information in pnp to see where the serial
port is. It gets told that it's irq 12 and presumably it runs into all
sorts of problems then. If memory serves that's the irq for the ps/2 mouse.

The interesting bit is in 3.6.0:

setserial
/dev/ttyS1, UART: 16550A, Port: 0x02f8, IRQ: 3

becomes in 3.7.0:

setserial
/dev/ttyS1, UART: 16550A, Port: 0x02f8, IRQ: 12

You should be able to set the right irq with setserial, but obviously
that doesn't help you if it fails in early boot. It's not immediately
obvious to me what can be done in the kernel for this. Maybe the dmesg
output could inspire, thanks.


Sean
