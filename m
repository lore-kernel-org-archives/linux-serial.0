From: Olof Johansson <olof@lixom.net>
Subject: Re: [RFC][PATCH] Xilinx uartlite serial driver
Date: Tue, 12 Sep 2006 09:33:01 -0500
Message-ID: <20060912093301.77f75bfb@localhost.localdomain>
References: <87ac9o3ak3.fsf@sleipner.barco.com>
	<878xlgercm.fsf@slug.be.48ers.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lixom.net ([66.141.50.11]:1949 "EHLO mail.lixom.net")
	by vger.kernel.org with ESMTP id S965260AbWILOel (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 12 Sep 2006 10:34:41 -0400
In-Reply-To: <878xlgercm.fsf@slug.be.48ers.dk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Peter Korsgaard <jacmet@sunsite.dk>
Cc: rmk+serial@arm.linux.org.uk, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 22 Aug 2006 17:13:13 +0200 Peter Korsgaard <jacmet@sunsite.dk> wrote:

> >>>>> "Peter" == Peter Korsgaard <jacmet@sunsite.dk> writes:
> 
> Hi,
> 
>  Peter> The following patch adds a driver for the Xilinx uartlite serial
>  Peter> controller used in boards with the PPC405 core in the Xilinx V2P/V4
>  Peter> fpgas.
> 
>  Peter> The hardware is very simple (baudrate/start/stopbits fixed and
>  Peter> no break support). See the datasheet for details:
> 
>  Peter> http://www.xilinx.com/bvdocs/ipcenter/data_sheet/opb_uartlite.pdf
> 
>  Peter> Comments and suggestions are welcome. I'm especially wondering about
>  Peter> the fact that I'm hijacking the device nodes used by the mpc52xx_uart
>  Peter> driver ..
> 
> Ok, I now got a chunk of the 204 major range from LANANA. That afaik
> solves the last remaining issue with this..

Hi,

I've been working on getting this running smoothly over the last few days.
In my opinion there's a few pieces missing:

1. There's no early boot console support for PPC. There's another
uartlite patch that's floating around that has this, very useful for
early bringup tasks. I'd like to see this expanded to include that as
well (the regular part of the other driver seems more or less broken
though, so this is a better base driver). That shouldn't stop this part
of the driver to go in though, just possible future work.

2. There seems to be some timeout issues with tx_empty. If I boot a
regular distro with getty, etc, I get veeeery slow console output right
when init starts up. Adding a small default timeout in the init of the
uart code seems to help -- the hanging thread seems to be sleeping in
uart_wait_until_sent(). I picked a value of '5', seems ok. (Also,
without this fix, getty won't start on the port for some reason, it
sits in the same timeout forever, or at least for a very long time).

3. It would be useful to demonstrate how to hook up the device all the
way through to the board port (i.e. add a config option and include it
in the ml403 platform code or similar). It's not hard, but it'd make it
easier for whomever comes next. Of course, with 4xx hopefully soon
moving over to arch/powerpc, this would be taken care of through the
device tree instead.

So, (2) is really the only thing that's needed (IMHO) before this goes
in, but the rest would be useful as well.


-Olof

