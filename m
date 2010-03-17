From: Feng Tang <feng.tang@intel.com>
Subject: Re: [PATCH v6] serial: spi: add spi-uart driver for Maxim 3110
Date: Wed, 17 Mar 2010 16:33:53 +0800
Message-ID: <20100317163353.685a6a38@feng-i7>
References: <cabda6421003161022x7c6e5a14xd283969e0843c493@mail.gmail.com>
	<20100317103532.6e19db08@feng-i7>
	<cabda6421003170039o4c8a75a4uea8341920478a244@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:23867 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753566Ab0CQIbY (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 17 Mar 2010 04:31:24 -0400
In-Reply-To: <cabda6421003170039o4c8a75a4uea8341920478a244@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: christian pellegrin <chripell@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Greg KH <greg@kroah.com>, David Brownell <david-b@pacbell.net>, Grant Likely <grant.likely@secretlab.ca>, Alan Cox <alan@lxorguk.ukuu.org.uk>, spi-devel-list <spi-devel-general@lists.sourceforge.net>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

On Wed, 17 Mar 2010 15:39:23 +0800
christian pellegrin <chripell@gmail.com> wrote:

> On Wed, Mar 17, 2010 at 3:35 AM, Feng Tang <feng.tang@intel.com>
> wrote:
> > Hi Christian,
> 
> Hi,
> 
> > your driver is posted on public. And the reasons I still posted
> > driver here are: 1. It provides a console
> 
> I'll provide a patch to the mainline driver for the console. Let me
> just finish my daily job duties ;-)

Cool!! I can test that on my platform.

> 
> > 2. It use buffer read/write to meet our performance goal, max3110
> > doesn't have good FIFO, but spi controller have and we can leverage
> > that for performance
> 
> I think this line of thinking is wrong. SPI generic layer is well ....
> generic. For example the platform I use is the S3C24xx which has a SPI
> shift register depth of just one byte. And using DMA is not an option
> because the setup of a DMA transfer takes tens of microseconds.
> Additionally the SPI driver in mainline is based on bit-banging which
> uses workqueues and so is limited by the fact that it fights with
> other sched_other processes. Unfortunately an alternative driver which
> was posted never got mainlined and we, who need it, have to maintain
> it ourself. But this is another story, the bottom line is that we have
> to cope with the most basic SPI support we can meet.

I'm no your side suggesting not to use DMA for 3110/3100, but David and
others have a valid point, we don't know what kind of SPI controller that
this driver will work with, and the driver has to be as general and
compatible as possible.

> 
> .... this is exactly the problem I was facing: loosing chars on RX. I
> tracked the problem to a too long latency in awakening of the
> workqueue (the RX FIFO of the MAX3100 overflows). I will post shortly
> a patch that moves this to threaded interrupts which solved the
> problem on the S3C platform I mentioned above working at 115200. A
> quick and dirty fix for workqueues is posted here:
> http://www.evolware.org/chri/paciugo/index.html. Anyway it has to do
> with scheduling of processes so many more factors are concerned, like
> HZ and preemption being enabled.
> 
> I will post some tests together with the patch, if you have some
> benchmarks you like to be run don't hesitate to send them. Thanks in
> advance!

heh, I don't have benchmarks but simply the copy/paste stuff and using
zmodem sometimes.
> 
> >> I don't think this is a good idea to change speed. Just check the T
> >> bit to see when the TX buffer is empty and send at the maximum
> >> available speed. So the usage of the SPI bus is better.
> > Yes, checking T bit is a good idea for single word transfer model,
> > but it doesn't help when using buffer read/write
> 
> I really don't understand why, can you elaborate on this?

Checking T bit has to be done in word level, send one word out, read one
back and check T bit inside one spi xfer.

Why not use the buffer model, the HW has a 8 words RX buffer, why not read
8 words back in one spi xfer, saving a lot of system cost. And if we make
the spi clk slightly slower than the baud rate, there will be no TX
overflow problem. 

> 
> > I didn't use kmalloc/kfree in my earlier submission, but other
> > developers mentioned the buffer allocated here need be DMA safe, as
> > 3110 may work with many kinds of SPI controller, some of them only
> > supports DMA mode.
> >
> 
> why you don't preallocate buffer for SPI transfers that are DMA-safe?
> For example the mcp251x driver
> (http://lxr.free-electrons.com/source/drivers/net/can/mcp251x.c?v=2.6.34-rc1)
> does this.
Some function will be called in several places, say re-entered, hard to use
a preallocate buffer.

> 
> >> I guess you are using mthread_up to avoid awakening the main thread
> >> too many times. But this makes sense? Anyway because the awakening
> >> and the setting of the bit is not atomic it won't work anyway.
> > Why this can't work? the test/set_bit are atomic operations. This
> > bit check is not exclusive, it just try to save some waking up,
> > though waking a already running thread doesn't cost too much as
> > mentioned by Andrew
> 
> First of all I think that the cost of re-awakening an already running
> thread is lower than the logic of testing bits. My note was just
> nit-picking: there is a window between when the task was woken-up and
> where you set the bit, so it doesn't guarantee you that you aren't
> awakening the thread more than once anyway.

OK, got your point now. test/set_bit's cost depends on the platform, 
and my simple test using perf tool showing it cost 10us level to wake
a running thread.
Anyway, re-wake it does no harm :)

Thanks,
Feng

