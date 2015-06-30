From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: [PATCH v3 2/4] tty/serial: at91: fix some macro definitions to
 fit coding style
Date: Tue, 30 Jun 2015 23:53:19 +0200
Message-ID: <20150630215319.GM485@piout.net>
References: <cover.1435672649.git.cyrille.pitchen@atmel.com>
 <9f0f19d2fe05ea95572b467ec49ecd11389e3be9.1435672649.git.cyrille.pitchen@atmel.com>
 <11308515.NsBzDiA1lH@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <11308515.NsBzDiA1lH@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Cyrille Pitchen <cyrille.pitchen@atmel.com>, nicolas.ferre@atmel.com, gregkh@linuxfoundation.org, wenyou.yang@atmel.com, ludovic.desroches@atmel.com, leilei.zhao@atmel.com, josh.wu@atmel.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, galak@codeaurora.org, ijc+devicetree@hellion.org.uk, mark.rutland@arm.com, pawel.moll@arm.com, robh+dt@kernel.org
List-Id: linux-serial@vger.kernel.org

On 30/06/2015 at 22:28:42 +0200, Arnd Bergmann wrote :
> On Tuesday 30 June 2015 16:05:15 Cyrille Pitchen wrote:
> > +#define UART_PUT_CR(port, v)   __raw_writel(v, (port)->membase + ATMEL_US_CR)
> > +#define UART_GET_MR(port)      __raw_readl((port)->membase + ATMEL_US_MR)
> > +#define UART_PUT_MR(port, v)   __raw_writel(v, (port)->membase + ATMEL_US_MR)
> > +#define UART_PUT_IER(port, v)  __raw_writel(v, (port)->membase + ATMEL_US_IER)
> > 
> 
> How about removing these macros entirely? I'm not aware of other drivers
> doing it like this, and it does not seem to add any value?
> 
> At the same time, you could use readl_relaxed() to make the driver
> endian-safe.
> 

I think using readl_relaxed() would break avr32.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
