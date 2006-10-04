From: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: [RFC][PATCH] Xilinx uartlite serial driver
Date: Wed, 04 Oct 2006 18:01:52 +0200
Message-ID: <878xjwkr2n.fsf@slug.be.48ers.dk>
References: <87ac9o3ak3.fsf@sleipner.barco.com>
	<878xlgercm.fsf@slug.be.48ers.dk>
	<20060912093301.77f75bfb@localhost.localdomain>
	<87ejugxqbw.fsf@slug.be.48ers.dk> <871wqfyjgi.fsf@slug.be.48ers.dk>
	<20060913100110.1e33d885@localhost.localdomain>
	<451E380B.5000401@dlasys.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from assei2bl6.telenet-ops.be ([195.130.133.69]:22923 "EHLO
	assei2bl6.telenet-ops.be") by vger.kernel.org with ESMTP
	id S1161468AbWJDQCK (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 4 Oct 2006 12:02:10 -0400
In-Reply-To: <451E380B.5000401@dlasys.net> (David H. Lynch, Jr.'s message of
	"Sat, 30 Sep 2006 05:25:31 -0400")
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: "David H. Lynch Jr." <dhlii@dlasys.net>
Cc: linux-serial@vger.kernel.org

>>>>> "David" == David H Lynch <dhlii@dlasys.net> writes:

Hi,

 David> 	Your ulite_console_write performance is pretty slow -
 David> almost an order of magnitude slower than what I am seeing in
 David> my driver. I beleive it is because you are waiting for the Tx
 David> FIFO to be empty before and after sending each character
 David> rather than only waiting while the Tx FIFO is full.

Really? The implementation is basically a copy of 8250.c, so I would
imagine that would get similar performance. Perhaps it's related to
your specific setup?

The driver only waits before sending a character, not afterwards.

 David> 	That may also be an issue in the rest of the driver but I have been
 David> unable to get it to through registering the driver.
 David> 	I suspect that is because your driver is a platform driver, but you did
 David> not provide patches to the arch/ppc/platforms/4xx/virtex.* or
 David> xilinx_ml???.* to setup the platform device structure.

No, because the Xilinx boards don't have any uartlite devices.

 David> 	If you could provide a copy I would appreciate it.

Sure, just add something like this to your board code (with your base
address/irq ofcause):
	
static struct resource uartlite_resources[] = {
       [0] = {
           .start  = 0xa1000003,
           .end    = 0xa1000012,
           .flags  = IORESOURCE_MEM,
       },
       [1] = {
           .start  = 2,
           .end    = 2,
           .flags  = IORESOURCE_IRQ,
       },
};

static struct platform_device uartlite = {
       .name              = "uartlite",
       .id                = 0,
       .num_resources     = ARRAY_SIZE(uartlite_resources),
       .resource          = uartlite_resources,
       .dev.platform_data = 0,
};

static struct platform_device *my_devices[] __initdata = {
       &uartlite,
       .
       .
       .
};

static int __init
my_platform_add_devices(void)
{
        return platform_add_devices(my_devices, ARRAY_SIZE(my_devices));

}

arch_initcall(my_platform_add_devices);

-- 
Bye, Peter Korsgaard
