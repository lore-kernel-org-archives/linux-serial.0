From: Martin Sperl <martin@sperl.org>
Subject: Re: serial: clk: bcm2835: Strange effects when using aux-uart in console
Date: Fri, 12 Feb 2016 12:56:09 +0100
Message-ID: <662D2FB2-B088-4CFC-8416-A4F35BBAD7DD@sperl.org>
References: <A5F427B7-9B78-4892-9722-69418C4D0C10@martin.sperl.org> <56BC895E.2010108@sperl.org> <1617009200.323700.219000a8-c162-4594-aacc-a7e9894518b2.open-xchange@email.1und1.de>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1617009200.323700.219000a8-c162-4594-aacc-a7e9894518b2.open-xchange@email.1und1.de>
Sender: linux-clk-owner@vger.kernel.org
To: Stefan Wahren <stefan.wahren@i2se.com>
Cc: Eric Anholt <eric@anholt.net>, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, linux-clk <linux-clk@vger.kernel.org>, linux-rpi-kernel <linux-rpi-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org


> On 11.02.2016, at 18:55, Stefan Wahren <stefan.wahren@i2se.com> wrote:
> I think the reason for this behavior can be found in the uart-pl011 driver which
> plays with the clocks.
> 
I will look into the why and share what I find...

> According to the clock tree "plld" seems to be critical and shouldn't be
> disabled?

Then we may need to avoid this - but as far as I can tell
the amba-pl011 driver only disables the clock in error cases
(or when shutting down).
Maybe we just need to disable the shutdown of the plld?

>> Is this maybe related to the uart0_pclk, uart1_pclk, apb_pclk
>> clocks created and registered in bcm2835_init_clocks?
> 
> Related or not i think we should get the rid off them.

A quick test shows that an empty bcm2835_init_clocks
does not change the basic kernel-boot behavior and everything
seems to work.

So we probably should remove it in:
* arch/arm/mach-bcm/board_bcm2835.c (call)
* drivers/clk/bcm/clk-bcm2835.c (function definition)

Martin

