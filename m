From: christian pellegrin <chripell@gmail.com>
Subject: Re: [PATCH v6] serial: spi: add spi-uart driver for Maxim 3110
Date: Wed, 17 Mar 2010 08:39:23 +0100
Message-ID: <cabda6421003170039o4c8a75a4uea8341920478a244@mail.gmail.com>
References: <cabda6421003161022x7c6e5a14xd283969e0843c493@mail.gmail.com>
	 <20100317103532.6e19db08@feng-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-fx0-f219.google.com ([209.85.220.219]:64441 "EHLO
	mail-fx0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752203Ab0CQHjY (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 17 Mar 2010 03:39:24 -0400
Received: by fxm19 with SMTP id 19so755433fxm.21
        for <linux-serial@vger.kernel.org>; Wed, 17 Mar 2010 00:39:23 -0700 (PDT)
In-Reply-To: <20100317103532.6e19db08@feng-i7>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Feng Tang <feng.tang@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Greg KH <greg@kroah.com>, David Brownell <david-b@pacbell.net>, Grant Likely <grant.likely@secretlab.ca>, Alan Cox <alan@lxorguk.ukuu.org.uk>, spi-devel-list <spi-devel-general@lists.sourceforge.net>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

On Wed, Mar 17, 2010 at 3:35 AM, Feng Tang <feng.tang@intel.com> wrote:
> Hi Christian,

Hi,

> your driver is posted on public. And the reasons I still posted driver here are:
> 1. It provides a console

I'll provide a patch to the mainline driver for the console. Let me
just finish my daily job duties ;-)

> 2. It use buffer read/write to meet our performance goal, max3110 doesn't have
> good FIFO, but spi controller have and we can leverage that for performance

I think this line of thinking is wrong. SPI generic layer is well ....
generic. For example the platform I use is the S3C24xx which has a SPI
shift register depth of just one byte. And using DMA is not an option
because the setup of a DMA transfer takes tens of microseconds.
Additionally the SPI driver in mainline is based on bit-banging which
uses workqueues and so is limited by the fact that it fights with
other sched_other processes. Unfortunately an alternative driver which
was posted never got mainlined and we, who need it, have to maintain
it ourself. But this is another story, the bottom line is that we have
to cope with the most basic SPI support we can meet.

This said I tested the throughput of the driver by doing a zmodem
transfer and, as far as I remember, the results were pretty good.
Please note that the transmission is already buffered in higher layer.
Don't be fooled by the fact that tx_empty is correctly implemented in
the actual driver: you *have* to implement it otherwise some things
like termios call tcdrain() will be broken. For example applications
that do RS485 rx/tx switching in user-space will go nuts without it.
As far receiving is concerned .....

> the datasheet say it supports 230400~300 baud rate, then driver guy need make
> it work as it claims, like copying 500 bytes string somewhere and paste it on
> this console in 230400/600 rate.

.... this is exactly the problem I was facing: loosing chars on RX. I
tracked the problem to a too long latency in awakening of the
workqueue (the RX FIFO of the MAX3100 overflows). I will post shortly
a patch that moves this to threaded interrupts which solved the
problem on the S3C platform I mentioned above working at 115200. A
quick and dirty fix for workqueues is posted here:
http://www.evolware.org/chri/paciugo/index.html. Anyway it has to do
with scheduling of processes so many more factors are concerned, like
HZ and preemption being enabled.

I will post some tests together with the patch, if you have some
benchmarks you like to be run don't hesitate to send them. Thanks in
advance!

>> I'm more than happy to work with you to have just one perfect (or
>> almost perfect) driver instead of two of them half-done. See some
>> comments inline.
> Can't agree more, all I want is just a upstream driver which meets the basic
> requirement.
>

I think upstream drivers have to meet the requirement of the average
user not be tailored to specific user-cases (see the Android code
inclusion debate). For example changing SPI speed to meet some rate of
data flow is wrong. Nothing will assure you that you get the rate you
asked: it all depends of the master SPI clock and the granularity
resulting by its division. So I still think the best way is poll the T
bit by using the SPI bus as little as possible.

>> I don't think this is a good idea to change speed. Just check the T
>> bit to see when the TX buffer is empty and send at the maximum
>> available speed. So the usage of the SPI bus is better.
> Yes, checking T bit is a good idea for single word transfer model, but it
> doesn't help when using buffer read/write

I really don't understand why, can you elaborate on this?

> I didn't use kmalloc/kfree in my earlier submission, but other developers
> mentioned the buffer allocated here need be DMA safe, as 3110 may work
> with many kinds of SPI controller, some of them only supports DMA mode.
>

why you don't preallocate buffer for SPI transfers that are DMA-safe?
For example the mcp251x driver
(http://lxr.free-electrons.com/source/drivers/net/can/mcp251x.c?v=2.6.34-rc1)
does this.

>> I guess you are using mthread_up to avoid awakening the main thread
>> too many times. But this makes sense? Anyway because the awakening and
>> the setting of the bit is not atomic it won't work anyway.
> Why this can't work? the test/set_bit are atomic operations. This bit
> check is not exclusive, it just try to save some waking up, though waking a
> already running thread doesn't cost too much as mentioned by Andrew

First of all I think that the cost of re-awakening an already running
thread is lower than the logic of testing bits. My note was just
nit-picking: there is a window between when the task was woken-up and
where you set the bit, so it doesn't guarantee you that you aren't
awakening the thread more than once anyway.

Bye,

PS.: sorry to have missed you previous emails where some points where
already discussed. Please CC me next time, unfortunately spi-devel
mailing list carries quite a bit of spam and so I have to search its
post in the trash folder. I realized this is the reason why I didn't
see your previous posts :-/

-- 
Christian Pellegrin, see http://www.evolware.org/chri/
"Real Programmers don't play tennis, or any other sport which requires
you to change clothes. Mountain climbing is OK, and Real Programmers
wear their climbing boots to work in case a mountain should suddenly
spring up in the middle of the computer room."
