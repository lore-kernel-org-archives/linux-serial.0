Return-Path: <SRS0=8eBw=5X=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38DD9C2BABC
	for <linux-serial@archiver.kernel.org>; Tue,  7 Apr 2020 09:16:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D22420748
	for <linux-serial@archiver.kernel.org>; Tue,  7 Apr 2020 09:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586250976;
	bh=lxtAEZgTZYEOnKFPYs4f9mkdDkEbk/o3qr1XD05lqqs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eNs7TaRah+cGpqt5hwri72rtDs1ORSKI4Aftw0Lvo/7o2sWcn+NSzMaQ1G/4nIULc
	 0njOZ61uh5hBxPLMRHkkhNZG62cmhEfNvnzmulY1UE1zaPiQud5DXoGnaDP0HkmbdH
	 PS4gv4k4tEV3ZV134EiTjlwHy4Y1ldp697zKSLdo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbgDGJQP (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 7 Apr 2020 05:16:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:37806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726562AbgDGJQP (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 7 Apr 2020 05:16:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC597206C0;
        Tue,  7 Apr 2020 09:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586250974;
        bh=lxtAEZgTZYEOnKFPYs4f9mkdDkEbk/o3qr1XD05lqqs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jj01Y45hyRfiRHwSntGuo77qpXgGZSxR9OFGluQ+3RQelJevcsB5EGifGWRigaUV4
         JhGiDqEIMSTnRIxpDP21BgNBMVC/rO6sNdqMN1VcNJa1kge9Gp24DzddZhgroXDvf3
         aZGTIJfyMdm8LlXaQFnJo0USWbfBPUCYBURo4Nhc=
Date:   Tue, 7 Apr 2020 11:16:11 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     gianluca <gianlucarenzi@eurek.it>
Cc:     jslaby@suse.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Gianluca Renzi <icjtqr@gmail.com>,
        dimka@embeddedalley.com, linux@rempel-privat.de
Subject: Re: Serial data loss
Message-ID: <20200407091611.GA657631@kroah.com>
References: <960c5054-48b0-fedc-4f3a-7246d84da832@eurek.it>
 <20200407082454.GA299198@kroah.com>
 <19bbd87d-75d7-3d9f-d7c1-629d1cc961e8@eurek.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19bbd87d-75d7-3d9f-d7c1-629d1cc961e8@eurek.it>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Apr 07, 2020 at 11:01:08AM +0200, gianluca wrote:
> On 04/07/2020 10:24 AM, Greg Kroah-Hartman wrote:
> > On Tue, Apr 07, 2020 at 09:30:21AM +0200, gianluca wrote:
> > > I have a BIG trouble having dataloss when using two internal serial ports of
> > > my boards based on NXP/FreeScale iMX28 SoC ARMv5Te ARM920ej-s architecture.
> > > 
> > > It runs at 454Mhz.
> > > 
> > > Kernel used 4.9.x
> > 
> > That's a very old kernel, you are going to have to get support for that
> > from the vendor you bought it from :(
> > 
> 
> We are the vendor. ;-)

Good luck!  :)

> Jokes apart, I can try to use the latest kernel 5.6, and see how is going on
> them, but at the first check the driver seems exactly the same as in kernel
> 4.9.
> 
> > > When using my test case unit software between two serial ports connect each
> > > other by a null modem cable, it fails when the speed rate are different,
> > 
> > Of course, how would that work?
> > 
> 
> I am not native english speaker so I am misleading to a misunderstanding: my
> test case is a software with two pthreads which the main thread is working
> with a differnet baud rate than the other pthread. Using the same software
> in two different machines, and using the same baudrate for each
> corrispondant port it should work.
> 
> i.e. /dev/ttyAPP1 is running at 9600 and /dev/ttyAPP2 is running at 38400
> 
> The same in the other machine. Both ports are null-modem connected:
> 
> 	9600  /dev/ttyAPP1 <----> /dev/ttyAPP1 9600
> 	38400 /dev/ttyAPP2 <----> /dev/ttyAPP2 38400
> 
> I hope to be clear now. ;-)

Ok, yes, that makes more sense now, thank you.

> > > and
> > > dataloss is increasing higher the speed rate.
> > 
> > What type of flow control are you using?
> > 
> 
> Unfortunately no flow control. Because the I cannot use it. When connected
> to the real-hardware those two ports are connected to a microcontroller unit
> which does not have flow control, only RX & TX connected (i.e. no
> RTS/CTS/DTE/DCE lines)

Then you are going to have problems, that is exactly what flow control
was designed for.  To ignore that is to have problems.

Also, there is software flow control when you do not have any control
lines.  This "issue" was solved decades ago :)

> > > I am talking about the high latency from the IRQ up to the service routine
> > > when flushing the FIFO and another IRQ is called by another uart in the same
> > > time at different speed.
> > > 
> > > The code I was looking is: drivers/tty/serial/mxs-auart.c __but__ all other
> > > serial drivers are acting in the same way: they are reading one character at
> > > time from the FIFO (if it exists) and put it into the circular buffer so
> > > serial/tty driver can pass them to the user read routine.
> > > 
> > > Each function call has some overhead and it is time-consuming, and if
> > > another interrupt is invoked by the same UART Core but from another serial
> > > port (different context) the continuos insertion done by hardware UART into
> > > the FIFO cannot be served fast enough to have an overrun. I think this can
> > > be applied __almost__ to every serial driver as they are written in the same
> > > way.
> > > 
> > > And it is __NOT__ an issue because of the CPU and its speed! Using two
> > > serial converter (FTDI and Prolific PL2303 based) on each board, the problem
> > > does not appear at all even after 24 hours running at more than 115200!!!
> > 
> > usb-serial devices are totally different and send data to the host in a
> > completly different way.
> > 
> > Your hardware might just not be able to handle really high baud rates at
> > a continous stream, what baud rate were you using?
> > 
> 
> I suppose that, but the same issue can be proven with all single core (NO
> FIFO UART) processors using two ports on the same uart core, running Linux
> kernel @ 450 Mhz or less.
> 
> The irq latency it is the same.

Again, usb-serial devices do not use a uart on the host, so they have a
totally different design and code flow.

> > And again, this is what flow control was designed for, please use it.
> > 
> 
> I know and usually I am using a sort of protocol which can check correctness
> of packet, and if not, the packet has to be reasked/resent.
> In this case the microcontroller board I am connected to is not built by us,
> and the software is a custom protocol (and I do not know if an error on
> transfer can be accomplished by another request).
> 
> So the flow control __CANNOT_BE_USED_AT_ALL__...

Then that is a design mistake, please fix that.

good luck!

greg k-h
