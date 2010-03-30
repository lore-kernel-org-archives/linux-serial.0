From: Feng Tang <feng.tang@intel.com>
Subject: Re: [PATCH v1 3/4] max3100: adds console support for MAX3100
Date: Tue, 30 Mar 2010 10:14:45 +0800
Message-ID: <20100330101445.5c64dedb@feng-i7>
References: <1269340105-6503-1-git-send-email-chripell@fsfe.org>
	<1269340170-6558-1-git-send-email-chripell@fsfe.org>
	<20100329104838.49c18075@feng-i7>
	<cabda6421003282311x78051e1eq38ada68f2553609e@mail.gmail.com>
	<20100329150642.4a94e78a@feng-i7>
	<cabda6421003290555k70d13168y4beba2c3ae6e2ece@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:6544 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755092Ab0C3CJi (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 29 Mar 2010 22:09:38 -0400
In-Reply-To: <cabda6421003290555k70d13168y4beba2c3ae6e2ece@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: christian pellegrin <chripell@fsfe.org>
Cc: "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "greg@kroah.com" <greg@kroah.com>, "david-b@pacbell.net" <david-b@pacbell.net>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "alan@lxorguk.ukuu.org.uk" <alan@lxorguk.ukuu.org.uk>, "spi-devel-general@lists.sourceforge.net" <spi-devel-general@lists.sourceforge.net>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

On Mon, 29 Mar 2010 20:55:51 +0800
christian pellegrin <chripell@fsfe.org> wrote:

> On Mon, Mar 29, 2010 at 9:06 AM, Feng Tang <feng.tang@intel.com>
> wrote:
> 
> > Our platform is Intel Moorestown platform, and use a spi controller
> > core from Designware (drivers/spi/dw_*.c). I know the problem may
> > probably be caused by my setting, but the dw_spi driver works fine
> > with our own 3110 driver.
> 
> I had a look at the dw_spi driver. The spi_transfer path queues some
> work to a worqueue that itself schedules a tasklet. I don't think this
> is good for latency, I won't bet that such an architecture could
> deliver good performance. Now I see why you needed to do only big fat
> SPI transfers. Anyway this doesn't justify the 2 seconds delay between
Hi

DW controller driver don't need max3110 driver to use big spi transfer,
the early version of our max3110 is also one word per spi transfer mode,
and the 2 drivers work fine, though the rx performance is not good (copy
& paste a bulk message to console).

Let me use some example to explain why I use big spi transfer for 3110:

When the HW works at 230400 bps, when we copy bulk data to the console,
max3110 will probably receive about 20K characters, so the time for
handling each char is 50us. If you use one char per spi transfer, it
will have to execute 20K spi_transfer in one second, and each need be
done in 50us, in this 50us you'll have to deal with controller IRQ 
handler + spi system overhead + tty receiving overhead. Is it a little
over-killing to use one char per spi transfer? while the HW does
have a 8 words RX FIFO 

> chars coming in and going out through the max31x0 you are seeing. I
> will try to analyze what's going on. BTW is only input slow or output
> is sluggish too? The initial messages from the console are coming out
> fast? If you disable the MAX3110 for console but you use just as a
> normal terminal (set console=/dev/null in the kernel command line and
> add getty 115200 /dev/ttyMAX0 in iniitab) is the interaction with the
> system fine? Thanks for helping sorting out this.

The output is not so slow as input, if we set the console=/dev/ttyMAX0,
the output is sluggish, looks like below, but when enter command line
console the output is smooth, while the input is very slow.

--------------------------------------------------------------
   kernel print log of max3100 over Moorestown platform
--------------------------------------------------------------

    0.000000] Moorestown CPU Lincroft identified
[[    ..000000  iiuu  eessoo  ....44rr11((eeggffnn--77  ggccvvrriinn444411((bbnnuu44441144bbnnuu))))
[[    ..000000  BBOO--8800  0000000000001100--0000000000008800  uuaall))

                                                                            00000000]]  IISSee22::00
00000000110000 - 000000000f2000000 (usabl))
                                           [     .0000000  BIOS-e822:: 000000000220000    0000000110
000000((eserved)
[    0.000000]  BIISSe820:: 00000000ee00000 --000000000fec01000 (reseree))

                                                                              00000000]]  IISSee200
[[    ..000000  BBOO--8800  00000000ff000000--0000000000000000  rrssrree))

                                                                              00000000]]NNttcc::NN
[[    ..000000  8800uuddtt  aagg::0000000000000000    0000000000000000((ssbbee  ==  rrssrree))

                                                                                                  00
000000]]ee22  eeooeerrnnee  0000000000aa0000--0000000000110000  uuaall))

                                                                            00000000]]llss__ff    xx
2200mmxxaacc__ff    xx000000

                                00000000]]MMRR  eeaall  yyee  nnaahhbbee

                                                                            00000000]]MMRR  iiee  aa
[[    ..000000    0000--FFFF  rrtt--aakk

[[    ..000000    0000--FFFF  rrtt--aakk    00000000]]  AA0000BBFFFFuuccccaall

                                            00000000]]MMRR  aaiibbeerrnnee  nnbbee::




> 1) the console code has to check if the serial port associated to the
> same physical max3100 is up (console driver start their life much
> before serial ones).
> 
> 2) if yes send data to the tty associated to the serial driver.
> Locking is needed here.
> 
> I will implement this ASAP.

cool!

