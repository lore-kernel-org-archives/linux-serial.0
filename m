From: Michael Westermann <mw@microdata-pos.de>
Subject: Re: [Delivery unsuccesful: Delivery problems]
Date: Wed, 19 Feb 2003 08:31:03 +0100
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <20030219083103.A20380@microdata-pos.de>
References: <20030218120933.GQ351@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20030218120933.GQ351@lug-owl.de>; from jbglaw@lug-owl.de on Tue, Feb 18, 2003 at 01:09:34PM +0100
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: jbuermann@zes.com

Hello,
> I`m using linux mandrake kernel 2.4.19 on a 2 GHz Pentium 4 with 128
> MByte RAM. The serial port /dev/cua0 is connected to a external device
> and receives data with 115200 Baud.

> 
> Unfortunatelly I get a lot of fifo overruns. I have unmasked the hda
> interrupts with:
> 
> hdparm -u1 /dev/hda
> 
> also set the low_latency flag in the serial driver. The harddisk dma
> couldn't disabled.
> 
> I'm wonder at this behaviour, because with a lower machine (Pentium I
> 120 MHz, Kernel 2.2.13) I get overruns only once in a blue moon. And I
> expected, that a 2 GHz machine should be quick enough, to responds to
> the serial interrupts.

Have you tested Kernel 2.2.13 with the 2 GHz Pentium ? 

> 
> Additional to this I tried a PCI card with a 16950 (128 Byte fifo!) and
> set the uart with the setserial command. But also here a lot of
> overruns!!!

Use the 16950 the full FIFO ?

> 
> >From a embedded linux project (ELAN SC520 133MHz, kernel 2.2.19) I know,
> that the harddisk type influence the serial communication. So I got
> overruns after I changed the original drive with a newer one (the first
> was a old IBM with 500MByte, the newer a IBM with 20GByte). Last not
> least I must replace the linux kernel with a realtime linux (rtlinux)
> and do the serial communication in a realtime handler.
> 
> Because I didn't want to replace my desktop machine with a realtime
> linux, I'm looking for some hints to solve this problems.
> 
> What's about irqtune? I'm know this tool only with kernels up to 2.2.x.
> Is there a bug in the serial driver (I didn't found any hints in the
> mailing list or with google)?
> 
> Should I change the PCI interrupts in the BIOS to set the interrupt
> priority?
> 
> I don't know anymore. Please help.
> 

I have the same strange serial Problem

I have a box with Kernel 2.2.23 and Suse and a box with
Debian with kernel 2.2.23. Old IDE-Disk's without DMA.
Both boxes are connect with crossober Cable. 

I have tested only with a runnig bash "lili: linux init=/bin/bash"
the same Problem. On both boxes are the same kernel, the same
serial parabeters, both boxes work with FIFO.

I have tested the kernel 2.2.16...23 and 2.4.2 2.4.17 2.4.20, only
the 2.4.17 has the same problem on debian.

I think that is a interrupt  Probelem,but what is the causale?
what the difference.

When I use the FIFO, the UART read 8 char's to put a Interrupt.
The time for 8 char's is 2 ms. After this time we have a overrun,
but I thin that is a long time witout a Interrupt.

I Thing that is a general Problem.

Michael




