From: Sean Young <sean@mess.org>
Subject: Re: console issue since 3.6, console=ttyS1 hangs
Date: Tue, 25 Oct 2016 21:41:40 +0100
Message-ID: <20161025204139.GA22268@gofer.mess.org>
References: <20161017164140.GA35950@stormcage.americas.sgi.com>
 <20161018164004.GA159046@stormcage.americas.sgi.com>
 <20161018180518.GA28700@gofer.mess.org>
 <20161018192930.GA207959@stormcage.americas.sgi.com>
 <20161019090719.GA1764@gofer.mess.org>
 <29b311e3-a26e-81de-82cf-e0a202db6d96@sgi.com>
 <20161020201051.GA29324@gofer.mess.org>
 <49f038af-5cb7-e76f-e4e9-57fad876710d@sgi.com>
 <20161024135235.GA29984@gofer.mess.org>
 <20161024214925.GA143272@stormcage.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161024214925.GA143272@stormcage.americas.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nathan Zimmer <nzimmer@sgi.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, gregkh@linuxfoundation.org, alan@linux.intel.com
List-Id: linux-serial@vger.kernel.org

On Mon, Oct 24, 2016 at 04:49:25PM -0500, Nathan Zimmer wrote:
> [    0.974874] system 00:03: Plug and Play ACPI device, IDs PNP0c02 (active)
> [    0.975038] pnp 00:04: parse resource options
> [    0.975048] pnp 00:04:   dependent set 0 (acceptable) io  min 0x2f8 max 0x2f8 align 1 size 8 flags 0x1
> [    0.975056] pnp 00:04:   dependent set 0 (acceptable) irq 3 4 5 6 7 10 11 12 flags 0x1
> [    0.975060] pnp 00:04:   dependent set 0 (acceptable) dma <none> (bitmask 0x0) flags 0x0

So here the bios claims that the serial port can use any of 3 to 12 irqs.

> [    1.543636] Serial: 8250/16550 driver, 8 ports, IRQ sharing disabled

Why is this kernel compiled with irq sharing disabled?

> [    1.565062] serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A

The isa probe driver find the serial port.

> [    1.566453] serial 00:04: pnp_assign_resources, try dependent set 0
> [    1.567383] serial 00:04:   couldn't assign io 0 (min 0x2f8 max 0x2f8)

But then decides that the port is already in use (the existing serial driver).

> [    1.568366] serial 00:04: pnp_assign_resources failed (-16)
> [    1.569188] serial 00:04: unable to assign resources
> [    1.569924] serial: probe of 00:04 failed with error -16

Please try and boot 3.7.0 with "8250.share_irqs=1", maybe it will pick
irq 3 and it will be happy again, but that is just a guess.

I think I have not fully understood what the failure is. Does the serial
port not work or does the boot hang? What are the symptoms?

We might be able to fix the problem with a pnp quirk but 3.7 is has not had
any releases for a long time. We will need a reproduction on a concurrent
kernel so a patch can be written for that.


Sean
