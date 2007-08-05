From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: 8250.c::autoconfig() fails loopback test on MPC824[15]
Date: Sun, 5 Aug 2007 16:06:02 +0200 (CEST)
Message-ID: <Pine.LNX.4.60.0708051600550.4120@poirot.grange>
References: <Pine.LNX.4.60.0708050106270.4299@poirot.grange>
 <200708050135.07753.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:49420 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751164AbXHEOF6 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sun, 5 Aug 2007 10:05:58 -0400
In-Reply-To: <200708050135.07753.arnd@arndb.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, linux-serial@vger.kernel.org

On Sun, 5 Aug 2007, Arnd Bergmann wrote:

> On Sunday 05 August 2007, Guennadi Liakhovetski wrote:
> > I tried using of_serial.c on a (PPC) MPC8241 based system, which has a 
> > "16650A" compatible double UART built into the SoC. Using of_serial.c 
> > causes the ports to be autoconfigured, and this fails. The loopback test 
> > fails, because the MSR register on 824[15] doesn't implement the 
> > UART_MSR_DCD bit. Question: what's better, teach 8250.c to handle UARTs 
> > without this bit, or set the UPF_SKIP_TEST bit in of_serial.c for these 
> > SOCs to skip the loopback test altogether? The latter is certainly easier 
> > and affects much fewer systems, so, I'd go for that.
> 
> Yes, that sounds good. Just make sure you test the "compatible" property
> in the device node for something appropriate. In of_platform_serial_probe(),
> you can then do something like
> 
> 	if (of_device_is_compatible(ofdev, "mpc8241-serial"))
> 		flags |= UPF_SKIP_TEST;

That would be a possibility, but that would mean all 8241/8245 have to 
adjust their .dts. Ok, there are not so many of them in the mainline now 
(in fact, hardly any apart from linkstation:-)), still. Cannot we use 
something already available to just check if we're running on such a CPU? 
Worst case - find and parse cpu node, or maybe using some cpu_feature?

Thanks
Guennadi
---
Guennadi Liakhovetski
