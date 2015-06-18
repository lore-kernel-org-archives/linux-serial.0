From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: [PATCH linux-next v2 1/4] ARM: at91/dt: add a new DT property to
 support FIFOs on Atmel USARTs
Date: Thu, 18 Jun 2015 18:39:24 +0200
Message-ID: <20150618163924.GQ27492@piout.net>
References: <cover.1434038494.git.cyrille.pitchen@atmel.com>
 <16bdcf0c3f710ca46df86eeea82c9840454cb7aa.1434038494.git.cyrille.pitchen@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <16bdcf0c3f710ca46df86eeea82c9840454cb7aa.1434038494.git.cyrille.pitchen@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Cyrille Pitchen <cyrille.pitchen@atmel.com>
Cc: nicolas.ferre@atmel.com, gregkh@linuxfoundation.org, wenyou.yang@atmel.com, ludovic.desroches@atmel.com, leilei.zhao@atmel.com, josh.wu@atmel.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, galak@codeaurora.org, ijc+devicetree@hellion.org.uk, mark.rutland@arm.com, pawel.moll@arm.com, robh+dt@kernel.org
List-Id: linux-serial@vger.kernel.org

On 11/06/2015 at 18:20:14 +0200, Cyrille Pitchen wrote :
> This patch adds a new DT property, "atmel,fifo-size", to enable and set
> the maximum number of data the RX and TX FIFOs can store on FIFO capable
> USARTs.
> 
> Please be aware that the VERSION register can not be used to guess the
> size of FIFOs. Indeed, for a given hardware version, the USARTs can be
> integrated on Atmel SoCs with different FIFO sizes. Also the
> "atmel,fifo-size" property is optional as older USARTs don't embed FIFO at
> all.
> 
> Besides, the FIFO size can not be read or guessed from other registers:
> When designing the FIFO feature, no dedicated registers were added to
> store this size. Unsed spaces in the I/O register range are limited and
> better reserved for future usages. Instead, the FIFO size of each
> peripheral is documented in the programmer datasheet.
> 
> Finally, on a given SoC, there can be several instances of USART with
> different FIFO sizes. This explain why we'd rather use a dedicated DT
> property than use the "compatible" property.
> 
> Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
