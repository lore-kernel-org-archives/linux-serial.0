From: Nathan Zimmer <nzimmer@sgi.com>
Subject: Re: console issue since 3.6, console=ttyS1 hangs
Date: Tue, 18 Oct 2016 11:40:04 -0500
Message-ID: <20161018164004.GA159046@stormcage.americas.sgi.com>
References: <20161017144951.GA235535@stormcage.americas.sgi.com>
 <20161017151906.GA19082@gofer.mess.org>
 <20161017164140.GA35950@stormcage.americas.sgi.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="G4iJoqBmSsgzjUCe"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161017164140.GA35950@stormcage.americas.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nathan Zimmer <nzimmer@sgi.com>
Cc: Sean Young <sean@mess.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, gregkh@linuxfoundation.org, alan@linux.intel.com
List-Id: linux-serial@vger.kernel.org


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

3.7.0
cat /sys/bus/pnp/drivers/serial/*/resources
state = active
io 0x2f8-0x2ff
irq 12
dma disabled

3.6.0
:~ # cat /sys/bus/pnp/drivers/serial/*/resources
cat: /sys/bus/pnp/drivers/serial/*/resources: No such file or directory

Which is intresting.
So I thought tacking on "tail /sys/devices/pnp0/*/resources" might be helpful.



On Mon, Oct 17, 2016 at 11:41:40AM -0500, Nathan Zimmer wrote:
> Ok I'll get that sometime tomorrow.  Right now they pulled it down maintenance...
> 
> On Mon, Oct 17, 2016 at 04:19:07PM +0100, Sean Young wrote:
> > On Mon, Oct 17, 2016 at 09:49:51AM -0500, Nathan Zimmer wrote:
> > > A cluster client recently tried to update from Sles11 to Sles12 and found in
> > > some cases the boxes would hang in early boot.  It came down to console=ttyS1
> > > on the command line.  After a bisection I found it happended in here:
> > > 
> > > commit 835d844d1a28efba81d5aca7385e24c29d3a6db2
> > > Author: Sean Young <sean@mess.org>
> > > Date:   Fri Sep 7 19:06:23 2012 +0100
> > > 
> > >     8250_pnp: do pnp probe before legacy probe
> > > 
> > > 
> > > I found I can revert the part of the patch in 8250.c (now 8250_core.c) and
> > > the hangs do not happen.
> > > 
> > > Bios of the offending box ( I don't know if there a bios update )
> > > Version 2.15.1234. Copyright (C) 2012 American Megatrends, Inc.
> > > BIOS Date: 02/05/2014 13:45:09
> > > Ver: ma2e2054.16I
> > > 
> > > I don't have much more info but will collect anything that is asked.
> > > Any help would be appeciated.
> > 
> > The console output would be helpful (both before 3.6 and with 3.6). It 
> > could be that what the bios provides in pnp does not match the actual
> > config.
> > 
> > The output of:
> > 
> > cat /sys/bus/pnp/drivers/serial/*/resources
> > 
> > Would be helpful, thanks.
> > 
> > 
> > Sean

--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="info_3.6.0"

==> /sys/devices/pnp0/00:00/resources <==
bus 0x0-0x7e
io 0xcf8-0xcff
io 0x0-0x3af window
io 0x3e0-0xcf7 window
io 0x3b0-0x3df window
io 0xd00-0x9fff window
mem 0xa0000-0xbffff window
mem 0xc0000-0xdffff window
mem 0x90000000-0xe7ffffff window
mem 0x380000000000-0x380fffffffff window

==> /sys/devices/pnp0/00:01/resources <==
state = active
mem 0xfc000000-0xfcffffff
mem 0xfd000000-0xfdffffff
mem 0xfe000000-0xfeafffff
mem 0xfeb00000-0xfebfffff
mem 0xfed00400-0xfed3ffff
mem 0xfed45000-0xfedfffff

==> /sys/devices/pnp0/00:02/resources <==
state = active
mem 0xe7ffc000-0xe7ffdfff

==> /sys/devices/pnp0/00:03/resources <==
state = active
io disabled
io 0xa00-0xa1f

==> /sys/devices/pnp0/00:04/resources <==
state = disabled

==> /sys/devices/pnp0/00:05/resources <==
state = active
dma 4
io 0x0-0xf
io 0x81-0x83
io 0x87-0x87
io 0x89-0x8b
io 0x8f-0x8f
io 0xc0-0xdf

==> /sys/devices/pnp0/00:06/resources <==
state = active
io 0x70-0x71
irq 8

==> /sys/devices/pnp0/00:07/resources <==
state = active
io 0x61-0x61

==> /sys/devices/pnp0/00:08/resources <==
io 0x65-0x6f
io 0x72-0x7f
io 0x80-0x80
io 0x84-0x86
io 0x88-0x88
io 0x8c-0x8e
io 0x90-0x9f
io 0xa2-0xbf
io 0xe0-0xef
io 0x4d0-0x4d1

==> /sys/devices/pnp0/00:09/resources <==
state = active
io 0xf0-0xff
irq 13

==> /sys/devices/pnp0/00:0a/resources <==
state = active
io 0xca2-0xca2
io 0xca3-0xca3

==> /sys/devices/pnp0/00:0b/resources <==
state = active
io 0x400-0x453
io 0x458-0x47f
io 0x1180-0x119f
io 0x500-0x57f
mem 0xfed1c000-0xfed1ffff
mem 0xfec00000-0xfecfffff
mem 0xfed08000-0xfed08fff
mem 0xff000000-0xffffffff

==> /sys/devices/pnp0/00:0c/resources <==
state = active
io 0x454-0x457

==> /sys/devices/pnp0/00:0d/resources <==
state = active
mem 0xfed00000-0xfed003ff

==> /sys/devices/pnp0/00:0e/resources <==
state = active
bus 0x7f-0x7f

==> /sys/devices/pnp0/00:0f/resources <==
state = active
bus 0x80-0xfe
io 0x0-0x0 window
io 0xa000-0xffff window
mem 0x0-0x0 window
mem 0xe8000000-0xfbffffff window
mem 0x381000000000-0x381fffffffff window

==> /sys/devices/pnp0/00:10/resources <==
state = active

==> /sys/devices/pnp0/00:11/resources <==
state = active
mem 0xfbffe000-0xfbffffff

==> /sys/devices/pnp0/00:12/resources <==
state = active
bus 0xff-0xff

setserial
/dev/ttyS0, UART: unknown, Port: 0x03f8, IRQ: 4
/dev/ttyS1, UART: 16550A, Port: 0x02f8, IRQ: 3
/dev/ttyS2, UART: unknown, Port: 0x03e8, IRQ: 4
/dev/ttyS3, UART: unknown, Port: 0x02e8, IRQ: 3

--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="info_3.7.0"

==> /sys/devices/pnp0/00:00/resources <==
bus 0x0-0x7e
io 0xcf8-0xcff
io 0x0-0x3af window
io 0x3e0-0xcf7 window
io 0x3b0-0x3df window
io 0xd00-0x9fff window
mem 0xa0000-0xbffff window
mem 0xc0000-0xdffff window
mem 0x90000000-0xe7ffffff window
mem 0x380000000000-0x380fffffffff window

==> /sys/devices/pnp0/00:01/resources <==
state = active
mem 0xfc000000-0xfcffffff
mem 0xfd000000-0xfdffffff
mem 0xfe000000-0xfeafffff
mem 0xfeb00000-0xfebfffff
mem 0xfed00400-0xfed3ffff
mem 0xfed45000-0xfedfffff

==> /sys/devices/pnp0/00:02/resources <==
state = active
mem 0xe7ffc000-0xe7ffdfff

==> /sys/devices/pnp0/00:03/resources <==
state = active
io disabled
io 0xa00-0xa1f

==> /sys/devices/pnp0/00:04/resources <==
state = active
io 0x2f8-0x2ff
irq 12
dma disabled

==> /sys/devices/pnp0/00:05/resources <==
state = active
dma 4
io 0x0-0xf
io 0x81-0x83
io 0x87-0x87
io 0x89-0x8b
io 0x8f-0x8f
io 0xc0-0xdf

==> /sys/devices/pnp0/00:06/resources <==
state = active
io 0x70-0x71
irq 8

==> /sys/devices/pnp0/00:07/resources <==
state = active
io 0x61-0x61

==> /sys/devices/pnp0/00:08/resources <==
io 0x65-0x6f
io 0x72-0x7f
io 0x80-0x80
io 0x84-0x86
io 0x88-0x88
io 0x8c-0x8e
io 0x90-0x9f
io 0xa2-0xbf
io 0xe0-0xef
io 0x4d0-0x4d1

==> /sys/devices/pnp0/00:09/resources <==
state = active
io 0xf0-0xff
irq 13

==> /sys/devices/pnp0/00:0a/resources <==
state = active
io 0xca2-0xca2
io 0xca3-0xca3

==> /sys/devices/pnp0/00:0b/resources <==
state = active
io 0x400-0x453
io 0x458-0x47f
io 0x1180-0x119f
io 0x500-0x57f
mem 0xfed1c000-0xfed1ffff
mem 0xfec00000-0xfecfffff
mem 0xfed08000-0xfed08fff
mem 0xff000000-0xffffffff

==> /sys/devices/pnp0/00:0c/resources <==
state = active
io 0x454-0x457

==> /sys/devices/pnp0/00:0d/resources <==
state = active
mem 0xfed00000-0xfed003ff

==> /sys/devices/pnp0/00:0e/resources <==
state = active
bus 0x7f-0x7f

==> /sys/devices/pnp0/00:0f/resources <==
state = active
bus 0x80-0xfe
io 0x0-0x0 window
io 0xa000-0xffff window
mem 0x0-0x0 window
mem 0xe8000000-0xfbffffff window
mem 0x381000000000-0x381fffffffff window

==> /sys/devices/pnp0/00:10/resources <==
state = active

==> /sys/devices/pnp0/00:11/resources <==
state = active
mem 0xfbffe000-0xfbffffff

==> /sys/devices/pnp0/00:12/resources <==
state = active
bus 0xff-0xff
setserial
/dev/ttyS0, UART: unknown, Port: 0x03f8, IRQ: 4
/dev/ttyS1, UART: 16550A, Port: 0x02f8, IRQ: 12
/dev/ttyS2, UART: unknown, Port: 0x03e8, IRQ: 4
/dev/ttyS3, UART: unknown, Port: 0x02e8, IRQ: 3

--G4iJoqBmSsgzjUCe--
